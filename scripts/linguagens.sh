#!/bin/bash

verde="\033[1;32m"
amarelo="\033[1;33m"
vermelho="\033[1;31m"
neutro="\033[0m"

KOTLIN_DIR="$HOME/.kotlin"
KOTLIN_BIN="$KOTLIN_DIR/kotlinc/bin"

while true; do
  clear
  echo -e "${verde}Instalação de linguagens de programação${neutro}"
  echo "---------------------------------------------"
  echo "1) Python"
  echo "2) Node.js"
  echo "3) Java (OpenJDK 17)"
  echo "4) Kotlin (Manual)"
  echo "0) Voltar ao menu principal"
  echo
  read -p "› " linguagem

  case $linguagem in
    1)
      if command -v python >/dev/null 2>&1; then
        echo -e "${amarelo}Python já está instalado.${neutro}"
      else
        echo -e "${verde}Instalando Python...${neutro}"
        pkg install python -y
      fi
      ;;
    2)
      if command -v node >/dev/null 2>&1; then
        echo -e "${amarelo}Node.js já está instalado.${neutro}"
      else
        echo -e "${verde}Instalando Node.js...${neutro}"
        pkg install nodejs -y
      fi
      ;;
    3)
      if command -v javac >/dev/null 2>&1; then
        echo -e "${amarelo}Java já está instalado.${neutro}"
      else
        echo -e "${verde}Instalando OpenJDK 17...${neutro}"
        pkg install openjdk-17 -y
      fi
      ;;
    4)
      if [ -d "$KOTLIN_DIR" ] && [ -f "$KOTLIN_BIN/kotlinc" ]; then
        echo -e "${amarelo}Kotlin já está instalado.${neutro}"
      else
        echo -e "${verde}Instalando Kotlin Compiler manualmente...${neutro}"
        pkg install unzip curl -y
        mkdir -p "$KOTLIN_DIR"
        cd "$KOTLIN_DIR" || exit
        curl -LO https://github.com/JetBrains/kotlin/releases/download/v1.9.22/kotlin-compiler-1.9.22.zip
        unzip kotlin-compiler-1.9.22.zip > /dev/null
        echo 'export PATH=$PATH:$HOME/.kotlin/kotlinc/bin' >> "$HOME/.bashrc"
        source "$HOME/.bashrc"
        echo -e "${verde}Kotlin instalado com sucesso!${neutro}"
        rm kotlin-compiler-1.9.22.zip
      fi
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
