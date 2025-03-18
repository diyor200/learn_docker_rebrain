FROM nginx:stable

COPY nginx.conf /etc/nginx/nginx.conf

EXPOSE 8890

CMD ["nginx", "-g", "daemon off;"]