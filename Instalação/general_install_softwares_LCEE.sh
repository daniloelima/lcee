#!/bin/bash
# Ultima Atualização: 18/10/2023


USER=$(whoami)

# Documentacao LCEE: https://docs.google.com/document/d/1bnXhSl0Q7n9jgF0m1FqWycCkRyAJd4P5/edit?usp=sharing&ouid=104487920549651403501&rtpof=true&sd=true


ATUALIZAR_SISTEMA=true

# Lista de Softwares para Instalar
DOCKER=true # 
KICAD=true # incompleto
VSCODE=true # Completo + Extensoes
WIRESHARK=true # 
ROS2=true # 
OCTAVE=true #


# Atualizacao de Sistemas

if $ATUALIZAR_SISTEMA; then
    sudo apt-get update
    sudo apt-get install ca-certificates
    sudo apt-get install curl
    sudo apt-get install gnupg
    sudo apt-get install lsb-release
fi


# DOCKER
if $DOCKER; then
    echo "Instalando Docker"
    
    sudo mkdir -p /etc/apt/keyrings
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

    echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

    sudo apt-get update
    sudo apt-get install docker-ce docker-ce-cli containerd.io docker-compose-plugin -y

    sudo groupadd docker
    sudo usermod -aG docker $USER
fi

#KiCAD
if $KICAD; then 
    echo "Instalando KiCAD"

    sudo add-apt-repository ppa:js-reynaud/kicad-4
    sudo apt-get update
    sudo apt-get install kicad -y


    # Transformar da versao trial para free
    # -> identificar os arquivos 

    path_kicad=/home/$USER/opt
    
    rm_plugins=(
        "qcaddwg.dll"
    )

    for i in ${rmplugins[@]}; do
        rm -f $path_kicad/qcad-3.28.2-trial-linux-qt5.14-x86_64/plugins/$i
    done
fi


#VSCODE
if $VSCODE; then
    echo "Instalando Visual Studio CODE"

    extensions=(
        "ms-vscode.cpptools-extension-pack" 
        "vscjava.vscode-java-pack"
        "ms-toolsai.jupyter"
        "MS-CEINTL.vscode-language-pack-pt-BR"
        "donjayamanne.python-extension-pack"
    )
    extensions_names=(
        "C/C++ Extension Pack"
        "Extension Pack for Java"
        "Jupyter"
        "Portuguese (Brazil) Language Pack for Visual Studio Code"
        "Python Extension Pack"
    )


    sudo apt-get install code

    sudo snap install --classic code
    sudo apt-get install snapd snapd-xdg-open
    sudo snap refresh code

    #code --list-extensions 
    for i in ${!extensions[@]}; do
        echo "Installing ${extensions_names[i]}"
        code --install-extension ${extensions[i]} --force
    done
fi

#WIRESHARK
if $WIRESHARK; then
    echo "Instalando WIRESHARK"
    sudo apt install wireshark -y
fi

#ROS2
if $ROS2; then
    echo "Instalando ROS2"

    # Agora adicione a chave ROS 2 GPG com apt
    sudo curl -sSL https://raw.githubusercontent.com/ros/rosdistro/master/ros.key -o /usr/share/keyrings/ros-archive-keyring.gpg
    # Em seguida, adicione o repositorio a sua lista de fontes.
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/ros-archive-keyring.gpg] http://packages.ros.org/ros2/ubuntu $(. /etc/os-release && echo $UBUNTU_CODENAME) main" | sudo tee /etc/apt/sources.list.d/ros2.list > /dev/null

    sudo apt update -y
    sudo apt upgrade -y


    # instalacao do ROS2
    sudo apt install ros-humble-desktop -y
fi



if $OCTAVE; then
    sudo apt install octave -y
    sudo apt install liboctave-dev -y # development files
fi
