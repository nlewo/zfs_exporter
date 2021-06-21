FROM golang:1.16-buster AS build
WORKDIR /app
COPY go.mod .
COPY go.sum .
RUN go mod download
COPY *.go .
COPY collector/*.go ./collector/
RUN go build -o /zfs-exporter


FROM debian:10
WORKDIR /
COPY --from=build /zfs-exporter /zfs-exporter
RUN echo deb http://deb.debian.org/debian buster main contrib >> /etc/apt/sources.list
RUN echo deb http://deb.debian.org/debian buster-backports main contrib  >> /etc/apt/sources.list
RUN apt-get update && apt-get install -y --no-install-recommends zfsutils-linux
ENTRYPOINT ["/zfs-exporter"]
