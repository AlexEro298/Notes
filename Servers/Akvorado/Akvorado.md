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

> nano /opt/akvorado/config/akvorado.yaml (producer ---> zstd)
```bash
kafka:
  topic: flows
  brokers:
    - kafka:9092
  topic-configuration:
    num-partitions: 8
    replication-factor: 1
    config-entries:
      # The retention policy in Kafka is mainly here to keep a buffer
      # for ClickHouse.
      segment.bytes: 1073741824
      retention.ms: 86400000 # 1 day
      cleanup.policy: delete
      compression.type: producer -> zstd
```

### Edit inlet.yaml

> nano /opt/akvorado/config/inlet.yaml 
```bash
workers: 4 -> 8
receive-buffer: 212992 -> 10485760
```

### Edit outlet.yaml

```html
---
metadata:
  providers:
    - type: snmp
      credentials:
        ::/0:
          communities: <community>
routing:
  provider:
    type: bmp
    # Before increasing this value, look for it in the troubleshooting section
    # of the documentation.
    receive-buffer: 10485760
core:
  exporter-classifiers:
    # This is an example. This should be customized depending on how
    # your exporters are named.
    - ClassifySiteRegex(Exporter.Name, "^([^-]+)-", "$1")
    - ClassifyRegion("europe")
    - ClassifyTenant("<name_tenant>")
    - ClassifyRole("edge")
  interface-classifiers:
    # This is an example. This must be customized depending on the
    # descriptions of your interfaces. In the following, we assume
    # external interfaces are named "Transit: Cogent" Or "IX:
    # FranceIX".
    - |
      ClassifyConnectivityRegex(Interface.Description, "^(?i).*?(downlink|peer|uplink):? ", "$1") &&
      ClassifyProviderRegex(Interface.Description, "([^\\s(]+)\\s*\\(", "$1") &&
      ClassifyExternal()
    - ClassifyConnectivityRegex(Interface.Description, "^<name_internal>$", "internal") &&
      ClassifyInternal()
    - ClassifyInternal()
```

### Edit console.yaml
```bash
---
http:
  cache:
    type: redis
    server: redis:6379
database:
  saved-filters:
    # These are prepopulated filters you can select in a drop-down
    # menu. Users can add more filters interactively.
    - description: "From Google"
      content: >-
        SrcAS = AS15169
```

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