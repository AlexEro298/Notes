# Firewall-cmd:
```html
firewall-cmd --list-all
firewall-cmd --permanent --add-port=80/tcp
firewall-cmd --permanent --add-port=6500-6700/udp
firewall-cmd --permanent --add-port=80/tcp --add-port=443/tcp
firewall-cmd --permanent --new-service=zabbix
firewall-cmd --permanent --service=zabbix --add-port=10050/tcp
firewall-cmd --permanent --service=zabbix --set-short="Zabbix Agent"
firewall-cmd --permanent --add-service=zabbix
firewall-cmd --permanent --add-service=ntp

firewall-cmd --reload
```
# Troubleshooting:
```html
firewall-cmd --state
firewall-cmd --list-all                                                                                                 ### all rules
firewall-cmd --get-services                                                                                             ### list services
firewall-cmd --info-service=<name_service>                                                                              ### info services
firewall-cmd --permanent --add-service=<name_service>                                                                   ### add service permanent firewall
firewall-cmd --permanent --add-port=80/tcp                                                                              ### example: allow port
firewall-cmd --permanent --add-port=6500-6700/udp
firewall-cmd --permanent --new-service=<name_service>                                                                   ### create custom services
firewall-cmd --permanent --service=<name_service> --add-port=2200/tcp
firewall-cmd --permanent --service=<name_service> --set-short="Service With This Name"                                  ### 
firewall-cmd --permanent --service=<name_service> --set-description="Long Description For Service With This Name"       ### Description services
firewall-cmd --reload                                                                                                   ### Softly reread the rules
firewall-cmd --complete-reload                                                                                          ### hard reread the rules and drop current connection
firewall-cmd --runtime-to-permanent                                                                                     ### save current rules (current -> permanent)



firewall-cmd --permanent --remove-port=80/tcp
```
