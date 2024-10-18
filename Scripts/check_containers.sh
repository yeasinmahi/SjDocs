#!/bin/bash

# Function to check if a container is running
is_container_running() {
    local container_name=$1
    local container_status=$(docker inspect -f '{{.State.Running}}' "$container_name" 2>/dev/null)
    if [ "$container_status" == "true" ]; then
        return 0
    else
        return 1
    fi
}

# Function to send email notification
send_email() {
    local sender_email="yeasinmahi70@gmail.com"
    local sender_password="kstpkytafsihjtdn"
    local receiver_email="arafat.yeasin@surbanajurong.com"
    local subject="Container Alert"
    local body="$1"

    local message="Subject: $subject\n\n$body"

    # Sending email using mail command (this may require configuring your local mail server)
    echo -e "$message" | mail -s "$subject" -a "From: $sender_email" "$receiver_email"
}

# Define container names
container_names=("cardaccess", "smarttoilet", "test")

# Check if any container is not running
not_running_containers=()
for container_name in "${container_names[@]}"; do
    if ! is_container_running "$container_name"; then
        not_running_containers+=("$container_name")
    fi
done

# If there are containers not running, send email notification
if [ ${#not_running_containers[@]} -gt 0 ]; then
    email_body="The following containers are not running:\n${not_running_containers[*]}"
    echo -e "`date` : Some containers are not running. Sending email notification..."
    send_email "$email_body"
else
    echo -e "`date` : All containers are running."
fi
read -p "Press any key to continue... " -n1 -s