# Apache Atlas Image #

This build is attempting to build Atlas Server running in a kerberized environment, eventually with TagSync flowing to a Ranger service

**NOTE:** This image will take a while to start up as it has to create all the object tyoes etc, need to look at how to speed this up

## Running the Image ##

This image has a dependance on an external SolrCloud. The easiest way to get Atlas running is by using a compose file. You will find one in the root directory of this repo called `docker-compose.atlas.yml` and can build it by running the following command:

```sh
docker-compose -f docker-compose.atlas.yml up
```

## Accessing the UI ##

To access the image, go to a browser and go to the [UI](http://localhost:21000). The default port for Atlas is 21000 and will be running on your localhost. To log in use the super secure username / password combination `admin`/`admin`

## Building the image locally ##

If you want to try and rebuild this image locally for a different version of Atlas etc. then you can follow the instructions below:

__Note__: Running the commands below to rebuild a new image will take a __*LONG*__ time

1. Update the branch in `./../.gitsubmodules` and refresh the submodules by running `git submodule update --recursive --remote`
2. Make a new directory "binaries". As the binaries can be quite large we dont want to store the compiled version in git and there is a `.gitignore` entry for the binaries file
`mkdir binaries`
3. Run `./build.sh` - This might take a while as it will be building Atlas from the source code
4. Update the version in Dockerfile.local to the version of ranger binaries you have (Careful as this might look like 3.1.0-SNAPSHOT or it could be 3.0)
5. Run `docker build . -f Dockerfile.local`

You should now have a new ImageID for the dockerfile. Update the docker-compose file with the new ImageID to test

## Known Issues ##

- Slow start up speed (10 minutes +)
