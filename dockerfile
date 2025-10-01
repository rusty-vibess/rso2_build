FROM ros:humble-ros-base

ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install -y \
    # Ros humble
    ros-humble-desktop \
    ros-humble-demo-nodes-cpp \
    ros-humble-demo-nodes-py \
    # Nav2
    ros-humble-navigation2 \
    ros-humble-nav2-bringup \
    # Cartographer
    ros-humble-cartographer \
    ros-humble-cartographer-ros \
 && rm -rf /var/lib/apt/lists/*

SHELL ["/bin/bash","-lc"]
WORKDIR /workspace
CMD ["bash"]
