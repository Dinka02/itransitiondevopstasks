apt-get update
apt-get -y upgrade

apt-get install -y nginx
apt-get install -y mysql-server
apt-get install -y php-fpm php-mysql

# создаем две директории для двух виртуальных хостов
mkdir /var/www/site1.loc
mkdir /var/www/site2.loc
# создаем в каждой из этих директорий php-файл
echo '<?php phpinfo(); ?>' > /var/www/site1.loc/index.php
echo '<?php phpinfo(); ?>' > /var/www/site2.loc/index.php

# создаем два виртуальных хоста
cat > /etc/nginx/sites-available/site1.loc <<EOF
server {
    # слушать порт 80
    listen 80;
    # директория сайта
    root /var/www/site1.loc;
    # индексные файлы
    index index.php index.html;
    # домен сайта
    server_name site1.loc www.site1.loc;

    location / {
        try_files \$uri \$uri/ =404;
    }

    # PHP скрипты передаются на выполнение FastCGI серверу
    location ~ \.php$ {
        include snippets/fastcgi-php.conf;
        # With php-fpm (or other unix sockets):
        fastcgi_pass unix:/var/run/php/php7.2-fpm.sock;
    }
}
EOF

cat > /etc/nginx/sites-available/site2.loc <<EOF
server {
    # слушать порт 80
    listen 80;
    # директория сайта
    root /var/www/site2.loc;
    # индексные файлы
    index index.php index.html;
    # домен сайта
    server_name site2.loc www.site2.loc;

    location / {
        try_files \$uri \$uri/ =404;
    }

    # PHP скрипты передаются на выполнение FastCGI серверу
    location ~ \.php$ {
        include snippets/fastcgi-php.conf;
        # With php-fpm (or other unix sockets):
        fastcgi_pass unix:/var/run/php/php7.2-fpm.sock;
    }
}
EOF

ln -s /etc/nginx/sites-available/site1.loc /etc/nginx/sites-enabled/
ln -s /etc/nginx/sites-available/site2.loc /etc/nginx/sites-enabled/

echo '' >> '/etc/hosts'
echo '127.0.0.1   site1.loc www.site1.loc' >> '/etc/hosts'
echo '127.0.0.1   site2.loc www.site2.loc' >> '/etc/hosts'

systemctl reload nginx