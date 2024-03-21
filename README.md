# SYSadmin
General sys admin automation & managment.

# Sign-in-script

<ins>**Info:**<ins>
- Please be aware these are just drafts and not intended to be used with out modifications to ensure security complience and general needs. The Sign-In-Script's are designed to be run the first time a windows user signs into their account while connected to a domain. There are three scripts writtin in VBS, Python and PS1.

<ins>**Features:**<ins>
- automatically maps network drive
- requires first time sign in password change
- sets password requirments ( 14 char min, special character, number )

<ins>**Notes:**<ins>
- Make sure to replace "\\server\share" with the actual path of your network drive that you want to map. Additionally, replace "HKCU:\Software\MyCompany" with a suitable path for your organization. These scripts also use registry keys to determine whether it's the user's first login.

# Go-Phish

<ins>**Info:**<ins>
- Draft HTML page used for internal phishing for employee education purposes. This form includes fields for name, number, and email, along with a submit button. The image is displayed at the top of the form within the designated image container.

<ins>**Notes:**<ins>
- Replace "your_image.png" with the actual path to your PNG image.

# Add-User

<ins>**Info:**<ins>
- **THIS HAS NOT BEEN TESTED** These are drafted scripts to add users to a windows domain.

<ins>**Notes:**<ins>
- Replace "PASSWORD" with the desired password and adjust the paths ("\\fileserver\users\", "\\server\scripts\") as necessary for your environment. Additionally, for setting the first-time sign-in script, you may need to manually run a PowerShell or VBScript command to set the script path (Set-ADUser in PowerShell or objUser.Put in VBScript) as this functionality is not directly available in Python.

# deb-test

<ins>**Info:**<ins>
- This is a draft to automate the installation of various repos and packages within a debian linux enviorment.

<ins>**Notes:**<ins>
- This script is very limited at the moment, its currently only used for updating the system and adding the Docker repo and packages to the OS.
