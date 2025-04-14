FROM alpine

WORKDIR /app

COPY . .
RUN ls
CMD [ "./main" ]
