#!/bin/sh

XSOCK=/tmp/.X11-unix
XAUTH=/tmp/.docker.mockup.xauth
if [ ! -f $XAUTH ]; then
	touch $XAUTH
	xauth nlist $DISPLAY | sed -e 's/^..../ffff/' | xauth -f $XAUTH nmerge -
fi

while getopts "n:k:" opt
do
	case "$opt" in
		"n")
			LICENSENAME=$OPTARG
			;;
		"k")
			LICENSEKEY=$OPTARG
			;;
	esac
done

docker run --rm -d \
    --name mockup \
    -e DISPLAY \
    -e "LICENSENAME=${LICENSENAME}" \
    -e "LICENSEKEY=${LICENSEKEY}" \
    -e XAUTHORITY=${XAUTH} \
    -v ${XAUTH}:${XAUTH}:rw \
    -v $XSOCK:$XSOCK:rw \
    --device /dev/snd:/dev/snd \
    xylphid/mockup $@