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
    # random extensions and deps
    python3-colcon-common-extensions \
    ros-humble-ros-gz-bridge \
    ros-humble-ros-gz-sim \
    lsb-release \
    gnupg \
    # GUI + noVNC deps
    libgl1-mesa-dri \
    libgl1-mesa-glx \
    mesa-utils \
    xvfb \
    x11vnc \
    fluxbox \
    novnc \
    websockify \
    && rm -rf /var/lib/apt/lists/*

RUN curl -sSL https://packages.osrfoundation.org/gazebo.gpg -o /usr/share/keyrings/pkgs-osrf-archive-keyring.gpg && \
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/pkgs-osrf-archive-keyring.gpg] https://packages.osrfoundation.org/gazebo/ubuntu-stable $(lsb_release -cs) main" \
        > /etc/apt/sources.list.d/gazebo-stable.list && \
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/pkgs-osrf-archive-keyring.gpg] https://packages.osrfoundation.org/gazebo/ubuntu-prerelease $(lsb_release -cs) main" \
        > /etc/apt/sources.list.d/gazebo-prerelease.list && \
    apt-get update && \
    apt-get install -y gz-fortress \
    && rm -rf /var/lib/apt/lists/*

RUN apt-get update && apt-get install -y \
    # noVNC windowing deps
    software-properties-common && \
    add-apt-repository universe && \
    apt-get update && \
    apt-get install -y xdotool \
    && rm -rf /var/lib/apt/lists/*

SHELL ["/bin/bash","-lc"]

# Scripts
COPY scripts/ /usr/scripts/
RUN bash /usr/scripts/setup

WORKDIR /workspace
CMD ["bash"]
