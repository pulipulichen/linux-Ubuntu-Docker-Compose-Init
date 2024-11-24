#!/bin/bash

if ! command -v docker &> /dev/null; then
  curl -fsSL https://get.docker.com -o get-docker.sh
  bash get-docker.sh
  rm -f get-docker.sh
fi

if ! command -v docker-compose &> /dev/null; then
  apt install -y docker-compose
fi

if [[ ! -f Dockerfile ]]; then
  curl -fsSL https://pulipulichen.github.io/linux-Ubuntu-Docker-Compose-Init/assets/Dockerfile -o Dockerfile
fi

if [[ ! -f docker-compose.yml ]]; then
  curl -fsSL https://pulipulichen.github.io/linux-Ubuntu-Docker-Compose-Init/assets/docker-compose.yml -o docker-compose.yml
fi

if [[ ! -f startup.sh ]]; then
  curl -fsSL https://pulipulichen.github.io/linux-Ubuntu-Docker-Compose-Init/assets/startup.sh -o startup.sh
  chmod +x startup.sh
fi

# =================================================================

# Function to check and append command to /etc/crontab if not present
check_and_append_crontab() {
    local command_to_check="$1"
    if ! grep -q "$command_to_check" /etc/crontab; then
        echo "$command_to_check" | sudo tee -a /etc/crontab > /dev/null
        echo "Command appended to /etc/crontab"
    else
        echo "Command already exists in /etc/crontab"
    fi
}

# =================================================================

check_and_append_crontab "@reboot root $(pwd)/startup.sh"