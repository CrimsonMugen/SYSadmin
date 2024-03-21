import subprocess

# Prompt for user's name
name = input("Enter user's name: ")

# Assign password
password = "PASSWORD"

# Create new user
subprocess.run(["net", "user", name, password, "/add"])

# Add user to group
subprocess.run(["net", "localgroup", "users", name, "/add"])

# Set first-time sign-in script (not directly available in Python)
# You may need to manually set this through PowerShell or VBScript

# Create directory on network file server
subprocess.run(["mkdir", "\\\\fileserver\\users\\" + name])
