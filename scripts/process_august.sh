#!/bin/bash

SENSORS_LIST=( $1 )
DATE=$2

YEAR=$(date -d ${DATE}01 +%Y)
MONTH=$(date -d ${DATE}01 +%m)

source /lustre/storeB/users/mikhaili/icearc-avhrr-sic/env/lustre-env.sh

echo DATE: $DATE
OUTPUT_DIR=/lustre/storeB/users/mikhaili/icearc-avhrr-sic/data/resampled-avhrr-gac/$YEAR/$MONTH
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

    for i in `find /lustre/storeB/users/steinare/gacrepr1/pps_v1/$YEAR/${YEAR}${MONTH}??/${SENSOR}*avhrr.h5`;
       do echo $i $SENSOR_NAME;
          python $PROJECT_DIR/codeshop/compute_sic/resample_gac.py --input-file $i --output-dir=$OUTPUT_DIR --sensor=avhrr_${SENSOR_NAME} -a $PROJECT_DIR/codeshop/compute_sic/areas.cfg
    done
done
