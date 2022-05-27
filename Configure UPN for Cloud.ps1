Set-ADForest -Identity smartcore.com -UPNSuffixes @{replace="smartcore.onmicrosoft.com"}

# get all users in sales
$usersSales = Get-ADUser -Filter * -SearchBase "OU=Sales,OU=Tel-Aviv,OU=ouBranches,DC=smartcore,DC=com" -Properties SamAccountName
$usersCustServ = Get-ADUser -Filter * -SearchBase "OU=Customer Service,OU=New-York,OU=ouBranches,DC=smartcore,DC=com" -Properties SamAccountName
$usersCAdmins = Get-ADUser -Filter * -SearchBase "OU=CloudAdmins,DC=smartcore,DC=com" -Properties SamAccountName

# re-create upn
$usersSales | % { 
    Set-ADUser -Identity $_ -UserPrincipalName ($_.SamAccountName + "@smartcorecorp.onmicrosoft.com" )
}
$usersCustServ | % { 
    Set-ADUser -Identity $_ -UserPrincipalName ($_.SamAccountName + "@smartcorecorp.onmicrosoft.com" )
}
$usersCAdmins | % { 
    Set-ADUser -Identity $_ -UserPrincipalName ($_.SamAccountName + "@smartcorecorp.onmicrosoft.com" )
}

# check
$usersSales | % { write $_.UserPrincipalName}
$usersCustServ | % { write $_.UserPrincipalName}
$usersCAdmins | % { write $_.UserPrincipalName}