FROM jupyter/base-notebook:latest
# Built from... https://hub.docker.com/r/jupyter/base-notebook/
#               https://github.com/jupyter/docker-stacks/blob/HEAD/base-notebook/Dockerfile
# Built from... Ubuntu 20.04

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
        gcc \
        g++ \
        make \
        pkg-config \
        libsecret-1-dev \
        zip \
        vim \
 && rm -rf /var/lib/apt/lists/*

# Fix suggested by Damian on support thread
RUN wget https://raw.githubusercontent.com/mwouts/jupytext/main/binder/labconfig/default_setting_overrides.json \
    -P  /opt/conda/etc/jupyter/labconfig/

USER $NB_USER

COPY requirements.txt /tmp/requirements.txt
RUN python -m pip install --no-cache-dir \
    -r /tmp/requirements.txt

# Support overriding a package or two through passed docker --build-args.
# ARG PIP_OVERRIDES="jupyterhub==1.3.0"
ARG PIP_OVERRIDES=
RUN if [[ -n "$PIP_OVERRIDES" ]]; then \
        pip install --no-cache-dir $PIP_OVERRIDES; \
    fi

# Uncomment the line below to make nbgitpuller default to start up in JupyterLab
#ENV NBGITPULLER_APP=lab

# Enable interactive widgets
# https://stackoverflow.com/questions/36351109/ipython-notebook-ipywidgets-does-not-show#38001920
RUN jupyter nbextension enable --py widgetsnbextension
