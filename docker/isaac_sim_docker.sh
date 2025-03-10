#!/bin/bash
# start_isaac_sim_local.sh
#
# このスクリプトは、サーバのローカルXサーバー（通常 DISPLAY=:0）にコンテナ内のGUIアプリケーションを表示するための例です。

# サーバのローカルXサーバーへのアクセスを許可
# xhost +local


docker run --name isaac-sim-local -it --rm \
  --runtime=nvidia --gpus all -e "ACCEPT_EULA=Y" --rm --network=host -e "PRIVACY_CONSENT=Y" \
  --entrypoint /bin/bash \
  -e DISPLAY=$DISPLAY \
  -v ~/docker/isaac-sim/cache/kit:/isaac-sim/kit/cache:rw \
  -v ~/docker/isaac-sim/cache/ov:/root/.cache/ov:rw \
  -v ~/docker/isaac-sim/cache/pip:/root/.cache/pip:rw \
  -v ~/docker/isaac-sim/cache/glcache:/root/.cache/nvidia/GLCache:rw \
  -v ~/docker/isaac-sim/cache/computecache:/root/.nv/ComputeCache:rw \
  -v ~/docker/isaac-sim/logs:/root/.nvidia-omniverse/logs:rw \
  -v ~/docker/isaac-sim/data:/root/.local/share/ov/data:rw \
  -v ~/docker/isaac-sim/documents:/root/Documents:rw \
  -v /tmp/.X11-unix:/tmp/.X11-unix:rw \
  isaac-sim:custom
