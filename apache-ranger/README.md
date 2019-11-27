# Apache Ranger Image #

This build is attempting to build a ranger container with TagSync running in a kerberized environment

## Updating the Image ##

If there is an update in `./ranger` then run follow the commands below to rebuild a new image (Note: This will take a __*LONG*__ time)

You can also change the branch source from the **ranger** submodule configured in `../.gitmodules`

1. `./build.sh` - This might take a while
2. `git add . && git commit -m "updated the Ranger source code/image"`
3. `git push`

Wait for dockerhub to build the new image or build it manually by running `docker build .`
