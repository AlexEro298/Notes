# console.yaml

> nano /opt/akvorado/config/console.yaml 

```html
---
http:
  cache:
    type: redis
    server: redis:6379
database:
  saved-filters:
    # These are prepopulated filters you can select in a drop-down
    # menu. Users can add more filters interactively.
    - description: "From Google (AS15169)"
      content: >-
        InIfBoundary = external  AND SrcAS = AS15169
    - description: "Uplink and Peer to Uplink and Peer"
      content: >-
        InIfBoundary = external AND (InIfConnectivity = "uplink" OR InIfConnectivity= "peer") AND  (OutIfConnectivity = "uplink" OR OutIfConnectivity = "peer")
    - description: "From  Rostelecom (AS12389)"
      content: >-
        InIfBoundary = external  AND SrcAS = AS12389
    - description: "From Russian Company (AS15493)"
      content: >-
        InIfBoundary = external  AND SrcAS = AS15493
    - description: "From TransTeleCom (AS20485)"
      content: >-
        InIfBoundary = external  AND SrcAS = AS20485
    - description: "From Fiord (AS28917)"
      content: >-
        InIfBoundary = external  AND SrcAS = AS28917
    - description: "From Motiv (AS31499)"
      content: >-
        InIfBoundary = external  AND SrcAS = AS31499
    - description: "From Global-IX (AS31500)"
      content: >-
        InIfBoundary = external  AND SrcAS = AS31500
```