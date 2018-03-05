---
title: 使用iText提取PDF文档中特定信息
date: 2018-3-4  17:19:00
tags: 
- 数据提取
- Java
author: Lin
---
## 1 简介
[itextpdf](https://github.com/itext/itextpdf)是一款基于Java/.Net语言的专业的PDF处理工具，大多数场景下用于网站上在线生成PDF文档。网上可以找到很多PDF数据提取工具，但大多数只能简单的把PDF文档中的文字转换为纯文本，原有的PDF文档的排版，文档结构没有办法保留。工作中遇到一些场景，需要把PDF文档中的特定部分然后调用google翻译，翻译其中的一部分。现有的工具都没有办法满足需求。所以决定研究下itextpdf的源码，进行开发，提取想要的数据。

## 2 基本的例子
在网上随便百度一下，找到的例子是这样的：利用itextpdf中的PdfTextExtractor对PDF内容的文本进行了提取。
<!--more-->
```
package ulin.pdf_parser;

import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;


import com.itextpdf.text.pdf.PdfReader;
import com.itextpdf.text.pdf.parser.PdfTextExtractor;

/**
 * Hello world!
 *
 */
public class App 
{
    public static void main( String[] args ) throws FileNotFoundException, IOException
    {
        
    	String pdf = "test.pdf";
        PdfReader pdfReader = new PdfReader(new FileInputStream(pdf));
        //FileOutputStream outfs = new FileOutputStream(pdf + ".txt");
      
        
        System.out.println("number of pages:" + pdfReader.getNumberOfPages())
        int pageNumber = pdfReader.getNumberOfPages();

        for(int i = 1; i <= pageNumber; i++)
        {
        	//System.out.println(PdfTextExtractor.getTextFromPage(pdfReader, i).replace("\t", " "));
        	System.out.println("Page:" + i);
        	String content = PdfTextExtractor.getTextFromPage(pdfReader, i);
        	//System.out.println(content.replace("\t", " "));
        	
        	byte[] pageContent = content.replace("\t", " ").getBytes();
        	//outfs.write(pageContent);
        	//outfs.close();
        }
        pdfReader.close();
    }
}

```
## 3 想要提取的文档类型
想要提取的文档如下:  
1 目录
1.1 概述
1.1.1 aaaa
* desc:
* * this is a test document!
```
#!/bin/bash 
some code
```
* summery
比如要提取1.1.1标题和desc,及对应的代码（**各部分对应的字体是不一样的**,如果字体是一样的，这个文档的排版就太差了）。进行翻译时，code部分内容是不翻译的，如果按照基本的提取方式，把所有的文档提取出来，那么代码的正常的文字就混在了一起，没有办法调用Google翻译了。
## 4 思路
为弄清楚要怎么提取这样文本特征，研究了下，基本例子中内容的提取流程。
PdfTextExtractor.getTextFromPage(pdfReader, i)函数的定义如下:
```
    public static String getTextFromPage(PdfReader reader, int pageNumber) throws IOException{
        return getTextFromPage(reader, pageNumber, new LocationTextExtractionStrategy());
    }
```
函数传入了一个LocationTextExtractionStrategy对象。
通过高度跟踪调用，最终找到是通过LocationTextExtractionStrategy对象的renderText函数完成对文本的渲染（提取）。
```
 public void renderText(TextRenderInfo renderInfo) {
    	LineSegment segment = renderInfo.getBaseline();
    	if (renderInfo.getRise() != 0){ 
	    	Matrix riseOffsetTransform = new Matrix(0, -renderInfo.getRise());
	    	segment = segment.transformBy(riseOffsetTransform);
    	}
    	//DocumentFont df = renderInfo.getFont(); 此行代码用来调试，显示字体
        TextChunk tc = new TextChunk(renderInfo.getText(), tclStrat.createLocation(renderInfo, segment));
        locationalResult.add(tc);        
    }
```
刚好PdfTextExtractor也提供了getTextFromPage的另外一种形式：
```
String content = PdfTextExtractor.getTextFromPage(pdfReader, i, new MyExtractor());
```
那么就可以通过自定义一个与LocationTextExtractionStrategy相似的类来实现基于字体实现对文本提取了。把LocationTextExtractionStrategy类的代码拷贝过来，然后修改renderText方法就可以了。
## 5 解决
通过自定义的MyExtractor类，调试代码，发现需要提取的文本的字体名称，然后根据这些名称，对输出的文本进行过滤，就能得到想要的数据了。如下是我调试时输出的信息，输出的字体名称为:ABCDEE+Cambria-Bold,Cambria-Bold才是字体名称，前面的ABCDEF是文档自己生成的，结构相似的文档输出的结果中，"+"号前的字符串是不同的，主要依靠后面的字体名称来区分。
```
font:ABCDEE+Cambria-Bold
font:ABCDEE+Cambria-Bold
font:ABCDEE+Cambria-Bold
font:ABCDEE+Cambria-Bold
font:ABCDEE+Cambria-Bold
font:ABCDEE+Cambria-Bold
font:ABCDEE+Cambria-Bold
font:ABCDEE+Cambria-Bold
font:ABCDEE+Cambria-Bold
font:SymbolMT
font:ABCDEE+Cambria
font:ABCDEE+Cambria
font:ABCDEE+Cambria
font:ABCDEE+Cambria
font:ABCDEE+Cambria
font:ABCDEE+Cambria
font:ABCDEE+Cambria
```
同一个字体的信息是连续的，但是1个字符接1个字符的样式渲染的，所以真正提取，还要加一些处理，识别当前字体发生变化的位置，把标记信息附加进去，就能把格式信息保留下来了。
## 6 总结
同样是基于开源项目来解决手头的问题。虽然解决过程有点波折，但还是挺有成就感的。
