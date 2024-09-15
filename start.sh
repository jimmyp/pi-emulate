#!/bin/bash

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

# open the machine in the browser
xdg-open http://localhost:8006
