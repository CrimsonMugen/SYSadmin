#!/bin/bash

# Prompt user for update
read -p "Would you like to update the OS and all installed packages? (yes/no): " update_choice

if [[ $update_choice == "yes" ]]; then
    sudo apt-get update && sudo apt-get upgrade -y
    echo "Update completed."
elif [[ $update_choice == "no" ]]; then
    echo "Skipping update."
else
    echo "Invalid input. Skipping update."
fi

# Prompt user for Docker installation
read -p "Would you like to install Docker? (yes/no): " docker_choice

if [[ $docker_choice == "yes" ]]; then
    # Add Docker's official GPG key
    sudo apt-get update
    sudo apt-get install -y ca-certificates curl
    sudo install -m 0755 -d /etc/apt/keyrings
    sudo curl -fsSL https://download.docker.com/linux/debian/gpg -o /etc/apt/keyrings/docker.asc
    sudo chmod a+r /etc/apt/keyrings/docker.asc
    
    # Add the repository to Apt sources
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/debian \
        $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
        sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
    sudo apt-get update
    
    # Install Docker
    sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose
    echo "Docker installation completed."
elif [[ $docker_choice == "no" ]]; then
    echo "Skipping Docker installation."
else
    echo "Invalid input. Skipping Docker installation."
fi

# Prompt user for Nala installation
read -p "Would you like to install Nala? (yes/no): " nala_choice

if [[ $nala_choice == "yes" ]]; then
    sudo apt-get install -y nala
    echo "Nala installation completed."
elif [[ $nala_choice == "no" ]]; then
    echo "Skipping Nala installation."
else
    echo "Invalid input. Skipping Nala installation."
fi

echo "Complete!"
