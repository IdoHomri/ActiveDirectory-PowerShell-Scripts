$pass_length = 0
$pass = ""

$special_chars = @('!','@','#','$','&','?')

# request for password length, do untill length is correct
Do {

    # validate input 
    Try { 
        $pass_length = [int]::Parse((Read-Host "Enter Password Length"))
    } 
    Catch { Write-Host " --- incorrect input, try again --- " }

    # validate that maximum length is 20 characters
    if ($pass_length -gt 20) {
        Write-Host " --- maximum password length must be 20 ---"
        $pass_length = 0
    }

} While ($pass_length -eq 0)



# generate pasword
for ($i = 0; $i -lt  $pass_length; $i++) {
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

# print generated password
Write-Host "Generated $pass_length Characters Password: $pass" -ForegroundColor Yellow -BackgroundColor Black
# copy to clipboard
Set-Clipboard -Value $pass
Write-Host "Copied To Clipboard!" -ForegroundColor Green -BackgroundColor Black
# paues script
Read-Host