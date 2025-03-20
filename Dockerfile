ARG NG_VERSION

FROM nginx:${NG_VERSION}

ARG NG_VERSION
ENV NG_VERSION=${NG_VERSION}

ARG ARG_FILE
RUN touch /opt/${ARG_FILE}

CMD ["nginx", "-g", "daemon off;"]
