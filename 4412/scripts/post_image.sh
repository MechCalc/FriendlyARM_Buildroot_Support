#!/bin/bash
#
# Buildroot post buildscript
#

BOARDS_PATH=$(dirname $(dirname $(dirname $BASH_SOURCE)))
BOARD=$BOARDS_PATH/4412

MKIMAGE_PATH=$BOARD/mkimages
MKIMAGE_TYPE=false

IMAGES=$1
ROOTFS=/$IMAGES/rootfs

# Loop through script args
for var in "$@"
do
    # Check for var, and do appropriate action
    echo "" > /dev/null

done

MKIMAGE_TYPE="make_ext4fs"
FS_EXT="ext4"
# If no image type found, exit.
if [[ $MKIMAGE_TYPE == false ]]; then
    echo "No mkimage selected, exitting..."
    exit 0
fi


if [[ ! -d $ROOTFS ]]; then
	mkdir -p $ROOTFS
fi

sudo rm -rf $ROOTFS/*

sudo tar -xpf $IMAGES/rootfs.tar -C $ROOTFS/

sudo chown -R root $ROOTFS/*

sudo $MKIMAGE_PATH/make_ext4fs -s -l 314572800 $IMAGES/rootfs.$FS_EXT $ROOTFS > /dev/null

sudo chmod 777 $IMAGES/rootfs.$FS_EXT

exit 0
