echo "Builing a new instance of Apache Ranger"

# echo "going into ranger directory"
cd ranger

echo "Pulling updated code"
git submodule update --recursive --remote

echo "Building from source"
mvn clean compile install package -DskipJSTests -DskipTests assembly:assembly
mvn eclipse:eclipse

echo "Copying binaries"
rm -rf ../binaries/*
cp target/ranger-2.0.1-SNAPSHOT-tagsync.tar.gz ../binaries
cp target/ranger-2.0.1-SNAPSHOT-usersync.tar.gz ../binaries
cp target/ranger-2.0.1-SNAPSHOT-admin.tar.gz ../binaries