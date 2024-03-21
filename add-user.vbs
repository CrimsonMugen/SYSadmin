Option Explicit

Dim strName, objUser, objGroup, objNetwork
Dim strPassword, strScriptPath, strDirectoryPath

' Prompt for user's name
strName = InputBox("Enter user's name")

' Assign password
strPassword = "PASSWORD"

' Create new user
Set objUser = GetObject("WinNT://./" & strName & ",user")
objUser.SetPassword strPassword
objUser.SetInfo

' Add user to group
Set objGroup = GetObject("WinNT://./users,group")
objGroup.Add(objUser.ADsPath)

' Set first-time sign-in script
strScriptPath = "\\server\scripts\first_time_login.vbs"
objUser.Put "LoginScript", strScriptPath
objUser.SetInfo

' Create directory on network file server
strDirectoryPath = "\\fileserver\users\" & strName
Set objNetwork = CreateObject("WScript.Network")
objNetwork.MapNetworkDrive "Z:", strDirectoryPath
