#!/bin/bash

# check xz is installed
if ! [ -x "$(command -v xz)" ]; then
    echo 'Error: xz is not installed. Install with "sudo apt install xz-utils"' >&2
    exit 1
fi

# download a file if it does not exist
if [ ! -f "boot.iso" ]; then
    curl -O https://downloads.raspberrypi.com/raspios_arm64/images/raspios_arm64-2024-07-04/2024-07-04-raspios-bookworm-arm64.img.xz
    xz -d -v 2024-07-04-raspios-bookworm-arm64.img.xz
    rm -rf raspios_arm64-2024-07-04/2024-07-04-raspios-bookworm-arm64.img.xz
    mv 2024-07-04-raspios-bookworm-arm64.img boot.iso
fi


 #start the docker copmose file in the background but ridirect the output to the terminal
docker-compose up -d

 # loop until it is up
echo "Waiting for the machine to be up"
while true; do
    curl -k http://localhost:8006 &> /dev/null
    if [ $? -eq 0 ]; then
        break
    fi
    sleep 1
    echo -n "."
done

# open the machine in the browser
xdg-open http://localhost:8006
