FROM php:cli-stretch
ENV GOSU_VERSION 1.7


RUN set -ex; \
	\
	deps=' \
	less \
	mysql-client \
	ca-certificates \
	gnupg2 \
	dirmngr \
	'; \
	apt-get update \
	&& apt-get install -y --no-install-recommends $deps

RUN curl -o /usr/local/bin/gosu -L "https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-$(dpkg --print-architecture)" \
	&& curl -o /usr/local/bin/gosu.asc -L "https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-$(dpkg --print-architecture).asc" \
	&& export GNUPGHOME="$(mktemp -d)" \
	&& gpg --keyserver ha.pool.sks-keyservers.net --recv-keys B42F6819007F00F88E364FD4036A9C25BF357DD4 \
	&& gpg --batch --verify /usr/local/bin/gosu.asc /usr/local/bin/gosu \
	&& rm -rf "$GNUPGHOME" /usr/local/bin/gosu.asc \
	&& chmod +x /usr/local/bin/gosu \
	&& gosu nobody true \
	&& rm -rf /var/lib/apt/lists/*;

RUN curl -o /tmp/ee4 -L https://raw.githubusercontent.com/mbtamuli/ee4-builds/master/ee.phar; \
	chmod +x /tmp/ee4; \
	mv /tmp/ee4 /usr/local/bin/ee4;

ENV VERSION "17.03.1-ce"
RUN curl -o /tmp/docker-$VERSION.tgz -L https://download.docker.com/linux/static/stable/x86_64/docker-$VERSION.tgz \
	&& tar -xz -C /tmp -f /tmp/docker-$VERSION.tgz \
	&& mv /tmp/docker/docker /usr/bin \
	&& rm -rf /tmp/docker-$VERSION /tmp/docker \
	&& apt-get purge -y --auto-remove $deps

ENV COMPOSE_VERSION 1.19.0
RUN curl -o /usr/local/bin/docker-compose -L \
	"https://github.com/docker/compose/releases/download/${COMPOSE_VERSION}/docker-compose-Linux-x86_64" \
	&& chmod +x /usr/local/bin/docker-compose

RUN groupadd -r -g 133 docker && groupadd -r -g 1000 ee && useradd -r -b /app -u 1000 -g ee ee && addgroup ee docker;\
	mkdir /app/;

COPY entrypoint.sh /app/entrypoint.sh
RUN chmod u+x /app/entrypoint.sh
VOLUME ["/app/ee/Sites", "/app/ee/.ee4"]
ENTRYPOINT ["/app/entrypoint.sh"]
