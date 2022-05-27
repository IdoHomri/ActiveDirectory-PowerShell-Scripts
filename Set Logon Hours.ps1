# OU 
$searchBase = "OU=,OU=,OU=,DC=,DC="

# get all Manufacturing departments users
$users = Get-ADUser -Filter * -SearchBase $searchBase
            
# allow logon 9am - 5pm Sunday to Thursday
# every 3 bytes represents a day, 1 byte represents 8 hours of a day
# every 1 bit represent an hour (1,2,4,8,16,32,64,128,256)
[byte[]]$hours = @(128,127,0,128,127,0,128,127,0,128,127,0,128,127,0,0,0,0,0,0,0)        

# apply logon hours to selected users
$users | % { Set-ADUser -Identity $_ -Replace @{logonhours = $hours} }