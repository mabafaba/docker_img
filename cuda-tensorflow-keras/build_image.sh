#! /bin/bash

set -e

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
sudo nvidia-docker build $DIR -t cuda_tensorflow_keras