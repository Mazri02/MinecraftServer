#!/bin/bash
cd /root/minecraft-1.20.1/

# Stop the Minecraft server
echo "Stopping Minecraft server..."
screen -S minecraft -X stuff $'stop\r'
sleep 30

# Clean up any terminated screen sessions
screen -wipe

# Git operations
echo "Pushing changes to Git..."
git add .
git commit -m "Daily backup $(date +'%Y-%m-%d %H:%M')"
git push origin main

# Restart the server
echo "Restarting Minecraft server..."
cd /root/minecraft-1.20.1/

# Check if old screen session still exists
if screen -list | grep -q "minecraft"; then
    echo "Old screen session still exists. Killing it..."
    screen -S minecraft -X quit
    sleep 2
fi

# Start new screen session
screen -dmS minecraft bash -c "cd /root/minecraft-1.20.1/ && ./run.sh"
