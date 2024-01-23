#!/bin/bash

DATABASE_DIR="database/scripts"
CONFIG_FILE="pipeline/config-deploy.json"
DDL_FILE="pipeline/tmp/execute-scripts.sql"

# Ler a ordem definida no JSON
jq -r '.database.scripts[] | "\(.ordem) \(.script)"' $CONFIG_FILE | while read -r order script_name; do
    script_path="$DATABASE_DIR/$script_name"

    # Verificar se o script SQL está presente
    if [ -e "$script_path" ]; then
        echo "echo 'Executing $script_path'" >> $DDL_FILE
        echo "@$script_path" >> $DDL_FILE
    else
        echo "echo 'Script not found: $script_path'" >> $DDL_FILE
    fi
done

echo 'exit' >> $DDL_FILE
