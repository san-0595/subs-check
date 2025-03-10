FROM debian:bookworm
ENV TZ=Asia/Shanghai
RUN apt-get update && apt-get install -y ca-certificates tzdata && \
    ln -fs /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && \
    dpkg-reconfigure -f noninteractive tzdata && \
    rm -rf /var/cache/apt/*  && \
    mkdir -p /app

RUN ARCH=$(uname -m) && \
    if [ "$ARCH" = "x86_64" ]; then \
        cp /dist/BestSub_linux_amd64_v1/BestSub /app/BestSub; \
    elif [ "$ARCH" = "aarch64" ]; then \
        cp /dist/BestSub_linux_arm64_v8.0/BestSub /app/BestSub; \
    elif [ "$ARCH" = "armv7l" ]; then \
        cp /dist/BestSub_linux_arm_7/BestSub /app/BestSub; \
    elif [ "$ARCH" = "i386" ]; then \
        cp /dist/BestSub_linux_386_sse2/BestSub /app/BestSub; \
    else \
        echo "Unsupported architecture: $ARCH"; exit 1; \
    fi

CMD /app/BestSub