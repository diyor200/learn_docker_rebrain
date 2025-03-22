FROM golang:1.22-alpine

ARG SECRET_KEY

WORKDIR /app

COPY main.go .

RUN go mod init gocalc && \
    go mod tidy && \
    go build -o app main.go

FROM alpine:3.19

COPY --from=0 app /bin/app
RUN echo SECRET_KEY > secret.txt

CMD ["/bin/app"]