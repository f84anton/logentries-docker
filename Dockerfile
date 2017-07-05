FROM ubuntu:xenial

RUN echo 'deb http://rep.logentries.com/ xenial main' > /etc/apt/sources.list.d/logentries.list \
  && gpg --keyserver pgp.mit.edu --recv-keys A5270289C43C79AD && gpg -a --export A5270289C43C79AD | apt-key add - \
  && apt-get update -qq \
  && apt-get install -qy python-setproctitle logentries logentries-daemon locales \
  && rm -rf /var/lib/apt/lists/* \
  && localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8

ENV LANG en_US.utf8
