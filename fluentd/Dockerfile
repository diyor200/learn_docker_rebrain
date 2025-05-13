FROM fluent/fluentd:latest

USER root

RUN gem install fluent-plugin-elasticsearch --no-document

COPY fluent.conf /fluentd/etc/

USER fluent