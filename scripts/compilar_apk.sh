#!/bin/bash

verde="\033[1;32m"
amarelo="\033[1;33m"
vermelho="\033[1;31m"
neutro="\033[0m"

STORAGE="$HOME/storage/shared/TermuxDev"

if [ ! -d "$STORAGE" ]; then
    echo -e "${vermelho}Nenhum projeto criado ainda.${neutro}"
    read -p "Pressione Enter para voltar..." nada
    exit
fi

clear
echo -e "${amarelo}Projetos disponíveis:${neutro}"
ls "$STORAGE"
echo
read -p "Digite o nome do projeto para compilar: " nome

PROJETO="$STORAGE/$nome"

if [ ! -d "$PROJETO" ]; then
    echo -e "${vermelho}Projeto não encontrado.${neutro}"
    read -p "Pressione Enter para voltar..." nada
    exit
fi

# Detectar linguagem
if [ -d "$PROJETO/java" ]; then
    linguagem="java"
elif [ -d "$PROJETO/kotlin" ]; then
    linguagem="kotlin"
else
    echo -e "${vermelho}Não foi possível detectar a linguagem do projeto.${neutro}"
    read -p "Pressione Enter para voltar..." nada
    exit
fi

echo -e "${amarelo}Linguagem detectada: $linguagem${neutro}"

# Verificar dependências
falta=""
command -v d8 >/dev/null || falta+=" d8"
command -v adb >/dev/null || falta+=" adb"
[ "$linguagem" = "java" ] && command -v javac >/dev/null || falta+=" javac"
[ "$linguagem" = "kotlin" ] && command -v kotlinc >/dev/null || falta+=" kotlinc"

if [ "$falta" != "" ]; then
    echo -e "${vermelho}Faltam dependências:$falta${neutro}"
    read -p "Deseja instalar agora? (s/n): " inst
    if [ "$inst" = "s" ]; then
        pkg update && pkg install openjdk-17 android-tools -y
        # Instalar kotlinc manual se for Kotlin
        if [ "$linguagem" = "kotlin" ]; then
            echo -e "${amarelo}Você precisa instalar o Kotlin manualmente se não estiver no PATH.${neutro}"
        fi
    else
        echo -e "${vermelho}Instalação cancelada.${neutro}"
        exit
    fi
fi

clear
echo "Modo de compilação:"
echo "1) Debug (compilar e instalar)"
echo "2) Release (compilar assinado)"
read -p "Escolha: " modo

SRC_DIR="$PROJETO/$linguagem"
OUT_DIR="$PROJETO/build"
DEX_FILE="$OUT_DIR/classes.dex"
APK_FILE="$OUT_DIR/$nome.apk"

mkdir -p "$OUT_DIR"

if [ "$linguagem" = "java" ]; then
    javac -d "$OUT_DIR" "$SRC_DIR"/*.java
elif [ "$linguagem" = "kotlin" ]; then
    kotlinc "$SRC_DIR"/*.kt -d "$OUT_DIR"
fi

d8 "$OUT_DIR"/*.class --output "$OUT_DIR"

# Criar APK (simples zip de estrutura mínima)
cd "$OUT_DIR"
zip -r "$APK_FILE" classes.dex > /dev/null
cd - > /dev/null

if [ "$modo" = "2" ]; then
    KEY="$HOME/.termuxdev/keystore.jks"
    if [ ! -f "$KEY" ]; then
        echo -e "${vermelho}Keystore não encontrado. Configure a assinatura primeiro.${neutro}"
        read -p "Pressione Enter para voltar..." nada
        exit
    fi

    jarsigner -keystore "$KEY" "$APK_FILE" alias_name  # Ajuste conforme o alias
    echo -e "${verde}APK assinado salvo em: $APK_FILE${neutro}"
else
    adb install -r "$APK_FILE"
    echo -e "${verde}APK instalado no dispositivo (modo debug).${neutro}"
fi

read -p "Pressione Enter para voltar..." nada
