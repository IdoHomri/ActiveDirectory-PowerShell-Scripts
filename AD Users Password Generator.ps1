$special_chars = @('!','@','#','$','&','?')

# generate and set users passwords
$ou = "Test"
$users = Get-ADUser -Filter * -SearchBase ("OU=" + $ou + ",DC=Smartcore,DC=com") -Properties *
$users | % {
    $pass = ""
    for ($i = 0; $i -lt  10; $i++) {
        # set the current character type: 0='a'-'b', 1='A'-'B', 2=number, 3=speacial char
        $char_type = Get-Random -Minimum 0 -Maximum 4
        $current_char = ''
        Do {
            Switch ($char_type) {
                0 { $current_char = [char](Get-Random -Minimum 65 -Maximum 91) }
                1 { $current_char = [char](Get-Random -Minimum 97 -Maximum 123) }
                2 { $current_char = Get-Random -Minimum 0 -Maximum 10 }
                3 { $current_char = $special_chars[(Get-Random -Minimum 0 -Maximum ($special_chars.Length))] }
            }
        } While ($pass.Contains($current_char))
        $pass += $current_char
    }
    $pass

    Set-ADAccountPassword -Identity $PSItem.DistinguishedName -Reset -NewPassword (ConvertTo-SecureString -AsPlainText $pass -Force)
}

# export to CSV
$path = "C:\Users\admin.SMARTCORE\Desktop\"
$file_name = (Get-Date).ToShortDateString().Replace("/","-") + "_" + (Get-Date).ToShortTimeString().Replace(":","-") + "_" + $ou +".csv"
$users | select -Property Name, UserPrincipalName, PasswordLastSet | Export-Csv -Path ($path + $file_name)

