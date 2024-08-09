# build everything
FROM ubuntu:22.04

RUN apt-get update && apt-get upgrade -y && \
    apt-get install -y curl \
    wget \
    build-essential \
    git \
    python3-pip \
    python3.10-venv \
    ca-certificates \
    curl \
    gnupg \
    lsb-release \ 
    gzip \
    libftdi1-2 \
    libftdi1-dev \
    libhidapi-hidraw0 \
    libhidapi-dev \
    libudev-dev \
    zlib1g-dev \
    cmake \
    pkg-config \
    make \
    g++ \
    udev

ADD install.sh /install.sh

ARG TARGETOS
ARG TARGETARCH
ARG DATESTAMP

RUN echo $TARGETOS $TARGETARCH

RUN bash install.sh

ENV PATH="${PATH}:/opt/oss-cad-suite/bin/"
ENV DATESTAMP=$DATESTAMP
