version 1.0;
ns junos = "http://xml.juniper.net/junos/*/junos";
ns xnm = "http://xml.juniper.net/xnm/1.1/xnm";
ns jcs = "http://xml.juniper.net/junos/commit-scripts/1.0";
import "../import/junos.xsl";

match configuration {
 var $hn = system/host-name;
 if ($hn/@junos:group) {
 } else if ($hn) {
 <transient-change> {
 <groups> {
 <name> "re0";
 <system> {
 <host-name> $hn _ '-RE0';
 }
 }
 <groups> {
 <name> "re1";
 <system> {
 <host-name> $hn _ '-RE1';
 }
 }
 <system> {
 <host-name inactive="inactive">;
 }
 } else {
 <xnm:error> {
 <message> "Missing [system host-name]";
 }
 }
 }
}