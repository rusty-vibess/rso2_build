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
- It's worth mentioning the ros-core server once started doesn't spin down gracefully. It stops eventually, but I'd recommend spamming `ctrl + c` a few times or `ctrl + \` for a hard kill.

- After spinning down the `ros-core` server there can be orphaned processes, this should not be an issue as running `start` again will look to kill stragglers but if existing processes are causing problems, stop the docker containers and start them again with `docker compose up`.

- Ensure to set the appropriate IP addresses under Peers in `etc/cyclonedds.xml`, as LAN based communication will fail without this being configured. You may also need to change settings like `ROS_DOMAIN_ID` in `docker-compose.yml`.
