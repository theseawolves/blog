---
title: Python正则表达式
date: 2017-05-26 22:00:38
tags:
---
## 引
正则表达式原理上是一个有限状态机(FSM)。简单理解就是一个系统有有限个数的状态，它的各个状态之间的跳转是遵循一定的规则的。正则表达式跳转依据是下一个字符。正则表达式强大的地方
在于对文本的处理。主流的编程语言都提供了对正则支持，比如Perl, Python, Javascript等。
## 基本的正则表达式
在编写应用时，经常遇到要过滤一些字符串。如用户输入的邮箱格式校验。
* abc.1_2@abc.com:要求的格式
<!--more-->

那么对应的正则表达式可以写为：
* ^[a-zA-Z0-9_-]+@[a-zA-Z0-9_-]+(\.[a-zA-Z0-9_-]+)+$
* 其中[]里的内容表示任意选择一个进行匹配。可以匹配字母、数字、_和-，后面的+号表示至少要匹配到一个前面的字符。最前面的"^"表示最开始的字符只能是[]里的字符。
* @：表示匹配邮箱中的@符号。
* @后的与前面的一样。其中“\.”表示匹配一个句点，不加反斜杠的情况下，"."可以匹配除\n外的任意字符。
* 最后的$表示匹配终止。

表示法|描述|示例
---|---|---
literal |普通字符，只匹配自己| abc
a\ |b |匹配a或者b
. |匹配除换行\n外的任意字符。|
^ |匹配以其后开始的字符串| ^a 只匹配abc,aa；不匹配bac
$ |匹配结束标志|b$所匹配的字符串一定是以b结尾，否则匹配失败。
* |匹配0次多数（贪婪型）
+ |匹配1次或者多次
? |匹配0次或者1次
{N}|匹配前面表达式N次
{M,N}|匹配前面表示式M到N次
[abcd]|匹配当中的任意一个字符
[^..]|不匹配当中出现的任意一个字符

## Python中的正则实现
Python中使用正则表达式模块是re,使用方法为在程序中引入re包，如下：
```
import re
```
通过dir(re)，命令可以查看到re有哪些函数和属性。

```
>>> import re
>>> dir(re)
['DEBUG', 'DOTALL', 'I', 'IGNORECASE', 'L', 'LOCALE', 'M', 'MULTILINE', 'S', 'Scanner', 'T', 'TEMPLATE', 'U', 'UNICODE', 'VERBOSE', 'X', '_MAXCACHE', '__all__', '__builtins__', '__doc__', '__file__', '__name__', '__package__', '__version__', '_alphanum', '_cache', '_cache_repl', '_compile', '_compile_repl', '_expand', '_pattern_type', '_pickle', '_subx', 'compile', 'copy_reg', 'error', 'escape', 'findall', 'finditer', 'match', 'purge', 'search', 'split', 'sre_compile', 'sre_parse', 'sub', 'subn', 'sys', 'template']
>>>
```
有一些Python中通用的属性，如__doc__是模块的注释说明，__file__是模块所在的文件，如果是已经运行过的，后缀为.pyc文件。其他的大家可以自行在Python终端里查看。
这里要介绍下re中常用的正则匹配函数:
1. match
2. findall
3. search
### match
match是从字符串开始匹配的，开关没有匹配成功就认为失败了。使用help(re.match)查看此函数的介绍
```
Help on function match in module re:

match(pattern, string, flags=0)
    Try to apply the pattern at the start of the string, returning
    a match object, or None if no match was found.
	```
help和dir是Python里面比较常用的两个函数。很方便。如下的代码片段可以看出match对象的两个函数group和groups的区别,group返回匹配到的字符串，groups返回一个set。
```
>>> m = re.match('hel*p', 'help')
>>> m
<_sre.SRE_Match object at 0x7f92aa144d30>
>>> dir(m)
['__class__', '__copy__', '__deepcopy__', '__delattr__', '__doc__', '__format__', '__getattribute__', '__hash__', '__init__', '__new__', '__reduce__', '__reduce_ex__', '__repr__', '__setattr__', '__sizeof__', '__str__', '__subclasshook__', 'end', 'endpos', 'expand', 'group', 'groupdict', 'groups', 'lastgroup', 'lastindex', 'pos', 're', 'regs', 'span', 'start', 'string']
>>> m.group
<built-in method group of _sre.SRE_Match object at 0x7f92aa144d30>
>>> m.group()
'help'
>>> m.groups()
()
```
### findall
通过help命令可以查看到findall是返回所有匹配到的内容的列表，不是返回匹配对象了。
### search
search函数的注释表明，它是match的加强版，同样返回一个匹配对象，不再要求是从字符串开始位置匹配。
```
Help on function search in module re:

search(pattern, string, flags=0)
    Scan through string looking for a match to the pattern, returning
    a match object, or None if no match was found.
```
