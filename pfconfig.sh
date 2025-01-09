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

Geometry=DSc100z10s0
Physics=REr # es. MX :: Maxwell, 2013 pbm a - quick cv parameters
Conditions=DP23 # Dupuit y-upper -2, y-lower -3
Solver=IN0 # NL:Inexact Newton, with Tolerance and else, version 0

run_name=DSc100z10s0
#cellsize=100

## RUN SIMULATION
echo "Job started at " `date`
# chmod +rx pfsimulation_yaml.py
python3 pfsimulation_yamlGPCS.py $run_name --parflow-directory ${PARFLOW_DIR} --working-directory ${WORK_DIR} --show-line-error --validation-verbose -p 2 -q 2 -r 1
# run_script.py [-h] [--parflow-directory PARFLOW_DIRECTORY] [--parflow-version PARFLOW_VERSION]
#  [--working-directory WORKING_DIRECTORY] [--skip-validation] [--dry-run] [--show-line-error]
#  [--exit-on-error] [--write-yaml] [--validation-verbose] [-p P] [-q Q] [-r R]
echo "Job finished at " `date`

rm tmp/${run_name}.*.dist
ls tmp/
cp InputKeysGeometry_${Geometry}.yaml tmp/
cp InputKeysPhysics_${Physics}.yaml tmp/
cp InputKeysConditions_${Conditions}.yaml tmp/
cp InputKeysSolver_${Solver}.yaml tmp/
#rm -r /home/patras/PF-Test/DumbSquare/outputs/${run_name}_new/
mkdir /home/patras/PF-Test/DumbSquare/outputs/$Geometry.$Physics.$Conditions.${Solver}_new/
mv /home/patras/PF-Test/DumbSquare/scripts/run/tmp/${run_name}.* /home/patras/PF-Test/DumbSquare/outputs/$Geometry.$Physics.$Conditions.${Solver}_new/ 
mv /home/patras/PF-Test/DumbSquare/scripts/run/tmp/InputKeys*.yaml /home/patras/PF-Test/DumbSquare/outputs/$Geometry.$Physics.$Conditions.${Solver}_new/ 
