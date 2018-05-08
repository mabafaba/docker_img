#!/usr/bin/env bash

# Set your environment variables before running the container:
# export NOTEBOOK_DIR=/Users/Marcus/Documents/CS/projects/notebooks/
# export SHELTER_REPO_PATH=/Users/Marcus/Documents/CS/projects/shelter/
# export SHELTER_DATA_PATH=/Users/Marcus/google_drive/shelter_data/

sudo docker run  \
    --privileged \
    -it \
    --rm \
    -p 8888:8888  \
    --net=host \
    -v $NOTEBOOK_DIR:/notebooks/  \
    -v $SHELTER_REPO_PATH:/shelter_repo/  \
    -v $SHELTER_DATA_PATH:/media/data/  \
    cuda-tensorflow-keras