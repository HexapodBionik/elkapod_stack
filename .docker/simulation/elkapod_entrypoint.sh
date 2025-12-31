#!/bin/bash
set -e

source "/opt/ros/$ROS_DISTRO/setup.bash"

if [ -f "/elkapod_sim_ws/install/setup.bash" ]; then
  source "/elkapod_sim_ws/install/setup.bash"
fi

exec "$@"
