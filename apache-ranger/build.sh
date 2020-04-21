echo "Builing a new instance of Apache Ranger"

# echo "going into ranger directory"
cd ranger

echo "Building from source"
#mvn clean compile package -DskipJSTests -DskipTests
#mvn eclipse:eclipse
mvn -Pall -DskipTests=true -DskipJSTests clean compile package


echo "Copying binaries"
rm -rf ../binaries/*
cp target/ranger-2.1.0-SNAPSHOT-tagsync.tar.gz ../binaries
cp target/ranger-2.1.0-SNAPSHOT-usersync.tar.gz ../binaries
cp target/ranger-2.1.0-SNAPSHOT-admin.tar.gz ../binaries
