#!/bin/bash

verde="\033[1;32m"
amarelo="\033[1;33m"
vermelho="\033[1;31m"
neutro="\033[0m"

STORAGE_DIR="$HOME/storage/shared/TermuxDev"

if [ ! -d "$STORAGE_DIR" ]; then
  echo -e "${vermelho}Nenhum projeto encontrado.${neutro}"
  read -p "Pressione Enter para voltar..." nada
  exit 0
fi

projects=($(ls -d "$STORAGE_DIR"/*/ 2>/dev/null | xargs -n1 basename))

if [ ${#projects[@]} -eq 0 ]; then
  echo -e "${vermelho}Sem projeto para deletar.${neutro}"
  read -p "Pressione Enter para voltar..." nada
  exit 0
fi

while true; do
  clear
  echo -e "${amarelo}Projetos disponíveis:${neutro}"
  for p in "${projects[@]}"; do
    echo "- $p"
  done
  echo "0) Voltar ao menu"
  echo
  read -p "Digite o nome exato do projeto para deletar (ou 0 para voltar): › " nome_proj

  if [[ "$nome_proj" == "0" ]]; then
    break
  fi

  if [[ ! " ${projects[*]} " =~ " $nome_proj " ]]; then
    echo -e "${vermelho}Projeto '$nome_proj' não encontrado.${neutro}"
    sleep 2
    continue
  fi

  read -p "Para confirmar, digite novamente o nome do projeto '$nome_proj': › " confirm

  if [[ "$confirm" == "$nome_proj" ]]; then
    rm -rf "$STORAGE_DIR/$nome_proj"
    echo -e "${verde}Projeto '$nome_proj' deletado com sucesso.${neutro}"
    # Atualiza lista de projetos
    projects=($(ls -d "$STORAGE_DIR"/*/ 2>/dev/null | xargs -n1 basename))
    if [ ${#projects[@]} -eq 0 ]; then
      echo -e "${amarelo}Nenhum projeto restante.${neutro}"
      read -p "Pressione Enter para voltar..." nada
      break
    fi
    sleep 2
  else
    echo -e "${vermelho}Confirmação incorreta. Operação cancelada.${neutro}"
    sleep 2
  fi
done
