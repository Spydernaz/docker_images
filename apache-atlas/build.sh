echo "Builing a new instance of Apache Atlas"

echo "Pulling updated code"
git submodule update --recursive --remote

cd atlas

echo "Building from source"
mvn clean -DskipTests -Drat.skip=true package -Pdist,embedded-hbase-solr

echo "Copying binaries"
rm -rf ./../binaries/*
cp ./distro/target/apache-atlas-3.0.0-SNAPSHOT-bin.tar.gz ./../binaries

