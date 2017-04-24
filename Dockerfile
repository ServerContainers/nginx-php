FROM servercontainers/nginx
LABEL github.user="ServerContainers"

RUN apk update \
 && apk add php5-fpm \
 && rm -f /var/cache/apk/* \
 \
 && sed -i 's/exec "/php-fpm -F \&\nexec "/g' /usr/local/bin/entrypoint.sh \
 && sed -i 's/index.html" ]/index.html" ] \&\& [ ! -e "\/data\/index.php" ] /g' /usr/local/bin/entrypoint.sh \
 && sed -i 's,.*> /data/index.html.*,    echo "<?php phpinfo(); ?>" > /data/index.php,g' /usr/local/bin/entrypoint.sh \
 && sed -i 's,location,include /etc/nginx/snippets/php.conf; location,g' /etc/nginx/conf.d/default.conf

COPY snippets /etc/nginx/snippets/

