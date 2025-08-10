# Quick tutorial how to run & setup docker environment for Elkapod docker images

## Contents
- [Available images](#available-images)

# Available images
There are currently two images available:
- `simulation` - image with all necessary dependancies and libraries needed to run Elkapod system in gazebo simulated environment
- `deploy` - image with only core libraries and dependencies that allow you to deploy Elkapod system on robot hardware (Raspberry Pi 5)

## `simulation` image
### NVIDIA GPU acceleration setup
Latest Gazebo release has better graphics so running simulator without any GPU acceleration is real pain. So, before running the container it's quite important to install on your HOST machine NVIDIA Container Toolkit.

1. Follow the installation guide provided by NVIDIA [here](https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/latest/install-guide.html).
2. Attach toolkit to your Docker
```bash
sudo nvidia-ctk runtime configure --runtime=docker
```
3. Restart Docker daemon
```bash
sudo systemctl restart docker
```
4. Check if "nvidia" is available and shown on Runtimes list
```bash
docker info | grep -i -E 'Runtimes|Default Runtime'
```

### Local workspace setup

First of all you have to setup local workspace. To do so follow these steps:

```bash
mkdir -p elkapod_sim_ws/src/
```

```bash
git clone git@github.com:HexapodBionik/elkapod_stack.git elkapod_sim_ws/src/
cd elkapod_sim_ws/
```

> [!IMPORTANT] 
> If you have valid ssh key connected to your github account and want to use it for repository cloning use the following script. It changes default https-based urls for ssh-based for all repos that will be cloned.
>
> ./src/ssh_repos_url.sh src/elkapod_all.repos | vcs import src/
>
> Otherwise use only vcs tool like this
>
> vcs import src/ < src/elkapod_all.repos
>

### Pulling the image and startup

Pull the docker simulation image using:

```bash
docker pull vistek528/elkapod_sim:latest
```

For running the container (from workspace folder)

```bash
docker compose -f src/.docker/simulation/docker-compose.yaml run --rm sim
```

