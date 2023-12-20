FROM golang:alpine

ARG BUILD_RFC3339="1970-01-01T00:00:00Z"
ARG COMMIT="local"
ARG VERSION="v3.2.0"

ENV GITHUB_USER="kgretzky"
ENV EVILGINX_REPOSITORY="github.com/${GITHUB_USER}/evilginx2"
ENV INSTALL_PACKAGES="git make gcc musl-dev go"
ENV PROJECT_DIR="${GOPATH}/src/${EVILGINX_REPOSITORY}"
ENV EVILGINX_BIN="/bin/evilginx"

RUN mkdir -p ${GOPATH}/src/github.com/${GITHUB_USER} \
    && apk add --no-cache ${INSTALL_PACKAGES} \
    && git -C ${GOPATH}/src/github.com/${GITHUB_USER} clone https://github.com/${GITHUB_USER}/evilginx2 

RUN sed -i '180d;412d;609d;1657d;1658d;1659d' ${PROJECT_DIR}/core/http_proxy.go

RUN set -ex \
        && cd ${PROJECT_DIR}/ && go get ./... && make \
		&& cp ${PROJECT_DIR}/build/evilginx ${EVILGINX_BIN} \
		&& apk del ${INSTALL_PACKAGES} && rm -rf /var/cache/apk/* && rm -rf ${GOPATH}/src/*

COPY ./docker-entrypoint.sh /opt/
RUN chmod +x /opt/docker-entrypoint.sh
		
ENTRYPOINT ["/opt/docker-entrypoint.sh"]
EXPOSE 443

STOPSIGNAL SIGKILL

# Build-time metadata as defined at http://label-schema.org
ARG BUILD_DATE
ARG VCS_REF
ARG VERSION

LABEL org.label-schema.build-date=$BUILD_DATE \
  org.label-schema.name="Evilginx2 Docker" \
  org.label-schema.description="Evilginx2 Docker Build" \
  org.label-schema.url="https://github.com/almart/docker-evilginx2" \
  org.label-schema.vcs-ref=$VCS_REF \
  org.label-schema.vcs-url="https://github.com/almart/docker-evilginx2" \
  org.label-schema.vendor="warhorse" \
  org.label-schema.version=$VERSION \
  org.label-schema.schema-version="1.0"
