1. cli解决墙内firewall问题（原因： node fetch不走全局代理）： @shopify/cli下 全局安装 https-proxy-agent ，修改C:\Users\esr-administrator\AppData\Roaming\nvm\v20.9.0\node_modules\@shopify\cli\dist\chunk-xxx.js中 或者是在：
  (1) E:\www\node-dev\p-options\node_modules\@shopify\cli-kit\dist\public\node\http.js

  import { HttpsProxyAgent } from "https-proxy-agent";

	const proxy_url = "http://127.0.0.1:10809";
  const agent = new HttpsProxyAgent(proxy_url);
  return runWithTimer("cmd_all_timing_network_ms")(
    () => debugLogResponseInfo({ url: url2.toString(), request: fetch(url2, {...init, agent}) })
    // () => debugLogResponseInfo({ url: url2.toString(), request: fetch(url2, init) })
  );

  (2) 还有一处graphql-client代理：
  E:\www\node-dev\p-options\node_modules\@shopify\admin-api-client\dist\graphql-client\dist\graphql-client\http-fetch.js
  var { HttpsProxyAgent } = require("https-proxy-agent");

  const proxy_url = "http://127.0.0.1:10809";
  const agent = new HttpsProxyAgent(proxy_url);
  requestParams[1].agent = agent;
  response = await customFetchApi(...requestParams);

  (3) ruby代理：
  通过修改系统http_proxy https_proxy代理实现（否则需要修改ruby有关http.rb 中 connect函数 源代码？）

  (4) node_modules\@shopify\cli-kit\assets\cli-ruby\lib\shopify_cli\theme\extension\ui\host_theme_raw_progress_bar.rb
  git也要代理
  git config --global http.proxy http://127.0.0.1:10809
  git config --global https.proxy http://127.0.0.1:10809

 2. cli解决墙内firewall问题(ruby): 
 	设置系统终端代理或者全局代理（需要终端走代理）

 3. 自定义数据可以存到metafields 和 metaobject中，这样可以做到服务器端渲染

 4. php-example 解决 本地ssl验证
  E:\www\node-dev\page-builder\web\vendor\shopify\shopify-api\src\Clients\HttpClientFactory.php
  return new Client(['verify' => false, 'proxy' => 'http://127.0.0.1:10809']);

2. 发布remix app
  init:
  修改.env 需要 SHOPIFY_APP_URL / SHOPIFY_API_KEY / SHOPIFY_API_SECRET
  npm install
  npm run setup (database migrate)
  npm run build:prod

  run:
  pm2 satrt npm --name checkout-app -- run start

  stop:
  pm2 stop checkout-app

3. 发布extension
  shopify app deploy (需本地浏览器登录)

  不用浏览器登录方式（SSH)
  export SHOPIFY_CLI_PARTNERS_TOKEN=atkn_83740e0f4c8xxxxx  (partner平台获取)
  shopify app deploy --force 
  deploy.sh 内容如下：可实现不同环境部署
    #!/bin/bash
    ENV=$1
    if [ -z "$ENV" ]; then
        echo "Usage: ./deploy.sh [dev|test|prod]"
        exit 1
    fi 
    cp "shopify.app.$ENV.toml" shopify.app.toml
    echo "Deploying to $ENV ..."
    shopify app deploy --force

4. 