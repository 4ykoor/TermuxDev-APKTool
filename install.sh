#!/bin/bash

REPO="https://github.com/4ykoor/devpreguicoso"
DIR="devpreguicoso"

echo "🔄 Clonando o repositório de @4ykoor..."

if [ -d "$DIR" ]; then
    echo "🧹 Pasta '$DIR' já existe. Deseja sobrescrever? (s/n)"
    read -p "› " op
    if [ "$op" = "s" ]; then
        rm -rf "$DIR"
    else
        echo "❌ Instalação cancelada."
        exit 1
    fi
fi

git clone "$REPO"

if [ $? -eq 0 ]; then
    echo "✅ Repositório clonado com sucesso."
    cd "$DIR"
    chmod +x menu.sh
    echo "▶️ Pronto! Agora execute:"
    echo ""
    echo "  cd $DIR && bash menu.sh"
    echo ""
else
    echo "❌ Erro ao clonar o repositório."
fi
