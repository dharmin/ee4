FROM debian:stretch-slim

RUN apt-get update \
	&& apt-get install -y -q --no-install-recommends \
	wget \
	&& apt-get clean \
	&& rm -r /var/lib/apt/lists/*

ENV VERSION "17.03.1-ce"
RUN wget --no-check-certificate https://download.docker.com/linux/static/stable/x86_64/docker-$VERSION.tgz -O /tmp/docker-$VERSION.tgz \
	&& tar -xz -C /tmp -f /tmp/docker-$VERSION.tgz \
	&& mv /tmp/docker/docker /usr/bin \
	&& rm -rf /tmp/docker-$VERSION /tmp/docker \
	&& apt-get purge -y --auto-remove wget
