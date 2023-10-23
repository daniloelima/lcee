#!/bin/bash

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

# sudo snap install --classic vscode
# sudo apt-get install snapd snapd-xdg-open
# sudo snap refresh vscode


#code --list-extensions 
for i in ${!extensions[@]}; do
    echo "Installing ${extensions_names[i]}"
    code --install-extension ${extensions[i]} --force
done