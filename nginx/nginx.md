#1. install
./configure --user=www --group=www --with-http_ssl_module --with-http_v2_module --with-http_stub_status_module --add-module=../ngx_cache_purge-2.3（可选，可手动清除fastcgi_cache)
    wget https://github.com/FRiCKLE/ngx_cache_purge/archive/refs/tags/2.3.tar.gz 下载后解压即可

#2. rewrite try_files
try_files $uri $uri/ /index.php?$args;

#3. ssl server conf
server {
        listen 80;
        server_name ming.wp.com;
        rewrite ^(.*)$ https://${server_name}$1 permanent;
}

server {
        listen      443 ssl;
        server_name ming.wp.com;
        root        /www/ming.wp.com;
        ssl_certificate /usr/local/nginx/ssl/ming.wp.com.crt;
        ssl_certificate_key /usr/local/nginx/ssl/ming.wp.com.key;

        location / {
            index   index.php index.html index.htm;
                try_files $uri $uri/ /index.php?$query_string;
        }

        location ~* \.php {
            include                 fastcgi_params;
            fastcgi_index           index.php;
            fastcgi_pass            127.0.0.1:9000;
            fastcgi_split_path_info ^(.+\.php)(.*)$;
            fastcgi_param           PATH_INFO       $fastcgi_path_info;
            fastcgi_param           SCRIPT_NAME     $fastcgi_script_name;
            fastcgi_param           SCRIPT_FILENAME $document_root$fastcgi_script_name;
        }
    }

<<<<<<< HEAD
#4. 过滤静态文件
if ( $request_filename !~* .*.(jpg|js|css|ttf|svg|woff2|woff|png|webp|gif)$ ) {
    rewrite ^(.*)$ /index.php?$query_string;
}

#5. 
=======
#4. proxy

    location / {
        proxy_pass http://127.0.0.1:8080/;
        proxy_set_header    Host               $host:$server_port;
        proxy_set_header    Remote_Addr        $remote_addr;
        proxy_set_header    X-Real-IP          $remote_addr;
        proxy_set_header    X-Forwarded-For    $proxy_add_x_forwarded_for;
        proxy_set_header    X-Forwarded-Proto  $scheme;
        proxy_set_header    X-Nginx-Proxy      true;
        
        # index页面设置
        index index;
    }

#5. 配置jpg png静态不走php (可用于wordpress)

    location / {
        try_files $uri $uri/ @rewriteapp;
        index   index.php index.html index.htm;
    }
    location @rewriteapp {
        if ( $request_filename !~* \.(jpg|png)$ ) {
            rewrite ^(.*)$ /index.php/$1 last;
        }
    }

#6. 
>>>>>>> 177bb55806653db0ffc80046498368b763989b50


#7. wp配置fastcgi_cache 
    http{
        fastcgi_cache_path /tmp/wpcache levels=1:2 keys_zone=wpcache:128m inactive=7d max_size=1G;
        fastcgi_temp_path /tmp/wpcache/temp;
        fastcgi_cache_key "$scheme$request_method$host$request_uri";
        fastcgi_cache_methods GET HEAD;
        fastcgi_ignore_headers Cache-Control Expires Set-Cookie;
        fastcgi_hide_header Pragma;


        server{
            set $skip_cache 0;
            #post 访问不缓存
            if ($request_method = POST) {
                set $skip_cache 1;
            }
            #动态查询不缓存
            if ($query_string != "") {
                set $skip_cache 1;
            }
            #后台等特定页面不缓存（其他需求请自行添加即可）
            if ($request_uri ~* "/wp-admin/|/xmlrpc.php|wp-.*.php|/feed/|index.php|sitemap(_index)?.xml") {
                set $skip_cache 1;
            }
            #对登录用户、评论过的用户不展示缓存(注释掉就不区分登陆与否都缓存)
            if ($http_cookie ~* "comment_author|wordpress_[a-f0-9]+|wp-postpass|wordpress_no_cache|wordpress_logged_in") {
               set $skip_cache 0;
            }

            location \.php{
                fastcgi_cache_bypass $skip_cache;
                fastcgi_no_cache $skip_cache;
                fastcgi_cache wpcache;
                add_header X-Cache "$upstream_cache_status From $host";
                fastcgi_cache_valid 200 301 302 304 1d;
            }

            #缓存清理配置（可选模块，请细看下文说明）
            location ~ /purge(/.*) {
                allow 127.0.0.1;
                allow "此处填写你服务器的真实外网 IP";
                deny all;
                fastcgi_cache_purge wpcache "$scheme$request_method$host$request_uri";
            }
        }
    }
    
