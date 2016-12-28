FROM python:2.7-slim

RUN apt-get update && apt-get install -y --no-install-recommends \
		dos2unix \
	&& rm -rf /var/lib/apt/lists/*

ENV TINI_VERSION v0.13.2
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /tini
RUN chmod +x /tini

ENV RQ_VERSION 0.7.1
RUN pip install rq==$RQ_VERSION

ADD autoexec.sh /
RUN dos2unix /autoexec.sh
RUN chmod a+x /autoexec.sh

RUN mkdir /app
WORKDIR /app

ENV RQ_REDIS_URL redis://redis

ENTRYPOINT ["/tini", "--", "/autoexec.sh"]
CMD ["worker", "high", "normal", "low"]
