#!/usr/bin/env bash

# Install nvidia-docker:
# https://github.com/NVIDIA/nvidia-docker

# Set your environment variables before running the container -
# You shouldn't have any whitespaces or underscores in mount paths:
# export NOTEBOOK_DIR=/Users/Marcus/Documents/CS/projects/notebooks/
# export SHELTER_REPO_PATH=/Users/Marcus/Documents/CS/projects/classify_shelters/
# export SHELTER_DATA_PATH=/Users/Marcus/googledrive/shelterdata/

export NOTEBOOK_DIR=/home/marcus/Documents/notebooks/
export SHELTER_REPO_PATH=/home/marcus/Documents/projects/classify_shelters/
export SHELTER_DATA_PATH=/home/marcus/Documents/projects/shelter_data/

sudo nvidia-docker run   \
    --privileged  \
    -it  \
    --rm  \
    -p 8890:8888  \
    --net=host \
    -v $NOTEBOOK_DIR:/notebooks/  \
    -v $SHELTER_REPO_PATH:/repo/  \
    -v $SHELTER_DATA_PATH:/media/data/  \
    -v /var/run/docker.sock:/var/run/docker.sock \
    --name shelter_container \
    cuda_tensorflow_keras

# TODO: Resolve hostname hack:
# https://github.com/jupyter/notebook/issues/3605
# -h 0.0.0.0 \
