# PFE Commands

## MX80

```html
> show system information 
Model: mx80
Family: junos
Junos: 21.2R3-S9.21
Hostname: mx80-1
```

```html
> request pfe execute target tfeb0 command "show jnh 0 pool usage" 
SENT: Ukern command: show jnh 0 pool usage

EDMEM overall usage:
[NH////////|FW////////|CNTR///////////|HASH//////|ENCAPS////|------------------------]
0          4.0        8.0             14.0       18.1       22.1                     32.0M

Next Hop
[*****************|---------------|RRRRRRRRRRRRRRRRRRRR] 4.0M (33% | 67%)

Firewall
[|--------------------------------|RRRRRRRRRRRRRRRRRRRR] 4.0M (1% | 99%)

Counters
[****************************|---------------------------|RRRRRRRRRRRRRRRRRRRRRRRR] 6.0M (35% | 65%)

HASH
[******************************************************] 4.1M (100% | 0%)

ENCAPS
[******************************************************] 4.1M (100% | 0%)

Shared Memory - NH/FW/CNTR/HASH/ENCAPS
[--------------------------------------------------------------------------------] 9.9M (0% | 100%)

Free Shared Memory - NH/FW/CNTR/HASH/ENCAPS
[--------------------------------------------------------------------------------] 9.9M (0% | 100%)
```

```html
> request pfe execute target tfeb0 command "show jnh 0 pool summary"                     
SENT: Ukern command: show jnh 0 pool summary

                Name        Size      Allocated     % Utilization
               EDMEM    33554432       12226110               36%
               IDMEM      327680         315555               96%
                OMEM    66912416         196448             < 1%
```

```html
> request pfe execute target tfeb0 command "show threads cpu" | no-more 
SENT: Ukern command: show threads cpu
...
```

```html
> request pfe execute command "show jnh 0 exceptions terse" target tfeb0 timeout 0 
SENT: Ukern command: show jnh 0 exceptions terse


Reason                             Type           Packets      Bytes
==================================================================


alexero@mx80-1>
```

```html
> request pfe execute target tfeb0 command "sh jnh 0 inline-services flow-table-info" 
```

```html
> request pfe execute target tfeb0 command "show nhdb summary"          
SENT: Ukern command: show nhdb summary

 Total number of NH = 115
```

```html
> request pfe execute target tfeb0 command "show jspec client" 
```

## MX204

```html
> show system information 
Model: mx204
Family: junos
Junos: 23.4R2-S6.9
Hostname: mx204
```

```html
> request pfe execute target fpc0 command "show jnh 0 pool usage" 
SENT: Ukern command: show jnh 0 pool usage

EDMEM overall usage:
[NH//////////|HASH////////|------------------------------------------------------]
0            5.0          9.9                                                    31.7M

Next Hop
[**************************************************************|-----------------] 5.0M (78% | 22%)

HASH
[*******************************************************************************] 4.9M (100% | 0%)

Shared Memory - NH/HASH
[*****************|---------------------------------------------------------------] 17.8M (21% | 79%)

Free Shared Memory - NH/HASH
[**********************|----------------------------------------------------------] 17.8M (28% | 72%)

RO_EDMEM overall usage:
[NH//////////////////////////////////////////|FW/////////////////////////////////|]
0                                            5.0                                 9.0 9.0M

Next Hop
[*********************************************************|----------------------] 5.0M (71% | 29%)

Firewall
[|---------------------------------------|RRRRRRRRRRRRRRRRRRRRRRRR] 4.0M (<1% | >99%)

Shared Memory - NH/FW
[*******|-------------------------------------------------------------------------] 1.0M (9% | 91%)

Free Shared Memory - NH/FW
[********************************************************************************] 1.0M (100% | 0%)

DMEM overall usage:
[CNTR//|HASH//////////////////////////////////////|------------------------------]
0      8.0                                        60.1                           98.0M

Counters
[****|----|RRR] 8.0M (35% | 65%)

HASH
[********************************************************************************] 52.1M (100% | 0%)

Shared Memory - CNTR/HASH
[--------------------------------------------------------------------------------] 29.5M (0% | 100%)

Free Shared Memory - CNTR/HASH
[--------------------------------------------------------------------------------] 29.5M (0% | 100%)
```

```html
> request pfe execute target fpc0 command "show jnh 0 pool summary"                     
SENT: Ukern command: show jnh 0 pool summary

                Name        Size      Allocated     % Utilization
               EDMEM    33259392       13064617               39%
               IDMEM      471040         339747               72%
           Bulk DMEM   102760320       65366775               21%
```

```html
> request pfe execute timeout 0 target fpc0 command "show threads cpu" | no-more 
SENT: Ukern command: show threads cpu

CPU hog check enabled
Max run time 2500
PID PR State     Name                   Stack Use  Time (Last/Max/Total) cpu
--- -- -------   ---------------------  ---------  ---------------------
  2 L  running   Idle                   796/32768  0/18/173316886 ms 94%
 48 M  asleep    PIC Periodic          2112/32768  0/17/3995784 ms  2%
 78 M  asleep    JGCI_Background       1652/32768  0/50/3306697 ms  1%
 18 M  asleep    QSFP                  2612/32768  0/18/497882 ms  0%
 26 M  asleep    SFP                   1588/32768  0/25/335146 ms  0%
 50 M  asleep    TNPC CM              14196/32768  0/605/294581 ms  0%
108 L  asleep    DDOS Policers         3504/32768  0/1/255837 ms  0%
 87 M  asleep    PFE Statistics        2960/32768  0/2/208797 ms  0%
 96 L  asleep    MQSS Statistics       4568/32768  0/1/172017 ms  0%
 75 M  asleep    PFE Manager          11104/32768  0/100/133620 ms  0%
105 M  asleep    Services TOD          2592/32768  1/9/122742 ms  0%
 94 L  asleep    EA Background Service  1716/32768  0/1/100670 ms  0%
 93 M  asleep    XQSS Service Thread   1568/32768  0/2/100038 ms  0%
 91 M  asleep    HMM Background         992/32768  0/1/70871 ms  0%
 99 M  asleep    Cassis Free Timer     2160/32768  0/1/54407 ms  0%
 95 M  asleep    MQSS Generic          1008/32768  0/1/54337 ms  0%
 77 L  asleep    PFEMAN SRRD Thread    3244/32768  0/1/46242 ms  0%
 31 L  asleep    LKUP ASIC Wedge poll thread   992/32768  0/0/46067 ms  0%
 73 L  asleep    cos halp stats daemon  1632/32768  0/1/44474 ms  0%
 85 H  asleep    CFM Manager           1364/32768  0/0/40824 ms  0%
 10 M  asleep    RSMON syslog thread   2884/32768  0/1/38405 ms  0%
 23 H  asleep    IGMP                  1412/32768  0/1/29591 ms  0%
 97 M  asleep    MQSS Queue Statistics   792/32768  0/1/27314 ms  0%
 40 H  asleep    TTP Transmit          1772/32768  0/2/25091 ms  0%
 21 M  asleep    DSX50ms                776/32768  0/0/21810 ms  0%
104 L  asleep    IP Reassembly         3072/32768  0/1/14637 ms  0%
 63 M  asleep    L2ALM Manager         5344/32768  0/1/14449 ms  0%
 64 M  asleep    ARP Proxy              968/32768  0/0/11467 ms  0%
112 M  asleep    bulkget Manager       5028/32768  0/1/11311 ms  0%
107 L  asleep    JNH Exception Counter Background Thread  2528/32768  0/1/11185 ms  0%
 39 H  asleep    TTP Receive           2004/32768  0/1/10232 ms  0%
 34 L  asleep    L2PD                   792/32768  0/0/9450 ms  0%
 15 M  asleep    Periodic               792/32768  0/1/5389 ms  0%
  3 H  asleep    Timer Services         776/32768  0/0/4343 ms  0%
 61 M  asleep    PPM Data thread       1308/32768  0/0/4257 ms  0%
 43 H  asleep    TNP Hello              840/32768  0/0/3746 ms  0%
 44 M  asleep    PTP stack             2788/32768  0/0/3321 ms  0%
 35 H  asleep    TCP Timers             760/32768  0/0/2588 ms  0%
 20 M  asleep    I2C Accel              936/32768  0/0/2130 ms  0%
 98 M  asleep    MQSS Wedge Detection  1008/32768  0/0/2124 ms  0%
103 H  asleep    Cube Server           1380/32768  0/0/2101 ms  0%
 28 M  asleep    Host Loopback Periodic   792/32768  0/0/2007 ms  0%
110 L  asleep    JNH KA Transmit       1156/32768  0/0/2003 ms  0%
113 M  asleep    PRECL Chip Generic     824/32768  0/0/1940 ms  0%
100 M  asleep    JNH Partition Mem Recovery  1224/32768  0/0/1921 ms  0%
114 M  asleep    PRECL Chip Generic     824/32768  0/0/1830 ms  0%
 56 M  asleep    RFC2544 periodic       952/32768  0/1/1446 ms  0%
 33 M  asleep    HSL2                   660/32768  0/0/1391 ms  0%
 72 L  asleep    DFW Alert             1080/32768  0/0/1291 ms  0%
102 M  asleep    Stats Page Ager        844/32768  0/0/1291 ms  0%
 83 H  asleep    CLKSYNC PHY DRIVER     660/32768  0/0/1274 ms  0%
 16 M  asleep    OTN                    660/32768  0/0/1256 ms  0%
  7 M  asleep    GR253                  840/32768  0/0/1240 ms  0%
 22 M  asleep    DSXonesec              644/32768  0/0/1178 ms  0%
 27 M  asleep    Linux CMERROR         1556/32768  0/0/1117 ms  0%
 17 M  asleep    CXP                    952/32768  0/0/1104 ms  0%
 24 M  asleep    CFP                    836/32768  0/0/1094 ms  0%
 25 M  asleep    XFP                    820/32768  0/0/1060 ms  0%
 57 H  asleep    Pfesvcsor              776/32768  0/0/1034 ms  0%
 60 M  asleep    PPM Manager           4332/32768  0/0/684 ms  0%
 84 M  asleep    CLKSYNC Manager       1888/32768  0/56/547 ms  0%
106 M  asleep    Trap_Info Read PFE 0.0  1504/32768  0/0/538 ms  0%
  6 L  asleep    Sheaf Background       724/32768  0/0/262 ms  0%
 12 M  asleep    MSA300PIN              676/32768  0/0/236 ms  0%
 47 M  asleep    Agent Daemon          1188/32768  0/0/206 ms  0%
101 M  asleep    LU-CNTR Reader         580/32768  0/0/60 ms  0%
 46 L  asleep    IFCM                  1428/32768  0/0/56 ms  0%
109 L  asleep    jnh errors daemon      692/32768  0/0/36 ms  0%
 69 L  asleep    ICMP Input            1280/32768  0/0/31 ms  0%
 14 L  asleep    Syslog                 812/32768  0/0/28 ms  0%
  1 H  asleep    Maintenance            612/32768  0/0/24 ms  0%
111 L  asleep    VBF PFE Events         516/32768  3/3/3 ms  0%
 51 M  asleep    RCM Pfe Manager        820/32768  0/0/1 ms  0%
  9 M  asleep    mac_db                2960/32768  0/0/1 ms  0%
 76 L  asleep    PFEMAN Service Thread  1188/32768  0/0/0 ms  0%
 62 M  asleep    VRRP Manager          1628/32768  0/0/0 ms  0%
 59 M  asleep    RDMAN                 1524/32768  0/0/0 ms  0%
736 L  ready     Cattle-Prod Daemon    3940/32768  0/0/1 ms  0%
 80 L  asleep    Virtual Console       1060/32768  0/0/0 ms  0%
737 L  asleep    Cattle-Prod Daemon    2212/32768  0/0/0 ms  0%
 81 L  asleep    Console               2340/32768  0/0/0 ms  0%
 68 L  asleep    IP6 Option Input      1428/32768  0/0/0 ms  0%
 70 L  asleep    IP Option Input       1412/32768  0/0/0 ms  0%
 71 M  asleep    IGMP Input            1412/32768  0/0/0 ms  0%
 86 M  asleep    CFM Data thread       1396/32768  0/0/0 ms  0%
 45 M  asleep    SyncApp               1524/32768  0/0/0 ms  0%
 79 L  asleep    IPC Test Daemon        724/32768  0/0/0 ms  0%
  8 H  asleep    IPv4 PFE Control Background   484/32768  0/0/0 ms  0%
 58 M  asleep    Mobile edge RCM thread   804/32768  0/0/0 ms  0%
  5 L  asleep    Ukern Syslog           484/32768  0/0/0 ms  0%
 36 H  asleep    TCP Receive            628/32768  0/0/0 ms  0%
 32 L  asleep    TOE Coredump           596/32768  0/0/0 ms  0%
 88 L  asleep    VBF MC Purge           516/32768  0/0/0 ms  0%
 74 L  asleep    NH Probe Service       500/32768  0/0/0 ms  0%
 67 L  asleep    ICMP6 Input            772/32768  0/0/0 ms  0%
 52 L  asleep    CLNS Err Input         612/32768  0/0/0 ms  0%
 53 L  asleep    CLNS Option Input      612/32768  0/0/0 ms  0%
 29 M  asleep    TTRACE Creator         644/32768  0/0/0 ms  0%
 55 M  asleep    RPM Msg thread         484/32768  0/0/0 ms  0%
 65 M  asleep    CEIP Ping              484/32768  0/0/0 ms  0%
 38 H  asleep    RDP Input              612/32768  0/0/0 ms  0%
 49 M  asleep    PIC                    484/32768  0/0/0 ms  0%
 54 H  asleep    L2TP-SF KA Transmit    484/32768  0/0/0 ms  0%
 42 M  asleep    UDP Input              612/32768  0/0/0 ms  0%
 13 L  asleep    Firmware Upgrade       532/32768  0/0/0 ms  0%
 30 M  asleep    TTRACE Tracer          596/32768  0/0/0 ms  0%
 19 M  asleep    DCC Background         628/32768  0/0/0 ms  0%
 41 L  asleep    TTP Transmit LowPri    500/32768  0/0/0 ms  0%
 37 H  asleep    RDP Timers             484/32768  0/0/0 ms  0%
 11 M  asleep    IFD RPF CHANGE         596/32768  0/0/0 ms  0%
```

```html
> request pfe execute command "show jnh 0 exceptions terse" target fpc0 timeout 0 
SENT: Ukern command: show jnh 0 exceptions terse


Reason                             Type           Packets      Bytes
==================================================================


Error Parcels
----------------------
from WAN                           M2L ERROR     38067650


PFE State Invalid
----------------------
sw error                           DISC( 64)       294091   31728503
unknown family                     DISC( 73)         1614     177540
unknown iif                        DISC(  1)          600      68214


Packet Exceptions
----------------------
DDOS policer violation notifs      PUNT( 15)           10        947


Bridging
----------------------
bridge ucast split horizon         DISC( 26)         1186     308357
mlp pkt                            PUNT( 11)           14        406


Firewall
----------------------
firewall discard                   DISC( 67)         3347     154237
firewall reject                    PUNT( 36)           26       1324


Routing
----------------------
discard route                      DISC( 66)        23310   12233874
discard route IPv6                 DISC(102)         8161     587544
control pkt punt via nh            PUNT( 34)       711110   63318730
host route                         PUNT( 32)      1042939  180599726
reject route                       PUNT( 40)         2664     294816


Misc
----------------------
sample pfe                         PUNT( 43)         3347     154237
```

```html
> request pfe execute target fpc0 command "sh jnh 0 inline-services flow-table-info" 
SENT: Ukern command: sh jnh 0 inline-services flow-table-info
```

```html
> request pfe execute target fpc0 command "show nhdb summary"          
SENT: Ukern command: show nhdb summary

 Total number of NH = 351
```

```html
> request pfe execute target fpc0 command "show qsfp list"       
SENT: Ukern command: show qsfp list

QSFP Toolkit summary:
  wakeup count: 184193, debug: 0
  thread: 0xdeb3ac20, itable: 0xdeb05170

Index  Name   State
-----  ----   -----
    1  qsfp-0/0/0 Present
    2  qsfp-0/0/1 Present
    3  qsfp-0/0/2 Absent
    4  qsfp-0/0/3 Present
```

```html
> request pfe execute target fpc0 command "show qsfp 4"       
SENT: Ukern command: show qsfp 4
More information is needed.

Possible choices:
    alarms                show qsfp alarms
    diagnostics           show qsfp diagnostics
    enh_diagnostics       show qsfp enhanced diagnostics
    fec                   show FEC status
    fw_features           show qsfp firmware upgrade features (QSFP-DD CMIS-v4.0 and above)
    fw_info               show qsfp firmware information (QSFP-DD CMIS-v4.0 and above)
    i2c_accel_err         show qsfp i2c acceleration error
    identifier            show qsfp identifier info
    info                  show qsfp info
    pm                    QSFP Performance Monitoring data
```

```html
> request pfe execute target fpc0 command "show qsfp 4 info"
SENT: Ukern command: show qsfp 4 info
...
```

```html
> request pfe execute target fpc0 command "show heap" 
SENT: Ukern command: show heap

ID        Base      Total(b)       Free(b)       Used(b)   %   Name
--  ----------   -----------   -----------   -----------  ---   -----------
0    57aad000    2684350440    1806233232     878117208   32  Kernel
1    1c000000     234881024     213259992      21621032    9  DMA
2    18dfffe0      52428784      52428784             0    0  Blob
```

```html
> request pfe execute target fpc0 command "show jspec client"  
```