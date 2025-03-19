FROM ubuntu:18.04

RUN apt update -y && apt install nginx -y

WORKDIR /etc/nginx/

COPY nginx.conf .

VOLUME /var/lib/nginx

EXPOSE 80

CMD ["-g", "daemon off;"]
ENTRYPOINT ["nginx"]
