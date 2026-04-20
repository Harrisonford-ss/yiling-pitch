FROM nginx:alpine
COPY index.html /usr/share/nginx/html/
COPY refs /usr/share/nginx/html/refs/
COPY scene_07 /usr/share/nginx/html/scene_07/
COPY scene_15 /usr/share/nginx/html/scene_15/
EXPOSE 80
