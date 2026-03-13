FROM ubuntu:22.04

RUN apt-get update && apt-get install -y \
    bwa \
    samtools \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /workflow

COPY . /workflow

CMD ["samtools","--version"]
