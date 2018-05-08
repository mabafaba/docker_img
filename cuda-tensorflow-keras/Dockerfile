#!/usr/bin/env bash

ARG python_version=3.6
ARG cuda_version=9.0
ARG cudnn_version=7
FROM nvidia/cuda:${cuda_version}-cudnn${cudnn_version}-devel

#FROM dataquestio/ubuntu-base

# Set conda envs
ENV CONDA_DIR /opt/conda
ENV PATH $CONDA_DIR/bin:$PATH

# Install system packages
RUN apt-get update && apt-get install -y --no-install-recommends \
      git \
      wget && \
    rm -rf /var/lib/apt/lists/*


# Install Tini
RUN wget --quiet https://github.com/krallin/tini/releases/download/v0.10.0/tini && \
    echo "1361527f39190a7338a0b434bd8c88ff7233ce7b9a4876f3315c22fce7eca1b0 *tini" | sha256sum -c - && \
    mv tini /usr/local/bin/tini && \
    chmod +x /usr/local/bin/tini

# Install anaconda
RUN wget --quiet https://repo.anaconda.com/archive/Anaconda3-5.1.0-Linux-x86_64.sh -O ~/anaconda.sh && \
    /bin/bash ~/anaconda.sh -b -p /opt/conda && \
    rm ~/anaconda.sh && \
    ln -s /opt/conda/etc/profile.d/conda.sh /etc/profile.d/conda.sh && \
    echo ". /opt/conda/etc/profile.d/conda.sh" >> ~/.bashrc && \
    echo "conda activate base" >> ~/.bashrc

# Install dependencies
RUN conda install -y python=${python_version} && \
    pip install --upgrade pip && \
    pip install \
      sklearn_pandas \
      tensorflow-gpu && \
    conda install \
      h5py \
      matplotlib \
      notebook \
      Pillow \
      pandas \
      numpy \
      gdal \
      scikit-learn \
      scikit-image && \
    git clone git://github.com/keras-team/keras.git /src && pip install -e /src[tests] && \
    pip install git+git://github.com/keras-team/keras.git && \
    conda clean -yt

# Microsoft Cognitive Toolkit
# pip install https://cntk.ai/PythonWheel/GPU/cntk-2.1-cp36-cp36m-linux_x86_64.whl

# Set root pw
RUN echo "root:shelter" | chpasswd

# Switch to user jovyan
RUN useradd -ms /bin/bash jovyan
USER jovyan
WORKDIR /home/jovyan

# Copy notebook config
ENTRYPOINT ["tini", "--"]
COPY jupyter_notebook_config.py /home/$NB_USER/.jupyter/

# Expose ports and start notebook server
EXPOSE 8888

CMD jupyter notebook --port=8888  \
                     --ip=0.0.0.0  \
                     --notebook-dir=/notebooks/