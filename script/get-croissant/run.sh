#!/bin/bash

echo "======================================================="

cd ${MLC_MLCOMMONS_CROISSANT_PATH}/python/mlcroissant
if [ "${?}" != "0" ]; then exit 1; fi

echo ""
echo "Running ${MLC_PYTHON_BIN_WITH_PATH} -m pip install -e .[git]"

${MLC_PYTHON_BIN_WITH_PATH} -m pip install -e .[git]
if [ "${?}" != "0" ]; then exit 1; fi

echo ""
echo "Validating Croissant ..."

mlcroissant validate --file ../../datasets/titanic/metadata.json
if [ "${?}" != "0" ]; then exit 1; fi

echo "======================================================="

