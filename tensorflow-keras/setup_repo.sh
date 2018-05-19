#!/usr/bin/env bash

cd /repo
python setup.py develop

jupyter notebook --port=8888  \
                 --ip=0.0.0.0  \
                 --notebook-dir=/notebooks/