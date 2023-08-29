FROM golang:alpine AS build
WORKDIR /app
COPY main.go .
RUN apk update && apk add --no-cache git
RUN CGO_ENABLED=0 GOOS=linux go build -ldflags "-s -w" -o main main.go

FROM scratch

COPY --from=build /app/main /

CMD ["/main"]
