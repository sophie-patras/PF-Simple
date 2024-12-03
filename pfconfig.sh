#!/bin/bash

## lines already compiled in .bashrc
# spack load parflow
# echo "Using PARFLOW_DIR: ${PARFLOW_DIR}"

export EXEC_DIR=/home/patras/PF-Test/DumbSquare/scripts/run/
cd ${EXEC_DIR}
# mkdir tmp

export WORK_DIR=/home/patras/PF-Test/DumbSquare/scripts/run/tmp/
# echo "Using WORK_DIR: ${WORK_DIR}"
# input files must be in tmp


run_name=DS.c100s0001
cellsize=100

## RUN SIMULATION
echo "Job started at " `date`

# chmod +rx pfsimulation_yaml.py
python3 pfsimulation_yamlall.py $run_name $cellsize --parflow-directory ${PARFLOW_DIR} --working-directory ${WORK_DIR} --show-line-error --validation-verbose -p 3 -q 3 -r 1

# run_script.py [-h] [--parflow-directory PARFLOW_DIRECTORY] [--parflow-version PARFLOW_VERSION]
#  [--working-directory WORKING_DIRECTORY] [--skip-validation] [--dry-run] [--show-line-error]
#  [--exit-on-error] [--write-yaml] [--validation-verbose] [-p P] [-q Q] [-r R]

echo "Job finished at " `date`

rm tmp/${run_name}.*.dist
ls tmp/
cp InputKeys_c100s0.yaml tmp/${run_name}.yaml
#rm /home/patras/Valmalenco/Tmp/${run_name}_new/*
mkdir /home/patras/PF-Test/DumbSquare/outputs/${run_name}_new/
mv /home/patras/PF-Test/DumbSquare/scripts/run/tmp/${run_name}.* /home/patras/PF-Test/DumbSquare/outputs/${run_name}_new/ 

