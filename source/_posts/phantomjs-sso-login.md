---
title: PhantomJS SSO单点登录，加Cookie异常情况处理
date: 2017-12-13 15:36:44
tags: 
- 网络爬虫
- PhantomJS
- Python
author: Lin
---

# Intro
## PhantomJS加Cookie的流程
* 加载一个页面
一般会选择目的页面。
```
driver.get(url)
```
* 加载Cookie
Cookie一般以分号分割。按照规范RFC2109规定，一个Cookie条目，有name,value,domain,secure,expires,pathcomment其中name与value是成对出现的，也是可以直接看到的属性。
domain限定了cookie的作用范围，请求的域名不在此范围内时，浏览器不会发送Cookie。secure是一个可选项，没有值，用来标识此Cookie是否经过HTTPS发送。expires指定的是过期时间，path是Cookie的有效路径。comment是可选项，用来向客户端传递人眼可读信息。
单点登录时，可能会跳转到登录页面，登录页面如果与当前页面不共域的时候，使用目的域是无法登录的。
按照这些要求添加好Cookie。调用
```
driver.add_cookie(cookie)
```
<!--more-->
一般页面在加载时，会有一些Cookie已经存在在driver中了，需要把这些cookie删除掉。
```
driver.delete_all_cookies()
```
之后再加载传入的登录后的Cookie。
* 刷新页面
有人用driver.refresh()来刷新页面，如果是SSO，加载Cookie时，跳转到别的页面了，这里的refresh是不能保证成功登录的。
还是使用原来的url，
driver.get(url)

# SSO登录失败
## 原因
前面说到，Cookie条目中的domain属性用来限制Cookie的作用范围。原来的做法是，以目的URL的域名作为所有Cookie的域属性，SSO情况下
，页面跳转到了登录域，目标域是new.a.com的话，登录域是login.a.com,而PhantomJS要求，添加Cookie时，所添加的Cookie与当前页面的域一致，或者是共用一个父域名，没有进行处理的话，PhantomJS拒绝添加这个Cookie。Cookie添加失败，自然不能登录。
## 解决方法
加载第一个页面后，进行一次判断，如果是SSO（登录页与目标页不在一个域内），取两者自底向上的第一个公共父域，作为加Cookie时的domain属性，这样就可以保证，既能加载Cookie，又能成功登录。
