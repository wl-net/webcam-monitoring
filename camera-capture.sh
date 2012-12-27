#!/bin/bash
#######################################
# WLNet Camera Recording
# Last Updated: 2012-12-24
#######################################

# User defined options
V4L_DEVICE=/dev/video0
CAMSHOT_WIDTH=640
CAMSHOT_HEIGHT=480
CAMERA_INTERVAL=5
WORKING_DIRECTORY=/home/andrew/.Applications/wlnet-monitoring/
# End user defined options

CAMSHOT_PID=0
CAMSHOT=$(which camshot)

if [ ! -z `pgrep camshot` ]; then
    echo "Camshot already runing, quiting"
    exit 1
fi

detectDevice() {
    if [ ! -e $V4L_DEVICE ]; then
        echo "Video 4 Linux device $V4L_DEVICE not found."
        if [ $CAMSHOT_PID -ne 0 ]; then
            kill $CAMSHOT_PID
        fi
        exit 1
    fi
}

detectDevice
mkdir -p $WORKING_DIRECTORY/data

$CAMSHOT -d $V4L_DEVICE -W $CAMSHOT_WIDTH -H $CAMSHOT_HEIGHT -p ./campipe 1>/dev/null 2>&1 &
CAMSHOT_PID=$!
echo "camshot started with PID: $CAMSHOT_PID"

while true; do
    NOW=`date +%s`
    cat $WORKING_DIRECTORY/campipe > $WORKING_DIRECTORY/data/capture-$NOW.bmp
    convert $WORKING_DIRECTORY/data/capture-$NOW.bmp $WORKING_DIRECTORY/data/capture-$NOW.jpg
    rm $WORKING_DIRECTORY/data/capture-$NOW.bmp

    sleep $CAMERA_INTERVAL
    detectDevice
done
