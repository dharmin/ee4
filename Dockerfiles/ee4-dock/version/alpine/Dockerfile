FROM php:cli-alpine3.7
ENV GOSU_VERSION 1.7

## Install dependencies
RUN set -ex; \
	\
	deps=' \
	less \
	mysql-client \
	shadow \
	'; \
	apk add --no-cache $deps


## Install gosu
RUN set -ex; \
	\
	apk add --no-cache --virtual .gosu-deps \
	dpkg \
	gnupg \
	openssl \
	; \
	\
	dpkgArch="$(dpkg --print-architecture | awk -F- '{ print $NF }')"; \
	wget -O /usr/local/bin/gosu "https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-$dpkgArch"; \
	wget -O /usr/local/bin/gosu.asc "https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-$dpkgArch.asc"; \
	\
	# verify the signature
	export GNUPGHOME="$(mktemp -d)"; \
	gpg --keyserver ha.pool.sks-keyservers.net --recv-keys B42F6819007F00F88E364FD4036A9C25BF357DD4; \
	gpg --batch --verify /usr/local/bin/gosu.asc /usr/local/bin/gosu; \
	rm -r "$GNUPGHOME" /usr/local/bin/gosu.asc; \
	\
	chmod +x /usr/local/bin/gosu; \
	# verify that the binary works
	gosu nobody true; \
	\
	apk del .gosu-deps

	
## Install ee phar
RUN curl -o /tmp/ee4 -L https://raw.githubusercontent.com/mbtamuli/ee4-builds/master/ee.phar; \
	chmod +x /tmp/ee4; \
	mv /tmp/ee4 /usr/local/bin/ee4;

## Install Docker-client
ENV VERSION "17.03.1-ce"
RUN curl -o /tmp/docker-$VERSION.tgz -L https://download.docker.com/linux/static/stable/x86_64/docker-$VERSION.tgz \
	&& tar -xz -C /tmp -f /tmp/docker-$VERSION.tgz \
	&& mv /tmp/docker/docker /usr/bin \
	&& rm -rf /tmp/docker-$VERSION /tmp/docker \

## Install Docker-compose
ENV COMPOSE_VERSION 1.19.0
RUN curl -o /usr/bin/docker-compose -L \
	"https://github.com/docker/compose/releases/download/${COMPOSE_VERSION}/docker-compose-Linux-x86_64" \
	&& chmod +x /usr/bin/docker-compose

## Add user and group "ee"
RUN groupadd -r -g 133 docker && groupadd -r -g 1000 ee && useradd -r -b /app -u 1000 -g ee ee && addgroup ee docker; \
	mkdir /app/;

COPY entrypoint.sh /app/entrypoint.sh
RUN chmod u+x /app/entrypoint.sh
VOLUME ["/app/ee/Sites", "/app/ee/.ee4"]
ENTRYPOINT ["/app/entrypoint.sh"]
