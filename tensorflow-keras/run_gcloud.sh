#!/usr/bin/env bash

# Set your environment variables before running the container -
# You shouldn't have any whitespaces or underscores in mount paths:
export NOTEBOOK_DIR=/notebooks
export SHELTER_REPO_PATH=/classifyshelters
export SHELTER_DATA_PATH=/shelterdata

sudo docker run   \
    --privileged  \
    -it  \
    --rm  \
    -p 8888:8888  \
    -v $NOTEBOOK_DIR:/notebooks/  \
    -v $SHELTER_REPO_PATH:/repo/  \
    -v $SHELTER_DATA_PATH:/media/data/  \
    -h 0.0.0.0 \
    --name shelter_container \
    tensorflow_keras

# TODO: Resolve hostname hack:
# https://github.com/jupyter/notebook/issues/3605
