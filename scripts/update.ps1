###
# Update
###

Write-Host "`n Mise à jour en cours" -ForegroundColor Green

Stop-Process -Force -Name "MonIT" -ErrorAction SilentlyContinue
Stop-Process -Force -Name "speedtest" -ErrorAction SilentlyContinue
Stop-Process -Force -Name "tiny" -ErrorAction SilentlyContinue

Start-sleep 2

[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
Invoke-WebRequest -useb https://raw.githubusercontent.com/Fl0wyn/MonIT/master/scripts/install.ps1 | Invoke-Expression

Start-Process -FilePath "$env:USERPROFILE\Desktop\MonIT.exe" -Wait