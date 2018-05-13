#!/usr/bin/env bash

# Set your environment variables before running the container -
# You shouldn't have any whitespaces or underscores in mount paths:
# export NOTEBOOK_DIR=/Users/Marcus/Documents/CS/projects/notebooks/
# export SHELTER_REPO_PATH=/Users/Marcus/Documents/CS/projects/classify_shelters/
# export SHELTER_DATA_PATH=/Users/Marcus/googledrive/shelterdata/

sudo docker run   \
    --privileged  \
    -it  \
    --rm  \
    -p 8888:8888  \
    -v $NOTEBOOK_DIR:/notebooks/  \
    -v $SHELTER_REPO_PATH:/shelter_repo/  \
    -v $SHELTER_DATA_PATH:/media/data/  \
    tensorflow_keras

#    --net=host