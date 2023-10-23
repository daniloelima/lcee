#!/bin/bash



# Configuração do Locale
locale
sudo apt update && sudo apt install locales
sudo locale-gen en_US en_US.UTF-8
sudo update-locale LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8
export LANG=en_US.UTF-8
locale  # verify settings

# Configuração das Fontes

sudo apt install software-properties-common
sudo add-apt-repository universe -y


# Agora adicione a chave ROS 2 GPG com apt
sudo apt update && sudo apt install curl -y
sudo curl -sSL https://raw.githubusercontent.com/ros/rosdistro/master/ros.key -o /usr/share/keyrings/ros-archive-keyring.gpg
# Em seguida, adicione o repositório à sua lista de fontes.
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/ros-archive-keyring.gpg] http://packages.ros.org/ros2/ubuntu $(. /etc/os-release && echo $UBUNTU_CODENAME) main" | sudo tee /etc/apt/sources.list.d/ros2.list > /dev/null -y

sudo apt update -y
sudo apt upgrade -y

# instalação do ROS2
sudo apt install ros-humble-desktop -y
