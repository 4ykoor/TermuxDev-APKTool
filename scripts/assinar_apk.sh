#!/bin/bash

verde="\033[1;32m"
amarelo="\033[1;33m"
vermelho="\033[1;31m"
neutro="\033[0m"

KEYSTORE="$HOME/.termuxdev/keystore.jks"

mkdir -p "$HOME/.termuxdev"

# Verificar se já existe um keystore
if [ ! -f "$KEYSTORE" ]; then
  echo -e "${amarelo}Nenhum keystore encontrado.${neutro}"
  echo "Deseja criar um agora? (s/n)"
  read -p "› " criar
  if [ "$criar" = "s" ]; then
    echo -e "${amarelo}Criando keystore...${neutro}"
    read -p "Digite um nome para o alias: " alias
    read -p "Digite uma senha para o keystore: " senha
    keytool -genkey -v -keystore "$KEYSTORE" -alias "$alias" \
      -keyalg RSA -keysize 2048 -validity 10000 \
      -storepass "$senha" -keypass "$senha" <<EOF
.
.
.
.
.
.
.
EOF
    echo -e "${verde}Keystore criado com sucesso!${neutro}"
  else
    echo -e "${vermelho}Assinatura cancelada.${neutro}"
    read -p "Pressione Enter para voltar..." nada
    exit
  fi
else
  echo -e "${verde}Keystore encontrado.${neutro}"
fi

# Pedir caminho do APK
echo
read -p "Digite o caminho completo do APK a ser assinado: " apk
if [ ! -f "$apk" ]; then
  echo -e "${vermelho}Arquivo APK não encontrado.${neutro}"
  read -p "Pressione Enter para voltar..." nada
  exit
fi

# Pedir alias e senha
read -p "Alias usado na assinatura: " alias
read -p "Senha do keystore: " senha

# Assinar APK
SIGNED_APK="${apk%.apk}-signed.apk"
jarsigner -keystore "$KEYSTORE" -storepass "$senha" -keypass "$senha" \
  -signedjar "$SIGNED_APK" "$apk" "$alias"

echo -e "${verde}APK assinado salvo em:${neutro} $SIGNED_APK"
read -p "Pressione Enter para voltar..." nada
