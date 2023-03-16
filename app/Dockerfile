FROM docker.io/golang:alpine as builder

WORKDIR /go/src/app

COPY . .

RUN go mod download

RUN go build -o /app main.go

FROM scratch

COPY --from=builder /app /app

EXPOSE 80

CMD ["/app"]
