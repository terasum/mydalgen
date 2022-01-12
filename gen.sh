#!/bin/sh
set -ex
# mvn clean package -Dmaven.test.skip=true
java -jar target/dalgen-1.0-SNAPSHOT-jar-with-dependencies.jar -configfile generatorConfig.xml -overwrite