#!/bin/bash

# Instalador para dotfiles - aliases
echo "🚀 Instalando dotfiles aliases..."

# Obtener el directorio actual
DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ALIAS_FILE="$DOTFILES_DIR/.alias"

# Detectar el shell y archivo de configuración
if [[ "$SHELL" == *"zsh"* ]]; then
    CONFIG_FILE="$HOME/.zshrc"
    SHELL_NAME="zsh"
elif [[ "$SHELL" == *"bash"* ]]; then
    CONFIG_FILE="$HOME/.bashrc"
    SHELL_NAME="bash"
else
    echo "❌ Shell no soportado: $SHELL"
    exit 1
fi

echo "📝 Detectado shell: $SHELL_NAME"
echo "📁 Archivo de configuración: $CONFIG_FILE"

# Crear el archivo de configuración si no existe
if [[ ! -f "$CONFIG_FILE" ]]; then
    echo "📄 Creando $CONFIG_FILE..."
    touch "$CONFIG_FILE"
fi

# Línea a añadir
SOURCE_LINE="source \"$ALIAS_FILE\""

# Verificar si ya existe la línea
if grep -Fq "$SOURCE_LINE" "$CONFIG_FILE"; then
    echo "✅ Los aliases ya están configurados en $CONFIG_FILE"
else
    echo "➕ Añadiendo source de aliases a $CONFIG_FILE..."
    echo "" >> "$CONFIG_FILE"
    echo "# Dotfiles aliases" >> "$CONFIG_FILE"
    echo "$SOURCE_LINE" >> "$CONFIG_FILE"
    echo "✅ Aliases añadidos correctamente"
fi

echo ""
echo "🎉 Instalación completada!"
echo "💡 Para aplicar los cambios ejecuta: source $CONFIG_FILE"
echo "💡 O simplemente abre una nueva terminal" 