FROM python:3.8-alpine

RUN apk update && apk upgrade && \
    apk add --no-cache bash git openssh
RUN pip install --no-cache-dir git+https://github.com/zmbc/shakespearelang.git

