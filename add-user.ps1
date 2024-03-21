# Prompt for user's name
$name = Read-Host -Prompt "Enter user's name"

# Assign password
$password = ConvertTo-SecureString -String "PASSWORD" -AsPlainText -Force

# Create new user
New-ADUser -Name $name -AccountPassword $password -PasswordNeverExpires $true

# Add user to group
Add-ADGroupMember -Identity "users" -Members $name

# Set first-time sign-in script
Set-ADUser -Identity $name -ScriptPath "first_time_login_script.bat"

# Create directory on network file server
New-Item -Path "\\fileserver\users\$name" -ItemType Directory
