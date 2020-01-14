## shadowsocks & GoQuiet

> showdowsocks 使用 [GoQuiet](https://github.com/cbeuw/GoQuiet) 做混淆 docker 配置

### build

```
docker build -t ss -f Dockerfile .
```

### start

```
docker run -d -e ss_pwd='123456' --name ss --network host --restart unless-stopped ss
```
