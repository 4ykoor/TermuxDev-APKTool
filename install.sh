#!/bin/bash

# Cores para deixar bonitão
verde="\033[1;32m"
vermelho="\033[1;31m"
neutro="\033[0m"

echo -e "${verde}🔧 Iniciando configuração do TermuxDev APK Tool...${neutro}"

# Confere se está no diretório do projeto (menu.sh deve existir)
if [ ! -f "menu.sh" ]; then
  echo -e "${vermelho}Erro: Não encontrei o arquivo menu.sh. Rode o script no diretório do projeto.${neutro}"
  exit 1
fi

# Dá permissão de execução aos scripts
chmod +x menu.sh
chmod +x scripts/*.sh

# Detecta se é Termux para pedir permissão de armazenamento
if [ "$PREFIX" = "/data/data/com.termux/files/usr" ]; then
  echo -e "${verde}📱 Detectado Termux, solicitando permissão para armazenamento...${neutro}"
  termux-setup-storage
  sleep 2
fi

echo -e "${verde}✅ Instalação/configuração concluída com sucesso!${neutro}"
echo -e "Para iniciar a ferramenta, rode: ${verde}bash menu.sh${neutro}"

