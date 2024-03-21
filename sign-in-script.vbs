Option Explicit

Dim objNetwork, objShell
Dim strUserName, strNewPassword, strConfirmPassword
Dim strDriveLetter, strNetworkPath

' Initialize network and shell objects
Set objNetwork = CreateObject("WScript.Network")
Set objShell = CreateObject("WScript.Shell")

' Get current user name
strUserName = objNetwork.UserName

' Check if the user has logged in for the first time
If Not objShell.RegRead("HKCU\Software\MyCompany\FirstTimeLogin") Then
    ' Prompt user to update password
    Do
        strNewPassword = InputBox("Please enter a new password." & vbCrLf & _
                                  "Password must be at least 14 characters long," & vbCrLf & _
                                  "and contain at least one capital letter, one symbol, and one number.", _
                                  "Change Password")
        strConfirmPassword = InputBox("Please confirm your new password.", "Confirm Password")
        
        ' Validate password requirements
        If Len(strNewPassword) < 14 Then
            MsgBox "Password must be at least 14 characters long.", vbExclamation, "Invalid Password"
        ElseIf Not ContainsUpperCase(strNewPassword) Then
            MsgBox "Password must contain at least one capital letter.", vbExclamation, "Invalid Password"
        ElseIf Not ContainsSymbol(strNewPassword) Then
            MsgBox "Password must contain at least one symbol.", vbExclamation, "Invalid Password"
        ElseIf Not ContainsNumber(strNewPassword) Then
            MsgBox "Password must contain at least one number.", vbExclamation, "Invalid Password"
        ElseIf strNewPassword <> strConfirmPassword Then
            MsgBox "Passwords do not match. Please try again.", vbExclamation, "Invalid Password"
        Else
            ' Update password
            objShell.Run "net user " & strUserName & " " & strNewPassword
            ' Set flag indicating first time login
            objShell.RegWrite "HKCU\Software\MyCompany\FirstTimeLogin", 1, "REG_DWORD"
            ' Map network drive
            MapNetworkDrive
            MsgBox "Password changed successfully. You can now access the network drive.", vbInformation, "Success"
            Exit Do
        End If
    Loop
End If

' Function to check if string contains at least one uppercase letter
Function ContainsUpperCase(str)
    Dim i
    ContainsUpperCase = False
    For i = 1 To Len(str)
        If Asc(Mid(str, i, 1)) >= 65 And Asc(Mid(str, i, 1)) <= 90 Then
            ContainsUpperCase = True
            Exit Function
        End If
    Next
End Function

' Function to check if string contains at least one symbol
Function ContainsSymbol(str)
    Dim symbols
    symbols = "!@#$%^&*()-_=+[{]};:'"",<.>/?"
    Dim symbol
    ContainsSymbol = False
    For Each symbol In Split(symbols, "")
        If InStr(str, symbol) > 0 Then
            ContainsSymbol = True
            Exit Function
        End If
    Next
End Function

' Function to check if string contains at least one number
Function ContainsNumber(str)
    Dim i
    ContainsNumber = False
    For i = 1 To Len(str)
        If IsNumeric(Mid(str, i, 1)) Then
            ContainsNumber = True
            Exit Function
        End If
    Next
End Function

' Subroutine to map network drive
Sub MapNetworkDrive()
    strDriveLetter = "Z:"
    strNetworkPath = "\\server\share"
    objNetwork.MapNetworkDrive strDriveLetter, strNetworkPath
End Sub
