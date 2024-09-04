**First add user radius and +attribute juniper local name (example name: remote).  
Tho steeps adding user remote in Juniper**

```html
system {
    ntp {
        server *.*.*.*;
    }
    radius-server {
        *.*.*.* {
            secret "***"; 
            source-address *.*.*.*;
        }
    }
}
snmp {
community *** {
    authorization read-only;
    clients {
        *.*.*.*/*;
    }
}

```

```html
set system ntp server *.*.*.*
set system radius-server *.*.*.* secret "***"
set system radius-server *.*.*.* source-address *.*.*.*
set snmp community *** authorization read-only
set snmp community *** clients *.*.*.*/*
```