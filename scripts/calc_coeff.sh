#!/bin/bash

# SENSORS_LIST=( $1 )
DATE="${@: -1}" # last element of the array

SENSORS_LIST=( "${@}" )
unset SENSORS_LIST[${#SENSORS_LIST[@]}-1] # get rid of the last element of the array which is date

YEAR=$(date -d ${DATE}01 +%Y)
MONTH=$(date -d ${DATE}01 +%m)

source /lustre/storeB/users/mikhaili/icearc-avhrr-sic/env/lustre-env.sh

INPUT_DIR=/lustre/storeB/users/mikhaili/icearc-avhrr-sic/data/resampled-avhrr-gac/$YEAR/$MONTH
OUTPUT_DIR=/lustre/storeB/users/mikhaili/icearc-avhrr-sic/data/vis09-coeffs/$YEAR/$MONTH

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

    filelist=$(find $INPUT_DIR/avhrr-gac_avhrr_${SENSOR_NAME}*nc);
    python $PROJECT_DIR/codeshop/compute_sic/calc_coeff.py ${filelist} --output-dir=$OUTPUT_DIR --sensor=avhrr_${SENSOR_NAME} -l $PROJECT_DIR/codeshop/compute_sic/resources/land_mask.npz \
                                                                                                                              -e $PROJECT_DIR/codeshop/compute_sic/resources/extent_mask.npz 
done
