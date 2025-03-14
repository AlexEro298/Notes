# Config Juniper:
## Netflow 9 example:
```html
set groups sampling interfaces <*> unit <*> family inet sampling input
set groups sampling interfaces <*> unit <*> family inet6 sampling input

set services flow-monitoring version9 template ipv4 flow-active-timeout 10
set services flow-monitoring version9 template ipv4 flow-inactive-timeout 10
set services flow-monitoring version9 template ipv4 template-refresh-rate packets 30
set services flow-monitoring version9 template ipv4 template-refresh-rate seconds 30
set services flow-monitoring version9 template ipv4 option-refresh-rate packets 30
set services flow-monitoring version9 template ipv4 option-refresh-rate seconds 30
set services flow-monitoring version9 template ipv4 ipv4-template
set services flow-monitoring version9 template ipv6 flow-active-timeout 10
set services flow-monitoring version9 template ipv6 flow-inactive-timeout 10
set services flow-monitoring version9 template ipv6 template-refresh-rate packets 30
set services flow-monitoring version9 template ipv6 template-refresh-rate seconds 30
set services flow-monitoring version9 template ipv6 option-refresh-rate packets 30
set services flow-monitoring version9 template ipv6 option-refresh-rate seconds 30
set services flow-monitoring version9 template ipv6 ipv6-template

set chassis fpc 0 sampling-instance <sample_instance_name>
set chassis fpc 0 inline-services flex-flow-sizing

set forwarding-options sampling instance <sample_instance_name> apply-flags omit
set forwarding-options sampling instance <sample_instance_name> input rate 1024
set forwarding-options sampling instance <sample_instance_name> input max-packets-per-second 65535
set forwarding-options sampling instance <sample_instance_name> family inet output flow-server <ip_address_flow_server> port <port_server>
set forwarding-options sampling instance <sample_instance_name> family inet output flow-server <ip_address_flow_server> autonomous-system-type origin
set forwarding-options sampling instance <sample_instance_name> family inet output flow-server <ip_address_flow_server> source-address <ip_address_lo0.0>
set forwarding-options sampling instance <sample_instance_name> family inet output flow-server <ip_address_flow_server> version9 template ipv4
set forwarding-options sampling instance <sample_instance_name> family inet output inline-jflow source-address <ip_address_lo0.0>
set forwarding-options sampling instance <sample_instance_name> family inet6 output flow-server <ip_address_flow_server> port <port_server>
set forwarding-options sampling instance <sample_instance_name> family inet6 output flow-server <ip_address_flow_server> autonomous-system-type origin
set forwarding-options sampling instance <sample_instance_name> family inet6 output flow-server <ip_address_flow_server> source-address <ip_address_lo0.0>
set forwarding-options sampling instance <sample_instance_name> family inet6 output flow-server <ip_address_flow_server> version9 template ipv6
set forwarding-options sampling instance <sample_instance_name> family inet6 output inline-jflow source-address <ip_address_lo0.0>
```
## IPFIX example:
```html
chassis {
    fpc 0 {
        sampling-instance <sample_instance_name>;
        inline-services {
            flow-table-size {
                ipv4-flow-table-size 10;
                ipv6-flow-table-size 5;
            }
        }

    }
}
services {
    flow-monitoring {
        version-ipfix {
            template v4 {
                ipv4-template;
            }
            template v6 {
                ipv6-template;
            }
        }
    }
}
forwarding-options {
    sampling {
        sample-once;
        instance {
            <sample_instance_name> {
                input {
                    rate 100;
                }
                family inet {
                    output {
                        flow-server <ip_address_flow_server> {
                            port <port_server>;
                            version-ipfix {
                                template {
                                    v4;
                                }
                            }
                        }
                        inline-jflow {
                            source-address <ip_address_lo0.0>;
                        }
                    }
                }
                family inet6 {
                    output {
                        flow-server <ip_address_flow_server> {
                            port <port_server>;
                            version-ipfix {
                                template {
                                    v6;
                                }
                            }
                        }
                        inline-jflow {
                            source-address <ip_address_lo0.0>;
                        }
                    }
                }
            }
        }
    }
}
```
# Troubleshooting
* flow export statistics:\
   `show services accounting flow inline-jflow fpc-slot 0`
* flow export status:\
  `show services accounting status inline-jflow fpc-slot 0`
* flow export errors:\
  `show services accounting errors inline-jflow fpc-slot 0`
* clear flow state:\
  `clear services accounting flow inline-jflow fpc-slot 0`
* show routing engine CPU, memory, and related state:\
  `show chassis routing-engine`
* show FPC CPu, memory, and related state:\
  `show chassis fpc`

See notes below for a deeper look at flow table sizing information and FPC detail.