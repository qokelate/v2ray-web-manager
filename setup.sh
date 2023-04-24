#!/bin/sh

cd "$(dirname "$0")"
cd "$(realpath "$PWD")"

mkdir db logs
ln -sf "$PWD" '/opt/jar'

screen -dmS admin \
java -jar -Xms40m -Xmx40m -XX:MaxDirectMemorySize=10M -XX:MaxMetaspaceSize=80m "$PWD/admin.jar" "--spring.config.location=$PWD/admin.yaml"

screen -dmS v2proxy \
java -jar -Xms40m -Xmx40m -XX:MaxDirectMemorySize=10M -XX:MaxMetaspaceSize=80m "$PWD/v2ray-proxy.jar" "--spring.config.location=$PWD/proxy.yaml"

screen -dmS v2ray \
"$PWD/v2fly/v2ray" run -c "$PWD/config.json"

exit
