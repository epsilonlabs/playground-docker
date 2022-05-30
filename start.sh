#!/bin/bash

mvn -B -o function:run -Drun.functionTarget=org.eclipse.epsilon.live.RunEpsilonFunction -Drun.port=8001 &
mvn -B -o function:run -Drun.functionTarget=org.eclipse.epsilon.live.FlexmiToGraphvizFunction -Drun.port=8002 &
mvn -B -o function:run -Drun.functionTarget=org.eclipse.epsilon.live.EmfaticToGraphvizFunction -Drun.port=8003 &

envsubst < /etc/nginx.conf.template > /etc/nginx/conf.d/default.conf && exec nginx -g "daemon off;"
