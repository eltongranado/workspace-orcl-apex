#!/bin/bash

CONFIG_DEPLOY="pipeline/config-deploy.json"
APPS_DIR="applications"
CONTROL_FILE_SQL="pipeline/tmp/export-app.sql"
CONTROLLER_XML="controller.xml"
NEW_INCLUDES=""

echo "cd $APPS_DIR" > $CONTROL_FILE_SQL
echo "lb generate-control-file --changelog-file $CONTROLLER_XML" >> $CONTROL_FILE_SQL
echo "lb clear-checksums" >> $CONTROL_FILE_SQL

while read -r appid pageids; do
    # Remover qualquer quebra de linha nos pageids e substituir por espaços
    pageids=$(echo $pageids | tr -d '\n')
    
    expcomponents=$(echo "$pageids" | sed 's/\([0-9]\+\)/PAGE:\1/g')
    echo "lb generate-apex-object -applicationid $appid -skipexportdate -exporiginalids -expcomponents \"$expcomponents\" -split" >> $CONTROL_FILE_SQL
    echo "host mv apex_install.xml apex_install_${appid}.xml" >> $CONTROL_FILE_SQL
    
    NEW_INCLUDES+="  <include file=\"apex_install_${appid}.xml\"/>\n"
    
done < <(jq -r '.apex[] | "\(.appids) \(.pageids | join(" "))"' $CONFIG_DEPLOY)

echo "host sed -i -e '/<include file=\"{filename.xml}\"\/>/c \\$NEW_INCLUDES' $CONTROLLER_XML" >> $CONTROL_FILE_SQL
echo 'exit' >> $CONTROL_FILE_SQL