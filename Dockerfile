FROM golang:1.24-alpine AS builder

WORKDIR /app
COPY . .

RUN go mod tidy && go build -o app main.go


FROM alpine

COPY --from=builder app .

EXPOSE 8080

CMD [ "./app" ]