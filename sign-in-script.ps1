function IsFirstLogin {
    try {
        $null = Get-ItemProperty -Path "HKCU:\Software\MyCompany" -Name "FirstTimeLogin" -ErrorAction Stop
        return $false
    } catch {
        return $true
    }
}

function ChangePassword {
    while ($true) {
        $newPassword = Read-Host -Prompt "Please enter a new password:`nPassword must be at least 14 characters long, and contain at least one capital letter, one symbol, and one number." -AsSecureString
        $newPassword = [System.Runtime.InteropServices.Marshal]::PtrToStringAuto([System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($newPassword))
        $confirmPassword = Read-Host -Prompt "Please confirm your new password:" -AsSecureString
        $confirmPassword = [System.Runtime.InteropServices.Marshal]::PtrToStringAuto([System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($confirmPassword))
        
        if ($newPassword.Length -lt 14) {
            Write-Host "Password must be at least 14 characters long."
        } elseif (-not $newPassword -cmatch "[A-Z]") {
            Write-Host "Password must contain at least one capital letter."
        } elseif (-not $newPassword -cmatch "\d") {
            Write-Host "Password must contain at least one number."
        } elseif (-not $newPassword -cmatch "[!@#$%^&*()-_=+[{]};:'\",<.>/?]") {
            Write-Host "Password must contain at least one symbol."
        } elseif ($newPassword -ne $confirmPassword) {
            Write-Host "Passwords do not match. Please try again."
        } else {
            $newPassword = ConvertTo-SecureString -String $newPassword -AsPlainText -Force
            Set-LocalUser -Name $env:USERNAME -Password $newPassword
            New-ItemProperty -Path "HKCU:\Software\MyCompany" -Name "FirstTimeLogin" -Value 1 -PropertyType DWORD -Force | Out-Null
            Write-Host "Password changed successfully."
            MapNetworkDrive
            break
        }
    }
}

function MapNetworkDrive {
    net use Z: "\\server\share"
}

if (IsFirstLogin) {
    ChangePassword
}
