FROM golang:1.21 as base

WORKDIR /web-app

COPY gp.mod .

RUN go mod download

COPY . .

RUN go build -o main .

# Final Stage - Distroless Stage
FROM gcr.io/distroless/base

COPY --from=base /web-app/main .

COPY --from=base /web-app/static ./static

EXPOSE 8080

CMD [ "./main" ]