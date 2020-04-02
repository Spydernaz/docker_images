echo "Builing a new instance of Apache Atlas"

cd atlas

echo "Building from source"
export MAVEN_OPTS="-Xms2g -Xmx2g"
# mvn clean -DskipTests -Drat.skip=true package -Pdist
mvn clean -DskipTests -Drat.skip=true package -Pdist,embedded-hbase-solr


echo "Copying binaries"
rm -rf ./../binaries/*
cp ./distro/target/*.tar.gz ./../binaries

