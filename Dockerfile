FROM alpine/git as builder

RUN git clone https://codeberg.org/wh0ami/file_directory_exporter.git /home/filexp
FROM alpine:latest

COPY --from=builder /home/filexp /usr/app

WORKDIR /usr/app

RUN echo "Hello World" > index.html && \
  apk add python3 && \
  rm -rf /tmp/* && \
  rm -rf /var/cache/* && \
  mv config.sample.json config.json

#ENTRYPOINT ["python3", "-m", "http.server"]
ENTRYPOINT ["python3","exporter.py","config.json"]
