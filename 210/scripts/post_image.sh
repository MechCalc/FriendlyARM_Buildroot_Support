#!/bin/bash
#
# Buildroot post buildscript
#

BOARDS_PATH=$(dirname $(dirname $(dirname $BASH_SOURCE)))
BOARD=$BOARDS_PATH/210

MKIMAGE_PATH=$BOARD/mkimages
MKIMAGE_TYPE=false

IMAGES=$1
ROOTFS=/$IMAGES/rootfs

# Loop through script args
for var in "$@"
do
    # Check for var, and do appropriate action

    # Check for image type
    if [[ $var == "yaffs2" ]]; then
        MKIMAGE_TYPE=mkyaffs2image-128M
        FS_EXT="yaffs2"
    elif [[ $var == "ubi" ]]; then
        MKIMAGE_TYPE=mkubimage-slc
        FS_EXT="ubi"
    fi

done


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

sudo $MKIMAGE_PATH/$MKIMAGE_TYPE $ROOTFS $IMAGES/rootfs.$FS_EXT > /dev/null

sudo chmod 777 $IMAGES/rootfs.$FS_EXT

exit 0
