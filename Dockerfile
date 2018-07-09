FROM nginx:1.14.0-alpine@sha256:3d36a2c9513a5aa6aa6c41b076201d468bdb94c4f2b4c6e55d32a461ac8f00ee
# ADD https://github.com/nginxinc/docker-nginx/blob/d377983a14b214fcae4b8e34357761282aca788f/stable/alpine/Dockerfile /Dockerfile

LABEL maintainer="Dino Hensen <dino.hensen@gmail.com>"

RUN mkdir -p /src
WORKDIR /src
VOLUME [ "/src" ]
COPY requirements/requirements.txt /src/requirements.txt
RUN apk add --no-cache python3 uwsgi-python3 supervisor \
    && python3 -m ensurepip \
    && pip3 install -r /src/requirements.txt

COPY supervisord/supervisord.conf /etc/supervisord/supervisord.conf
COPY supervisord/conf.d /etc/supervisord/conf.d

EXPOSE 80
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisord/supervisord.conf"]
