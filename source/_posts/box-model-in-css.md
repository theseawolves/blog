---
title: CSS中的盒子模型(box model)
date: 2017-05-25 18:56:19
categories:
- CSS盒子模型
tags:
- CSS
- CSS盒子模型
- 翻译
author: Quay
---

允许你定义HTML元素的大小和行为的CSS属性。
原文链接：http://cssreference.io/box-model/

# border-bottom-width
像 ***border-width***，但仅适用于底部边框。

## border-bottom-width: 0; //默认值
移除底部边框。
![border-bottom-width: 0;](/images/border-bottom-width: 0;.png)
<!--more-->

## border-bottom-width: 4px;
你可以使用像素值。
![border-bottom-width: 4px;](/images/border-bottom-width: 4px;.png)

# border-left-width
像 ***border-width*** ，但仅限于左侧边框。

## border-left-width: 0; //默认值
移除左侧边框。
![border-left-width: 0;](/images/border-left-width: 0;.png)

## border-left-width: 4px;
你可以使用像素值。
![border-left-width: 4px;](/images/border-left-width: 4px;.png)

# border-right-width
像 ***border-width***，但是仅适用于右侧边框。

## border-right-width: 0; //默认值
移除右侧边框。
![border-right-width: 0;](/images/border-right-width: 0;.png)

## border-right-width: 4px;
你可以使用像素值。
![border-right-width: 4px;](/images/border-right-width: 4px;.png)

# border-top-width
像 ***border-width***，但是仅限于顶部边框。

## border-top-width: 0; //默认值
移除顶部边框。
![border-top-width: 0;](/images/border-top-width: 0;.png)

## border-top-width: 4px;
你可以使用像素值。
![border-top-width: 4px;](/images/border-top-width: 4px;.png)

# border-width
定义元素边框的宽度。

## border-width: 1px; //默认值
将所有边框的宽度定义为 1px。
![border-width: 1px;](/images/border-width: 1px;.png)

## border-width: 2px 0;
将顶部和底部边框定义为 2px，左侧和右侧为0。
![border-width: 2px 0;](/images/border-width: 2px 0;.png)

# box-sizing
定义元素的宽度和高度如何计算：它们是否包含内边距和边框。

## box-sizing: content-box; //默认值
元素的宽度和高度仅适用于元素的内容。
例如，这个元素有

- border-width: 12px
- padding: 30px
- width: 200px

全宽为 24px + 60px + 200px = 284px。
内容宽度就是显式定义的宽度。 盒子宽度包含这些尺寸。
![box-sizing: content-box;](/images/box-sizing: content-box;.png)

## box-sizing: border-box;
元素的宽度和高度适用于元素的所有部分：内容，内边距和边框。
例如，这个元素有
全宽为 200 像素，无论如何。

- border-width: 12px
- padding: 30px
- width: 200px

盒子宽度就是显式定义的宽度。 内容宽度包含这些尺寸，最终为 200px - 60px - 24px = 116px。
![box-sizing: border-box;](/images/box-sizing: border-box;.png)

# height
定义元素的高度。

## height: auto; //默认值
元素将自动调整其高度，以使其内容正确显示。
![height: auto;](/images/height: auto;.png)

## height: 100px;
你可以使用数字值，如像素，（r）em，百分比...
如果内容不符合规定的高度，则会溢出。 父容器将如何处理这个溢出的内容是由 ***overflow*** 属性来定义的。
![height: 100px;](/images/height: 100px;.png)

# line-height
定义单行文本的高度。

## line-height: normal; //默认值
转而使用浏览器的默认值。
![line-height: normal;](/images/line-height: normal;.png)

## line-height: 1.6; //推荐
你可以使用无单位值：行高将相对于字体大小。
![line-height: 1.6;](/images/line-height: 1.6;.png)

## line-height: 30px;
你可以使用像素值。
![line-height: 30px;](/images/line-height: 30px;.png)

## line-height: 0.8em;
你可以使用em值：像无单位值一样，行高将相对于字体大小。
![line-height: 0.8em;](/images/line-height: 0.8em;.png)

# margin-bottom
定义元素底部 外部的空间。

## margin-bottom: 0; //默认值
移除底部的任何外边距。
![margin-bottom: 0;](/images/margin-bottom: 0;.png)

## margin-bottom: 30px;
你可以使用像素值。
![margin-bottom: 30px;](/images/margin-bottom: 30px;.png)

## margin-bottom: 2em;
你可以使用（r）em值。
该值相对于字体大小：

- em：相对于元素的当前字体大小
- rem：相对于<html>根元素的字体大小

![margin-bottom: 2em;](/images/margin-bottom: 2em;.png)

## margin-bottom: 10%;
你可以使用百分比值。
百分比是基于父容器的宽度。
![margin-bottom: 10;](/images/margin-bottom: 10;.png)

# margin-left
定义元素左侧外部的空间。

## margin-left: 0; //默认值
移除左边的任何外边距。
![margin-left: 0;](/images/margin-left: 0;.png)

## margin-left: 50px;
你可以使用像素值。
![margin-left: 50px;](/images/margin-left: 50px;.png)

## margin-left: 7em;
你可以使用（r）em值。
该值相对于字体大小：

- em：相对于元素的当前字体大小
- rem：相对于<html>根元素的字体大小

![margin-left: 7em;](/images/margin-left: 7em;.png)

## margin-left: 30%;
你可以使用百分比值。
百分比是基于父容器的宽度。
![margin-left: 30;](/images/margin-left: 30;.png)

## margin-left: auto;
***auto*** 关键字将给予左侧部分剩余空间。
当与 ***margin-right：auto*** 组合时，如果定义了固定宽度，它将使元素居中。
![margin-left: auto;](/images/margin-left: auto;.png)

# margin-right
定义元素右侧外部的空间。

## margin-right: 0; //默认值
移除右边的任何外边距。
![margin-right: 0;](/images/margin-right: 0;.png)

## margin-right: 50px;
你可以使用像素值。
![margin-right: 50px;](/images/margin-right: 50px;.png)

## margin-right: 7em;
你可以使用（r）em值。
该值相对于字体大小：

- em：相对于元素的当前字体大小
- rem：相对于<html>根元素的字体大小
![margin-right: 7em;](/images/margin-right: 7em;.png)

## margin-right: 30%;
你可以使用百分比值。
百分比是基于父容器的宽度。
![margin-right: 30;](/images/margin-right: 30;.png)

## margin-right: auto;
***auto*** 关键字将给予右侧部分剩余空间。
当与 ***margin-left：auto*** 组合时，如果定义了固定宽度 ，它将使元素居中。
![margin-right: auto;](/images/margin-right: auto;.png)

# margin-top
定义元素顶部外部的空间。

## margin-top：0; //默认值
移除顶部的任何外边距。
![margin-top0;](/images/margin-top0;.png)

## margin-top: 30px;
你可以使用像素值。
![margin-top: 30px;](/images/margin-top: 30px;.png)

## margin-top: 2em;
你可以使用（r）em值。
该值相对于字体大小：

- em：相对于元素的当前字体大小
- rem：相对于<html>根元素的字体大小

![margin-top: 2em;](/images/margin-top: 2em;.png)

## margin-top: 10%;
你可以使用百分比值。
百分比是基于父容器的宽度。
![margin-top: 10;](/images/margin-top: 10;.png)

# margin
***margin-top***、***margin-right***、***margin-bottom*** 和 ***margin-left*** 的速记属性

## margin: 0; //默认值
移除所有外边距。
![margin: 0;](/images/margin: 0;.png)

## margin: 30px;
当使用1个值时，所有4个外边距都设置相同的边距。
![margin: 30px;](/images/margin: 30px;.png)

## margin: 30px 60px;
当使用2个值时：

- 第一个值是顶部/底部
- 第二个值是右/左

要记住顺序，请你想想你没有定义的值。
如果输入2个值（上/右），则省略左下设置。 因为底部是顶部的垂直对应，它将使用顶部的值。 因为左侧是右侧的水平对应，它将使用右侧的价值。
![margin: 30px 60px;](/images/margin: 30px 60px;.png)

## margin: 30px 60px 45px;
当使用3个值时：

- 第一个值是顶部的
- 第二个值是右/左
- 第三个值是底部的

要记住顺序，请你想想你没有定义的值。
如果输入3个值（上/下/右），则省略左侧设置。 左侧作为右侧的对应，它将使用右侧的值。
![margin: 30px 60px 45px;](/images/margin: 30px 60px 45px;.png)

## margin: 30px 60px 45px 85px;
当使用4个值时：

- 第一个值是顶部的
- 第二个值是右侧的
- 第三个值是底部的
- 第四个值为左侧的

要记住顺序，从顶部开始顺时针方向。
![margin: 30px 60px 45px 85px;](/images/margin: 30px 60px 45px 85px;.png)

# max-height
定义元素的的最大可能高度。

## max-height: none; //默认值
该元素在高度方面没有限制。
![max-height: none;](/images/max-height: none;.png)

## max-height: 2000px;
你可以使用数字值，如像素，（r）em，百分比...
如果最大高度大于元素的实际高度，则最大高度不起作用。
![max-height: 2000px;](/images/max-height: 2000px;.png)

## max-height: 100px;
如果内容不能适应最大高度，则会溢出。 父容器将如何处理这个溢出的内容是由 ***overflow*** 属性来定义的。
![max-height: 100px;](/images/max-height: 100px;.png)

# max-width
定义元素的最大可能宽度。

## max-width: none; //默认值
该元素在宽度方面没有限制。
![max-width: none;](/images/max-width: none;.png)

## max-width: 2000px;
你可以使用数字值，如像素，（r）em，百分比...
如果最大宽度大于元素的实际宽度，则最大宽度不起作用。
![max-width: 2000px;](/images/max-width: 2000px;.png)

## max-width: 150px;
如果内容不能适应最大宽度，它将自动更改元素的高度以适应对内容的包装。
![max-width: 150px;](/images/max-width: 150px;.png)

# min-height
定义元素的最小高度。

## min-height: 0; //默认值
元素没有最小高度。
![min-height: 0;](/images/min-height: 0;.png)

## min-height: 200px;
你可以使用数字值，如像素，（r）em，百分比...
如果最小高度大于元素的实际高度，则将应用最小高度。
![min-height: 200px;](/images/min-height: 200px;.png)

## min-height: 5px;
如果最小高度小于元素的实际高度，则最小高度不起作用。
![min-height: 5px;](/images/min-height: 5px;.png)

# min-width
定义元素的最小宽度。

## min-width: 0; //默认值
元素没有最小宽度。
![min-width: 0;](/images/min-width: 0;.png)

## min-width: 300px;
你可以使用数字值，如像素，（r）em，百分比...
如果最小宽度大于元素的实际宽度，则将应用最小宽度。
![min-width: 300px;](/images/min-width: 300px;.png)

## min-width: 5px;
如果最小宽度小于元素的实际宽度，则最小宽度不起作用。
![min-width: 5px;](/images/min-width: 5px;.png)

# padding-bottom
定义元素底部的内部空间。

## padding-bottom：0; //默认值
移除底部的任何内边距。
![padding-bottom0;](/images/padding-bottom0;.png)

## padding-bottom: 50px;
你可以使用像素值。
![padding-bottom: 50px;](/images/padding-bottom: 50px;.png)

## padding-bottom: 7em;
你可以使用（r）em值。
该值相对于字体大小：

- em：相对于元素的当前字体大小
- rem：相对于<html>根元素的字体大小

![padding-bottom: 7em;](/images/padding-bottom: 7em;.png)

## padding-bottom: 30%;
你可以使用百分比值。
百分比是基于元素的宽度。
![padding-bottom: 30;](/images/padding-bottom: 30;.png)

# padding-left
定义元素左侧的内部空间。

## padding-left: 0; //默认值
移除左侧的任何内边距。
![padding-left: 0;](/images/padding-left: 0;.png)

## padding-left: 50px;
你可以使用像素值。
![padding-left: 50px;](/images/padding-left: 50px;.png)

## padding-left: 7em;
你可以使用（r）em值。
该值相对于字体大小：

- em：相对于元素的当前字体大小
- rem：相对于<html>根元素的字体大小

![padding-left: 7em;](/images/padding-left: 7em;.png)

## padding-left: 30%;
你可以使用百分比值。
百分比是基于元素的宽度。
![padding-left: 30;](/images/padding-left: 30;.png)

# padding-right
定义元素右侧的内部空间。

## padding-right: 0; //默认值
移除右侧的任何内边距。
![padding-right: 0;](/images/padding-right: 0;.png)

## padding-right: 50px;
你可以使用像素值。
![padding-right: 50px;](/images/padding-right: 50px;.png)

## padding-right: 7em;
你可以使用（r）em值。
该值相对于字体大小：

- em：相对于元素的当前字体大小
- rem：相对于<html>根元素的字体大小

![padding-right: 7em;](/images/padding-right: 7em;.png)

## padding-right: 30%;
你可以使用百分比值。
百分比是基于元素的宽度。
![padding-right: 30;](/images/padding-right: 30;.png)

# padding-top
定义元素的顶部空间。

## padding-top: 0; //默认值
移除顶部的任何内边距。
![padding-top0;](/images/padding-top0;.png)

## padding-top: 50px;
你可以使用像素值。
![padding-top: 50px;](/images/padding-top: 50px;.png)

## padding-top: 7em;
你可以使用（r）em值。
该值相对于字体大小：

- em：相对于元素的当前字体大小
- rem：相对于<html>根元素的字体大小

![padding-top: 7em;](/images/padding-top: 7em;.png)

## padding-top: 30%;
你可以使用百分比值。
百分比是基于元素的宽度。
![padding-top: 30;](/images/padding-top: 30;.png)

# padding
***padding-top***、***padding-right***、***padding-bottom*** 和 ***padding-left*** 的速记属性。

## padding: 0; //默认值
移除所有内边距。
![padding: 0;](/images/padding: 0;.png)

## padding: 30px;
当使用1值时，所有4个边都设置相同的内边距。
![padding: 30px;](/images/padding: 30px;.png)

## padding: 30px 60px;
当使用2个值时：

- 第一个值是顶部/底部
- 第二个值是右/左

要记住顺序，请你想想你没有定义的值。
如果输入2个值（上/右），则省略左下设置。 因为底部是顶部的垂直对应，它将使用顶部的值。 因为左侧是右侧的水平对应，它将使用右侧的值。

![padding: 30px 60px;](/images/padding: 30px 60px;.png)

## padding: 30px 60px 45px;
当使用3个值时：

- 第一个值是顶部的
- 第二个值是右/左
- 第三个值是底部的

要记住顺序，请你想想你没有定义的值。
如果输入3个值（上/下/右），则省略左侧设置。 左侧作为右侧的对应，它将使用右侧的值。

![padding: 30px 60px 45px;](/images/padding: 30px 60px 45px;.png)

## padding: 30px 60px 45px 85px;
当使用4个值时：

- 第一个值是顶部的
- 第二个值是右侧的
- 第三个值是底部的
- 第四个值为左侧的

要记住顺序，从顶部开始顺时针方向。
![padding: 30px 60px 45px 85px;](/images/padding: 30px 60px 45px 85px;.png)

# width
定义元素的宽度。

## width: auto; //默认值
元素将自动调整其宽度，以使其内容正确显示。
![width: auto;](/images/width: auto;.png)

## width: 240px;
你可以使用数字值，如像素，（r）em，百分比...
![width: 240px;](/images/width: 240px;.png)

## width: 50%;
如果使用百分比，则该值相对于父容器的宽度。
![width: 50;](/images/width: 50;.png)
