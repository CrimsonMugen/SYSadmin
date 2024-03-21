import ctypes
import subprocess
import getpass
import re

def is_first_login():
    try:
        reg_query = subprocess.check_output(["reg", "query", "HKCU\\Software\\MyCompany", "/v", "FirstTimeLogin"], stderr=subprocess.DEVNULL)
        return False
    except subprocess.CalledProcessError:
        return True

def change_password():
    while True:
        new_password = getpass.getpass("Please enter a new password:\nPassword must be at least 14 characters long, and contain at least one capital letter, one symbol, and one number.\n")
        confirm_password = getpass.getpass("Please confirm your new password:\n")
        
        if len(new_password) < 14:
            print("Password must be at least 14 characters long.")
        elif not re.search(r"[A-Z]", new_password):
            print("Password must contain at least one capital letter.")
        elif not re.search(r"\d", new_password):
            print("Password must contain at least one number.")
        elif not re.search(r"[!@#$%^&*()-_=+[{]};:'\",<.>/?]", new_password):
            print("Password must contain at least one symbol.")
        elif new_password != confirm_password:
            print("Passwords do not match. Please try again.")
        else:
            subprocess.run(["net", "user", getpass.getuser(), new_password])
            subprocess.run(["reg", "add", "HKCU\\Software\\MyCompany", "/v", "FirstTimeLogin", "/t", "REG_DWORD", "/d", "1", "/f"])
            print("Password changed successfully.")
            map_network_drive()
            break

def map_network_drive():
    subprocess.run(["net", "use", "Z:", "\\server\share"])

if is_first_login():
    change_password()
