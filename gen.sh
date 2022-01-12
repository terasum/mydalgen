#!/bin/sh
set -ex
mvn clean package -Dmaven.test.skip=true
java -jar target/mydalgen-1.0-jar-with-dependencies.jar -c generatorConfig.xml -o true