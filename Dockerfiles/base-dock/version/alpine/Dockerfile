FROM alpine:3.4

RUN apk add --no-cache bash wget

ENV VERSION "17.03.1-ce"
RUN wget --no-check-certificate https://download.docker.com/linux/static/stable/x86_64/docker-$VERSION.tgz -O /tmp/docker-$VERSION.tgz \
	&& tar -xz -C /tmp -f /tmp/docker-$VERSION.tgz \
	&& mv /tmp/docker/docker /usr/bin \
	&& rm -rf /tmp/docker-$VERSION /tmp/docker
