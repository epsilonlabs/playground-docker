#!/bin/bash

set -e

export MAVEN_OPTS="-Xmx2g"

# Functions for running Epsilon
mvn -B -o function:run -Drun.functionTarget=org.eclipse.epsilon.live.RunEpsilonFunction -Drun.port=8001 &> mvn8001.log &
mvn -B -o function:run -Drun.functionTarget=org.eclipse.epsilon.live.FlexmiToGraphvizFunction -Drun.port=8002 &> mvn8002.log &
mvn -B -o function:run -Drun.functionTarget=org.eclipse.epsilon.live.EmfaticToGraphvizFunction -Drun.port=8003 &> mvn8003.log &

# nginx as frontend + reverse proxy
envsubst < /etc/nginx.conf.template > /etc/nginx/conf.d/default.conf
nginx -g "daemon off;" &

sleep 30s
cat mvn*.log

# wait for them all
wait -n
