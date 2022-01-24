FROM debian:bullseye-slim

ARG APP_URL="https://artifacts.elastic.co/downloads/beats/filebeat"
ARG APP_VERSION="7.16.3"
ARG APP_DIR="/app"
ARG APP_USER="logstash"
ARG APP_UID="1000"

ARG DEBIAN_FRONTEND=noninteractive

ENV PATH="${APP_DIR}:${PATH}"

SHELL ["/bin/bash", "-c"]

RUN apt-get update && \
    apt-get install wget -y

RUN groupadd -g "${APP_UID}" "${APP_USER}" && \
    useradd -u "${APP_UID}" -g "${APP_UID}" -s /bin/bash -m -d "${APP_DIR}" "${APP_USER}"

WORKDIR /tmp

RUN wget "${APP_URL}/filebeat-${APP_VERSION}-linux-x86_64.tar.gz" -O filebeat.tar.gz && \
    tar -xvf filebeat.tar.gz -C "${APP_DIR}" --strip-components=1 && \
    rm -f filebeat.tar.gz

RUN chown "${APP_USER}":"${APP_USER}" -R "${APP_DIR}"

WORKDIR "${APP_DIR}"

USER "${APP_USER}"

CMD ["filebeat", "-e", "-strict.perms=false"]
