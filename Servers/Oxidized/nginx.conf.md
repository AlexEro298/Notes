```html
# For more information on configuration, see:
#   * Official English Documentation: http://nginx.org/en/docs/
#   * Official Russian Documentation: http://nginx.org/ru/docs/

user nginx;
worker_processes auto;
error_log /var/log/nginx/error.log;
pid /run/nginx.pid;

# Load dynamic modules. See /usr/share/doc/nginx/README.dynamic.
include /usr/share/nginx/modules/*.conf;

events {
    worker_connections 1024;
}

http {
    log_format  main  '$remote_addr - $remote_user [$time_local] "$request" '
                      '$status $body_bytes_sent "$http_referer" '
                      '"$http_user_agent" "$http_x_forwarded_for"';

    access_log  /var/log/nginx/access.log  main;

    sendfile            on;
    tcp_nopush          on;
    tcp_nodelay         on;
    keepalive_timeout   65;
    types_hash_max_size 4096;

    include             /etc/nginx/mime.types;
    default_type        application/octet-stream;

    # Load modular configuration files from the /etc/nginx/conf.d directory.
    # See http://nginx.org/en/docs/ngx_core_module.html#include
    # for more information.
    include /etc/nginx/conf.d/*.conf;

#    server {
#        listen       80;
#        listen       [::]:80;
#        server_name  _;
#        root         /usr/share/nginx/html;

        # Load configuration files for the default server block.
#        include /etc/nginx/default.d/*.conf;

#        error_page 404 /404.html;
#        location = /404.html {
#        }

#        error_page 500 502 503 504 /50x.html;
#        location = /50x.html {
#        }
      server {
          listen          80 default;
          listen          [::]:80 default;
          server_name     _;
          root            /usr/share/nginx/html;

#          ssl_certificate     /etc/nginx/ssl/server.cert;
#          ssl_certificate_key /etc/nginx/ssl/server.key;
#          ssl_protocols       TLSv1 TLSv1.1 TLSv1.2;
#          ssl_ciphers         HIGH:!aNULL:!MD5;

          access_log /var/log/nginx/oxidized_access.log;
          error_log /var/log/nginx/oxidized_error.log;

          auth_basic      "Restricted Access";
          auth_basic_user_file    /etc/nginx/.oxidized_users;

          include /etc/nginx/default.d/*.conf;

          location / {
                  proxy_pass http://127.0.0.1:8888/;
          }
    }

# Settings for a TLS enabled server.
#
#    server {
#        listen       443 ssl http2;
#        listen       [::]:443 ssl http2;
#        server_name  _;
#        root         /usr/share/nginx/html;
#
#        ssl_certificate "/etc/pki/nginx/server.crt";
#        ssl_certificate_key "/etc/pki/nginx/private/server.key";
#        ssl_session_cache shared:SSL:1m;
#        ssl_session_timeout  10m;
#        ssl_ciphers PROFILE=SYSTEM;
#        ssl_prefer_server_ciphers on;
#
#        # Load configuration files for the default server block.
#        include /etc/nginx/default.d/*.conf;
#
#        error_page 404 /404.html;
#            location = /40x.html {
#        }
#
#        error_page 500 502 503 504 /50x.html;
#            location = /50x.html {
#        }
#    }

}
```
# Troubleshooting:
```html
nginx -t
```