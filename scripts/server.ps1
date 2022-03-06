###
# Server
###

$OutFile = "$env:USERPROFILE\Desktop\MonIT-Update.exe"
Remove-Item $OutFile -Force -ErrorAction SilentlyContinue 

$VersionLocal = Get-Content .\VERSION
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
$VersionGit = (Invoke-WebRequest -URI https://raw.githubusercontent.com/Fl0wyn/MonIT/master/VERSION | Format-Wide Content | Out-String).trim()

Write-Host "`n MonIT - v$VersionLocal (https://github.com/Fl0wyn/MonIT)" -ForegroundColor Yellow

function FuncOut($nb, $name) {
    $Total = 9
    Write-Host " [$nb/$Total]" -ForegroundColor DarkGreen -NoNewline
    Write-Host $name
}

#
#
#
if ($VersionLocal -ne $VersionGit ) {
    Write-Host "`n Une Mise à jour est disponible !" -ForegroundColor Green
    Write-Output "`n Exécuter `"MonIT-Update.exe`" présent sur le bureau"

    [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
    Invoke-WebRequest -useb https://github.com/Fl0wyn/MonIT/raw/master/MonIT-Update.exe -OutFile $OutFile

    Start-Sleep 15
}

Write-Output "`n Génération du rapport d'information..`n"

. .\app.ps1

$PortWeb = 3011
Stop-Process -Force -Name "tiny" -ErrorAction SilentlyContinue

$var_disk = func_disk ; FuncOut 1 "  Liste des disques" ;
$var_info = func_info ; FuncOut 2 "  Information Système"; 
$var_omDiskStatus = func_omDiskStatus ; FuncOut 3 "  Santé des disques"; 
$var_omRaidStatus = func_omRaidStatus ; FuncOut 4 "  Santé des RAID"; 
$var_omChassisStatus = func_omChassisStatus ; FuncOut 5 "  Santé du matériel"; 
$var_wsb = func_wsb ; FuncOut 6 "  Sauvegardes WSB"; 
$var_veeam = func_veeam ; FuncOut 7 "  Sauvegardes Veeam"; 
$var_reliability = func_reliability ; FuncOut 8 "  Historique de fiabilité"; 
$var_speedtest = func_speedtest ; FuncOut 9 "  Information Réseau"

function buildAllJson {
    Write-Output "{"
    Write-Output "`"disk`": $var_disk,"
    Write-Output "`"info`": $var_info,"
    Write-Output "`"omDiskStatus`": $var_omDiskStatus,"
    Write-Output "`"omRaidStatus`": $var_omRaidStatus,"
    Write-Output "`"omChassisStatus`": $var_omChassisStatus,"
    Write-Output "`"speedtest`": $var_speedtest,"
    Write-Output "`"wsb`": $var_wsb,"
    Write-Output "`"veeam`": $var_veeam,"
    Write-Output "`"reliability`": $var_reliability"
    Write-Output "}"
}

buildAllJson | Out-File ".\data.json"

Write-Host -ForegroundColor DarkGreen "`n Terminé !"
.\tiny.exe "$(Get-Location)" $PortWeb

Start-sleep 1
Start-Process http://localhost:$PortWeb 
Start-sleep 30

Stop-Process -Force -Name "tiny"
