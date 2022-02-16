FROM debian:buster-slim

ARG APP_USER="nxlog"
ARG APP_GROUP="${APP_USER}"
ARG APP_UID="1000"
ARG APP_GID="${APP_UID}"
ARG APP_URL="https://nxlog.co/system/files/products/files/348"
ARG APP_VERSION="3.0.2272"

ARG DEBIAN_FRONTEND=noninteractive

ENV APP_DIR="/app"
ENV PATH="${APP_DIR}/bin:${PATH}"

SHELL ["/bin/bash", "-c"]

RUN apt-get update && \
    apt-get install wget libcap-dev libapr1 -y

RUN groupadd -g "${APP_GID}" "${APP_GROUP}" && \
    useradd -u "${APP_UID}" -g "${APP_GID}" -s /bin/bash -m -d "${APP_DIR}" "${APP_USER}"

WORKDIR /tmp

RUN wget "${APP_URL}/nxlog-ce_${APP_VERSION}_debian_buster_amd64.deb" -O nxlog.deb && \
    dpkg-deb -R nxlog.deb tmp/ &&  \
    mv tmp/etc/nxlog/nxlog.conf "${APP_DIR}" && \
    mv tmp/usr/bin "${APP_DIR}" && \
    mv tmp/usr/lib/nxlog/modules "${APP_DIR}" && \
    mkdir "${APP_DIR}/certs" && \
    rm -rf tmp

RUN ln -sf /dev/stdout /app/nxlog.log

WORKDIR "${APP_DIR}"

RUN cat nxlog.conf

COPY ./entrypoint.sh .

RUN chown --recursive "${APP_USER}":"${APP_USER}" "${APP_DIR}"

USER "${APP_USER}"

ENTRYPOINT [ "/bin/bash", "entrypoint.sh" ]