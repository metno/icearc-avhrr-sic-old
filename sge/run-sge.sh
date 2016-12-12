#/bin/bash -f
#
#$ -q ded-parallel.q
#$ -S /bin/bash
#$ -cwd
#$ -t 200505-200509
#$ -e ./sge-output/error.txt
#$ -o ./sge-output/output.txt


source  /home/mikhaili/.virtualenvs/ice-arc/bin/activate
SCRIPT_PATH=$1
YEAR=$(date -d ${SGE_TASK_ID}01 +%Y)
MONTH=$(date -d ${SGE_TASK_ID}01 +%m)
if [ "$MONTH" -ge 5 -a "$MONTH" -le 9 ]; then
    source /lustre/storeB/users/mikhaili/icearc-avhrr-sic/env/lustre-env.sh
    sensors=$(cat single_sat_list.$YEAR.txt)
    $SCRIPT_PATH $(printf '%q ' ${sensors[@]}) $SGE_TASK_ID
else
    echo "MONTH: ${MONTH} outside summer range 05-09"
    exit 1
fi
