#!/bin/bash
set -e

# setup ros2_control environment
source "/ws_ros2_control/install/setup.bash" --
exec "$@"
