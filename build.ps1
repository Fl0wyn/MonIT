# Pour construire l'exécutable de mise à jour .\build.ps1 u
$IsUp = $args[0]
if ($IsUp) {
  ps2exe `
    -inputFile .\scripts\update.ps1 `
    -outputFile .\MonIT-Update.exe `
    -iconFile .\src\assets\update.ico `
    -title 'MonIT - Update' `
    -product 'MonIT - Update' `
    -copyright 'GPL-3.0 License' `
    -version "1.0.0"
  Exit
}

ps2exe `
  -inputFile .\scripts\server.ps1 `
  -outputFile .\MonIT.exe `
  -iconFile .\public\favicon.ico `
  -title 'MonIT' `
  -product 'MonIT' `
  -copyright 'GPL-3.0 License' `
  -version "1.0.0"

$FolderDist = ".\MonIT"
$Version = $(Get-Content .\VERSION)
$File = "MonIT.zip"

yarn build

Rename-Item .\dist $FolderDist
Remove-Item $FolderDist\data.json

#Move-Item .\MonIT.exe $FolderDist
Copy-Item .\scripts\app.ps1 $FolderDist
Copy-Item .\VERSION $FolderDist
Copy-Item .\exe\* $FolderDist 

Compress-Archive $FolderDist $File

function PushGitHub {
  $filelog = ".\CHANGELOG.md"
  $lines = Get-Content $filelog
  $rem = @()

  @("---") | ForEach-Object {
    $rem += $lines[(($lines | Select-String -Pattern "$_").LineNumber)..`
    (($lines | Select-String -Pattern "$_").LineNumber + 1000)]
  }
    (Compare-Object $lines $rem | Select-Object -ExpandProperty InputObject) `
    -Replace '---' | Where-Object { $_ -ne "" } | Set-Content .\.GITLOG.md

  gh release create v$Version --title "Release v$Version" --notes-file .\.GITLOG.md $File
  Remove-Item .\.GITLOG.md
}

PushGitHub

Remove-Item -Recurse $FolderDist
Remove-Item *.zip