# Shaping firewall
```html
set firewall policer shaping-10g apply-flags omit
set firewall policer shaping-10g if-exceeding bandwidth-limit 10g
set firewall policer shaping-10g if-exceeding burst-size-limit 1250000000
set firewall policer shaping-10g then discard
set firewall policer shaping-1g apply-flags omit
set firewall policer shaping-1g if-exceeding bandwidth-limit 1g
set firewall policer shaping-1g if-exceeding burst-size-limit 125m
set firewall policer shaping-1g then discard
set firewall policer shaping-20g apply-flags omit
set firewall policer shaping-20g if-exceeding bandwidth-limit 20g
set firewall policer shaping-20g if-exceeding burst-size-limit 2500000000
set firewall policer shaping-20g then discard
set firewall policer shaping-2g apply-flags omit
set firewall policer shaping-2g if-exceeding bandwidth-limit 2g
set firewall policer shaping-2g if-exceeding burst-size-limit 250m
set firewall policer shaping-2g then discard
set firewall policer shaping-30g apply-flags omit
set firewall policer shaping-30g if-exceeding bandwidth-limit 30g
set firewall policer shaping-30g if-exceeding burst-size-limit 3750000000
set firewall policer shaping-30g then discard
set firewall policer shaping-3g apply-flags omit
set firewall policer shaping-3g if-exceeding bandwidth-limit 3g
set firewall policer shaping-3g if-exceeding burst-size-limit 375m
set firewall policer shaping-3g then discard
set firewall policer shaping-40g apply-flags omit
set firewall policer shaping-40g if-exceeding bandwidth-limit 40g
set firewall policer shaping-40g if-exceeding burst-size-limit 5g
set firewall policer shaping-40g then discard
set firewall policer shaping-4g apply-flags omit
set firewall policer shaping-4g if-exceeding bandwidth-limit 4g
set firewall policer shaping-4g if-exceeding burst-size-limit 500m
set firewall policer shaping-4g then discard
set firewall policer shaping-5g apply-flags omit
set firewall policer shaping-5g if-exceeding bandwidth-limit 5g
set firewall policer shaping-5g if-exceeding burst-size-limit 625m
set firewall policer shaping-5g then discard
```
## Family ccc
```html
set firewall family ccc filter shaper_ccc_10g apply-flags omit
set firewall family ccc filter shaper_ccc_10g term shaping then policer shaping-10g
set firewall family ccc filter shaper_ccc_10g term shaping then accept
set firewall family ccc filter shaper_ccc_1g apply-flags omit
set firewall family ccc filter shaper_ccc_1g term shaping then policer shaping-1g
set firewall family ccc filter shaper_ccc_1g term shaping then accept
set firewall family ccc filter shaper_ccc_20g apply-flags omit
set firewall family ccc filter shaper_ccc_20g term shaping then policer shaping-20g
set firewall family ccc filter shaper_ccc_20g term shaping then accept
set firewall family ccc filter shaper_ccc_2g apply-flags omit
set firewall family ccc filter shaper_ccc_2g term shaping then policer shaping-2g
set firewall family ccc filter shaper_ccc_2g term shaping then accept
set firewall family ccc filter shaper_ccc_30g apply-flags omit
set firewall family ccc filter shaper_ccc_30g term shaping then policer shaping-30g
set firewall family ccc filter shaper_ccc_30g term shaping then accept
set firewall family ccc filter shaper_ccc_3g apply-flags omit
set firewall family ccc filter shaper_ccc_3g term shaping then policer shaping-3g
set firewall family ccc filter shaper_ccc_3g term shaping then accept
set firewall family ccc filter shaper_ccc_40g apply-flags omit
set firewall family ccc filter shaper_ccc_40g term shaping then policer shaping-40g
set firewall family ccc filter shaper_ccc_40g term shaping then accept
set firewall family ccc filter shaper_ccc_4g apply-flags omit
set firewall family ccc filter shaper_ccc_4g term shaping then policer shaping-4g
set firewall family ccc filter shaper_ccc_4g term shaping then accept
set firewall family ccc filter shaper_ccc_5g apply-flags omit
set firewall family ccc filter shaper_ccc_5g term shaping then policer shaping-5g
set firewall family ccc filter shaper_ccc_5g term shaping then accept
```
# Troubleshooting
```html
show firewall log
show firewall terse
show firewall filter <filter_name>
```