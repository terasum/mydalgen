#!/bin/sh
mvn clean package -Dmaven.test.skip=true
version=$(cat pom.xml | grep '##project version' | awk -F '>' '{print $2}' | awk -F '<' '{print $1}')

mkdir -p dist/bin
cp -r target/mydalgen-$version-jar-with-dependencies.jar dist/bin/mydalgen-$version-all.jar

cat <<EOF > dist/bin/mydqlgen
#!/bin/sh
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

java -jar mydalgen-1.0-all.jar -c "\${in_file}" -o "\${override}"

EOF

tar -C dist -zcf dist/mydalgen-$version.tar.gz bin
