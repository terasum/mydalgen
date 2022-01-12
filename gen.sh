#!/bin/sh
set -ex
java -jar target/mydalgen-1.0-jar-with-dependencies.jar -c generatorConfig.xml -o true