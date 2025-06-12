#!/bin/bash
clear
echo "=============================="
echo "  📱 INFORMAÇÕES DO DISPOSITIVO"
echo "=============================="

echo ""
echo "📦 Marca: $(getprop ro.product.manufacturer)"
echo "📱 Modelo: $(getprop ro.product.model)"
echo "📲 Android: $(getprop ro.build.version.release)"
echo "🔢 API Level: $(getprop ro.build.version.sdk)"
echo "🏗 Arquitetura: $(dpkg --print-architecture || uname -m)"
echo ""
echo "🔗 Repositório: https://github.com/4ykoor/devpreguicoso"
echo ""

read -p "[0] Voltar ao menu principal: " voltar
bash menu.sh
