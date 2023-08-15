function check_disk {
  $logicalDisks = Get-WmiObject Win32_LogicalDisk -Filter "DriveType=3"

  $logicalDisks | ForEach-Object {
    [PSCustomObject]@{
      DeviceID   = $_.DeviceID
      VolumeName = $_.VolumeName
      FreeSpace  = $_.FreeSpace
      Size       = $_.Size
    } | ConvertTo-Json
  }
}

function check_info {
  $computerSystem = Get-WmiObject Win32_ComputerSystem
  $operatingSystem = Get-WmiObject Win32_OperatingSystem
  $cpu = Get-WmiObject Win32_Processor
  $bios = Get-WmiObject win32_bios

  $ManufacturerModel = "$($computerSystem.Manufacturer) $($computerSystem.Model)"

  $info = @{
    "hostname"     = "$($env:USERDOMAIN)\$($env:USERNAME) ($($env:COMPUTERNAME))"
    "os"           = $operatingSystem.Caption
    "memory"       = $computerSystem.TotalPhysicalMemory
    "cpu"          = $cpu.Name.Trim()
    "manufacturer" = $ManufacturerModel
    "serialnumber" = $bios.SerialNumber
    "lastreboot"   = $operatingSystem.LastBootUpTime
  }

  $info | ConvertTo-Json
}

function check_omDiskStatus {
  if (Get-Command omreport -ErrorAction SilentlyContinue) {
    omconfig preferences cdvformat delimiter=asterisk | Out-Null
    $OmReport = omreport storage pdisk controller=0 -fmt cdv | Select-String -SimpleMatch "ID*Status" -Context 0, 5000

    if ($OmReport) {
      $DiskStatus = $OmReport | ConvertFrom-Csv -Delimiter "*" | ForEach-Object {
        [PSCustomObject]@{
          "name"     = $_.Name
          "status"   = $_.Status
          "state"    = $_.State
          "failure"  = $_.'Failure Predicted'
          "capacity" = $_.Capacity
        }
      } | ConvertTo-Json
      Write-Output $DiskStatus
    }
    else {
      Write-Output "null"
    }
  }
  else {
    Write-Output "null"
  }
}

function check_omRaidStatus {
  if (Get-Command omreport -ErrorAction SilentlyContinue) {
    omconfig preferences cdvformat delimiter=asterisk | Out-Null
    $OmReport = omreport storage vdisk -fmt cdv | Select-String -SimpleMatch "ID*Status" -Context 0, 5000

    if ($OmReport) {
      $RAIDStatus = $OmReport | ConvertFrom-Csv -Delimiter "*" | ForEach-Object {
        [PSCustomObject]@{
          "name"   = $_.Name
          "layout" = $_.Layout
          "status" = $_.Status
          "state"  = $_.State
          "media"  = $_.Media
        }
      } | ConvertTo-Json
      Write-Output $RAIDStatus
    }
    else {
      Write-Output "null"
    }
  }
  else {
    Write-Output "null"
  }
}

function check_omChassisStatus {
  if (Get-Command omreport -ErrorAction SilentlyContinue) {
    omconfig preferences cdvformat delimiter=asterisk | Out-Null
    $OmReport = omreport chassis -fmt cdv | Select-String -SimpleMatch "*"
    $Parray = $OmReport | ConvertFrom-Csv -Delimiter "*"
    $ChassisStatus = $Parray | ForEach-Object {
      $Component = $_ -replace '}', '' -split (" COMPONENT=")
      $Severity = $Component -replace ';', '' -split ("SEVERITY=")
      [PSCustomObject]@{
        "component" = $Component[1]
        "severity"  = $Severity[1]
      }
    } | ConvertTo-Json
    Write-Output $ChassisStatus
  }
  else {
    Write-Output "null"
  }
}

function check_speedtest {
  $Folder = "tools\ookla-speedtest-1.2.0-win64"
  $SpeedTest = Invoke-Expression -Command "$Folder\speedtest.exe -f json --accept-license --accept-gdpr" 2>$null

  if ($LASTEXITCODE -eq 0) {
    $SpeedTest = $SpeedTest | ConvertFrom-Json
    [PSCustomObject]@{
      "download"   = $SpeedTest.download.bandwidth
      "upload"     = $SpeedTest.upload.bandwidth
      "ping"       = $SpeedTest.ping.latency
      "internalIp" = $SpeedTest.interface.internalIp
      "externalIp" = $SpeedTest.interface.externalIp
    } | ConvertTo-Json
  }
  else {
    Write-Output "null"
  }
}

function check_wsb {
  if (Get-Command Get-WBSummary -ErrorAction SilentlyContinue) {
    $WsbSummary = Get-WBSummary
    $LastSuccessfulBackupTime = $WsbSummary.LastSuccessfulBackupTime
    $NumberOfVersions = $WsbSummary.NumberOfVersions

    [PSCustomObject]@{
      "LastSuccessfulBackupTime" = $LastSuccessfulBackupTime
      "NumberOfVersions"         = $NumberOfVersions
    } | ConvertTo-Json
  }
  else {
    Write-Output "null"
  }
}

function check_veeam {
  $EventLogName = "Veeam Agent"
  $veeamLog = Get-EventLog -LogName $EventLogName -InstanceId 190 -Newest 1 -ErrorAction SilentlyContinue

  if ($veeamLog) {
    $veeamMessage = $veeamLog.Message
    $veeamTime = $veeamLog.TimeWritten

    [PSCustomObject]@{
      "Message"     = $veeamMessage
      "TimeWritten" = $veeamTime
    } | ConvertTo-Json
  }
  else {
    Write-Output "null"
  }
}

function check_reliability {
  $EventReliability = Get-WmiObject Win32_ReliabilityRecords -ErrorAction SilentlyContinue

  if ($EventReliability) {
    $EventReliability | Select-Object -First 5 | ForEach-Object {
      [PSCustomObject]@{
        SourceName    = $_.SourceName
        Message       = $_.Message
        TimeGenerated = $_.TimeGenerated
      } | ConvertTo-Json
    }
  }
  else {
    Write-Output "null"
  }
}
function get-date {
  Get-Date -Format "MM/dd/yyyy HH:mm:ss"
}
function Start-FunctionsAndGenerateJson {
  $functionsList = @(
    "check_disk"
    "check_info"
    "check_omDiskStatus"
    "check_omRaidStatus"
    "check_omChassisStatus"
    "check_wsb"
    "check_veeam"
    "check_reliability"
    "check_speedtest"
  )

  $var_results = @{}

  for ($i = 0; $i -lt $functionsList.Length; $i += 1) {
    $functionName = $functionsList[$i]

    $result = & $functionName
    $var_results[$functionName.Replace("check_", "")] = $result | ConvertFrom-Json
  }

  $var_results | ConvertTo-Json -Depth 100 | Out-File "data.json" -Encoding utf8
}

function Update-Html {
  param (
    [string]$oldString,
    [string]$jsonFilePath
  )
  $filePath = ".\dist\index.html"
  $newString = Get-Content -Path $jsonFilePath -Raw | ConvertFrom-Json | ConvertTo-Json
  (Get-Content -Path $filePath -Raw) -replace [regex]::Escape($oldString), $newString | Set-Content -Path $filePath
}

Start-FunctionsAndGenerateJson
Update-Html "TEMPLATE_VERSION" "VERSION"
Update-Html '"TEMPLATE_DATA"' "data.json"
