#Created by https://github.com/VladimirKosyuk

#Find events of interacting with files in stored event log for a list of accounts
#
# Build date: 21.09.2020									   
 
#-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


#path to result output file
$LogOut = 
#list of user accounts
$list = 
#path where event log is stored, could be a directory
$LogStore =
$item = get-childitem $LogStore | where-object {$_.CreationTime -ge ((Get-Date).AddMonths(-1))} | select-object -ExpandProperty FullName
foreach ($I in $Item){foreach ($L in $list){(get-winevent -filterhashtable @{path=$I;Id='4663';data=$L} -ErrorAction SilentlyContinue| Select-Object -ExpandProperty Message) -split "`n"| select-string -pattern 'Account Name', 'Object Name', 'Accesses' | Select-Object -ExpandProperty Line| out-file $LogOut -Append}}
Remove-Variable -Name * -Force -ErrorAction SilentlyContinue