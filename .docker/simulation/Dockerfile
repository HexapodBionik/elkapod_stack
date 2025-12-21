ARG ROS_DISTRO="jazzy"
FROM ros:$ROS_DISTRO

ARG ELKAPOD_CORE_BRANCH
ARG ROS2_CONTROL_TAG="5.5.0"

SHELL ["/bin/bash", "-lc"]

COPY elkapod_entrypoint.sh /elkapod_entrypoint.sh
RUN chmod +x /elkapod_entrypoint.sh


RUN apt-get update \
    && apt-get upgrade -y \
    && \
    : "remove cache" && \
    apt-get autoremove -y -qq && \
    apt install libserial-dev -y && \
    rm -rf /var/lib/apt/lists/*

# Install Gazebo
RUN apt-get update && apt-get install curl lsb-release gnupg libgl1 libglx0 mesa-utils -y && rm -rf /var/lib/apt/lists/*
RUN curl https://packages.osrfoundation.org/gazebo.gpg --output /usr/share/keyrings/pkgs-osrf-archive-keyring.gpg \
    && echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/pkgs-osrf-archive-keyring.gpg] http://packages.osrfoundation.org/gazebo/ubuntu-stable $(lsb_release -cs) main" | tee /etc/apt/sources.list.d/gazebo-stable.list > /dev/null \
    && apt-get update \
    && apt-get install gz-harmonic -y \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /

# Build ros2_control
RUN mkdir -p /ws_ros2_control/src/ \
    && cd /ws_ros2_control/ 

WORKDIR /ws_ros2_control/src/

ADD https://raw.githubusercontent.com/ros-controls/ros2_control_ci/master/ros_controls.$ROS_DISTRO.repos ros_controls.$ROS_DISTRO.repos

WORKDIR /ws_ros2_control/

RUN vcs import src < src/ros_controls.$ROS_DISTRO.repos \
    && rosdep update --rosdistro=$ROS_DISTRO \
    && apt-get update \
    && rosdep install --from-paths src --ignore-src -r -y \
    && rm -rf /var/lib/apt/lists/* 

RUN source /opt/ros/$ROS_DISTRO/setup.bash && colcon build --symlink-install \
    && source install/setup.bash

# Install some dependencies from apt
RUN apt-get update && apt-get install -y \
        libboost-all-dev \
        libtbb-dev \
        ros-$ROS_DISTRO-rmw-cyclonedds-cpp \
        ros-$ROS_DISTRO-spatio-temporal-voxel-layer \
        ros-$ROS_DISTRO-rqt-graph \
        ros-$ROS_DISTRO-perception-pcl \
        ros-$ROS_DISTRO-pcl-msgs \
        ros-$ROS_DISTRO-navigation2 \
        ros-$ROS_DISTRO-nav2-bringup \
        ros-$ROS_DISTRO-nav2-minimal-tb* \
        ros-$ROS_DISTRO-robot-localization \
        ros-$ROS_DISTRO-vision-opencv \
        ros-$ROS_DISTRO-rtabmap-ros \
        ros-$ROS_DISTRO-plotjuggler-ros \
        ros-$ROS_DISTRO-rqt \
        ros-$ROS_DISTRO-rqt-common-plugins \
        libxcb-cursor0 \
        libxcb-cursor-dev \
        gdb \
        nano \
        python3-pip \
    && pip install --break-system-packages PySide6 \
    && rm -rf /var/lib/apt/lists/*

RUN echo ". /elkapod_sim_ws/colcon_build.sh" >> /root/.bashrc
RUN echo "export RMW_IMPLEMENTATION=rmw_cyclonedds_cpp" >>  /root/.bashrc

WORKDIR /elkapod_sim_ws/

ENTRYPOINT ["/ros_entrypoint.sh", "/elkapod_entrypoint.sh"]
CMD ["bash"]