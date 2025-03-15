# Elkapod walking robot stack
![ROS2 distro](https://img.shields.io/badge/ros--version-jazzy-blue)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
![Python Version](https://img.shields.io/badge/python-3.12-g.svg)

This repository contains groups of packages such as:
- [elkapod core](https://github.com/HexapodBionik/elkapod_core) - robot description, ros2 controllers, gait generation and communication with hardware layer
- [elkapod simulation](https://github.com/HexapodBionik/elkapod_simulation) - packages related with robot simulation in Gazebo Sim
- [elkapod nav2](https://github.com/HexapodBionik/elkapod_nav2) - navigation stack
- [elkapod teleop](https://github.com/HexapodBionik/elkapod_teleop) - teleoperation and remote control packages

## Installation
You can choose one of two possible deploy modes for Elkapod robot:
1. Launch Elkapod in Gazebo Harmonic simulation environment
2. Launch Elkapod in real world 

### Launching Elkapod in Gazebo Simulation
For the first scenario, you should download all groups of packages into one `elkapod_simulation_ws`

1. Create a workspace
```bash
mkdir -p elkapod_simulation_ws/src/
```
2. Move into `elkapod_simulation_ws/src/` folder and download all packages using [vcstool](http://wiki.ros.org/vcstool)
```bash
cd elkapod_simulation_ws/
vcs import src/ < src/elkapod_all.repos
```

3. Build the workspace
```bash
colcon build --symlink-install && source install/setup.bash
```

### Launch Elkapod in real world
In this scenario, packages are divided into two groups:
- `local` - those packages are uploaded into Raspberry Pi 5 working onboard Elkapod 
- `remote` - used on remote PC computer

Depending on platform you should use `elkapod_deploy_local.repos` for `local` and `elkapod_deploy_remote.repos` for `remote` and follow points from previous chapter.