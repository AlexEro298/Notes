**request chassis routing-engine master switch - switch current master to other RE  
request routing-engine login other-routing-engine - login other RE  
request system software add \*\*\*.tgz re1 reboot - update re1**

```html
system {
    commit synchronize;
}
chassis {
    redundancy {
        routing-engine 0 master;
        routing-engine 1 backup;
        graceful-switchover;
    }
protocols{
    layer2-control {
        nonstop-bridging;
    }
}
```

```html
set system commit synchronize
set routing-options nonstop-routing
set chassis redundancy routing-engine 0 master
set chassis redundancy routing-engine 1 backup
set chassis redundancy graceful-switchover
```

**Troubleshooting**
```html
show chassis routing-engine
show database-replication summary
show version invoke-on other-routing-engine
show version invoke-on all-routing-engines 
show version invoke-on all-routing-engines | match "Hostname|boot"  

GRES:
request routing-engine login other-routing-engine
show system switchover
show task replication
```

Management for each RE
```html
set groups re0 system host-name MX480-TEST-RE0
set groups re0 interfaces fxp0 unit 0 description mgmt-re0
set groups re0 interfaces fxp0 unit 0 family inet address 10.0.0.255/22
set groups re1 system host-name MX480-TEST-RE1
set groups re1 interfaces fxp0 unit 0 description mgmt-re1
set groups re1 interfaces fxp0 unit 0 family inet address 10.0.0.232/22
set apply-groups re0
set apply-groups re1
```