FROM ubuntu:xenial

ENV RUNLEVEL=1 \
    DEBIAN_FRONTEND=noninteractive \
    TZ=Europe/Moscow

RUN \
 apt-get update -qq \
 && apt-get install -qy --no-install-recommends tzdata locales jq nmap \
 && localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8 \
 && rm -rf /var/lib/apt/lists/*

COPY entrypoint.sh /

ENTRYPOINT ["/entrypoint.sh"]
