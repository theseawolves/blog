---
title: Java反射机制学习
date: 2017-10-01 14:36:44
tags: 
- 编程学习
- Java
author: Lin
---
# 概念
Java反射机制是在运行状态中，对于任意一个类，都能够知道这个类的所有属性和方法；对于任意一个对象，都能够调用它的任意一个方法；这种动态获取的信息以及动态调用对象的方法的功能称为Java语言的反射机制。学习MFC时，知道MFC中有Runtime的概念。也可以动态生成对象。但是只限于MFC，C++语言本身不支持Runtime的。这样看来Java反射机制功能很强大。
<!--more-->
# 为什么有用？
比如说这样的功能，给定一个对象，和它的一个属性名称，然后需要访问到这个属性的值，你要怎么搞定？注意是程序运行过程中。你可能这样回答：为什么不直接通过obj.property这样的方式去访问呢？这里需要说明下，运行时和非运行时的差别：
- 运行时，代码全部以编译之后的二进制形式加载在内存中，Java的字节码一样，是加载在JVM中的，没有人眼可读的代码。
- 非运行时，代码未经过编译，或者编译之后，还没有加载。这时，对象的属性就写在代码文件中的。
分清楚了两种状态的差别，那么这部分文字开始时提出的通过对象和属性名称去访问属性值的需求中，属性名称其实是一个字符串。你不可能通过obj."property_name"的形式去访问这个属性值的。
也许你还会说，为什么不在代码中写好？既然是动态的，谁能确定什么时候会访问呢？哈哈

## 说点痛苦的经历
当年用MFC写Win32用户界面时，需要遍历窗口里的控件。写过这种程序的同学应该有共鸣，控件的ID虽然在资源库中有名称，但那个全称其实是个宏全称，最后的值是一个个整形数值。宏的名称是有规律的以IDC_EDIT_123这样的形式定义好的。当时有种需求，我可以根据需要动态地生成这样的宏名称，然后把这些宏名称作为参数传递给一些函数，实现对这些控制位置，尺寸的控制。跟上面的运行时对应起来的话，就是说，这些宏的名字是非运行时状态的，当程序运行时，这些宏的名称是不存在的，在内存当中的只有一个个的数字ID。
```
for (int i = 0; i < 5; i++) {
	id = "IDC_EDIT_" + i.toString();
	change_size_by_id(id);
	}
```
也就是上面的代码是不能实现的。
这个需求的在Java中正是可以用到反射机制的地方。
# 代码时间
其实我对Java的使用需求并不强烈。我只是简单地喜欢把技术细节分析给人听。结合下面的例子和之前学习反序列化时的代码，来详细说说Java反射机制的强大。
反射机制允许动态访问任意一对象的属性和方法。属性就是一些字段，记住这种属性必须是公有的，也就是你对对象的这些成员做了属性封装。下面就说明下具体的代码示例。
## 动态访问属性
示例入口类的代码
```
package r3flection_learn;

import java.lang.reflect.Field;

public class r3flection {

	public static void main(String[] args) throws Exception{
		
		TestClass o = new TestClass();
		
		//通过调用get_property函数来访问属性值
		String name = (String)get_property((Object)o, "name");
		
		System.out.println(name);
		

	}
	
	public static Object get_property(Object obj, String filed_name) throws NoSuchFieldException, SecurityException, IllegalArgumentException, IllegalAccessException {
		//利用反谢机制getClass获取运行时的类对象。没错它也是个对象，代表了TestClass运行时的类。
		Class<? extends Object> the_class = obj.getClass();
		
		//利用getFlield得到属性的filed实例
		Field fld = the_class.getField(filed_name);
		
		//利用filed的方法get访问到属性的值
		return fld.get(obj);
	}

}
```

示例要访问的类代码

```
package r3flection_learn;

public class TestClass {
	public String name;
	
	public TestClass() {
		this.name = "lin";
	}
	
	public void print_oneself() {
		System.out.println(this.name);
	}
}
``` 

TestClass类中定义了一个公有属性name和公有方法print_mysql。代码就几行就能实现动态访问属性的功能了。假如有以下场景，类A和类B有一些共同的属性，某一个运行时刻要把这些相同的属性值进行同步，比如把A的值赋给B。需要同步哪些属性，可以通过写一个属性的列表，写一个循环，利用反射机制来完成。
## 动态访问方法
给测试入口类，加一个函数。

```
public static void _1nvoke(Object obj, String method) throws Exception {
	
	Class<? extends Object> c = obj.getClass();
	
	Method m = c.getMethod(method);
	
	m.invoke(obj);
}
```

这个函数就是通过反射机制，按照给出的方法名，触发一个方法的执行。注意方法c.getMethod，使用时，如果调用的方法没有参数，c.getMethod只需要传入一个方法名，类型为字符串的参数。Method类是定义在reflect包中的。

# 总结
研究了下Java反射机制的使用方法。
按照自己的理解给出了适用的场景，写了个小Demo。

