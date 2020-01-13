FROM shadowsocks/shadowsocks-libev
USER root

ADD ./bin /usr/local/bin
ADD ./etc /usr/local/etc

ENTRYPOINT ["sh", "/usr/local/bin/entrypoint.sh"]
