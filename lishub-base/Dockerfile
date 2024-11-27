FROM jupyter/base-notebook:latest
# Built from...
#    https://hub.docker.com/r/jupyter/base-notebook/
#    https://github.com/jupyter/docker-stacks/blob/HEAD/base-notebook/Dockerfile which uses
#    https://github.com/jupyter/docker-stacks/blob/main/images/docker-stacks-foundation/Dockerfile
#
# As of Sept 2023 this starts from Ubuntu 22.04 (see docker-stacks-foundation).

# VULN_SCAN_TIME=2022-02-22_01:13:56

# The jupyter/docker-stacks images contains jupyterhub and jupyterlab already.

# Example install of git and nbgitpuller.
# NOTE: git is already available in the jupyter/minimal-notebook image.
USER root
RUN apt-get update \
 && apt-get upgrade -y \
 && apt-get install -y curl \
 && apt update \
 && apt-get install -y --no-install-recommends \
        dnsutils \
        git \
        iputils-ping \
        gfortran \
        g++ \
        gcc \
        cmake \
        make \
        libopenblas-dev \
        pkg-config \
        libsecret-1-dev \
        zip \
        unzip \
        vim \
        r-base \
        libcurl4-openssl-dev \
        libssl-dev \
        libxml2-dev \
        liblzma-dev \
        libbz2-dev \
        ne \
    # Packages to export as pdf
        texlive-xetex \
        texlive-fonts-recommended \
        texlive-plain-generic \
        pandoc \
 && rm -rf /var/lib/apt/lists/*

# Install Quarto
RUN curl -L https://github.com/quarto-dev/quarto-cli/releases/download/v1.3.450/quarto-1.3.450-linux-amd64.deb -o quarto.deb && \
    dpkg --install quarto.deb && \
    apt -f install && \
    rm quarto.deb

# Set nbclassic no banner.
COPY jupyterhub_config.py /etc/jupyterhub/

USER $NB_USER

COPY requirements.txt /tmp/requirements.txt
RUN python -m pip install --no-cache-dir \
    -r /tmp/requirements.txt

# Tex Path
RUN export PATH=/Library/TeX/texbin:$PATH

# Support overriding a package or two through passed docker --build-args.
# ARG PIP_OVERRIDES="jupyterhub==1.3.0"
ARG PIP_OVERRIDES=
RUN if [[ -n "$PIP_OVERRIDES" ]]; then \
        pip install --no-cache-dir $PIP_OVERRIDES; \
    fi

# Uncomment the line below to make nbgitpuller default to start up in JupyterLab
ENV NBGITPULLER_APP=lab

# Enable interactive widgets
# https://stackoverflow.com/questions/36351109/ipython-notebook-ipywidgets-does-not-show#38001920
RUN jupyter nbextension enable --py widgetsnbextension
