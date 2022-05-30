#!/bin/bash

set -e

# Functions for running Epsilon
mvn -B -o function:run -Drun.functionTarget=org.eclipse.epsilon.live.RunEpsilonFunction -Drun.port=8001 &
mvn -B -o function:run -Drun.functionTarget=org.eclipse.epsilon.live.FlexmiToGraphvizFunction -Drun.port=8002 &
mvn -B -o function:run -Drun.functionTarget=org.eclipse.epsilon.live.EmfaticToGraphvizFunction -Drun.port=8003 &

# nginx as frontend + reverse proxy
envsubst < /etc/nginx.conf.template > /etc/nginx/conf.d/default.conf
nginx -g "daemon off;" &

# wait for them all
wait -n
