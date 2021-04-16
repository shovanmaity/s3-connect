FROM alpine:3.12
RUN apk add --no-cache python3 py3-pip bash
RUN pip3 install --upgrade pip
RUN pip3 install awscli==1.19.48
RUN rm -rf /var/cache/apk/*
COPY run.sh /usr/bin/run.sh
ENTRYPOINT ["run.sh"]
