#!/bin/bash

verde="\033[1;32m"
amarelo="\033[1;33m"
vermelho="\033[1;31m"
neutro="\033[0m"

while true; do
  clear
  echo -e "${verde}{Informações do celular}${neutro}"
  echo
  # Mostra as informações do celular logo ao entrar
  echo "Marca: $(getprop ro.product.brand)"
  echo "Modelo: $(getprop ro.product.model)"
  echo "Versão Android: $(getprop ro.build.version.release)"
  echo "Versão Termux: $(termux-info | grep 'Version')"
  echo
  echo "[1] - Link para repositório"
  echo "[0] - Voltar ao menu principal"
  echo
  read -p "› " opcao

  case $opcao in
    1)
      echo
      echo "Repositório: https://github.com/4ykoor/TermuxDev-APKTool"
      ;;
    0)
      break
      ;;
    *)
      echo -e "${vermelho}Opção inválida!${neutro}"
      ;;
  esac

  echo
  read -p "Pressione Enter para continuar..." nada
done
