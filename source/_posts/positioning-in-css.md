---
title: CSS中的定位（position）
date: 2017-01-31 07:24:10
categories:
- CSS定位
- 翻译
tags:
- CSS
- CSS属性
- CSS定位
- 翻译
author: Quay
---

允许你在HTML中手动定位元素的CSS属性。
原文链接：http://cssreference.io/positioning/

# bottom
根据元素的底边定义元素的位置。

## bottom: auto; //默认值
元素将保持在其自然位置。
![bottom: auto;](/images/bottom: auto;.png)
<!--more-->
## bottom: 20px;
如果元素处于相对定位，元素将向上移动（move upwards）bottom属性值定义的量。***如果是负值，则向下移动。***
![bottom: 20px;](/images/bottom: 20px;.png)


## bottom: 0;
如果元素处于绝对定位，则元素将自己定位在第一个被定位的祖先元素的底部。
![bottom: 0;](/images/bottom: 0;.png)



# left  
根据元素的左边缘定义元素的位置。

## left: auto; //默认值
元素将保持在其自然位置。
![left: auto;](/images/bottom: auto;.png)


## left: 80px;
如果元素处于相对定位，元素将向左移动（move left）left属性值定义的量。***如果是负值，则向右移动。***
![left: 80px;](/images/left: 80px;.png)




## left: -20px;
如果元素处于绝对定位，则元素将自己定位在第一个被定位的祖先元素的左侧。
![left: -20px;](/images/left: -20px;.png)

# position
定义元素的定位行为。

## position: static; //默认值
元素将保持在页面的自然流中。
因此，它不会充当被绝对定位的粉色块元素的定位点。
此外，它不会对以下属性做出反应：
- top
- bottom
- left
- right
- z-index

![position: static;](/images/position: static;.png)

## position: relative;
元素将保持在页面的自然流中。
它也使元素被定位：它将作为被绝对定位粉红色块元素的锚点。
此外，它将对以下属性做出反应：
- top
- bottom
- left
- right
- z-index

![position: relative;](/images/position: relative;.png)


## position: absolute;
元素不会保持在页面的自然流中。 它将根据最接近的被定位的祖先元素定位它自己。
因为它已经被定位，它将作为绝对定位的粉红色块元素的锚点。
此外，它将对以下属性做出反应：
- top
- bottom
- left
- right
- z-index

![position: absolute;](/images/position: absolute;.png)


## position: fixed;
元素不会保留在页面的自然流中。它将根据视口定位自身。
因为它已经被定位，它将作为绝对定位的粉红色块元素的锚点。
此外，它将对以下属性做出反应：
- top
- bottom
- left
- right
- z-index

![position: fixed;](/images/position: fixed;.png)


# right
根据元素的右边缘定义元素的位置。

## right: auto; //默认值
元素将保持在其自然位置。
![right: auto;](/images/bottom: auto;.png)


## right: 80px;
如果元素处于相对定位，元素将向右移动（move right）right属性值定义的量。***如果是负值，则向左移动。***
![right: 80px;](/images/right: 80px;.png)


## right: -20px;
如果元素处于绝对定位，则元素将自己定位在第一个被定位的祖先元素的右侧。
![right: -20px;](/images/right: -20px;.png)


# top
根据元素的顶部边缘定义元素的位置。

## top: auto; //默认值
元素将保持在其自然位置。
![top: auto;](/images/bottom: auto;.png)


## top: 20px;
如果元素处于相对定位，则元素将向下移动（move downwards）由top属性值定义的量。***如果是负值，则向上移动。***
![top: 20px;](/images/top: 20px;.png)


## top: 0;
如果元素处于绝对定位，则元素将自己定位在第一个被定位的祖先元素的顶部。
![top: 0;](/images/top: 0;.png)


# z-index
定义元素在z轴上的顺序。 它只适用于已经被定位的元素（即除了position:static之外的任何元素）。

## z-index: auto; //默认值
元素的顺序由其在HTML代码中的书写顺序来定义：
- 首先出现在代码中 = 后面
- 最后出现在代码中 = 前面

![z-index: auto;](/images/z-index: auto;.png)


## z-index: 1;
z-index属性值是相对于其他值。 目标元素在其兄弟元素的前面移动。
![z-index: 1;](/images/z-index: 1;.png)


## z-index: -1;
你可以使用负值。 目标元素移动到其兄弟元素后面。
![z-index: -1;](/images/z-index: -1;.png)
