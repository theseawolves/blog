---
title: LVS配置详解
date: 2017-2-13 22:52:10
tags:
- LVS
categories:
---
# LVS配置命令理解1

上周末对照着[Ubuntu LVS配置 ](http://blog.csdn.net/lihancheng/article/details/47152499)的教程初步熟悉了ubuntu下LVS的配置过程中。这对于想掌握其原理的人来说是不够的。
配置的命令有以下几条：
## ifconfig来为当前的网卡配置虚拟IP。
其中同样通过在CSDN上搜索，可以知道，通过在eth0（网卡接口名称）后加“:n"，其中n为N+（正整数），就可以为网卡配置多个虚拟IP地址。这样的IP地址是不会有真实的数据经过它。
比如我的电脑上只有一个无线网卡，用ifconfig命令得到的回显中，显示名称是wlps1s0。
```
lin@lin-pc2:~/Documents/ops$ ifconfig
lo        Link encap:Local Loopback  
          inet addr:127.0.0.1  Mask:255.0.0.0
          inet6 addr: ::1/128 Scope:Host
          UP LOOPBACK RUNNING  MTU:65536  Metric:1
          RX packets:614 errors:0 dropped:0 overruns:0 frame:0
          TX packets:614 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1
          RX bytes:57615 (57.6 KB)  TX bytes:57615 (57.6 KB)

wlp1s0    Link encap:Ethernet  HWaddr d0:57:7b:b0:a1:d0  
          inet addr:192.168.31.172  Bcast:192.168.31.255  Mask:255.255.255.0
          inet6 addr: fe80::2805:4caf:e64f:ff0d/64 Scope:Link
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:2241 errors:0 dropped:0 overruns:0 frame:0
          TX packets:1901 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1000
          RX bytes:1512337 (1.5 MB)  TX bytes:394920 (394.9 KB)
```
其中lo为本地的回环接口。LVS配置过程中也要使用这个接口。可以得到我的局域网IP网络号为192.168.31.x。那么如下的命令可以为我的无线网卡添加一个虚拟IP。
```
lin@lin-pc2:~/Documents/ops$ sudo ifconfig wlp1s0:1 192.168.31.173 netmask 255.255.255.0
```
再次使用ifconfig命令得到的回显为：
```
lin@lin-pc2:~/Documents/ops$ ifconfig
lo        Link encap:Local Loopback  
          inet addr:127.0.0.1  Mask:255.0.0.0
          inet6 addr: ::1/128 Scope:Host
          UP LOOPBACK RUNNING  MTU:65536  Metric:1
          RX packets:672 errors:0 dropped:0 overruns:0 frame:0
          TX packets:672 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1
          RX bytes:65106 (65.1 KB)  TX bytes:65106 (65.1 KB)

wlp1s0    Link encap:Ethernet  HWaddr d0:57:7b:b0:a1:d0  
          inet addr:192.168.31.172  Bcast:192.168.31.255  Mask:255.255.255.0
          inet6 addr: fe80::2805:4caf:e64f:ff0d/64 Scope:Link
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:3001 errors:0 dropped:0 overruns:0 frame:0
          TX packets:2249 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1000
          RX bytes:2382550 (2.3 MB)  TX bytes:459282 (459.2 KB)

wlp1s0:1  Link encap:Ethernet  HWaddr d0:57:7b:b0:a1:d0  
          inet addr:192.168.31.173  Bcast:192.168.31.255  Mask:255.255.255.0
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1

```
可以看到已经新增了一个虚拟IP。可以注意到这个虚拟IP对应的接口，没有显示接收，发送的数据包信息，却可以在局域网中ping通这个IP地址。原因是，它只是一个虚拟的，真正的数据包还是经过wlp1s0这个接口发送和接收的。
## 启动IP包转发功能
ubuntu内核中默认是不支持IP包转发的。因为ubuntu是作为终端操作系统来运行的，IP包转发是路由器的功能。然而，强大的内核可配置性，允许我们改变这样的默认设置，使它支持包转发。这也是为什么，ubuntu操作系统中支持wifi热点搭建的原因。控制这个选项的变量是在/proc/sys/net/ipv4/ip_forward文件中写着的。启动的方法有两种。
### 1. 直接在文件中写入1
```
#echo "1" /proc/sys/net/ipv4/ip_forward
```
命令前面的#表示这个命令是需要有root权限的。
### 2. 通过sysctl命令来修改
```
#sysctl net.ipv4.ip_forward=1
```
同样需要root权限，都能达到目的。sysctl是一个非常有用的在内核运行时改变内核参数的工具。
