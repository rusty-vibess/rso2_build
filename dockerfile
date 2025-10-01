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

RUN apt-get update && apt-get install -y \
    lsb-release \
    gnupg

RUN curl -sSL https://packages.osrfoundation.org/gazebo.gpg -o /usr/share/keyrings/pkgs-osrf-archive-keyring.gpg && \
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/pkgs-osrf-archive-keyring.gpg] https://packages.osrfoundation.org/gazebo/ubuntu-stable $(lsb_release -cs) main" \
        > /etc/apt/sources.list.d/gazebo-stable.list && \
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/pkgs-osrf-archive-keyring.gpg] https://packages.osrfoundation.org/gazebo/ubuntu-prerelease $(lsb_release -cs) main" \
        > /etc/apt/sources.list.d/gazebo-prerelease.list && \
    apt-get update && \
    apt-get install -y gz-fortress



SHELL ["/bin/bash","-lc"]
WORKDIR /workspace
CMD ["bash"]
