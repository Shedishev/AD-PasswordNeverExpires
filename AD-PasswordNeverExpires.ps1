$users = "%username1%","%username2%"
Foreach ($username in $users){
$user = Get-ADUser -identity $username -properties pwdlastset
#Before Changed
echo "user $username pwd was set";[datetime]::FromFileTime($user.pwdlastset)
$user.pwdlastset =0
set-aduser -Instance $user
$user.pwdlastset = -1
set-aduser -Instance $user
$user = Get-ADUser -identity $username -properties pwdlastset
#After Changed
echo "user $username pwd is now set to";[datetime]::FromFileTime($user.pwdlastset)
Get-ADUser -Identity $username | 
 Set-ADUser -PasswordNeverExpires:$False
}
