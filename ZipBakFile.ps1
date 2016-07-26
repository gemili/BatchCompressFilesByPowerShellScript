<#   
This script compress all .bak files {sql backups} in there cureent folder and make new .7zip file. 
#> 
 
$BakFileDir = "E:\sqlbak\2016" 
$ScriptDir = Split-Path $script:MyInvocation.MyCommand.Path

Write-Host "Current script directory is $ScriptDir"
 
if (-not (test-path "$ScriptDir\7-Zip\7za.exe")) {throw "7za.exe needed"} 
set-alias za "$ScriptDir\7-Zip\7za.exe" 

$baks = Get-ChildItem -Path $BakFileDir | Where-Object { $_.Extension -eq ".bak" } 
 
########### END of VARABLES ################## 
 
foreach ($file in $baks) { 
                    $name = $file.name 
                    $directory = $file.DirectoryName
		    Write-Host "Current file is $directory\$name"
                    $zipfile = $name.Replace(".bak",".zip") 
                    za a -tzip -plianfu@2016 "$directory\$zipfile" "$directory\$name" 
		    Remove-Item $directory\$name
                } 
 
########### END OF SCRIPT ########## 

