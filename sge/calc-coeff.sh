#/bin/bash -f
#
#$ -q ded-parallel.q
#$ -S /bin/bash
#$ -cwd
#$ -N calc_coeff

YEAR=$(date -d ${SGE_TASK_ID}01 +%Y)

source /lustre/storeB/users/mikhaili/icearc-avhrr-sic/env/lustre-env.sh
sensors=$(cat list.$YEAR.txt)
/lustre/storeB/users/mikhaili/icearc-avhrr-sic/scripts/calc_coeff.sh $(printf '%q ' ${sensors[@]}) $SGE_TASK_ID
