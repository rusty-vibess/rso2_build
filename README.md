# Simple setup:
Install Docker Desktop app and ensure it is running, this starts the daemon which is required.

Also a weird one, make sure to do a full restart of your machine after installing docker for the first time.

```bash
# Navigate to this project
cd path/to/repo
# Defines a builder, required to force arm64
docker buildx create --name ros2-arm64-builder --use
docker buildx inspect --bootstrap
# Build and run
docker compose build
docker compose up
# Open another terminal and enter container shell
docker exec -it ros-sim bash
# Start headless gazebo sim, this command specifically loads an empty world for testing
ign gazebo -s -r /workspace/worlds/empty.sdf --verbose
# ctrl + p then ctrl + q to exit shell without killing it
# Open browser and connect in
http://localhost:6080/vnc.html
```
