
# Welcome to the Bash Scripting Challenge - 
#Day 4! This challenge is designed to test your Bash scripting skills and problem-solving abilities in the context of 
#process monitoring and management.

# Scenario
# You are tasked with writing a Bash script that efficiently monitors a specific process on a Linux system. 
#The script's primary goal is to ensure the process is always running, and if it unexpectedly stops, it should be 
#restarted automatically.

# Task
# Process Selection:

# The script should accept a command-line argument to specify the target process to monitor. 
#For example: ./monitor_process.sh <process_name>.
# Process Existence Check:

# Implement a function that checks if the specified process is currently running on the system.

# If the process is running, print a message indicating its presence.

# Restarting the Process:

# If the process is not running, implement a function that attempts to restart the process automatically.

# Print a message indicating the attempt to restart the process.

# Ensure the script does not enter an infinite loop while restarting the process. Limit the number of restart attempts.

# Automation:

# Provide instructions on how to schedule the script to run at regular intervals using a cron job or any other 
#appropriate scheduling method.
# Documentation:

# Include clear and concise comments in the script to explain its logic and functionality.

# Write a separate document describing the purpose of the script, how to use it, and any specific considerations.

# Bonus:

# Implement a notification mechanism (e.g., email, Slack message) to alert administrators if the process requires manual intervention after a certain number of restart attempts.
# Remember to test your script thoroughly on a test system before deploying it to a production environment. Ensure it does not interfere with critical processes or cause any unintended side effects. 
#Consider edge cases and potential race conditions during process monitoring and restarting.

#!/bin/bash

process_name="$1"

#process existence check
function check_process_running() {
    if pgrep -x "$process_name" >/dev/null; then
        echo "The process $process_name is running."
        return 0
    else
        echo "The process $process_name is not running."
        return 1
    fi
}

#restart process

max_attempts=3
current_attempt=1
function restart_process() {
    echo "Restarting $process_name..."
    systemctl restart "$process_name"
}

while true; do
    if check_process_running; then
        break
    fi

    if [ "$current_attempt" -le "$max_attempts" ]; then
        restart_process
        current_attempt=$((current_attempt + 1))

    else
        echo "Max restart attempts reached. Exiting..."
        echo "Please try to restart the process manually."
        exit 1
    fi
done


#bash nginx_process.sh nginx