FROM nginx:alpine

# 复制所有静态文件到 nginx 默认目录
COPY . /usr/share/nginx/html/

# 移除部署相关的元文件
RUN rm -f /usr/share/nginx/html/Dockerfile \
          /usr/share/nginx/html/zbpack.json \
          /usr/share/nginx/html/.dockerignore \
          /usr/share/nginx/html/README.md

# 自定义 nginx 配置：开启 gzip + 大文件支持
RUN echo 'server { \
    listen 80; \
    server_name _; \
    root /usr/share/nginx/html; \
    index index.html; \
    \
    # 大文件优化（视频 294M） \
    client_max_body_size 500M; \
    sendfile on; \
    tcp_nopush on; \
    tcp_nodelay on; \
    \
    # MP4 流式传输支持 \
    location ~ \.mp4$ { \
        mp4; \
        mp4_buffer_size 4M; \
        mp4_max_buffer_size 16M; \
        add_header Cache-Control "public, max-age=3600"; \
    } \
    \
    # 静态资源缓存 \
    location ~* \.(png|jpg|jpeg|gif|webp|svg)$ { \
        add_header Cache-Control "public, max-age=86400"; \
    } \
    \
    # 默认入口 \
    location / { \
        try_files $uri $uri/ /index.html; \
    } \
}' > /etc/nginx/conf.d/default.conf

EXPOSE 80
