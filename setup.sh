#!/bin/sh

git clone https://github.com/yuki7070/docker-mirakurun-epgstation-with-nvenc.git
cd docker-mirakurun-epgstation
cp docker-compose-sample.yml docker-compose.yml
cp epgstation/config/enc.js.template epgstation/config/enc.js
cp epgstation/config/av1_nvenc.sh.template epgstation/config/av1_nvenc.sh
cp epgstation/config/h264_nvenc.sh.template epgstation/config/h264_nvenc.sh
cp epgstation/config/h265_nvenc.sh.template epgstation/config/h265_nvenc.sh
cp epgstation/config/config.yml.template epgstation/config/config.yml
cp epgstation/config/operatorLogConfig.sample.yml epgstation/config/operatorLogConfig.yml
cp epgstation/config/epgUpdaterLogConfig.sample.yml epgstation/config/epgUpdaterLogConfig.yml
cp epgstation/config/serviceLogConfig.sample.yml epgstation/config/serviceLogConfig.yml
docker-compose run --rm -e SETUP=true mirakurun
