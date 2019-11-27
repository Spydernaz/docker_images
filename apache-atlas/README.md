# Apache Atlas Image #

If there is an update in `./atlas` then run follow the commands below to rebuild a new image

1. `./build.sh` - This might take a while
2. `git add . && git commit -m "updated the Atlas source code/image"`
3. `git push`

Wait for dockerhub to build the new image or build it manually by running `docker build .`
