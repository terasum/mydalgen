#!/bin/sh
mvn clean package --file pom.xml -Dmaven.test.skip=true
version=$(cat pom.xml | grep '##project version' | awk -F '>' '{print $2}' | awk -F '<' '{print $1}')

mkdir -p dist/mydalgen-"v${version}"
cp -r target/mydalgen-$version-jar-with-dependencies.jar dist/mydalgen-"v${version}"/mydalgen-$version-all.jar
cp -r generatorConfig.xml dist/mydalgen-"v${version}"/

cat <<EOF > dist/mydalgen-"v${version}"/mydqlgen
#!/bin/sh
SCRIPT_DIR=\$(dirname "\$(python -c 'import os, sys; print(os.path.realpath(sys.argv[1]))' \$0)")
while getopts c:o: OPT; do
  case \${OPT} in
    c) in_file=\${OPTARG}
    ;;
    o) override=\${OPTARG}
    ;;
    \?)
    printf "Usage: mydalgen -c generatorConfig.xml -o true \n" >&2
    printf "       -c : configuration file path\n" >&2
    printf "       -o : override flag, this will override exists file\n" >&2
    exit 1
  esac
done


if [ -z "\${override}" ]; then
  override="false"
fi

if [ -z "\${in_file}" -o ! -f "\${in_file}" ]; then
  printf "Error: invalid config file: -c=%s\n" "\${in_file}"
  exit 1
fi

java -jar \${SCRIPT_DIR}/mydalgen-${version}-all.jar -c "\${in_file}" -o "\${override}"

EOF

tar -C dist -zcf dist/mydalgen.tar.gz mydalgen-"v${version}"
