#!/usr/bin/env bash
. local/config.txt
bin/download-tomcat.sh
bin/download-libs.sh
docker image build --progress=plain -t image-fancy context
