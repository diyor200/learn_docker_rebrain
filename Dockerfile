FROM golang:1.24-alpine AS builder

WORKDIR /app
COPY . .

# Build for Linux (Alpine is Linux-based), static build
RUN GOOS=linux GOARCH=amd64 go build -o server main.go

# Final small image
FROM alpine
WORKDIR /app

COPY --from=builder /app/server .

CMD ["./server"]
