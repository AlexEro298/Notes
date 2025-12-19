# OpenSpeedTest

## Install Docker

[Docker.md](../Docker/Docker.md)

## Install OpenSpeedTest

```html
cd /opt/
mkdir -p openspeedtest
cd openspeedtest/
nano docker-compose.yml
```
```html
services:
  openspeedtest:
    image: openspeedtest/latest
    container_name: openspeedtest
    restart: unless-stopped
    ports:
      - "3000:3000"
      - "3001:3001"
    healthcheck:
      test: ["CMD", "wget", "--no-verbose", "--tries=1", "--spider", "http://localhost:3000"]
      interval: 30s
      timeout: 10s
      retries: 3
      start_period: 10s
    environment:
      ENABLE_LETSENCRYPT: "True"
      DOMAIN_NAME: "domain.name.example"
      USER_EMAIL: "admin@example.com"
```

```html
docker compose up
docker compose up -d
docker compose down
docker compose ps
```

```html
http://10.10.13.82?Run
```

## Edit Index.html

```html
mkdir -p /opt/openspeedtest/custom-site
cd /opt/openspeedtest/custom-site
docker cp openspeedtest:/usr/share/nginx/html/. /opt/openspeedtest/custom-site/
chown -R 101:101 /opt/openspeedtest/custom-site/.well-known/
chmod -R 777 /opt/openspeedtest/custom-site/.well-known/
```
> add docker-compose.yml lines:
```html
    volumes:
      - ./html:/usr/share/nginx/html
    # Явно указываем пользователя nginx (UID 101)
    user: "101:101"
```

## Features

1. Stress Test. (Continuous Speed Test)

To enable the stress test. Pass `Stress` or `S` keyword as a URL parameter.

````
http://10.10.13.82?Stress=Low
````

After the `STRESS` or `S` keyword, you can specify the number of seconds you need to run the StressTest in seconds, or preset values such as `Low`, `Medium`, `High`, `VeryHigh`, `Extreme`, `Day`, and `Year`. Will run a speed test for `300`,`600`,`900`,`1800`,`3600`,`86400`,`31557600` seconds, respectively. Also, you can feed the first letter of each parameter and its values.

````
http://10.10.13.82?S=L
````

`S=L` is the same as passing `Stress=low`

Or you can specify the number of seconds eg:`5000` directly without any preset keywords.

````
http://10.10.13.82?Stress=5000
````

2. Run a speed test automatically

Run a speed test automatically on page load.

````
http://10.10.13.82?Run
````

Run a speed test automatically after a few seconds.

````
http://10.10.13.82?Run=10 or http://10.10.13.82?R=10
````

You can pass multiple keywords, and it's not `Case-Sensitive`.

````
http://10.10.13.82?Run&Stress=300 OR http://10.10.13.82?R&S=300
````

This will start a speed test immediately and run for `300 seconds` in each direction. That is 300 seconds for download and `300 seconds` for upload.

3. Save results to a Database

Edit `Index.html`

````
var saveData = true;

var saveDataURL = "//yourDatabase.Server.com:4500/save?data=";
````

4. Add multiple servers. The app will choose one with the least latency automatically.

Edit `Index.html`

````
var openSpeedTestServerList = [

{"ServerName":"Home-Earth", "Download":"/downloading", "Upload":"/upload", "ServerIcon":"DefaultIcon"},

{"ServerName":"Home-Mars", "Download":"/downloading", "Upload":"/upload", "ServerIcon":"DefaultIcon"},

{"ServerName":"Home-Moon", "Download":"/downloading", "Upload":"/upload", "ServerIcon":"DefaultIcon"}

];
````

5. Disable or change Overhead Compensation factor.

````
http://10.10.13.82?clean
````

Overhead Compensation factor, This is browser based test, Many Unknowns. Currently 4%. That is within the margin of error.

You can pass `Clean` or `C` as a URL Parameter and reset Overhead Compensation factor to Zero or set any value between 0 and 4. 1 = 1% to 4 = 4%.

`Clean` will not accept values above 4, so Compensation is limited to maximum 4%.

6. Change the default limit of 6 parallel HTTP connections to the Server.

````
http://10.10.13.82?XHR=3 OR http://10.10.13.82?X=3
````

Allow the user to Change the default limit of 6 parallel HTTP connections to the Server. `XHR` will Accept values above 1 and max 32

pass `XHR` or `X` as a URL Parameter.

7. Select a different server to run a speed test.

````
http://10.10.13.82?Host=http://192.168.55.1:90 OR http://10.10.13.82?h=http://192.168.55.1:90
````

Pass `Host` or `H` as a URL Parameter.

`HOST` will Accept only valid HTTP URLs like `http://192.168.1.10:3000` or `https://yourHost.com`.

8. Select and run one test at a time, `DOWNLOAD`, `UPLOAD`, or `PING`.

````
http://10.10.13.82?Test=Upload OR http://10.10.13.82?T=U
````

`TEST` Allow the user to select and run one test at a time, Download, Upload, or Ping.

Pass `Test` or `T` as a URL Parameter.

9. Set a PingTimeout dynamically by passing `Out` or `O` as a URL Parameter

````
http://10.10.13.82?Out=7000 OR http://10.10.13.82?O=7000
````

If Server not responded within 5 Seconds for any requests we send ('pingSamples' times)

We will show `Network Error`, You can change the limit here.

In milliseconds, if you need to set `6 seconds`. Change the value to `6000`.

  

10. Set the Number of ping samples by adding `Ping` or `P` as a URL Parameter

````
http://10.10.13.82?Ping=500 OR http://10.10.13.82?P=500
````

More samples = more accurate representation. `Ping = 500` will send `501` requests to server to find the accurate ping value.
Take a look at index.html, you can set a custom ping sample size, threads, upload data size etc.
