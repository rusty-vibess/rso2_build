source /opt/ros/humble/setup.bash
mkdir -p ~/turtlebot3_ws/src
cd ~/turtlebot3_ws/src/
git clone -b humble https://github.com/ROBOTIS-GIT/DynamixelSDK.git
git clone -b humble https://github.com/ROBOTIS-GIT/turtlebot3_msgs.git
git clone -b humble https://github.com/ROBOTIS-GIT/turtlebot3.git
# sudo apt install -y python3-colcon-common-extensions     ros-humble-ros-gz-bridge \ ros-humble-ros-gz-sim
cd ~/turtlebot3_ws
colcon build --symlink-install
source ~/.bashrc