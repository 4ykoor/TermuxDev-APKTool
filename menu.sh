#!/bin/bash

verde="\033[1;32m"
amarelo="\033[1;33m"
vermelho="\033[1;31m"
neutro="\033[0m"

while true; do
  clear
  echo -e "${verde}Criador @4ykoor${neutro}"
  echo "Desenvolvido com muita preguiça"
  echo
  echo -e "${amarelo}Opções${neutro}"
  echo "1) Informações"
  echo "2) Scripts úteis"
  echo "3) Instalação de linguagens"
  echo "4) Criar estrutura APK"
  echo "5) Deletar estrutura APK"
  echo "6) Compilar APK"
  echo "7) Assinar APK"
  echo "0) Sair"
  echo
  read -p "› " opcao

  case $opcao in
    1) bash scripts/infos.sh ;;
    2) bash scripts/comandos.sh ;;
    3) bash scripts/linguagens.sh ;;
    4) bash scripts/criar_estrutura.sh ;;
    5) bash scripts/deletar_projeto.sh ;;
    6) bash scripts/compilar_apk.sh ;;
    7) bash scripts/assinar_apk.sh ;;
    0) echo -e "${verde}Saindo...${neutro}"; exit 0 ;;
    *) echo -e "${vermelho}Opção inválida!${neutro}"; sleep 2 ;;
  esac

  echo
  read -p "Pressione Enter para voltar ao menu..." nada
done
