---
title: Linux命令-xargs
date: 2017-07-24 20:30:00
tags:
- Linux
author: Lin
---
## 介绍
xargs是bash中的一个命令，用于命令行中参数的传递和处理。可用来将特定的参数传递给另外一个命令。另外一个命令作为xargs的参数传递进来。
在shell里面，通过man xargs查看其使用说明。这里只给出了前面的部分。
<!--more-->
```
NAME
       xargs - build and execute command lines from standard input

SYNOPSIS
       xargs  [-0prtx]  [-E  eof-str]  [-e[eof-str]]  [--eof[=eof-str]]  [--null]  [-d  delimiter] [--delimiter delimiter] [-I replace-str] [-i[replace-str]] [--replace[=replace-str]]
       [-l[max-lines]] [-L max-lines] [--max-lines[=max-lines]] [-n max-args] [--max-args=max-args]  [-s  max-chars]  [--max-chars=max-chars]  [-P  max-procs]  [--max-procs=max-procs]
       [--interactive] [--verbose] [--exit] [--no-run-if-empty] [--arg-file=file] [--show-limits] [--version] [--help] [command [initial-arguments]]

DESCRIPTION
       This  manual  page documents the GNU version of xargs.  xargs reads items from the standard input, delimited by blanks (which can be protected with double or single quotes or a
       backslash) or newlines, and executes the command (default is /bin/echo) one or more times with any initial-arguments followed by items read from standard input.  Blank lines on
       the standard input are ignored.

       Because  Unix  filenames  can contain blanks and newlines, this default behaviour is often problematic; filenames containing blanks and/or newlines are incorrectly processed by
       xargs.  In these situations it is better to use the -0 option, which prevents such problems.   When using this option you will need to ensure that the  program  which  produces
       the input for xargs also uses a null character as a separator.  If that program is GNU find for example, the -print0 option does this for you.

       If any invocation of the command exits with a status of 255, xargs will stop immediately without reading any further input.  An error message is issued on stderr when this hap-
       pens.
```
## manual格式说明
这里简要说明下manual的格式。SYNOPSIS是语法的意思，其下面的3行文字是用来说明如何使用这个命令。其中大部分的内容是说明这个命令的选项的。一个工具通常有很多种不同的用法，我们不想开发出一款工具却只能有一种用途，bash里面命令的灵活多变性，是通过选项(options)来实现控制的。对于使用shell的人员来说，manul是一个强大的工具，manual后面是各个选项的功能介绍和使用实例。简单来说有如下的规则：
* 如果是"-"来表示选项的话，那么它后面跟着的是一个字母代表的选项。如果是"--"两个话，后面跟一个单词作为选项。
* 用[]包围起来的内容表示一个语法单元，多是选项单元。选项单元由选项名和参数组成，中间用空格分割。1) 如果选项名后面没有参数，则说明这个选项后是不传递参数的。形如[-Oprtx]；2) 同时，如果"-"后有多个选项，则说明这个命令具有多个不带参数选项。3)如果参数用[]包围起来，则说明这个选项可以传递参数，也可以不传递。如[command [initial-arguments]]，其中的initial-arguments作为command的参数，可以有也可以没有。
* 有些选项和参数之间没有空格，需要注意。如[-I replace-str] [-i[replace-str]] ，同样的功能使用-i时，选项与参数之间没有空格。

## xargs使用实例
* 删除指定的文件
假如一个文件夹下有很多个子文件夹，这些文件件中都包含有*.log日志文件，你想要删除这些日志文件。
```
ulin@lin-pc:/mnt/d/program1/bash$ find
.
./1
./1/1
./1/1.log
./1/2
./1/2.log
./1/3
./1/33
./1/33/aa.log
./1/4
./1/aalog
./2
./2/b.log
./example_3-3-1.sh
./example_3-3.sh
./ex_8-1.sh
./scope.sh
```
我们可以通过find和grep工具把这些log文件的具体路径都找到：
```
ulin@lin-pc:/mnt/d/program1/bash$ find | grep "\.log$"
./1/1.log
./1/2.log
./1/33/aa.log
./2/b.log
```
如果没有xargs命令的话，我们需要写一个shell脚本，来获取这些日志的路径后，用一个for循环来删除。而有了xargs，可以直接这样用：
```
find | grep "\.log$" | xargs rm
```
这样一句命令就完成了删除。在每次删除之前，都要验证下，是不是真的找到了想删除的文件。因为rm删除的文件很难找回来。
