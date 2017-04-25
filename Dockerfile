FROM servercontainers/nginx
LABEL github.user="ServerContainers"

RUN apk update \
 && apk add php5-fpm \
 && rm -f /var/cache/apk/* \
 \
 && sed -i 's/exec "/php-fpm -F \&\nexec "/g' /usr/local/bin/entrypoint.sh \
 && sed -i 's/index.html" ]/index.html" ] \&\& [ ! -e "\/data\/index.php" ] /g' /usr/local/bin/entrypoint.sh \
 && sed -i 's,.*> /data/index.html.*,    echo "<?php phpinfo(); ?>" > /data/index.php,g' /usr/local/bin/entrypoint.sh \
 && sed -i 's,location,include /etc/nginx/snippets/php.conf; location,g' /etc/nginx/conf.d/default.conf \
 \
 && echo "security config" \
 \
 && echo "fix pathinfo see: (https://www.digitalocean.com/community/tutorials/how-to-install-linux-nginx-mysql-php-lemp-stack-on-ubuntu-14-04)" \
 && sed -i 's/;cgi.fix_pathinfo=1/cgi.fix_pathinfo=0/g' /etc/php5/php.ini \
 \
 && echo "done"

COPY snippets /etc/nginx/snippets/
