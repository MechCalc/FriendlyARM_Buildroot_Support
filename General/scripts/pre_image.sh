#!/bin/bash
#
# Buildroot post buildscript
#

BOARDS_PATH=$(dirname $(dirname $BASH_SOURCE))
FILES=$BOARDS_PATH/files
TARGET=$TARGET_DIR


WIFI=false

# Loop through script args
for var in "$@"
do
    # Check for var, and do appropriate action

    # Check for image type
    if [[ $var == "sdio_wifi" ]]; then
        FIRMWARE=$TARGET/lib/firmware
        if [[ ! -d $FIRMWARE ]]; then
            mkdir $FIRMWARE
        fi
        cp -rf $FILES/lib/firmware/sd8686* $FIRMWARE/
        WIFI=true
        cp $FILES/etc/init.d/S35sdio_wifi $TARGET/etc/init.d/
    elif [[ $var == "wifi" ]]; then
        WIFI=true
    fi

done

if [[ $WIFI == true ]]; then
        cp $FILES/etc/network/interfaces-wifi $TARGET/etc/network/interfaces
else
        cp $FILES/etc/network/interfaces $TARGET/etc/network/interfaces
fi

exit 0
