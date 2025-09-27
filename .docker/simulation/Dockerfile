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


RUN apt-get update && apt-get install -y \
        libboost-all-dev \
        libtbb-dev \
        # python3-pip \
        # python3-dev \
        # python3-venv \
        ros-$ROS_DISTRO-rqt-graph \
        ros-$ROS_DISTRO-perception-pcl \
        ros-$ROS_DISTRO-pcl-msgs \
        ros-$ROS_DISTRO-navigation2 \
        ros-$ROS_DISTRO-nav2-bringup \
        ros-$ROS_DISTRO-nav2-minimal-tb* \
        ros-$ROS_DISTRO-robot-localization \
        ros-$ROS_DISTRO-vision-opencv \
        gdb \
        nano \
    && rm -rf /var/lib/apt/lists/*

RUN git clone --branch 4.1.1 https://github.com/borglab/gtsam.git /gtsam \
    && cd /gtsam && mkdir build && cd build \
    && cmake -DCMAKE_BUILD_TYPE=Release -DGTSAM_BUILD_WITH_MARCH_NATIVE=OFF .. \
    && make -j$(nproc) \
    && make install \
    && rm -rf /gtsam

WORKDIR /extra/src/

ADD https://raw.githubusercontent.com/ros-controls/ros2_control_ci/master/ros_controls.$ROS_DISTRO.repos ros_controls.$ROS_DISTRO.repos

RUN vcs import . < ros_controls.$ROS_DISTRO.repos \
    && git clone https://github.com/dbarania/LIO-SAM.git --branch ros2 LIO_SAM \
    && rosdep update --rosdistro=$ROS_DISTRO \
    && apt-get update \
    && cd .. \
    && rosdep install --from-paths src --ignore-src -r -y \
    && rm -rf /var/lib/apt/lists/* 

WORKDIR /extra/

RUN source /opt/ros/$ROS_DISTRO/setup.bash && colcon build --symlink-install \
    && source install/setup.bash

WORKDIR /elkapod_sim_ws/

ENTRYPOINT ["/ros_entrypoint.sh", "/elkapod_entrypoint.sh"]
CMD ["bash"]