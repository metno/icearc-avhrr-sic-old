#!/bin/bash

PREFIX='gacv2-4k'

SENSORS_LIST=( $1 )
DATE="${@: -1}" # last element of the array

SENSORS_LIST=( "${@}" )
unset SENSORS_LIST[${#SENSORS_LIST[@]}-1] # get rid of the last element of the array which is date

YEAR=$(date -d ${DATE}01 +%Y)
MONTH=$(date -d ${DATE}01 +%m)

if [ "$MONTH" -le 4 -a "$MONTH" -ge 10 ]; then
    echo "MONTH: ${MONTH} outside summer range 05-09"
    exit 1
fi


source /lustre/storeB/users/mikhaili/icearc-avhrr-sic/env/lustre-env.sh

OUTPUT_DIR=${STORAGE_DIR}/data/resampled-avhrr-gac-${PREFIX}/$YEAR/$MONTH
if [ ! -d "$OUTPUT_DIR]" ]; then
    mkdir -p $OUTPUT_DIR
fi

SENSORS_NUMBER=${#SENSORS_LIST[@]}
for SENSOR in "${SENSORS_LIST[@]}"; do
    echo SENSOR: $SENSOR
    SENSOR_NAME=$SENSOR

    if [ "$1" == 'noaa9' ];
        then SENSOR_NAME='noaa09';
    fi
    if [ "$1" == 'noaa7' ];
        then SENSOR_NAME='noaa07';
    fi

    for i in `find ${GACDIR}/$YEAR/${YEAR}${MONTH}??/*_avhrr_${SENSOR}*Z.h5`;
       do echo $i $SENSOR_NAME;
          python $PROJECT_DIR/codeshop/compute_sic/resample_gac.py --area-name nsidc_stere_north_4k  --input-file $i --output-dir=$OUTPUT_DIR --sensor=avhrr_${SENSOR_NAME} -a $PROJECT_DIR/codeshop/compute_sic/areas.cfg
    done
done
