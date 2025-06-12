#!/bin/bash

verde="\033[1;32m"
amarelo="\033[1;33m"
vermelho="\033[1;31m"
neutro="\033[0m"

STORAGE_DIR="$HOME/storage/shared/TermuxDev"

comando_existe() {
  command -v "$1" >/dev/null 2>&1
}

while true; do
  clear
  echo -e "${verde}Criar estrutura de projeto APK${neutro}"
  echo "---------------------------------"
  echo "Escolha a linguagem:"
  echo "1) Python"
  echo "2) Node.js"
  echo "3) Java"
  echo "4) Kotlin"
  echo "0) Voltar ao menu"
  echo
  read -p "› " lang

  case $lang in
    1)
      if ! comando_existe python; then
        echo -e "${vermelho}Python não está instalado. Instale antes.${neutro}"
        sleep 2
        continue
      fi
      LING="Python"
      ;;
    2)
      if ! comando_existe node; then
        echo -e "${vermelho}Node.js não está instalado. Instale antes.${neutro}"
        sleep 2
        continue
      fi
      LING="Nodejs"
      ;;
    3)
      if ! comando_existe javac; then
        echo -e "${vermelho}Java (OpenJDK) não está instalado. Instale antes.${neutro}"
        sleep 2
        continue
      fi
      LING="Java"
      ;;
    4)
      if [ ! -d "$HOME/.kotlin" ] || [ ! -f "$HOME/.kotlin/kotlinc/bin/kotlinc" ]; then
        echo -e "${vermelho}Kotlin não está instalado. Instale antes.${neutro}"
        sleep 2
        continue
      fi
      LING="Kotlin"
      ;;
    0)
      break
      ;;
    *)
      echo -e "${vermelho}Opção inválida!${neutro}"
      sleep 2
      continue
      ;;
  esac

  read -p "Nome do projeto: " projname
  if [[ -z "$projname" ]]; then
    echo -e "${vermelho}Nome inválido!${neutro}"
    sleep 2
    continue
  fi

  read -p "Package (ex: com.seunome.app): " package
  if [[ ! "$package" =~ ^[a-zA-Z0-9_.]+$ ]]; then
    echo -e "${vermelho}Package inválido! Use letras, números, pontos e underscores.${neutro}"
    sleep 2
    continue
  fi

  PROJ_DIR="$STORAGE_DIR/$projname"
  if [ -d "$PROJ_DIR" ]; then
    echo -e "${amarelo}Projeto já existe. Deseja sobrescrever? (s/n)${neutro}"
    read -p "› " resp
    if [[ ! "$resp" =~ ^[Ss]$ ]]; then
      echo "Cancelado."
      sleep 2
      continue
    else
      rm -rf "$PROJ_DIR"
    fi
  fi

  mkdir -p "$PROJ_DIR"
  echo -e "${verde}Criando estrutura para $LING no projeto '$projname' com package '$package'...${neutro}"

  case $LING in
    Python)
      mkdir -p "$PROJ_DIR/src"
      echo -e "print('Hello from $projname')" > "$PROJ_DIR/src/main.py"
      ;;
    Nodejs)
      mkdir -p "$PROJ_DIR/src"
      echo -e "console.log('Hello from $projname');" > "$PROJ_DIR/src/main.js"
      ;;
    Java)
      package_path=$(echo "$package" | tr '.' '/')
      mkdir -p "$PROJ_DIR/src/$package_path"
      cat > "$PROJ_DIR/src/$package_path/Main.java" << EOF
package $package;

public class Main {
    public static void main(String[] args) {
        System.out.println("Hello from $projname");
    }
}
EOF
      ;;
    Kotlin)
      mkdir -p "$PROJ_DIR/src"
      cat > "$PROJ_DIR/src/Main.kt" << EOF
package $package

fun main() {
    println("Hello from $projname")
}
EOF
      ;;
  esac

  cat > "$PROJ_DIR/AndroidManifest.xml" << EOF
<manifest xmlns:android="http://schemas.android.com/apk/res/android"
    package="$package">
    <application android:label="$projname">
        <activity android:name=".MainActivity">
            <intent-filter>
                <action android:name="android.intent.action.MAIN"/>
                <category android:name="android.intent.category.LAUNCHER"/>
            </intent-filter>
        </activity>
    </application>
</manifest>
EOF

  mkdir -p "$PROJ_DIR/res/layout"
  cat > "$PROJ_DIR/res/layout/activity_main.xml" << EOF
<?xml version="1.0" encoding="utf-8"?>
<LinearLayout xmlns:android="http://schemas.android.com/apk/res/android"
    android:orientation="vertical" android:layout_width="match_parent"
    android:layout_height="match_parent">
    <TextView
        android:layout_width="wrap_content"
        android:layout_height="wrap_content"
        android:text="Hello from $projname!" />
</LinearLayout>
EOF

  echo -e "${verde}Estrutura criada em $PROJ_DIR${neutro}"
  read -p "Pressione Enter para voltar ao menu..." nada
  break
done
