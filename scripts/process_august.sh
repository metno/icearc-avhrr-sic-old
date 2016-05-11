#!/bin/bash

SENSOR=$1
YEAR=$2
MONTH="08"

SENSOR_NAME=$SENSOR

if [ "$1" == 'noaa9' ];
    then SENSOR_NAME='noaa09';
fi

for i in `find /lustre/storeB/users/steinare/gacrepr1/pps_v1/$YEAR/${YEAR}${MONTH}??/${SENSOR}*avhrr.h5`;
   do echo $i $SENSOR_NAME;
      python compute_sic/compute_sic.py --input-file $i --output-dir=/lustre/storeB/users/mikhaili/icearc-avhrr-sic/data/avhrr-sic-output --coeffs=/lustre/storeB/users/mikhaili/icearc-avhrr-sic/data/coeffs/coeffPDF_daytime_mean-std-line_v2p2.txt --sensor=avhrr_${SENSOR_NAME} -a ./compute_sic/areas.cfg
done
