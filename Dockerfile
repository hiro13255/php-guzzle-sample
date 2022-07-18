FROM php:7.4-alpine3.12

ENV USER=user
ENV UID=12345
ENV GID=23456

RUN apk add --update --no-cache \
      chromium \
      chromium-chromedriver \
      udev \
      zlib-dev \
    && rm -rf /var/cache/apk/*

RUN mkdir /temp

ADD https://noto-website.storage.googleapis.com/pkgs/NotoSansCJKjp-hinted.zip /temp

WORKDIR /temp
RUN unzip NotoSansCJKjp-hinted.zip && \
    mkdir -p /usr/share/fonts/temp && \
    cp *.otf /usr/share/fonts/temp && \
    chmod 644 -R /usr/share/fonts/temp/ && \
    fc-cache -fv

WORKDIR /
RUN rm -rf /temp

ENTRYPOINT tail -f /dev/null

RUN addgroup --gid "$GID" "$USER" \
    && adduser \
    --disabled-password \
    --gecos "" \
    --home "/home/user" \
    --ingroup "$USER" \
    --no-create-home \
    --uid "$UID" \
    "$USER"
RUN mkdir /home/user && chown -R user.user /home/user
USER user
WORKDIR /home/user

RUN curl -s https://getcomposer.org/installer | php && alias composer='php ./composer.phar'
RUN php composer.phar require guzzlehttp/guzzle symfony/dom-crawler symfony/css-selector chrome-php/chrome:0.8.1

COPY dynamicSiteSample.php /home/user

CMD ['php', '-S', '0.0.0.0:3000']
