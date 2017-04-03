---
title: CSS中的弹性布局(Flexbox)
date: 2017-04-03 17:47:45
categories:
- CSS布局
- 翻译
tags:
- CSS
- CSS属性
- CSS布局
- 翻译
author: Quay
---

允许你使用CSS3 Flexbox功能的CSS属性
原文链接：http://cssreference.io/flexbox/

# align-content（flex container属性）
定义每个行在flexbox容器(flexbox container)中的对齐方式。 它仅适用于 ***flex-wrap: wrap*** 存在的情况下，并且如果有多行的flexbox项目(flexbox item)。

## align-content: stretch;//默认值
每行将拉伸以填充剩余空间。
在这种情况下，容器的高度为300px。 所有盒子都是50px高，除了第二个是100px高。
- 第一行是100px高
- 第二行是50px高
- 剩余空间为150像素
该剩余空间在两行之间平均分布：
- 第一行现在是175px高
- 第二行现在是125px高

![align-content: stretch;](/images/align-content: stretch;.png)
<!--more-->

## align-content: flex-start;
每行只会填充所需的空间。它们都将移动到flexbox容器（flexbox container）的垂直的交叉轴的开始位置。
![align-content: flex-start;](/images/align-content: flex-start;.png)

## align-content: flex-end;
每行只会填充所需的空间。它们都将移动到flexbox容器（flexbox container）的垂直交叉轴的结束位置。
![align-content: flex-end;](/images/align-content: flex-end;.png)

## align-content: center;
每行只会填充所需的空间。它们都将移动到flexbox容器（flexbox container）的垂直交叉轴的中心位置。
![align-content: center;](/images/align-content: center;.png)

## align-content: space-between;
每行只会填充所需的空间。剩余空间将出现在两行之间。
![align-content: space-between;](/images/align-content: space-between;.png)

## align-content: space-around;
每行只会填充所需的空间。剩余的空间将均匀地分布在行间：在第一行之前，在两行之间，在最后一行之后。
![align-content: space-around;](/images/align-content: space-around;.png)

# align-items（flex container属性）
定义flexbox项目（flexbox item）如何根据垂直交叉轴在flexbox容器（flexbox container）的一行内对齐。

## align-items: flex-start;
flexbox项目（flexbox item）在垂直交叉轴开始位置对齐。
默认情况下，交叉轴是垂直的。 这意味着flexbox项目（flexbox item）将在顶部垂直对齐。
![align-items: flex-start;](/images/align-items: flex-start;.png)

## align-items: flex-end;
flexbox项目（flexbox item）在垂直交叉轴的末端对齐。
默认情况下，交叉轴是垂直的。 这意味着flexbox项目（flexbox item）将在底部垂直对齐。
![align-items: flex-end;](/images/align-items: flex-end;.png)

## align-items: center;
flexbox项目（flexbox item）在垂直交叉轴的中心对齐。
默认情况下，交叉轴是垂直的。 这意味着flexbox项目将垂直居中。
![align-items: center;](/images/align-items: center;.png)

## align-items: baseline;
flexbox项目（flexbox item）在垂直交叉轴的基线处对齐。
默认情况下，交叉轴是垂直的。 这意味着flexbox项目（flexbox item）将自己对齐，以使其文本的基线沿着水平线对齐。
![align-items: baseline;](/images/align-items: baseline;.png)

## align-items: stretch;
flexbox项目（flexbox item）将横跨整个垂直交叉轴拉伸。
默认情况下，交叉轴是垂直的。这意味着flexbox项目（flexbox item）将填满整个垂直空间。
![align-items: stretch;](/images/align-items: stretch;.png)

# align-self（flex items属性）
像 ***align-items*** 一样工作，但仅适用于单个Flexbox项目（flexbox item），而不是其中的所有项目。

## align-self: auto;//默认值
Flexbox项目（flexbox item）将使用 ***align-items*** 的值。
![align-self: auto;](/images/align-self: auto;.png)

## align-self: flex-start;
如果父容器设置 ***align-items: center*** ，并且Flexbox项目（flexbox item）具有 ***align-self：flex-start***，则目标项目将位于交叉轴的开头位置。
默认情况下，这意味着它将在顶部位置垂直对齐。
![align-self: flex-start;](/images/align-self: flex-start;.png)

## align-self: flex-end;
如果父容器设置 ***align-items: center*** ，并且Flexbox项目（flexbox item）具有 ***align-self: flex-end*** ，则目标项目将位于交叉轴的末尾位置。
默认情况下，这意味着它将在底部位置垂直对齐。
![align-self: flex-end;](/images/align-self: flex-end;.png)

## align-self: center;
如果父容器设置 ***align-items: flex-start*** ，并且Flexbox项目（flexbox item）具有 ***align-self: center***，则目标项目将位于交叉轴的中心位置。
默认情况下，这意味着它将垂直居中。
![align-self: center;](/images/align-self: center;.png)

## align-self: baseline;
如果父容器设置 ***align-items: center*** ，并且Flexbox项目（flexbox item）具有 ***align-self: baseline*** ，则目标项目将位于交叉轴的基线位置。
默认情况下，这意味着它将沿着文本的基线对齐。
![align-self: baseline;](/images/align-self: baseline;.png)

## align-self: stretch;
如果父容器设置 ***align-items: center*** ，并且Flexbox项目（flexbox item）具有 ***align-self: stretch***,则目标项目将沿着整个交叉轴拉伸。
![align-self: stretch;](/images/align-self: stretch;.png)

# flex-basis（flex items属性）
定义flexbox项目（flexbox item）的初始大小。

## flex-basis: auto;//默认值
该元素将根据其内容自动调整大小，或者在定义任何高度或宽度值时自动调整大小。
![flex-basis: auto;](/images/flex-basis: auto;.png)

## flex-basis: 80px;
你可以定义px、rem、em单位值。 该元素将包装其内容以避免任何溢出。
![flex-basis: 80px;](/images/flex-basis: 80px;.png)

# flex（flex items属性）
***flex-grow*** 、***flex-shrink*** 、***flex-basis*** 属性的简写。第二、第三个参数 ***flex-shrink*** 、***flex-basis*** 是可选的。默认值是 ***0 1 auto***。

# flex-direction（flex container属性）
定义所有flexbox项目（flexbox item）在Flexbox容器（flexbox container）中的顺序。

## flex-direction: row;//默认值
所有flexbox项目（flexbox item）的顺序与文本方向相同，都沿着主轴方向。
![flex-direction: row;](/images/flex-direction: row;.png)

## flex-direction: row-reverse;
所有Flexbox项目（flexbox item）沿着主轴方向并以与文本方向相反排列。
![flex-direction: row-reverse;](/images/flex-direction: row-reverse;.png)

## flex-direction: column;
所有flexbox项目（flexbox item）的排列方式与文本方向相同，沿着交叉轴。
![flex-direction: column;](/images/flex-direction: column;.png)

## flex-direction: column-reverse;
所有Flexbox项目（flexbox item）沿着交叉轴并与文本方向相反排列。
![flex-direction: column-reverse;](/images/flex-direction: column-reverse;.png)

# flex-flow（flex container属性）
***flex-direction*** 、***flex-wrap*** 属性的简写。

# flex-grow（flex items属性）
定义如果有空间可用，Flexbox项目应该增长多少。

## flex-grow: 0;//默认值
如果有空间可用，元素也不会增长。 它只会使用它需要的空间。
![flex-grow: 0;](/images/flex-grow: 0;.png)

## flex-grow: 1;
元素将增长占1份。如果没有其他flexbox项目不设置 ***flex-grow*** 的值，它将填满剩余空间。
![flex-grow: 1;](/images/flex-grow: 1;.png)

## flex-grow: 2;
因为 ***flex-grow*** 值是相对的，它的行为取决于flexbox项目兄弟姐妹元素的值。
在这个例子中，剩下的空间分为3份：
- 绿色项目占1/3
- 粉红色项目占2/3
- 黄色项目将不会变化，仍保留原来的宽度

![flex-grow: 2;](/images/flex-grow: 2;.png)

# flex-shrink（flex items属性）
定义如果没有足够的可用空间，Flexbox项目应该缩减多少。

## flex-shrink: 1;//默认值
如果容器主轴上没有足够的可用空间，则元素将缩小1份，并将其内容包装。
![flex-grow: 2;](/images/flex-grow: 2;.png)

## flex-shrink: 0;
该元素不会缩小：它将保留所需的宽度，而且不会包装其内容。 它的兄弟姐妹元素会收缩，给它挤出空间。
因为目标元素不会包装其内容，所以Flexbox容器（flexbox container）的内容有可能溢出。
![flex-shrink: 0;](/images/flex-shrink: 0;.png)

## flex-shrink: 2;
因为flex-shrink值是相对的，它的行为取决于flexbox项目（flexbox item）兄弟姐妹元素的值。
在此示例中，绿色项目要填充宽度的100％。 它需要的空间取自其两个兄弟姐妹元素，所需空间分为4份：
- 3/4来自红色项目
- 1/4是从黄色项目中取出

![flex-shrink: 2;](/images/flex-shrink: 2;.png)

# flex-wrap（flex container属性）
定义flexbox项目（flexbox item）是如何显示在一个行或多行的Flexbox容器中。

## flex-wrap: nowrap;//默认值
flexbox项目（flexbox item）将保持在一行，无论什么，如果需要，将最终溢出。
![flex-wrap: nowrap;](/images/flex-wrap: nowrap;.png)

## flex-wrap: wrap;
如果需要，flexbox项目（flexbox item）将分布在多行中。
![flex-wrap: wrap;](/images/flex-wrap: wrap;.png)

## flex-wrap: wrap-reverse;
如果需要，flexbox项目（flexbox item）将分布在多行中。 后面的行将显示在上一行之前。
![flex-wrap: wrap-reverse;](/images/flex-wrap: wrap-reverse;.png)

# justify-content（flex container属性）
定义Flexbox项目（flexbox item）在Flexbox容器中主轴方向上的对齐方式。

## justify-content: flex-start;//默认值
Flexbox项目（flexbox item）从父容器主轴的开始位置排列。
![justify-content: flex-start;](/images/justify-content: flex-start;.png)

## justify-content: flex-end;
Flexbox项目（flexbox item）从父容器主轴的末端位置排列。
![justify-content: flex-end;](/images/justify-content: flex-end;.png)

## justify-content: center;
Flexbox项目（flexbox item）沿着父容器的主轴居中。
![justify-content: center;](/images/justify-content: center;.png)

## justify-content: space-between;
剩余的空间分布在flexbox项目（flexbox item）之间。
![justify-content: space-between;](/images/justify-content: space-between;.png)

## justify-content: space-around;
剩余的空间分布在flexbox项目（flexbox item）周围：这将在第一个项目之前和之后添加空间。
![justify-content: space-around;](/images/justify-content: space-around;.png)

# order（flex items属性）
定义flexbox项目（flexbox item）的顺序。

## order: 0;//默认值
flexbox项目（flexbox item）的顺序是HTML代码中定义的。
![order: 0;](/images/order: 0;.png)

## order: 1;
该顺序是相对于flexbox项目（flexbox item）的兄弟姐妹元素的。 需要考虑到所有单独的flexbox项目（flexbox item）顺序值，才能定义最终顺序。
![order: 1;](/images/order: 1;.png)

## order: -1;
你可以使用负值。
![order: -1;](/images/order: -1;.png)

## order: 9;
你可以为每个flexbox项目（flexbox item）设置不同的值。
![order: 9;](/images/order: 9;.png)
