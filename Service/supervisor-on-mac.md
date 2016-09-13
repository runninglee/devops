### Install

```
brew update

brew install supervisor

```

### Configure

```

sudo supervisord -c /etc/supervisord.conf

sudo supervisorctl -c /etc/supervisord.conf

```

### Control

```

sudo brew services {start | stop | restart} supervisord


```

### Update Configure

```
sudo brew services stop supervisord

supervisord> stop all

```


### Make it work

```
sudo brew services start supervisord

sudo supervisorctl

supervisord>start (your queue worker)

```

### Help Command

```
supervisord> help

```

**Commands List**

`add` `exit` `open` `reload` `restart`  `start` `tail` `avail`

`version` `update` `reread` `clear` `status` `mailtail` `stop`

and so on ...
