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
docker exec -it ros-sim bash
```

## Running Gazebo:
```bash
# Utilise this command with optional world path
gz-up [/path/to/world.sdf]
# Open browser and connect in (can also use 'scaled' for resize arg)
http://localhost:6080/vnc.html?resize=remote
# Gazebo won't fill the entire VNC window at first, utilise this command while gazebo is up to fix
gz-resize
```

## Notes:
It's worth mentioning the process doesn't spin down gracefully at all. I'd recommend spamming `ctrl + c`
a few times or `ctrl + \` for a hard kill. 

No matter what I do there seems to be orphaned processes but `gz-up` should properly kill any them before attempting to start a new instance and getting errors.
