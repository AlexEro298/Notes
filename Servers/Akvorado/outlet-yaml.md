# outlet.yaml

> nano /opt/akvorado/config/outlet.yaml

```html
---
metadata:
  providers:
    - type: snmp
      credentials:
        ::/0:
          communities: <YOUR_COMMUNITY>
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
    - ClassifyTenant("<YOUR_COMPANY>")
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
    - ClassifyConnectivityRegex(Interface.Description, "^<LOCAL_IP_Transit_DESCR_INT>$", "internal") &&
      ClassifyInternal()
    - ClassifyInternal()
```