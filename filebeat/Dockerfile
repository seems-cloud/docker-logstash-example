FROM ubuntu:focal

ENV APP_DIR="/app"
ENV APP_USER="filebeat"
ENV APP_UID="1000"

ENV PATH="${APP_DIR}:${PATH}"

SHELL ["/bin/bash", "-c"]

RUN apt-get update && \
    apt-get install wget telnet -y

RUN groupadd -g "${APP_UID}" "${APP_USER}" && \
    useradd -u "${APP_UID}" -g "${APP_UID}" \
            -s /bin/bash -m -d "${APP_DIR}" "${APP_USER}"

WORKDIR /tmp

RUN wget https://artifacts.elastic.co/downloads/beats/filebeat/filebeat-7.16.0-linux-x86_64.tar.gz -O filebeat.tar.gz && \
    tar -xf filebeat.tar.gz -C "${APP_DIR}" --strip-components=1 && \
    chown "${FB_VERSION}":"${FB_VERSION}" -R "${APP_DIR}" && \
    rm -f filebeat.tar.gz

COPY --chown=1000:1000 ./entrypoint.sh "${APP_DIR}"

WORKDIR "${APP_DIR}"
USER "${APP_USER}"

ENTRYPOINT ["/bin/bash", "entrypoint.sh"]
