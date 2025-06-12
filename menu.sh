#!/bin/bash

# devpreguicoso - por @4ykoor
# Desenvolvido com muita preguiça 💤

clear
echo "=============================="
echo "   DEV PREGUIÇOSO - MENU DEV"
echo "=============================="
echo "Criador: @4ykoor"
echo "Desenvolvido com muita preguiça 🐢"
echo ""
echo "[1] Informações"
echo "[2] Comandos úteis"
echo "[3] Instalação de linguagens"
echo "[4] Criar estrutura APK"
echo "[5] Deletar estrutura APK"
echo "[6] Compilar APK"
echo "[7] Assinar APK"
echo "[0] Sair"
echo ""

read -p "Escolha uma opção: " opcao

case $opcao in
  1) bash scripts/info.sh ;;
  2) bash scripts/comandos.sh ;;
  3) bash scripts/linguagens.sh ;;
  4) bash scripts/criar_estrutura.sh ;;
  5) bash scripts/deletar_estrutura.sh ;;
  6) bash scripts/compilar_apk.sh ;;
  7) bash scripts/assinar_apk.sh ;;
  0) echo "Saindo..."; exit 0 ;;
  *) echo "Opção inválida."; sleep 1; bash menu.sh ;;
esac
