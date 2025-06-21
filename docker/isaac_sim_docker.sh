#!/bin/bash
# start_isaac_sim_local.sh
#
# このスクリプトは、サーバのローカルXサーバー（通常 DISPLAY=:0）にコンテナ内のGUIアプリケーションを表示するための例です。

# サーバのローカルXサーバーへのアクセスを許可
xhost +

docker run --name isaac-sim-ws2 -it --rm \
  --runtime=nvidia --gpus all \
  -e "ACCEPT_EULA=Y" \
  -e "PRIVACY_CONSENT=Y" \
  --network host \
  --entrypoint /bin/bash \
  -e DISPLAY=$DISPLAY \
  --device=/dev/nvidia0:/dev/nvidia0 \
  --device=/dev/nvidiactl:/dev/nvidiactl \
  --device=/dev/nvidia-uvm:/dev/nvidia-uvm \
  --device=/dev/nvidia-modeset:/dev/nvidia-modeset \
  --device=/dev/nvidia-uvm-tools:/dev/nvidia-uvm-tools \
  -v ~/docker/isaac-sim/cache/kit:/isaac-sim/kit/cache:rw \
  -v ~/docker/isaac-sim/cache/ov:/root/.cache/ov:rw \
  -v ~/docker/isaac-sim/cache/pip:/root/.cache/pip:rw \
  -v ~/docker/isaac-sim/cache/glcache:/root/.cache/nvidia/GLCache:rw \
  -v ~/docker/isaac-sim/cache/computecache:/root/.nv/ComputeCache:rw \
  -v ~/docker/isaac-sim/logs:/root/.nvidia-omniverse/logs:rw \
  -v ~/docker/isaac-sim/data:/root/.local/share/ov/data:rw \
  -v ~/docker/isaac-sim/documents:/root/isaac-sim/Documents:rw \
  -v /tmp/.X11-unix:/tmp/.X11-unix:rw \
  -v $HOME/.Xauthority:/root/.Xauthority:ro \
  -v "$(pwd)/lime_ws":/root/turtlebot3_lime_ws:rw \
  -v ~/Documents:/root/Documents:rw \
  prox_sim:4.5.0

