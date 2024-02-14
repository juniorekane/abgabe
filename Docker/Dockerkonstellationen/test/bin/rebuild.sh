#!/bin/bash
docker container rm -f $(docker container ls -aq)
docker system prune -a -f
bin/download-tomcat.sh
bin/download-libs.sh
docker image build --no-cache --progress=plain -t image-fancy context
bin/create-mynet-network.sh
