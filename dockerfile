FROM golang:latest AS builder

RUN apk add git

COPY ./ /github.com/ruslan272/finalmain
WORKDIR /github.com/ruslan272/finalmain


RUN go mod download
RUN CGO_ENABLED=0 GOOS=linux go build -o binary

FROM alpine

COPY --from=builder binary /
COPY --from=builder tracker.db /

CMD ["/binary"]