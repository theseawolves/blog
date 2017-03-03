---
title: 求最长子对称字符串算法
date: 2017-03-03 06:59:20

categories:
- 算法
- PPTV面试
tags:
- 算法
- PPTV面试
author: Lin
---

# 题目
最近在微信公众号里看看到了一个PPTV的面试算法题，感觉难度适中，想试下。题目的内容为求一个字符串的最长对称子字符串。如：
输入		输出
abba		4
abad		3
acccbaa		3
<!--more-->
# 我的算法1
自己反复思索了许多时间。一开始是觉得可以利用对称字符串的一个特点，就是反转前后两者是一样的。所以有如下的算法：
最长子串长度为max_sub_len
* 1 把输入的字符串a,进行反转得到b
* 2 把b与a首尾对齐
* 3 找当前相同位置上a与b相同的元素，比如a[0]与b[0], a[1]与b[1],....,a[n]与b[n]，找到最长连续相等的长度，记录此时最长的子串长度长度tmp_max_sub_len。取max_sub_len与tmp_max_sub_len中大者赋给max_sub_len。
* 4 把a左移动一位，如果已经到达a[n]与b[0]对齐时，退出.a[1]与b[0]对齐。重复第3步。
等到算法完成时，max_sub_len就是最长的子对称子串长度。
拿hello为例试下：

1，2
 a = hello
     b = olleh
3 找到a[2]=b[2]=l 最长连续相等为1
4 
a = ello
  b = olleh
3 找到a[1]=b[0] a[2]=b[1] 最长连接相等为2
4 
a = llo
  b = elleh
3 找到最长连续相等为1。
4 
a = lo
  b = elleh
3 找到最长连续相等数为0。
4 
a = o
  b = elleh
  到达终点算法退出。得到最长对称子串长度为2。
时间复杂度：比较次数为n + (n-1) + (n-2) + ... + 1 = n(n-1)/2 = O(n^2)
空间复杂度：可以通过索引的转化，实现只使用原数组。空间复杂度为O(n)
# 微信评论里的算法
有同学在评论里说，可以把反转后的a和b放在一起，求它们的最长公共子串。求最长公共子串的算法属于动态规划的算法，比较复杂，它的实现中，时间复杂度也是O(n^2)。没有我的算法1来得直接简单。具体实现我就不说了。
# 我的算法2
第一种算法算得上不错了。却不是最好的。因为它的时间复杂度n^2的系数为0.5,比较大。下面给出一种更好的算法。
对对称的情况进行分类。
奇对称的：aba类型的。
偶对称的：abba类型的。
第二种算法是根据两种类型的不同，以当前字符为中心向两侧辐射，比较对称两个字符。从而得到最长的对称子串。
不再描述其算法，直接上代码（我的github——[algorithm_ds](https://github.com/LearnInovationNature/algorithm_ds)）。这种算法在最坏的情况下，是aaaaaaaaaaaa，全是一个字符的字符串。要比较n(n-1)次。正常随机输入的情况下,o(n^2)的系数是很小的。
```
#! /usr/bin/python
# -*- coding: utf-8 -*-

'''
最长对称子字符串有两种形式
奇对称：abcba
偶对称：abccba
算法的时间复杂度为n^2
空间复杂度为n
'''
#写一个循环方便测试
while (True):
    max_sym_sub_len = 1
    max_single = 1 #奇对称最长子串
    max_double = 0 #偶对称最长子串

    raw_str = raw_input()
   
#    pdb.set_trace()

    if raw_str == 'q': #退出
        break;

    if (len(raw_str) == 1):
       pass 
    elif (len(raw_str) == 2):
        if (raw_str[0] == raw_str[1]): #长度为2,两个字符相等，最长子串为2
            max_sym_sub_len = 2
    else: #长度>3
        start_ind = 1 #从第2个字符开始判断
        tmp_ind = 0

        #奇对称的情形
        for start_ind in range(1, len(raw_str) - 1):
            max_single_tmp = 1
            # 判断当前的字符距离哪个端点更近
            tmp_range = min(start_ind, len(raw_str) - 1 - start_ind)
            # print start_ind, tmp_range
            for tmp_ind in range(1, tmp_range + 1):
                #开始判断,如果两侧的字符相等，临时最长的长度加2
                if (raw_str[start_ind - tmp_ind] == raw_str[start_ind + tmp_ind]):
                    max_single_tmp += 2
                else:
                    break;
            max_single = max(max_single, max_single_tmp)

        for start_ind in range(1, len(raw_str) - 1):
            max_double_tmp = 0
            # 判断当前的字符距离第一个字符，和当前字符的下个字符距离
            # 最后一个端点的距离中哪个更近
            tmp_range = min(start_ind, len(raw_str) - 2 - start_ind)
            # print start_ind, tmp_range
            # tmp_ind 应该从0开始
            for tmp_ind in range(tmp_range + 1):
                #开始判断,如果两侧的字符相等，临时最长的长度加2
                if (raw_str[start_ind - tmp_ind] == 
                        raw_str[start_ind + 1 + tmp_ind]):
                    max_double_tmp += 2
                else:
                    break;
            max_double= max(max_double, max_double_tmp)       
    max_sym_sub_len = max(max_single, max_double)
    print max_sym_sub_len
```
