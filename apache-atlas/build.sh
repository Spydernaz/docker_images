echo "Builing a new instance of Apache Atlas"

echo "Pulling updated code"
# git submodule update --recursive --remote --force

cd atlas

echo "Building from source"
export MAVEN_OPTS="-Xms2g -Xmx2g"
mvn clean -DskipTests -Drat.skip=true package -Pdist

echo "Copying binaries"
rm -rf ./../binaries/*
cp ./distro/target/*.tar.gz ./../binaries

