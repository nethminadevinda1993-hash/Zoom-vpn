FROM alpine:latest

# 1. Install tools
RUN apk add --no-cache curl unzip

# 2. Download and Setup V2Ray
RUN curl -L -o /tmp/v2ray.zip https://github.com/v2fly/v2ray-core/releases/download/v5.47.0/v2ray-linux-64.zip && \
    mkdir -p /usr/bin/v2ray && \
    unzip /tmp/v2ray.zip -d /usr/bin/v2ray && \
    chmod +x /usr/bin/v2ray/v2ray && \
    rm /tmp/v2ray.zip

# 3. Create Config (Port must be 7860 for Hugging Face)
RUN echo '{\
    "inbounds": [{\
        "port": 7860,\
        "protocol": "vmess",\
        "settings": {\
            "clients": [{"id": "1d8c7c9e-5e8b-4a3b-9c8d-7e6f5a4b3c2d"}]\
        },\
        "streamSettings": {\
            "network": "ws",\
            "wsSettings": {"path": "/zoom-v2ray"}\
        }\
    }],\
    "outbounds": [{"protocol": "freedom"}]\
}' > /etc/v2ray_config.json

# 4. Start V2Ray
CMD ["/usr/bin/v2ray/v2ray", "run", "-c", "/etc/v2ray_config.json"]
