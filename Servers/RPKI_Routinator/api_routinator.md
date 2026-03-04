
# Api
> curl http://127.0.0.1:8323/json

## Filter AS
> curl http://127.0.0.1:8323/json?select-asn=12389

## Filter Prefixes
> curl http://127.0.0.1:8323/json?select-prefix=82.221.32.0/20

If Use "More specifics"
> curl http://127.0.0.1:8323/json?select-prefix=82.221.32.0/20&include=more-specifics