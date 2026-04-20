FROM nginx:alpine

# 拷贝静态文件
COPY . /usr/share/nginx/html/

# 拷贝 nginx 配置
COPY nginx.conf /etc/nginx/conf.d/default.conf

# 清理元文件
RUN rm -f /usr/share/nginx/html/Dockerfile \
          /usr/share/nginx/html/nginx.conf \
          /usr/share/nginx/html/.dockerignore \
          /usr/share/nginx/html/README.md \
          /usr/share/nginx/html/DEPLOY_GUIDE.md \
          /usr/share/nginx/html/.gitignore

EXPOSE 80
