# Isaac Sim 4.5.0 の公式コンテナをベースにする
# 参考: https://docs.isaacsim.omniverse.nvidia.com/latest/installation/install_container.html
FROM nvcr.io/nvidia/isaac-sim:4.5.0


# setup timezone
RUN echo 'Etc/UTC' > /etc/timezone && \
    ln -s /usr/share/zoneinfo/Etc/UTC /etc/localtime && \
    apt-get update && \
    apt-get install -q -y --no-install-recommends tzdata && \
    rm -rf /var/lib/apt/lists/*

# install packages
RUN apt-get update && apt-get install -q -y --no-install-recommends \
    dirmngr \
    gnupg2 \
    && rm -rf /var/lib/apt/lists/*

# setup keys
RUN set -eux; \
       key='C1CF6E31E6BADE8868B172B4F42ED6FBAB17C654'; \
       export GNUPGHOME="$(mktemp -d)"; \
       gpg --batch --keyserver keyserver.ubuntu.com --recv-keys "$key"; \
       mkdir -p /usr/share/keyrings; \
       gpg --batch --export "$key" > /usr/share/keyrings/ros2-latest-archive-keyring.gpg; \
       gpgconf --kill all; \
       rm -rf "$GNUPGHOME"

# setup sources.list
RUN echo "deb [ signed-by=/usr/share/keyrings/ros2-latest-archive-keyring.gpg ] http://packages.ros.org/ros2/ubuntu jammy main" > /etc/apt/sources.list.d/ros2-latest.list

# setup environment
ENV LANG C.UTF-8
ENV LC_ALL C.UTF-8

ENV ROS_DISTRO humble

# install ros2 packages
RUN apt-get update && apt-get install -y --no-install-recommends \
    ros-humble-ros-core=0.10.0-1* \
    && rm -rf /var/lib/apt/lists/*

# install bootstrap tools
RUN apt-get update && apt-get install --no-install-recommends -y \
    build-essential \
    git \
    python3-colcon-common-extensions \
    python3-colcon-mixin \
    python3-rosdep \
    python3-vcstool \
    && rm -rf /var/lib/apt/lists/*

# bootstrap rosdep
RUN rosdep init && \
  rosdep update --rosdistro $ROS_DISTRO

# setup colcon mixin and metadata
RUN colcon mixin add default \
      https://raw.githubusercontent.com/colcon/colcon-mixin-repository/master/index.yaml && \
    colcon mixin update && \
    colcon metadata add default \
      https://raw.githubusercontent.com/colcon/colcon-metadata-repository/master/index.yaml && \
    colcon metadata update

# install ros2 packages
RUN apt-get update && apt-get install -y --no-install-recommends \
    ros-humble-ros-base=0.10.0-1* \
    && rm -rf /var/lib/apt/lists/*

# Install CycloneDDS RMW implementation
RUN apt-get update && apt-get install -y --no-install-recommends \
    ros-humble-rmw-cyclonedds-cpp \
    && rm -rf /var/lib/apt/lists/*

# Force correct version of libbrotli1
RUN apt-get update && apt-get install -y --allow-downgrades \
    libbrotli1=1.0.9-2build6 \
    && rm -rf /var/lib/apt/lists/*

# Install minimal ROS 2 GUI tools (rqt)
RUN apt-get update && apt-get install -y --no-install-recommends \
    ros-humble-rqt-console \
    ros-humble-rqt \
    && rm -rf /var/lib/apt/lists/*

# Install RViz2 with apt-get flags to work around dependency issues
RUN apt-get update && \
    apt-get install -y --no-install-recommends\
    ros-humble-rviz2 \
    && rm -rf /var/lib/apt/lists/*

#RUN echo 'export FASTRTPS_DEFAULT_PROFILES_FILE=/root/colcon_ws/src/isaac_ros2_utils/isaac_ros2_scripts/config/fastdds.xml' >> ~/.bashrc
#RUN echo 'export RMW_IMPLEMENTATION=rmw_fastrtps_cpp' >> ~/.bashrc

RUN echo 'export RMW_IMPLEMENTATION=rmw_cyclonedds_cpp' >> ~/.bashrc
RUN echo 'ip link set lo multicast on' >> ~/.bashrc

RUN echo 'source /opt/ros/humble/setup.bash' >> ~/.bashrc
RUN echo 'source /root/colcon_ws/install/setup.sh' >> ~/.bashrc

# コンテナ起動時は bash を実行
CMD ["/bin/bash"]
