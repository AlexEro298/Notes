# inlet.yaml

> nano /opt/akvorado/config/inlet.yaml 

```bash
workers: 4 -> 8
receive-buffer: 212992 -> 10485760
```

```html
---
flow:
  inputs:
    # NetFlow port
    - type: udp
      decoder: netflow
      listen: :2055
      workers: 8
      # Before increasing this value, look for it in the troubleshooting section
      # of the documentation.
      receive-buffer: 10485760
    # IPFIX port
    - type: udp
      decoder: netflow
      listen: :4739
      workers: 8
      receive-buffer: 10485760
    # sFlow port
    - type: udp
      decoder: sflow
      listen: :6343
      workers: 8
      receive-buffer: 10485760
```