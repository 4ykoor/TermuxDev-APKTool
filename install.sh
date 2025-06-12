#!/bin/bash

verde="\033[1;32m"
amarelo="\033[1;33m"
vermelho="\033[1;31m"
neutro="\033[0m"

echo -e "${amarelo}Iniciando instalação...${neutro}"

# Atualizar Termux
pkg update -y && pkg upgrade -y

# Instalar pacotes básicos
echo -e "${amarelo}Instalando pacotes necessários...${neutro}"
pkg install bash git openjdk-17 android-tools -y

# Criar diretórios
mkdir -p scripts
mkdir -p ~/.termuxdev

# Dar permissão de execução aos scripts
chmod +x menu.sh
chmod +x scripts/*.sh 2>/dev/null

# Atalho opcional para rodar com 'termuxdev'
if ! grep -q "alias termuxdev=" ~/.bashrc; then
  echo "alias termuxdev='bash ~/TermuxDev-APKTool/menu.sh'" >> ~/.bashrc
  echo -e "${verde}Atalho criado: use 'termuxdev' para abrir o menu.${neutro}"
  source ~/.bashrc
fi

echo
echo -e "${verde}Instalação concluída!${neutro}"
echo "Para começar, execute:"
echo -e "${amarelo}bash menu.sh${neutro} ou apenas ${verde}termuxdev${neutro}"
