#!/bin/bash

clear
echo "Criador: @4ykoor"
echo "Desenvolvido com muita preguiça"
echo ""
echo "Opções:"
echo "1) Informações"
echo "2) Scripts úteis"
echo "3) Instalação de linguagens"
echo "4) Criar estrutura APK"
echo "5) Deletar estrutura APK"
echo "6) Compilar APK"
echo "7) Assinar APK"
echo "0) Sair"
echo ""
read -p "› " opcao

case $opcao in
  1) bash scripts/submenus.sh info ;;
  2) bash scripts/submenus.sh scripts ;;
  3) bash scripts/submenus.sh install ;;
  4) bash scripts/submenus.sh criar ;;
  5) bash scripts/submenus.sh deletar ;;
  6) bash scripts/submenus.sh compilar ;;
  7) bash scripts/submenus.sh assinar ;;
  0) exit ;;
  *) echo "Opção inválida" && sleep 1 && bash menu.sh ;;
esac
