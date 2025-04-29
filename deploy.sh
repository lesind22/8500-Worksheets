#!/bin/sh 
USER=indirale
HOST=indiralessington.net
DIR=/public_html/

hugo && rsync -avz public/ ${USER}@${HOST}:~/${DIR}

exit 0
