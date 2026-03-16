FROM alpine:latest
RUN apk add --no-cache curl unzip
RUN curl -L -o v2ray.zip https://github.com/v2fly/v2ray-core/releases/download/v5.47.0/v2ray-linux-64.zip && \
    unzip v2ray.zip && \
    chmod +x v2ray
RUN echo '{"inbounds":[{"port":10000,"protocol":"vmess","settings":{"clients":[{"id":"1d8c7c9e-5e8b-4a3b-9c8d-7e6f5a4b3c2d"}]},"streamSettings":{"network":"ws","wsSettings":{"path":"/zoom-v2ray"}}}],"outbounds":[{"protocol":"freedom"}]}' > /config.json
CMD ["./v2ray", "run", "-c", "/config.json"]
