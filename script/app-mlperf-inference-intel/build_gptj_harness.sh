#!/bin/bash

export PATH=${MLC_CONDA_BIN_PATH}:$PATH
echo $PWD

if [ ! -d harness ]; then
  mkdir -p harness
fi

echo ${MLC_HARNESS_CODE_ROOT}
cd ${MLC_HARNESS_CODE_ROOT}
cd utils
python -m pip install .
test $? -eq 0 || exit $?
cd ../


mkdir -p data
export WORKLOAD_DATA=$(pwd)/data
mkdir -p ${WORKLOAD_DATA}/model

export INT8_MODEL_DIR=${WORKLOAD_DATA}/gpt-j-int8-model
export INT4_MODEL_DIR=${WORKLOAD_DATA}/gpt-j-int4-model


python download-dataset.py --split validation --output-dir ${WORKLOAD_DATA}/validation-data
test $? -eq 0 || exit $?
python download-calibration-dataset.py --calibration-list-file calibration-list.txt --output-dir ${WORKLOAD_DATA}/calibration-data
test $? -eq 0 || exit $?

if [[ -f ${INT8_MODEL_DIR}/best_model.pt ]]; then
  exit 0
fi

export CALIBRATION_DATA_JSON=${WORKLOAD_DATA}/calibration-data/cnn_dailymail_calibration.json
export VALIDATION_DATA_JSON=${WORKLOAD_DATA}/validation-data/cnn_dailymail_validation.json
#export INT4_CALIBRATION_DIR=${WORKLOAD_DATA}/quantized-int4-model
#sudo -E bash run_quantization.sh
#bash run_quantization.sh

INSTALLED_NS=$(python -c "import neural_speed; print(neural_speed.__path__[0])")
PATH_CONVERTED=`pwd`

export INSTALLED_NS=$INSTALLED_NS
echo "INSTALLED_NS=$INSTALLED_NS"
#export PATH_CONVERTED=$PATH_CONVERTED

echo "${RUN_QUANTIZATION_CMD}"
eval "${RUN_QUANTIZATION_CMD}"
test $? -eq 0 || exit $?
