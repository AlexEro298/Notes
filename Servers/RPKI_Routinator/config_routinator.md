> nano /etc/routinator/routinator.conf

```html
repository-dir = "/var/lib/routinator/rpki-cache"
rtr-listen = ["127.0.0.1:3323"]
http-listen = ["127.0.0.1:8323"]
```

```html
repository-dir = "/var/lib/routinator/rpki-cache"
rtr-listen = ["0.0.0.0:3323"]
http-listen = ["0.0.0.0:8323"]
```

> https://github.com/NLnetLabs/routinator/blob/main/etc/routinator.conf.example