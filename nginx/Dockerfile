FROM nginx:1.17.10-alpine

RUN apk update && \
  apk add --no-cache \
  apache2-utils

ENV PORT 3000
ENV APP_PATH /app
WORKDIR $APP_PATH

RUN mkdir -p log

# COPY ./web/public public/
COPY ./nginx.conf /tmp/docker.nginx
RUN echo "daemon off;" >> /etc/nginx/nginx.conf

# substitute variable references in the Nginx config template for real values 
# from the environment put the final config in its place
RUN envsubst $APP_PATH < /tmp/docker.nginx > /etc/nginx/conf.d/default.conf

EXPOSE 80
CMD ["nginx"]
