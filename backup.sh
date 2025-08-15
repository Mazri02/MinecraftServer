#!/bin/bash
cd /root/minecraft-1.20.1/

# Stop the Minecraft server
echo "Stopping Minecraft server..."
screen -S minecraft -X stuff "stop^M"
sleep 30  # Wait for server to save and shutdown

# Git operations
echo "Pushing changes to Git..."
git add .
git commit -m "Daily backup $(date +'%Y-%m-%d %H:%M')"
git push origin main

# Restart the server
echo "Restarting Minecraft server..."
screen -dmS minecraft ./run.bat
