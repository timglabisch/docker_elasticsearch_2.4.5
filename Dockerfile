FROM ubuntu:20.04

RUN apt-get update && apt-get install -y \
    wget \
    tzdata \
    openjdk-8-jdk \
    curl \
    apt-utils

ENV TZ=Europe/Berlin
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN curl -L -O https://download.elastic.co/elasticsearch/release/org/elasticsearch/distribution/tar/elasticsearch/2.4.5/elasticsearch-2.4.5.tar.gz && \
    tar -xvf elasticsearch-2.4.5.tar.gz

RUN useradd --system -s /sbin/nologin elasticsearch && adduser elasticsearch elasticsearch

RUN cd /elasticsearch-2.4.5 \
	&& mkdir -p ./data \
    && mkdir -p ./logs \
    && mkdir -p ./config \
    && mkdir -p ./config/scripts \
    && cd .. \
    && mkdir -p "elasticsearch-2.4.5" \
	&& export ES_JAVA_OPTS='-Xms32m -Xmx32m'

ADD elasticsearch.yml /elasticsearch-2.4.5/config/elasticsearch.yml

RUN chown -R elasticsearch:elasticsearch "/elasticsearch-2.4.5"

RUN apt-get install -y sudo
RUN echo 2
ADD start.sh /start.sh

ENTRYPOINT ["/start.sh"]
