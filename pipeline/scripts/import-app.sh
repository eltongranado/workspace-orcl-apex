#!/bin/bash

APPS_DIR="applications"
IMPORT_FILE_SQL="pipeline/tmp/import-app.sql"
CONTROLLER_XML="controller.xml"

echo "cd $APPS_DIR" > $IMPORT_FILE_SQL
echo "lb clear-checksums" >> $IMPORT_FILE_SQL
echo "lb status -changelog-file $CONTROLLER_XML" >> $IMPORT_FILE_SQL
echo "lb update -changelog-file $CONTROLLER_XML -debug -log" >> $IMPORT_FILE_SQL
echo 'exit' >> $IMPORT_FILE_SQL
