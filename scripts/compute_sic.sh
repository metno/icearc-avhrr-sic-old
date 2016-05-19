#!/bin/bash

# SENSORS_LIST=( $1 )
DATE="${@: -1}" # last element of the array

SENSORS_LIST=( "${@}" )
unset SENSORS_LIST[${#SENSORS_LIST[@]}-1] # get rid of the last element of the array which is date

YEAR=$(date -d ${DATE}01 +%Y)
MONTH=$(date -d ${DATE}01 +%m)

source /lustre/storeB/users/mikhaili/icearc-avhrr-sic/env/lustre-env.sh

INPUT_DIR=/lustre/storeB/users/mikhaili/icearc-avhrr-sic/data/resampled-avhrr-gac/$YEAR/$MONTH
OUTPUT_DIR=/lustre/storeB/users/mikhaili/icearc-avhrr-sic/data/sic-avhrr-gac/$YEAR/$MONTH

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

    for i in `find $INPUT_DIR/avhrr-gac_avhrr_${SENSOR_NAME}*nc`;
       do echo $i $SENSOR_NAME;
          python $PROJECT_DIR/codeshop/compute_sic/compute_sic.py --input-file $i --output-dir=$OUTPUT_DIR --sensor=avhrr_${SENSOR_NAME} -a $PROJECT_DIR/codeshop/compute_sic/areas.cfg -c $PROJECT_DIR/codeshop/compute_sic/coeffPDF_daytime_mean-std-line_v2p2.txt -m $PROJECT_DIR/data/vis09-coeffs/${YEAR}/${MONTH}/avhrr_${SENSOR_NAME}-coeffs.npy -e $PROJECT_DIR/codeshop/compute_sic/resources/extent_mask.npz 
    done
done
