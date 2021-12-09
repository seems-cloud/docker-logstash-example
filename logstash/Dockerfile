FROM azul/zulu-openjdk-debian:11

ARG OS_LS_URL="https://artifacts.opensearch.org/logstash"
ARG OS_LS_VERSION="7.13.2"

ENV APP_DIR="/app"
ENV APP_USER="logstash"
ENV APP_UID="1000"

ENV PATH="${APP_DIR}/bin:${PATH}"

SHELL ["/bin/bash", "-c"]

RUN apt-get update && \
    apt-get install wget telnet -y

RUN groupadd -g "${APP_UID}" "${APP_USER}" && \
    useradd -u "${APP_UID}" -g "${APP_UID}" \
            -s /bin/bash -m -d "${APP_DIR}" "${APP_USER}"

WORKDIR /tmp

RUN wget "${OS_LS_URL}/logstash-oss-with-opensearch-output-plugin-${OS_LS_VERSION}-linux-x64.tar.gz" -O logstash.tar.gz

RUN tar -xf logstash.tar.gz -C "${APP_DIR}" --strip-components=1 && \
    mkdir -p "${APP_DIR}/config/pipelines" && \
    chown 1000:1000 -R "${APP_DIR}" && \
    rm -f logstash.tar.gz

COPY --chown=1000:1000 ./entrypoint.sh "${APP_DIR}"

WORKDIR "${APP_DIR}"
USER "${APP_USER}"

ENTRYPOINT ["/bin/bash", "entrypoint.sh"]
