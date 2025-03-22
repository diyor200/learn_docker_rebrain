FROM golang:1.22-alpine AS builder

WORKDIR /app

COPY main.go .
RUN go mod init test && \
    go mod tidy && \
    go build -o /bin/app main.go


FROM alpine:3.19

COPY --from=builder /bin/app /bin/app

CMD ["/bin/app"]
