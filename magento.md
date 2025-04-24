#1. install
1. git clone file
2. exec script: bin/magento setup:install --base-url=https://jms.magento.com --db-host=127.0.0.1 --db-name=magento --db-user=magento --db-password=Magento123456. \
--admin-firstname=admin \
--admin-lastname=admin \
--admin-email=admin@admin.com \
--admin-user=admin \
--admin-password=admin123456 \
--language=en_US \
--currency=USD \
--timezone=America/Chicago \
--use-rewrites=1 \
--search-engine=elasticsearch7 \
--elasticsearch-host=127.0.0.1 \
--elasticsearch-port=9200 \
--elasticsearch-index-prefix=magento \
--elasticsearch-timeout=15
3. set web root to ./setup/ for web page install
4. set web root to ./pub
5. chmod folder 
6. change version1656622318 static folder or 
  php ./bin/magento config:set dev/static/sign 0 
  php ./bin/magento setup:static-content:deploy -f en_US
  php ./bin/magento config:clean
  php ./bin/magento config:flush
7. 处理登录提示：two-auth
  php ./bin/magento maintenance:disable
  php ./bin/magento module:disable Magento_AdminAdobeImsTwoFactorAuth Magento_TwoFactorAuth


#2. backend uri: /admin_z4ni5c


#3 install (windows)
	d:\web-server\php-8.2\php.exe ./bin/magento setup:install --base-url=https://lo.magento.com --db-host=127.0.0.1 --db-name=magento2 --db-user=root --db-password=root --admin-firstname=admin --admin-lastname=admin --admin-email=admin@123.com --admin-user=admin --admin-password=admin123456 --language=en_US --timezone=America/Chicago --use-rewrites=1 --search-engine=elasticsearch7 --elasticsearch-host=127.0.0.1 --elasticsearch-port=9200 --elasticsearch-index-prefix=magento2 --elasticsearch-timeout=15 --elasticsearch-username=elastic --elasticsearch-password=EqHbE*naiXPoKvmoC*Ut

	如果报： Unable to apply data patch Magento\Theme\Setup\Patch\Data\RegisterThemes for module Magento_Theme. Original excepti
  on message: Wrong file
   	处理: vendor\magento\framework\Image\Adapter\Gd2.php 改为：
   	private function validateURLScheme(string $filename) : bool
  {
      $allowed_schemes = ['ftp', 'ftps', 'http', 'https'];
      $url = parse_url($filename);
      if ($url && isset($url['scheme']) && !in_array($url['scheme'], $allowed_schemes) && !file_exists($filename)) {
          return false;
      }

      return true;
  }

  
