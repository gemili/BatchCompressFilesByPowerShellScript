$ScriptDir = Split-Path $script:MyInvocation.MyCommand.Path
Write-Host "Current script directory is $ScriptDir"

Get-Content "$ScriptDir\config.ini" | foreach-object -begin {$h=@{}} -process { $k = [regex]::split($_,'='); if(($k[0].CompareTo("") -ne 0) -and ($k[0].StartsWith("[") -ne $True)) { $h.Add($k[0], $k[1]) } }
$BakFileDir = $h.DirToProcess
$extention = $h.ext
$password = $h.pwd
$type = $h.type

Write-Host "Current bak directory is $BakFileDir"

if (-not (test-path "$ScriptDir\7-Zip\7za.exe")) {throw "7za.exe needed"} 
set-alias compress "$ScriptDir\7-Zip\7za.exe" 

$baks = Get-ChildItem -Path $BakFileDir | Where-Object { $_.Extension -eq ".$extention" } 
 
########### END of VARABLES ################## 
 
foreach ($file in $baks) { 
                    $name = $file.name 
                    $directory = $file.DirectoryName
		    Write-Host "Current file is $directory\$name"
                    $zipfile = $name.Replace(".$extention",".$type") 
                    compress a -t$type -p$password "$directory\$zipfile" "$directory\$name" 
		    Remove-Item $directory\$name
                } 
 
########### END OF SCRIPT ########## 

