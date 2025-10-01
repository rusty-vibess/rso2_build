FROM ros:humble-ros-base

ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install -y \
    ros-humble-desktop \
    ros-humble-demo-nodes-cpp \
    ros-humble-demo-nodes-py \
 && rm -rf /var/lib/apt/lists/*

SHELL ["/bin/bash","-lc"]
WORKDIR /workspace
CMD ["bash"]
