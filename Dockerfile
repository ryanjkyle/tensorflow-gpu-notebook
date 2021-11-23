# Copyright (c) Jupyter Development Team.
# Distributed under the terms of the Modified BSD License.
ARG OWNER=jupyter
ARG BASE_CONTAINER=$OWNER/scipy-notebook
FROM $BASE_CONTAINER

LABEL maintainer="Ryan J Kyle <ryanjkyle85@gmail.com>"

USER root

RUN usermod -aG sudo "${NB_USER}" && \
     sed -i -e 's/^#\(%sudo\sALL=(ALL:ALL)\)\s\+ALL/\1 NOPASSWD: ALL/' /etc/sudoers

USER "${NB_USER}"

# Fix DL4006
SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# Install Tensorflow
RUN mamba install --yes \
    'tensorflow-gpu' && \
    mamba clean --all -f -y && \
    fix-permissions "${CONDA_DIR}" && \
    fix-permissions "/home/${NB_USER}"

