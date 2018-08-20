---
title: PWN基础知识总结
date: 2018-08-19 15:37:49
tags:
- CTF
- PWN
- C语言
author: ulin
---
# 0x00 Intro
这里记录一些在CTF PWN类题目经常要考虑的技术点，是一些与C/ASM相关，比较底层的东西。总结来说有：
* C和汇编之间的参数传递
* 栈的细节
* 64位程序参数传递  
只有对这些细节都清楚了，那么利用时，如何构造Payload就没有想象中那么困难了。这里目前还是只限于x86-64架构。

# 0x01 C和汇编之间的参数传递
有编译器基础的都知道，GCC将C语言编译为机器语言中间有几个过程。
1. 预处理（将宏展开）
2. 汇编（将C代码转为汇编代码）
3. 编译（将汇编转为机器码）
4. 链接（将静态库，多个源文件.o，进行合并，得到可执行文件）  
也就是说C的一级是汇编。当使用IDA工具反汇编得到伪代码时，有时，需要反复交叉查阅，汇编和C代码。所以有必要熟悉下汇编和C的参数传递之间的对应关系。
C和汇编的函数调用的语法不太一样。所以转换过程需要留意。
举个例子来说：
<!--more-->
```
func(a1, a2);
```
这是一个C语言中的函数调用。如果是汇编，则会是这个样子
```
pushl $a2
pushl $a1
call func
```
可以看到，汇编语言中，程序员要手动将参数压入栈中。X86架构下，最后一个参数先压栈，然后是倒数第2个，为什么是这个样子，以及如何记住。在下一个环节说栈的细节时，会详细说下。

# 0x02 栈的细节
栈，队列是计算机中常见的2种数据结构。栈是FILO，队列是FIFO。
在计算机中，栈是用来在函数与函数之间传递参数的一段内存空间。  
在X86中，与栈相关的寄存器有3个。  

汇编中代码表示 | 名称 | 用途
---|---|---
ebp | 栈基地址寄存器 | 用来指示栈的底部
esp | 栈顶地址寄存器 | 用来指示栈的顶部
ss | 栈段寄存器 | 用来存放栈的段选择子  
需要注意的是ebp, esp这两个寄存器里存放的都是地址。不可能是非地址。
## 2.1 栈的特性  
* 在操作系统中，栈是由系统设置好的位于进程内存空间内的一段连续地址中。
* 栈的增长是由高地址向低地址方向进行的。

## 2.2 栈的操作
现代操作系统中不需要用户自行设置栈，所以ss寄存器基本是用不到。另外两个寄存器中，需要时常变动。通常使用push来保存调用现场，用pop在返回时，恢复调用之前的寄存器环境。
* push操作  
语法为：
```
push src
```
操作的源可以是地址内的数据，立即数，和寄存器数。  
push操作用来向栈中存放临时数据的。也叫压栈操作。操作过程中为：esp减小相应字节数，以esp的新位置为目标，将目标值写入。
例如：esp指向0x100位置内存。一个pushl 0x10的操作过程为：
```
1 esp减小4,指向0xFC
2 将0xFC指向的字节，以及其后的3个字节，当成一个32位类型解释，将100赋值给它。
```
* pop操作
为push的逆操作。语法为：
```
pop dest
```
操作的目标，为能接受数据的类型。只能是寄存器或者内存数。不能是立即数。
```
1 将%esp指针的值放入目标中
2 将%esp指针增加相应字节长度。
```
* 在栈上分配内存
我们知道函数内的局部变量是在栈上分配的。分配的方法为
```
1 push %ebp #保存%ebp
2 mov %esp, %ebp # 设置新的函数的临时栈
3 sub $4, %esp # 分配一个4字节的空间
```
因为%esp的值总是变化的，要引用这个变量的地址，要使用%ebp寄存器。即%ebp-4。
```
#include <stdio.h>

int main()
{
    // test %n
    int a = 0, b = 2;
    printf("123456%n\nqq2345%n\n", &a, &b);
    printf("a=%d, b=%d\n", a, b);

    return 0;
}
```
如上的C代码，使用命令
```
gcc -m32 p.c
```
编译，得到a.out可执行文件。有两个局部变量a, b。使用下面命令反汇编下
```
objdump -S a.out
```

```
0000057d <main>:
 57d:	8d 4c 24 04          	lea    0x4(%esp),%ecx
 581:	83 e4 f0             	and    $0xfffffff0,%esp
 584:	ff 71 fc             	pushl  -0x4(%ecx)
 587:	55                   	push   %ebp
 588:	89 e5                	mov    %esp,%ebp
 58a:	53                   	push   %ebx
 58b:	51                   	push   %ecx
 58c:	83 ec 10             	sub    $0x10,%esp
 58f:	e8 ec fe ff ff       	call   480 <__x86.get_pc_thunk.bx>
 594:	81 c3 40 1a 00 00    	add    $0x1a40,%ebx
 59a:	65 a1 14 00 00 00    	mov    %gs:0x14,%eax
 5a0:	89 45 f4             	mov    %eax,-0xc(%ebp)
 5a3:	31 c0                	xor    %eax,%eax
 5a5:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
 5ac:	c7 45 f0 02 00 00 00 	movl   $0x2,-0x10(%ebp)
 5b3:	83 ec 04             	sub    $0x4,%esp
 5b6:	8d 45 f0             	lea    -0x10(%ebp),%eax
 5b9:	50                   	push   %eax
 5ba:	8d 45 ec             	lea    -0x14(%ebp),%eax
 5bd:	50                   	push   %eax
 5be:	8d 83 dc e6 ff ff    	lea    -0x1924(%ebx),%eax
 5c4:	50                   	push   %eax
 5c5:	e8 36 fe ff ff       	call   400 <printf@plt>

```
我们来分析下。
1. 第587, 588行是在设置临时栈。
2. 58a,58b: 两个压栈动作。保存的是%ebx, %ecx。这是为了保护这个寄存器的值，避免调用main函数的上下文中有人使用这两个寄存器。
3. 58c:即为开辟局部变量存贮空间的操作。开辟了16字节。而每个int 字长是4,为什么开辟了16字节。由于之前有两个push操作，其实，现在栈的空间是16 + 8，24字节。
4. 59a，5a0:是 CANARY保护设置。
5. 5a5, 5ac: 是里设置两个变量的值。
6. 5b3: 又分配了4个字节。
7. 5b6-5c5:调用printf函数。
也就是说，一共开辟了0x14, 20字节的数据。加上之前的两个push，一共是28字节。
来看下，每个字节是如何使用的，以587,588设置临时栈为时间点。  

地址 | 字节数| 用途    
---- | ---- | --- 
ebp-4 | 4 | 保存ebx的值
ebp-8 | 4 | 保存ecx的值
ebp-12(0xc) | 4 | 保存CANARY
ebp-16(0x10) | 4 | 局部变量b
ebp-20(0x14) | 4 | 局部变量a 
ebp-24(0x18) | 4 | 空的
ebp-28(0x1c) | 4 | 空的
通过以下可以看出。局部变量是如何在栈上分配的，同时也可以看到，局部变量是通过ebp寄存器访问的。至于为什么调用来留出8字节的空间，暂时不知道。
## 2.3 参数的传递
通过查看printf的3个参数的传递可以发现，第一个参数，也就是格式化字符串，在汇编代码中是最后一个压栈的。这个跟一般理解的参数传递不太一样。也不太好记忆。我捋了下，原因是这样的。如下函数调用
```
func(a, b)
```
一般人看到这个，认为a变量先出现，b后出现。体现在栈里时，a的地址应比b的小，更先前一些。于是到栈里，栈的特性是push栈增长，向低地址方向增长。那么先压栈的地址一定比后压栈的地址要大。所以这里是地址高的先压栈，也就是b先压栈。  
回到上面的代码中，就是b先压栈。也里也说下字符串格式化漏洞的成因。如果有格式化字符串，又没有提供格式化变量的话，printf会以字符串地址为基准向高地址方向找一个变量作为格式化变量。高地址方向上，会有canary, 返回地址等信息，即可以漏洞一些有意思的信息出来了。
# 64位参数传递
32位环境下，参数是全部通过栈传递的。原因呢，是因为32位资源有限，寄存器比较少。到了64位时，参数优先通过以下6个寄存器来传递
* rdi
* rsi
* rdx
* rcx
* r8
* r9
如何还有更多的参数，就通过栈来存放。