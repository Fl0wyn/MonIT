<# 
.SYNOPSIS
    Replaces a string in a file with a string from a json file.
#>

function Update-Html {
    param ([string]$oldString, [string]$jsonFilePath)
    $filePath = ".\dist\index.html"
    $newString = Get-Content -Path $jsonFilePath -Raw | ConvertFrom-Json | ConvertTo-Json
    (Get-Content -Path $filePath -Raw ) -replace [regex]::Escape($oldString), $newString | Set-Content -Path $filePath
}

Update-Html "TEMPLATE_VERSION" "VERSION"
Update-Html "`"TEMPLATE_DATA`"" "data.json"