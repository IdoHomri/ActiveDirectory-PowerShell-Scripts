
#change manually
$Grouppath = "OU=Test,DC=ido,DC=tests"

$Groupname = [string]::Empty

do {
    $Groupname = Read-Host "Group Name"
    if (($Groupname -eq $null) -or ($Groupname.Trim().Length -lt 1)) {
       Write-Host "Group name can not be null" -ForegroundColor White -BackgroundColor Red
       $Groupname = [string]::Empty
    }
} while ($Groupname -eq [string]::Empty)


$Description = Read-Host "Description of the Group"
New-ADGroup -Name "$Groupname" `
            -SamAccountName $Groupname `
            -GroupCategory Security `
            -GroupScope Global `
            -DisplayName $Groupname `
            -Path $Grouppath `
            -Description $Description
