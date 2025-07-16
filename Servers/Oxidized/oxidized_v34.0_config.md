```html
---
username: username
password: password
model: junos
resolve_dns: true
interval: 43200
use_syslog: false
debug: false
run_once: false
threads: 30
use_max_threads: false
timeout: 200
retries: 2
prompt: !ruby/regexp /^([\w.@-]+[#>]\s?)$/
next_adds_job: false
vars: {}
groups: {}
group_map: {}
models: {}
pid: "/opt/oxidized/.config/oxidized/pid"
#logger:
#  level: :warn
#  appenders:
#    - type: syslog
#      level: :error
#    - type: file
#      file: "/opt/oxidized/.config/oxidized/logs/log"
extensions:
  oxidized-web:
    load: true
    listen: 127.0.0.1
    port: 8888
crash:
  directory: "/opt/oxidized/.config/oxidized/crashes"
  hostnames: false
stats:
  history_size: 10
input:
  default: ssh, telnet
  debug: false
  ssh:
    secure: false
  ftp:
    passive: true
  utf8_encoded: true
output:
  default: git
  clean_obsolete_nodes: true
  git:
    user: oxidized_bot
    email: oxidized@example.com
    single_repo: true
    repo: "~/.config/oxidized/oxidized.git"
source:
  default: csv
  csv:
    file: ~/.config/oxidized/router.db
    delimiter: !ruby/regexp /;/
    map:
       name: 0
       ip: 1
       username: 2
       password: 3
       model: 4
       group: 5
       port: 6
model_map:
  juniper: junos
  cisco: ios
hooks:
  github_backup:
    type: githubrepo
    events: [post_store]
    remote_repo: <GIT_REPO>
    username: <GIT_USER>
    password: <GIT_PASS>
```