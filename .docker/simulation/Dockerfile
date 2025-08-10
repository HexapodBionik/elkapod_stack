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

WORKDIR /elkapod_sim_ws/

ENTRYPOINT ["/ros_entrypoint.sh", "/elkapod_entrypoint.sh"]
CMD ["bash"]