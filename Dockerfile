ARG ubuntu_release=focal

FROM ubuntu:${ubuntu_release}

RUN \
  apt-get update && \
  DEBIAN_FRONTEND=noninteractive \
  apt-get -y --no-install-recommends install locales libtinfo5 libc6-dev && \
  locale-gen en_US.UTF-8 && \
  apt-get -y -f install && \
  apt-get autoclean && \
  apt-get autoremove && \
  rm -rf /var/lib/apt/lists/*

ENTRYPOINT ["/bin/bash"]

