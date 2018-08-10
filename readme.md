# Balsamiq Mockup

Balsamiq is a rapid wireframing tool that helps you **Work Faster & Smarter**. It reproduces the experience of sketching on a whiteboard, but using a computer.

**Making wireframes is fast**. You'll generate more ideas, so you can throw out the bad ones and discover the best solutions. 

## Tags available

- `latest`, `3.5.16`

## How to use this image

You can customize the `mockup.sh` script available in the repository or make your own as follow :
```bash
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
```

This script will create a X authentication file with proper permissions and mount this to a volume for the container to use.

Then execute your script :
```bash
$ ./mockup.sh software.exe
```

If you have a licence you can set it with the following command :
```bash
$ ./mockup.sh software.exe -n "LICENSENAME" -k "LICENSEKEY"
```

## Persistent data

If you want to save your datas, you can mount the user folder as follow :
```bash
docker run --rm -d \
    --name mockup \
    -e DISPLAY \
    -e "LICENSENAME=${LICENSENAME}" \
    -e "LICENSEKEY=${LICENSEKEY}" \
    -e XAUTHORITY=${XAUTH} \
    -v ${XAUTH}:${XAUTH}:rw \
    -v $XSOCK:$XSOCK:rw \
    -v /safe/data/path:/home/wine/.wine/drive_c/users/wine \
    --device /dev/snd:/dev/snd \
    xylphid/mockup $@
```


## Image inheritance

This docker image inherits from [wine](https://hub.docker.com/r/xylphid/wine) image