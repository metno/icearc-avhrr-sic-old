#/bin/bash -f
#
#$ -q ded-parallel.q
#$ -S /bin/bash
#$ -cwd
#$ -N resample_gac
DATE=$1
YEAR=$(date -d ${DATE}01 +%Y)
echo $YEAR

source /lustre/storeB/users/mikhaili/icearc-avhrr-sic/env/lustre-env.sh
sensors=$(cat list.$YEAR.txt)
/lustre/storeB/users/mikhaili/icearc-avhrr-sic/scripts/process_august.sh $(printf $sensors) $DATE
