# Akvorado (8vCPU and 8G)
> https://demo.akvorado.net/docs/intro#quick-start

## Install Docker

[Docker.md](../Docker/Docker.md)

## Install Akvorado
>https://demo.akvorado.net/docs/intro#quick-start

```bash
cd /opt
mkdir akvorado
cd akvorado
curl -sL https://github.com/akvorado/akvorado/releases/latest/download/docker-compose-quickstart.tar.gz | tar zxvf -
docker compose up
```
> Server example:
> http://10.10.13.73:8081/

## Config Akvorado

### Edit akvorado.yaml

[akvorado-yaml.md](akvorado-yaml.md)

### Edit inlet.yaml

[inlet-yaml.md](inlet-yaml.md)

### Edit outlet.yaml

[outlet-yaml.md](outlet-yaml.md)

### Edit console.yaml

[console-yaml.md](console-yaml.md)

## Trouble install:

## Problem 1 (Traefik) (Akvorado 2.0.2)
> After "docker compose up" in log:
```bash
traefik-1 | 2025-11-14T09:04:26Z ERR Failed to retrieve information of the docker client and server host error="Error response from daemon: client version 1.24 is too old. Minimum supported API version is 1.44, please upgrade your client to a newer version" providerName=docker 
traefik-1 | 2025-11-14T09:04:26Z ERR Provider error, retrying in 4.344988543s error="Error response from daemon: client ver
```

> Resolve:
> Replace in versions.yml Traefik image version
```bash
nano /opt/akvorado/docker/versions.yml
```
Old:
```bash
  traefik:
    image: traefik:v3.5 # v\d+\.\d+
```
New
```bash
  traefik:
    image: traefik:v3.6 # v\d+\.\d+
```

# Upgrade

> https://demo.akvorado.net/docs/install#upgrade

>When using docker compose, 
> use the following commands to get an updated docker-compose.yml file and update your installation.
```html
cd /opt/akvorado
curl -sL https://github.com/akvorado/akvorado/releases/latest/download/docker-compose-upgrade.tar.gz | tar zxvf -
docker compose pull
docker compose stop akvorado-orchestrator
docker compose up -d
```

# Troubleshooting

```bash
docker system df


cd /opt/akvorado/
docker compose ps --format "table {{.Service}}\t{{.Status}}"


curl -s http://127.0.0.1:8080/api/v0/inlet/metrics
```
if d0 != 0 > kafka→queue-size increase,increase workders
```bash
[root@akvorado akvorado]# ss -lunepm
State              Recv-Q             Send-Q                           Local Address:Port                           Peer Address:Port             Process                                                                                                                                                                                                                                       
UNCONN             0                  0                                    127.0.0.1:323                                 0.0.0.0:*                 users:(("chronyd",pid=796,fd=5))              ino:20907 sk:1 cgroup:/system.slice/chronyd.service <->
         skmem:(r0,rb212992,t0,tb212992,f0,w0,o0,bl0,d0)                                                                                      
UNCONN             0                  0                                        [::1]:323                                    [::]:*                 users:(("chronyd",pid=796,fd=6))              ino:20908 sk:2 cgroup:/system.slice/chronyd.service v6only:1 <->
         skmem:(r0,rb212992,t0,tb212992,f0,w0,o0,bl0,d0)  
```