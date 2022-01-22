#!/bin/bash

mvn function:run -Drun.functionTarget=org.eclipse.epsilon.live.RunEpsilonFunction -Drun.port=8001 &
mvn function:run -Drun.functionTarget=org.eclipse.epsilon.live.FlexmiToGraphvizFunction -Drun.port=8002 &
mvn function:run -Drun.functionTarget=org.eclipse.epsilon.live.EmfaticToGraphvizFunction -Drun.port=8003 &
cd ../epsilon/mkdocs/docs/live

exec python3 -m http.server 8000