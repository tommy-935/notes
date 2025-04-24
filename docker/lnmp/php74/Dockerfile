# 使用官方PHP 7.4 FPM镜像作为基础
FROM php:7.4-fpm

# 设置时区
# ENV TZ=Asia/Shanghai
# RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# 安装系统依赖
RUN apt-get update && apt-get install -y \
    git \
    curl \
    libpng-dev \
    libonig-dev \
    libxml2-dev \
    libzip-dev \
    libjpeg-dev \
    libfreetype6-dev \
    libssl-dev \
    libpq-dev \
    libcurl4-openssl-dev \
    libgmp-dev \
    libicu-dev \
    zip \
    unzip \
    && rm -rf /var/lib/apt/lists/*

# 安装PHP核心扩展
RUN docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install -j$(nproc) \
    gd \
    pdo_mysql \
    mysqli \
    mbstring \
    exif \
    pcntl \
    bcmath \
    zip \
    opcache \
    sockets \
    gmp \
    intl \
    curl

# 安装Swoole扩展（指定4.8.11稳定版）
RUN pecl install swoole-4.8.11 \
    && docker-php-ext-enable swoole

# 安装Redis扩展
RUN pecl install redis-5.3.7 \
    && docker-php-ext-enable redis

# 安装Composer
COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

# 调整PHP-FPM配置
RUN mkdir -p /var/log/php-fpm \
    && touch /var/log/php-fpm/error.log \
    && chown -R www-data:www-data /var/log/php-fpm

# 复制自定义php.ini
# COPY php.ini /usr/local/etc/php/conf.d/custom.ini

# Swoole专用配置
RUN echo "swoole.use_shortname = Off" >> /usr/local/etc/php/conf.d/docker-php-ext-swoole.ini

# 工作目录
WORKDIR /var/www/html

# 健康检查（同时检查FPM和Swoole）
HEALTHCHECK --interval=30s --timeout=3s \
    CMD php -r "if(!@fsockopen('localhost', 9001) && !@fsockopen('localhost', 9501)) { exit(1); }"

# 双模式启动：默认启动FPM，可通过环境变量切换为Swoole
CMD ["sh", "-c", "if [ \"$SWOOLE_ENABLE\" = \"1\" ]; then php /var/www/html/swoole-server.php; else php-fpm -F; fi"]