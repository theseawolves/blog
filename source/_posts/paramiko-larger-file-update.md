---
title:Paramiko模块大文件上传 
date: 2017-11-30 14:36:44
tags: 
- 编程学习
- Python
- Paramiko
author: Lin
---
# 介绍
Paramiko是Python中用来实现SSH远程登录的模块.Github仓库地址为[https://github.com/paramiko/paramiko](https://github.com/paramiko/paramiko),很多时候，运维人员需要远程登录Linux主机，执行一些Bash命令，对系统进行维护。当主机数量少时，这样是可行的，但如果主机数量多达上百台，这样的手工操作显然有点不合适。
<!--more-->
这时候Paramiko模块就显示出它的威力了。最近做项目就有这样的一个场景，需要将一个很大的文件上传到远程的服务器上，但通过Paramiko的Sftp模块上传时，上传速度超级慢。大概只有1M/s左右。而同样的主机上，使用Xftp或者WinWCP上传的速度可以达到30M/s。
# 如何解决？
首先还是上百度搜索，搜来搜去网上千篇一律地再介绍Paramiko怎么入坑？只有一个小哥在Chinaunix上问[链接](http://bbs.chinaunix.net/thread-4184699-1-1.html)，然而并没有
人回答他。这让我很忧伤，本来就是用Python的人，我决定去看下源码。我上传文件时用的代码是这样的
```
sftp = ssh.open_sftp()
sftp.put(local_file, remote_file, callback = upload_callback)
```
也就是我使用的是Paramiko里面的sftp对象。在Paramiko的源码中简单看了下，就找到了sftp_client.py文件。进去看下，找到了put函数的定义。
函数很简单，获取了要上传文件的大小后，就调用putfo的函数去了。而putfo函数最后是调用了_transfer_with_callback函数，到这个函数以后就看明白了。核心代码是一个循环，后面的代码已经不用看了。
```
size = 0
while True:
    data = reader.read(32768)
    writer.write(data)
    size += len(data)
    if len(data) == 0:
        break
    if callback is not None:
        callback(size, file_size)
```
很简单，一次从本地文件中读32768，这个单位你没有看错，是32768字节，也就是32Kb，一次读的内容太少了吧。本来Python运行效率就低，这样反复的IO读写操作，怎么能不慢。于是乎，我就加了个判断逻辑，一次如果文件大小大于10M，就一次读1M数据。
修改完成之后，上传速度就立马达到20M/s了。
# 总结
- 遇到问题，先上网搜索，如果别人有解决方案，直接拿来用，这样的成本最低。
- 如果没有人有方案，那么自己尝试看下源码，或许小修改下代码就能为我所用了呢！
