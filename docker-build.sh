#!/bin/sh

mvn dependency:copy-dependencies -DexcludeTransitive=true
docker build -t playground-docker:micronaut .