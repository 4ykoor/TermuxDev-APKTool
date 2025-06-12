#!/data/data/com.termux/files/usr/bin/bash

pkg update -y && pkg upgrade -y

curl -sLo ~/inter-menu.sh https://raw.githubusercontent.com/4ykoor/devpreguicoso/main/inter-menu.sh
chmod +x ~/inter-menu.sh

bash ~/inter-menu.sh

