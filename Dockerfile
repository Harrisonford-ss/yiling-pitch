FROM caddy:2-alpine

# 拷静态文件
COPY index.html /srv/
COPY refs /srv/refs/
COPY scene_07 /srv/scene_07/
COPY scene_15 /srv/scene_15/

# Caddyfile - 单文件配置最简单
RUN echo ':80 {' > /etc/caddy/Caddyfile && \
    echo '  root * /srv' >> /etc/caddy/Caddyfile && \
    echo '  file_server' >> /etc/caddy/Caddyfile && \
    echo '  try_files {path} /index.html' >> /etc/caddy/Caddyfile && \
    echo '}' >> /etc/caddy/Caddyfile

EXPOSE 80
