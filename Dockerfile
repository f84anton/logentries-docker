FROM ubuntu:xenial

ENV RUNLEVEL=1 \
    DEBIAN_FRONTEND=noninteractive \
    TZ=Europe/Moscow

RUN \
 echo 'deb http://rep.logentries.com/ xenial main' > /etc/apt/sources.list.d/logentries.list && \
 gpg --keyserver pgp.mit.edu --recv-keys A5270289C43C79AD && \
 gpg -a --export A5270289C43C79AD | apt-key add - && \
 apt-get update -qq && \
 apt-get install python-setproctitle logentries tzdata locales -yq && \
 localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8 && \
 mkdir -p /etc/le && \
 rm -rf /var/lib/apt/lists/*


COPY entrypoint.sh /

ENTRYPOINT ["/entrypoint.sh"]
