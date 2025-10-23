# Simple setup:

Install `Docker Desktop` and ensure it is running, this starts the daemon which is required. If it's your first time installing docker ensure to restart your machine.

## Building:
```bash
# Navigate to this project
cd path/to/repo
# Define a builder, required to allow 'platform:' arg in compose file
docker buildx create --name ros2-arm64-builder --use
docker buildx inspect --bootstrap
# Build images
docker compose build
# Spin up container
docker compose up
# Enter container with as many shells as you like with below command
docker exec -it ros-core bash
```

## Running Gazebo:
```bash
# Start server, if no line to exec passed, defaults to gazebo sim "ign gazebo [/path/to/world]"
start ["line to exec"]
# Open browser and connect in (can also use 'scaled' for resize arg)
http://localhost:6080/vnc.html?resize=remote
# Server may not fill the entire VNC window at first, utilise this command after starts to fix
resize
```

## Notes:
- It's worth mentioning the process doesn't spin down gracefully at all. I'd recommend spamming `ctrl + c` a few times or `ctrl + \` for a hard kill. 

- No matter what I do there seems to be orphaned processes but `start` should properly kill any them before attempting to start a new instance and getting errors.

- Ensure to set the appropriate IP addresses under Peers in `etc/cyclonedds.xml`, as LAN comms will fail without this config. You may also need to change settings like `ROS_DOMAIN_ID` in `docker-compose.yml`
