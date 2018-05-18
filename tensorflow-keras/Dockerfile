#!/usr/bin/env bash

ARG python_version=3.6
ARG cuda_version=9.0
ARG cudnn_version=7
FROM tensorflow/tensorflow

#FROM dataquestio/ubuntu-base

# Set envs
ENV NB_USER jovyan
ENV NB_UID 1000

# Set conda envs
ENV CONDA_DIR /opt/conda
ENV PATH $CONDA_DIR/bin:$PATH

# Install system packages
RUN  apt-get update && apt-get -y install \
      sudo \
      vim \
      git \
      wget

RUN rm -rf /var/lib/apt/lists/*


# Install Tini
RUN wget --quiet https://github.com/krallin/tini/releases/download/v0.10.0/tini && \
    echo "1361527f39190a7338a0b434bd8c88ff7233ce7b9a4876f3315c22fce7eca1b0 *tini" | sha256sum -c - && \
    mv tini /usr/local/bin/tini && \
    chmod +x /usr/local/bin/tini


# Create jovyan user with UID=1000 and in the 'users' group
RUN useradd -m -s /bin/bash -N -u $NB_UID $NB_USER && \
    echo "$NB_USER:shelter" | chpasswd && adduser $NB_USER sudo && \
    mkdir -p $CONDA_DIR && \
    chown $NB_USER $CONDA_DIR

# Switch to user jovyan
USER $NB_USER
WORKDIR /home/$NB_USER
RUN mkdir /home/$NB_USER/.jupyter

# Install anaconda
#RUN wget --quiet https://repo.anaconda.com/archive/Anaconda3-5.1.0-Linux-x86_64.sh -O ~/anaconda.sh && \
#    /bin/bash ~/anaconda.sh -b -p /opt/conda && \
#    rm ~/anaconda.sh && \
#    ln -s /opt/conda/etc/profile.d/conda.sh /etc/profile.d/conda.sh && \
#    echo ". /opt/conda/etc/profile.d/conda.sh" >> ~/.bashrc && \
#    echo "conda activate base" >> ~/.bashrc

RUN cd /tmp && \
    mkdir -p $CONDA_DIR && \
    curl -k https://repo.continuum.io/miniconda/Miniconda3-4.3.31-Linux-x86_64.sh -o Miniconda3-latest-Linux-x86_64.sh && \
    bash Miniconda3-latest-Linux-x86_64.sh -f -b -p $CONDA_DIR && \
    rm Miniconda3-latest-Linux-x86_64.sh && \
    echo 'export PATH="/anaconda3/bin:$PATH"' >> ~/.bashrc && \
    export PATH="/anaconda3/bin:$PATH" && \
    $CONDA_DIR/bin/conda config --system --add channels conda-forge && \
    $CONDA_DIR/bin/conda config --system --set auto_update_conda false && \
    conda clean --yes --all

# Install dependencies
RUN . ~/.bashrc && \
    conda install -y        \
        notebook            \
        matplotlib          \
        numpy               \
        pandas              \
        scipy               \
        scikit-learn        \
        scikit-image        \
        ipyparallel         \
        joblib              \
        flask               \
        h5py                \
        Pillow && \
    conda install -c conda-forge sqlalchemy-utils && \
    conda install -y -c conda-forge pygobject && \
    conda clean -tipsy && \
    pip install --upgrade pip && \
    pip install  --no-cache-dir \
                          utils \
                          sklearn_pandas \
                          tensorflow && \
    git clone git://github.com/keras-team/keras.git /home/$NB_USER/keras && \
    pip install -e /home/$NB_USER/keras[tests] && \
    pip install git+git://github.com/keras-team/keras.git && \
    pip install update && \
    rm -Rf ~/.cache/pip

# Microsoft Cognitive Toolkit
# pip install https://cntk.ai/PythonWheel/GPU/cntk-2.1-cp36-cp36m-linux_x86_64.whl

# Set root pw
USER root
RUN echo "root:shelter" | chpasswd

ENTRYPOINT ["tini", "--"]
CMD ["setup_repo.sh"]

# Add local files
COPY jupyter_notebook_config.py /home/$NB_USER/.jupyter/
COPY setup_repo.sh /usr/local/bin/
RUN chown -R $NB_USER:users /home/$NB_USER/.jupyter && \
    chmod a+x /usr/local/bin/setup_repo.sh

USER $NB_USER

# Expose ports and start notebook server
EXPOSE 8888

CMD jupyter notebook --port=8888  \
                     --ip=0.0.0.0  \
                     --notebook-dir=/notebooks/