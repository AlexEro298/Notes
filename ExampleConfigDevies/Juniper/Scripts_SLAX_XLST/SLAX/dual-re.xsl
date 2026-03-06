version 1.0;
ns junos = "http://xml.juniper.net/junos/*/junos";
ns xnm = "http://xml.juniper.net/xnm/1.1/xnm";
ns jcs = "http://xml.juniper.net/junos/commit-scripts/1.0";
import "../import/junos.xsl";

match configuration {
 for-each (system/host-name | interfaces/interface/unit/family/inet/address |
 interfaces/interface[name = 'fxp0']) {
 if (not(@junos:group) or not(starts-with(@junos:group, 're'))) {
 <xnm:warning> {
 call jcs:edit-path($dot = ..);
 call jcs:statement();
 <message> {
 expr "statement should not be in target";
 expr " configuration on dual RE system";
 }
 }
 }
 }
}