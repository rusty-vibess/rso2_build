#!/usr/bin/env bash
# Turtle bot setup script
source /opt/ros/humble/setup.bash

mkdir -p ~/turtlebot3_ws/src
cd ~/turtlebot3_ws/src/
git clone -b humble https://github.com/ROBOTIS-GIT/DynamixelSDK.git
git clone -b humble https://github.com/ROBOTIS-GIT/turtlebot3_msgs.git
git clone -b humble https://github.com/ROBOTIS-GIT/turtlebot3.git

cd ~/turtlebot3_ws
colcon build --symlink-install
echo 'source /opt/ros/humble/setup.bash' >> ~/.bashrc 
# Silence warnings
echo 'export XDG_RUNTIME_DIR=/tmp/runtime-root
mkdir -p $XDG_RUNTIME_DIR
chmod 700 $XDG_RUNTIME_DIR' >> ~/.bashrc


source ~/.bashrc

echo 'Setup complete...'