#1. v2ray + tls + ws + cdn
	1. nginx config

	server {
	    listen 80;
	    server_name xxxxx;  # 改成你的域名
	    rewrite ^(.*) https://$server_name$1 permanent;
	}

	server {
	    listen       443 ssl http2;
	    server_name xxxxx;
	    charset utf-8;

	    # ssl配置
	    ssl_protocols TLSv1.2 TLSv1.3; # tls 1.3要求nginx 1.13.0及以上版本
	    ssl_ciphers ECDHE-ECDSA-AES128-GCM-SHA256:ECDHE-RSA-AES128-GCM-SHA256:ECDHE-ECDSA-AES256-GCM-SHA384:ECDHE-RSA-AES256-GCM-SHA384:ECDHE-ECDSA-CHACHA20-POLY1305:ECDHE-RSA-CHACHA20-POLY1305:DHE-RSA-AES128-GCM-SHA256:DHE-RSA-AES256-GCM-SHA384;
	    ssl_prefer_server_ciphers off;
	    ssl_session_cache shared:SSL:10m;
	    ssl_session_timeout 1d;
	    ssl_session_tickets off;
	    ssl_certificate xxxxx; # 改成你的证书地址
	    ssl_certificate_key xxxx; # 改成证书密钥文件地址

	    access_log  /var/log/nginx/xxxx.access.log;
	    error_log /var/log/nginx/xxx.error.log;

	    root /usr/share/nginx/html;
	    location / {
	        index  index.html;
	    }
	}


	2. install v2ray exec script:
		bash <(curl -L https://raw.githubusercontent.com/v2fly/fhs-install-v2ray/master/install-release.sh)

	3. config the v2ray
		vi /usr/local/etc/v2ray/config.json
		{
		  "inbounds": [{
		    "port": 监听端口,
		    "protocol": "vmess",
		    "settings": {
		      "clients": [
		        {
		          "id": "用户id，生成方法见下面说明" 
		        }
		      ]
		    }
		  }],
		  "outbounds": [{
		    "protocol": "freedom",
		    "settings": {}
		  }]
		}

	4. exec /usr/local/bin/v2ctl uuid get client id

	5. config nginx proxy

	location /awesomepath { # 与 V2Ray 配置中的 path 保持一致
	      proxy_redirect off;
	      proxy_pass http://127.0.0.1:12345; # 假设v2ray的监听地址是12345
	      proxy_http_version 1.1;
	      proxy_set_header Upgrade $http_upgrade;
	      proxy_set_header Connection "upgrade";
	      proxy_set_header Host $host;
	      proxy_set_header X-Real-IP $remote_addr;
	      proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
	}

	6. v2ray config.json inbounds add 
	"streamSettings": {     # 载体配置段，设置为websocket
        "network": "ws",
        "wsSettings": {
          "path": "/awesomepath"  # 与nginx中的路径保持一致
        }
      },
    "listen": "127.0.0.1" # 出于安全考虑，建议只接受本地链接


    7. full conifg.json
    {
	  "log": {
	    "loglevel": "warning",
	    "access": "/var/log/v2ray/access.log",
	    "error": "/var/log/v2ray/error.log"
	   },
	  "inbounds": [{
	    "port": 12345,
	    "protocol": "vmess",
	    "settings": {
	      "clients": [
	        {
	          "id": "xxxxx", # 可以使用/usr/bin/v2ray/v2ctl uuid生成
	          "level": 1,
	          "alterId": 0
	        }
	      ]
	    },
	    "streamSettings": {     # 载体配置段，设置为websocket
	        "network": "ws",
	        "wsSettings": {
	          "path": "/awesomepath"  # 与nginx中的路径保持一致
	        }
	      },
	    "listen": "127.0.0.1" # 出于安全考虑，建议只接受本地链接
	  }],
	  "outbounds": [{
	    "protocol": "freedom",
	    "settings": {}
	  },{
	    "protocol": "blackhole",
	    "settings": {},
	    "tag": "blocked"
	  }],
	  "routing": {
	    "rules": [
	      {
	        "type": "field",
	        "ip": ["geoip:private"],
	        "outboundTag": "blocked"
	      }
	    ]
	  }
	}






