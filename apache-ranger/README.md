# Apache Ranger Image #

This build is attempting to build a ranger container with TagSync running in a kerberized environment

## Running the Image ##

This image has a dependance on the mysql backend running and reachable. The easiest way to get Ranger running is by using a compose file. You will find one in the root directory of this repo called `docker-compose.ranger.yml` and can build it by running the following command:

```sh
docker-compose -f docker-compose.ranger.yml up
```

(Note: the below commands will not enable logging as it requires SOLR)
If you want to deploy it on your host network or without a compose file, you will still need the db. Run the following commands to test:

```sh
docker run -d --network=host --name=ranger-db -e MYSQL_ROOT_PASSWORD=password spydernaz/apache-ranger-admin-db:latest
docker run -d --network=host --name=ranger-admin spydernaz/apache-ranger-admin:latest
```

## Accessing the UI ##

To access the image, go to a browser and go to the [UI](http://localhost:6080). The default port for Ranger is 6080 and will be running on your localhost. To log in use the super secure username / password combination `admin`/`password1`

## Building the image locally ##

If you want to try and rebuild this image locally for a different version of Ranger etc. then you can follow the instructions below:

__Note__: Running the commands below to rebuild a new image will take a __*LONG*__ time

1. Update the branch in `./../.gitsubmodules` and refresh the submodules by running `git submodule update --recursive --remote`
2. Make a new directory "binaries". As the binaries can be quite large we dont want to store the compiled version in git and there is a `.gitignore` entry for the binaries file
`mkdir binaries`
3. Run `./build.sh` - This might take a while as it will be building Ranger from the source code
4. Update the version in Dockerfile.local to the version of ranger binaries you have (Careful as this might look like 2.1.0-SNAPSHOT or it could be 2.0)
5. Run `docker build . -f Dockerfile.local`

You should now have a new ImageID for the dockerfile. Update the docker-compose file with the new ImageID to test

## Known Issues ##

- Image not currently kerberised
- TagSync tool not currently working in the image (appears to be a package missing?)
- No services connected (also havent tested atlas connectivity)
