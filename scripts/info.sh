#!/bin/bash

verde="\033[1;32m"
amarelo="\033[1;33m"
neutro="\033[0m"

REPO_LINK="https://github.com/4ykoor/TermuxDev-APKTool"

while true; do
  clear
  echo -e "${verde}Informações do celular${neutro}"
  echo "-------------------------"
  
  # Informações básicas do sistema/Termux
  echo -e "${amarelo}Dispositivo:${neutro} $(getprop ro.product.model)"
  echo -e "${amarelo}Fabricante:${neutro} $(getprop ro.product.manufacturer)"
  echo -e "${amarelo}Versão Android:${neutro} $(getprop ro.build.version.release)"
  echo -e "${amarelo}Versão Kernel:${neutro} $(uname -r)"
  echo -e "${amarelo}Espaço disponível em armazenamento:${neutro}"
  df -h | grep /data | awk '{print $4}'
  
  echo
  echo "Escolha uma opção:"
  echo "1) Abrir link do repositório"
  echo "0) Voltar ao menu principal"
  echo
  read -p "› " escolha

  if [ "$escolha" == "1" ]; then
    echo -e "${amarelo}Abrindo repositório...${neutro}"
    # Tenta abrir no Termux com termux-open
    if command -v termux-open >/dev/null 2>&1; then
      termux-open "$REPO_LINK"
    # Ou tenta abrir no Linux com xdg-open
    elif command -v xdg-open >/dev/null 2>&1; then
      xdg-open "$REPO_LINK"
    else
      echo "Não foi possível abrir o navegador automaticamente."
      echo "Por favor, acesse manualmente:"
      echo "$REPO_LINK"
    fi
    read -p "Pressione Enter para continuar..." nada
  elif [ "$escolha" == "0" ]; then
    break
  else
    echo "Opção inválida!"
    sleep 1
  fi
done
