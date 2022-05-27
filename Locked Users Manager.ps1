$DOMAIN = "SMARTCORE"
$ADMINISTRATOR_USER = "Administrator"
$ADMINISTRATOR_PASSWORD = "Pa55w.rd"

# create Credential Object, to use with PS Sessions
$pass = ConvertTo-SecureString -String $ADMINISTRATOR_PASSWORD -AsPlainText -Force
$cred = New-Object System.Management.Automation.PSCredential -ArgumentList ($DOMAIN + "\" + $ADMINISTRATOR_USER), $pass

Set-ExecutionPolicy -ExecutionPolicy AllSigned -Scope LocalMachine

# get all locked users
$locked = Search-ADAccount -LockedOut
# do if founded locked userse
if(($locked | measure).Count -gt 0) {
    $selected = $locked | select name,userprincipalname,LastLogonDate,distinguishedname `
                        | Out-GridView -OutputMode Multiple -Title "Select users to unlock"
    # unlocked selected accounts
    $selected | % { 
        try {
            Unlock-ADAccount -Identity $_.DistinguishedName 
            Write-Host ($_.Name + "'s account unlocked successfuly") -ForegroundColor White -BackgroundColor Green
        }
        catch { Write-Host ("Could'nt unlock" + $_.Name + "'s account") -ForegroundColor White -BackgroundColor Red } 
    }
} else {
    # write no locked accounts found message
    Write-Host "There are no locked accounts" -ForegroundColor Yellow -BackgroundColor Black
}