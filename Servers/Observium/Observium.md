# Observium

## Disable/Enable poller
```html
nano /etc/cron.d/observium
```
```html
# Run a complete discovery of all devices once every 6 hours
#33  */6   * * *   root    /opt/observium/observium-wrapper discovery >> /dev/null 2>&1

# Run automated discovery of newly added devices every 5 minutes
#*/5 *     * * *   root    /opt/observium/observium-wrapper discovery --host new >> /dev/null 2>&1

# Run multithreaded poller wrapper every 5 minutes
#*/5 *     * * *   root    /opt/observium/observium-wrapper poller >> /dev/null 2>&1

# Run housekeeping script daily for syslog, eventlog and alert log
#13 5      * * * root /opt/observium/housekeeping.php -ysel >> /dev/null 2>&1

# Run housekeeping script daily for rrds, ports, orphaned entries in the database and performance data
#47 4      * * * root /opt/observium/housekeeping.php -yrptb >> /dev/null 2>&1
```

## Rename Device Observium

```html
cd /opt/observium/

php rename_device.php <old_device_name> <new_device_name>
```

## Update
> Disable observium cronjobs (optional)

> Run the following commands (as root):
```html
cd /opt
mv observium observium_old
wget -Oobservium-community-latest.tar.gz https://www.observium.org/observium-community-latest.tar.gz
tar zxvf observium-community-latest.tar.gz
mv /opt/observium_old/rrd observium/
mv /opt/observium_old/logs observium/
mv /opt/observium_old/config.php observium/
```
> Update DB schema:
```html
/opt/observium/discovery.php -u
```
> If it has been a very long time since you've updated (12 months or more), you may want to force an immediate rediscovery of all devices to make sure things are up to date :
```html
/opt/observium/discovery.php -h all
```
> Re-enable observium cronjobs optional
> You may now delete your observium_old directory if everything has updated correctly:
```html
rm -rf observium_old
```