###
# App
###

<#
[int[]][char[]]'à' = $([char]224)
[int[]][char[]]'é' = $([char]233)
[int[]][char[]]'è' = $([char]232)
#>

#
# List Disk
#
function func_disk {
    $CmdDisk = Get-CimInstance -ClassName Win32_LogicalDisk -Filter "DriveType=3" | Select-Object -Property DeviceID, VolumeName, FreeSpace, Size | ConvertTo-Json
    if ( (Get-CimInstance -ClassName Win32_LogicalDisk -Filter "DriveType=3" | Measure-Object).Count -eq "1") {
        function buildJson {
            Write-Output "["
            $CmdDisk
            Write-Output "]"
        }
        buildJson
    }
    else {
        $CmdDisk
    }
}

#
# Information
#
function func_info {
    $Serial = Get-WmiObject win32_bios | Select-Object -ExpandProperty SerialNumber
    $Os = (Get-WmiObject Win32_OperatingSystem).Caption
    $lastReboot = (Get-CimInstance Win32_OperatingSystem | Select-Object -ExpandProperty LastBootUpTime | Out-String).trim()
    $Memory = (Get-CimInstance Win32_ComputerSystem | Format-Wide TotalPhysicalMemory | Out-String).trim()
    $Procesor = (Get-CimInstance -ClassName Win32_Processor | Format-Wide Name -Autosize | Out-String).trim()
    $Manufacturer = (Get-CimInstance -ClassName Win32_ComputerSystem | Format-Wide Manufacturer | Out-String).trim()
    $Model = (Get-CimInstance -ClassName Win32_ComputerSystem | Format-Wide Model | Out-String).trim()
    $ManufacturerModel = $Manufacturer + ' ' + $Model
    function buildJson {
        Write-Output "{"
        Write-Output "`"hostname`":{ `"name`": `"Nom de la machine`", `"val`": `"$env:computername`"},"
        Write-Output "`"os`":{ `"name`": `"Syst$([char]232)me d'exploitation`", `"val`": `"$Os`"},"
        Write-Output "`"memory`":{ `"name`": `"M$([char]233)moire`", `"val`": `"$Memory`"},"
        Write-Output "`"procesor`":{ `"name`": `"Processeur`", `"val`": `"$Procesor`"},"
        Write-Output "`"manufacturer`":{ `"name`": `"Fabricant`", `"val`": `"$ManufacturerModel`"},"
        Write-Output "`"serialnumber`":{ `"name`": `"Numero de s$([char]233)rie`", `"val`": `"$Serial`"},"
        Write-Output "`"lastreboot`":{ `"name`": `"Dernier red$([char]233)marrage`", `"val`": `"$lastReboot`"}"
        Write-Output "}"
    }
    buildJson
}

#
# Disk status (OpenManage)
#
function func_omDiskStatus {
    if (Get-Command omreport -errorAction SilentlyContinue) {
        omconfig preferences cdvformat delimiter=asterisk | out-null
        $OmReport = omreport storage pdisk controller=0 -fmt cdv | select-string -SimpleMatch "ID*Status" -Context 0, 5000

        if ($OmReport) {
            $Parray = convertfrom-csv $OmReport -Delimiter "*"
            $DiskStatus += "["
            foreach ($PhysicalDisk in $Parray) {
                $DiskStatus += "{ `
                `"name`": `"$($PhysicalDisk.Name)`", `
                `"status`": `"$($PhysicalDisk.Status)`", `
                `"state`": `"$($PhysicalDisk.State)`", `
                `"failure`": `"$($PhysicalDisk.'Failure Predicted')`", `
                `"capacity`": `"$($PhysicalDisk.'Capacity')`"},"
            }
            $DiskStatus -replace '.$', ']'
        }
        else {
            Write-Output "null"
        }
    }
    else {
        Write-Output "null"
    }
}

#
# RAID status (OpenManage)
#
function func_omRaidStatus {
    if (Get-Command omreport -errorAction SilentlyContinue) {
        omconfig preferences cdvformat delimiter=asterisk | out-null
        $OmReport = omreport storage vdisk -fmt cdv | select-string -SimpleMatch "ID*Status" -Context 0, 5000

        if ($OmReport) {
            $VDarray = convertfrom-csv $OmReport -Delimiter "*"
            $RAIDStatus += "["
            foreach ($VirtualDisk in $VDarray) {
                $RAIDStatus += "{ `
                `"name`": `"$($VirtualDisk.Name)`", `
                `"layout`": `"$($VirtualDisk.Layout)`", `
                `"status`": `"$($VirtualDisk.Status)`", `
                `"state`": `"$($VirtualDisk.State)`", `
                `"media`": `"$($VirtualDisk.Media)`"},"
            }
            $RAIDStatus -replace '.$', ']'
        }
        else {
            Write-Output "null"
        }
    }
    else {
        Write-Output "null"
    }
}

#
# Chassis status (OpenManage)
#
function func_omChassisStatus {
    if (Get-Command omreport -errorAction SilentlyContinue) {
        omconfig preferences cdvformat delimiter=asterisk | out-null
        $OmReport = omreport chassis -fmt cdv | select-string -SimpleMatch "*"
        $Parray = convertfrom-csv $OmReport -Delimiter "*"
        $ChassisStatus += "["
        foreach ($i in $Parray) {
            $Component = $i -replace '}', '' -split (" COMPONENT=") 
            $Severity = $Component -replace ';', '' -split ("SEVERITY=")
            $ChassisStatus += "{`
                `"component`": `"$($Component[1])`", `
                `"severity`": `"$($Severity[1])`"},"
        }
        $ChassisStatus -replace '.$', ']'
    }
    else {
        Write-Output "null"
    }
}

#
# Network
#
function func_speedtest {
    $Folder = "C:\Exploitation\MonIT"
    $SpeedTest = Invoke-Expression -Command "$Folder\speedtest.exe -f json --accept-license --accept-gdpr" 2> $null

    if ($?) {
        $SpeedTest
    }
    else {
        Write-Output "null"
    }
}

#
# Backup : WSB
#
function func_wsb {
    if (Get-Command Get-WBSummary -errorAction SilentlyContinue) {
        $WsbTest = Get-WBSummary 
        $LastSuccessfulBackupTime = ($WsbTest | Format-Wide LastSuccessfulBackupTime | Out-String).trim()
        $NumberOfVersions = ($WsbTest | Format-Wide NumberOfVersions | Out-String).trim()
        function buildJson {
            Write-Output "{"
            Write-Output "`"LastSuccessfulBackupTime`": `"$LastSuccessfulBackupTime`","
            Write-Output "`"NumberOfVersions`": `"$NumberOfVersions`""
            Write-Output "}"
        }
        buildJson
    }
    else {
        Write-Output "null"
    }
}

#
# Backup : Veeam
#
function func_veeam {
    $EventLogName = "Veeam Agent"    
    if ( ($(Get-EventLog -List).Log.Contains($EventLogName)) -And (Get-EventLog -LogName "Veeam Agent" | Where-Object { $_.InstanceId -eq 190 }) ) {
        $VeeamLog = Get-EventLog -LogName $EventLogName -InstanceId 190
        $VeeamResult = $VeeamLog | Select-Object -first 1
        $VeeamMessage = ($VeeamResult | Format-Wide -Property Message -Autosize | Out-String).trim()
        $VeeamTime = ($VeeamResult | Format-Wide -Property TimeWritten | Out-String).trim()
        function buildJson {
            Write-Output "{"
            Write-Output "`"Message`": `"$VeeamMessage`","
            Write-Output "`"TimeWritten`": `"$VeeamTime`""
            Write-Output "}"
        }
        buildJson
    }
    else {
        Write-Output "null"
    }
}

#
# Reliability History
#
function func_reliability {
    $EventReliability = Get-wmiobject Win32_ReliabilityRecords
    [bool]$EventReliability | Out-Null
    if ($EventReliability) {
        $EventReliability | Select-Object -first 8 SourceName, Message, TimeGenerated | ConvertTo-Json
    }
    else {
        Write-Output "null"
    }
}