FROM nginx:1.17.9-alpine

COPY entrypoint.sh /entrypoint.sh
COPY conf/nginx.conf /etc/nginx/nginx.conf
COPY conf/default.conf /etc/nginx/conf.d/default.conf

CMD [ "/bin/sh", "/entrypoint.sh" ]
