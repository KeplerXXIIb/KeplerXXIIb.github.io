---
title: 汇编语言实验过程记录202504（持续更新中）
date: 2025-04-16
cover_image: /imgs/20250416001.jpg
categories: tech-blog
tags:
  - CS
---
# 汇编语言实验过程记录
##目录
- [汇编语言实验过程记录](#汇编语言实验过程记录)
  - [实验来源](#实验来源)
  - [相关链接](#相关链接)
- [【模板】](#模板)
    - [实验X](#实验x)
      - [实验内容](#实验内容)
      - [实验过程及结论](#实验过程及结论)
  - [实验内容](#实验内容-1)
    - [实验1](#实验1)
      - [实验内容](#实验内容-2)
      - [实验过程及结论](#实验过程及结论-1)
    - [实验2](#实验2)
      - [实验内容](#实验内容-3)
      - [实验过程及结论](#实验过程及结论-2)
    - [实验3](#实验3)
      - [实验内容](#实验内容-4)
      - [实验过程及结论](#实验过程及结论-3)
    - [实验4](#实验4)
      - [实验内容](#实验内容-5)
      - [实验过程及结论](#实验过程及结论-4)
    - [实验5](#实验5)
      - [实验内容](#实验内容-6)
      - [实验过程及结论](#实验过程及结论-5)

## 实验来源
《汇编语言》（第3版，王爽著）P92
![](/imgs/20250416001.jpg?width=10&height=10)

## 相关链接
https://www.dosbox.com
https://www.masm32.com/index.htm
https://github.com/froginwell/assembly
https://www.bilibili.com/video/BV1cb411L7Hv/?spm_id_from=333.337.search-card.all.click&vd_source=5e2a8b05cdeecce93e566eee1d4ecbea
https://www.masm32.com/index.htm

# 【模板】
_____________模板
### 实验X
#### 实验内容
#### 实验过程及结论
1.  
2.  
![](/imgs/XXXXXXXXXXX)
_____________模板

## 实验内容
### 实验1
#### 实验内容
![](/imgs/20250414-1-expt1-p1.jpg=10x10)
![](/imgs/20250414-2-expt1-p2.jpg){:width="10px" height="10px"}
#### 实验过程及结论
1. 
1) Dosbox中默认输入数据时就是十六进制，不需要加入“H”。
2) al、bl代表的是ax寄存器低位（8位）、bx寄存器低位（8位）
3) al/bl进行运算时，如果遇到进位溢出，那么高位不会自动变化，只是改变了标志位。
2. 可利用jmp指令实现循环
3. 由于DosBox是模拟的环境，这里在ROM中查找生产日期的实验未成功，因为FFFF00H~FFFFFH内存地址存的值是空。
4. 在A0000~BFFFF区间写入数据时，指令无效，因为这部分是显存地址的所在空间（A0000\~BFFFF）.
![](/imgs/20250414-3-expt1-p3.jpg)

### 实验2
#### 实验内容
![](/imgs/20250414-4-expt2-p1.jpg)
![](/imgs/20250414-5-expt2-p2.jpg)
#### 实验过程及结论
1.  
1) 
  ax=C0EA,ax=C0FC;
  bx=30F0,bx=6021;
  ss=2200,sp=00FE,修改的内存单元的地址是2200:00FE、2200:00FF;内容为C0FC;
  ss=2200,sp=00FC,修改的内存单元的地址是2200:00FC、2200:00FD;内容为6021'
  sp=00FE,ax=6021;
  sp=0100,ax=6021;
  ss=2200,sp=00FE,修改的内存单元的地址是2200:00FE、2200:00FF;内容为F030;
  ss=2200,sp=00FC,修改的内存单元的地址是2200:00FC、2200:00FD;内容为312F；

2.  为什么2000:0\~2000:f的内容会发生变化？
ss:sp指向的地址是2000:0010，此时2000:0000 0010存储的是下一条要执行的指令的地址信息（即CS、IP等寄存器的信息）

### 实验3
#### 实验内容
![](/imgs/20250415-1-expt3-p1.jpg)

#### 实验过程及结论
1. 
2. 
  ![](/imgs/20250416-1-expt3-p2.jpg)
  ![](/imgs/20250416-2-expt3-p3.jpg)
  ![](/imgs/20250416-3-expt3-p4.jpg)
3. 
用debug加载t1.exe，查看PSP内容。可参考P92。
操作系统调用DosBox（这里是使用dosbox模拟x8086 16位，下一步这里直接写成DOS，就不再写DosBox套娃了），DOS调用command，command调用debug.exe，debug调用t1.exe。
程序段前缀PSP(Program Segment Prefix)与程序区虽然内存地址连续，但是段地址不同。其中PSP大小256字节。设PSP地址为SA:0，程序区地址则为SA+10H:0。
CS:IP存储CPU要执行的下一条指令，根据2.可知，程序段段地址为076AH:0，所以PSP地址为075AH:0。使用debug中"-d"语句查看该地址内存内容得下图，头两个字节即CD 20。
  ![](/imgs/20250416-4-expt3-p5.jpg)

### 实验4
#### 实验内容
![](/imgs/20250416-5-expt4-p1.jpg)
![](/imgs/20250416-6-expt4-p2.jpg)
#### 实验过程及结论
1.  
![](/imgs/20250416-7-expt4-p3.jpg)
2.  
  在做part2时，遇到了几个问题。
![](/imgs/20250416-8-expt4-p4.jpg)

1) 忘记了立即数不能直接传给段寄存器，我把立即数传给ds报错；
2) 使用"段:\[偏移地址]"表示地址时，"\[]"只能填index或寄存器，我填了寄存器的低位，报错；
3) 在改正2)和3)后，可以成功编译、链接、生成exe文件。但是执行时DOS窗口卡住无法输入，关掉重试后，DOS窗口还是卡住，DOS状态窗口直接报错：非法读取。
![](/imgs/20250416-11-expt4-p7.jpg)
最后的问题3)，在分析报错+DeepSeek搜索后发现错误，地址换算错了，取到的地址为2h，这部分内存地址不可随意写入，已解决。
![](/imgs/20250417-1-expt4-p9.jpg)
![](/imgs/20250416-9-expt4-p5.jpg)
![](/imgs/20250416-10-expt4-p6.jpg)
3.  
![](/imgs/20250416-12-expt4-p8.jpg) 
补充的两个空分别为 ss,10。
1) 赋值的是汇编代码的二进制表示，从 mov ax,ss 到loop s。
2) 通过debug>-d 0:200可查看最后占用的内存地址，从而计算出复制的字节数

### 实验5
#### 实验内容
![](/imgs/20250417-1-expt5-p1.jpg)
![](/imgs/20250417-2-expt5-p2.jpg)
![](/imgs/20250417-3-expt5-p3.jpg)
![](/imgs/20250417-4-expt5-p4.jpg)
![](/imgs/20250417-5-expt5-p5.jpg)
#### 实验过程及结论
1.  
程序执行前debug -r如图：
![](/imgs/20250417-6-expt5-p6.jpg)

程序执行前，三个段的内容如下：
![](/imgs/20250417-9-expt5-p9.jpg)
![](/imgs/20250417-10-expt5-p10.jpg)

程序执行后，三个段的内容如下：
![](/imgs/20250417-7-expt5-p7.jpg)
![](/imgs/20250417-8-expt5-p8.jpg)


1) 程序返回前，data段中的数据组成如图：
![](/imgs/20250417-7-expt5-p7.jpg)
组成部分有原来的数据+不知名数据+DOS中的PSP段。
1) cs:076Ch、ss:076Bh、ds:076Ah。
  data：076A，
  Stack：076B，
  Code：076C。
1) code段地址X，则data段地址为X-2，stack段地址为X-1。

2.  
程序执行前debug -r如图：
![](/imgs/20250417-11-expt5-p11.jpg)

程序执行前，三个段的内容如下：
![](/imgs/20250417-12-expt5-p12.jpg)
![](/imgs/20250417-13-expt5-p13.jpg)

程序执行后，三个段的内容如下：
![](/imgs/20250417-14-expt5-p14.jpg)
![](/imgs/20250417-15-expt5-p15.jpg)

1) 见程序执行前的段内容截图
2) 见程序执行后的段内容截图
3) code段地址X，则data段地址为X-2，stack段地址为X-1。
  data：076A，
  Stack：076B，
  Code：076C。
  虽然分配了3个段，但是每个段的长度并不一样，而是根据数据的长度灵活分配的。
4) ⌈N/16⌉*16 字节
   
5. 
程序执行前debug -r如图：
![](/imgs/20250417-16-expt5-p16.jpg)

程序执行前，三个段的内容如下：
![](/imgs/20250417-17-expt5-p17.jpg)
![](/imgs/20250417-18-expt5-p18.jpg)

程序执行后，三个段的内容如下：
![](/imgs/20250417-19-expt5-p19.jpg)
![](/imgs/20250417-20-expt5-p20.jpg)

1) 见程序执行前的段内容截图
2) 见程序执行后的段内容截图
3) code段地址X，则data段地址为X-2，stack段地址为X-1。
  Code：076A，
  data：076D，
  Stack：076E。

这次出数据后我发现两个可疑的点，
1、空白（无操作）区域数据不对劲。
之前的实验，空白区域一般都是0，但这次不是0，有可能是因为我结束上次实验后没有重启dosbox，RAM区域里还有之前实验的数据残留。
2、为什么code段与data段系统分配时隔了3？
图中 CD:21 说明有一个段是PSP，之前教材上说PSP为256字节（p92），这里没有规定段长，可以将PSP定为一个段呀，为什么段号相隔了3？

带着疑问，我重启了DOSBox又来了一次，结果如下。
程序执行前debug -r、段的内容如下：
![](/imgs/20250417-21-expt5-p21.jpg)

程序执行后，三个段的内容如下：
![](/imgs/20250417-22-expt5-p22.jpg)
![](/imgs/20250417-23-expt5-p23.jpg)

做完发现结论和上次一致。但是这个CD 21还是没懂，截止到这章节教材没有深入，只说CD 21 和PSP有密切联系。最后请来了deepseek答疑解惑：
![](/imgs/20250417-24-expt5-p24.jpg)
结论如下：
![](/imgs/20250417001.jpeg
1、CD21即汇编指令"int 21H"在内存中存储的形式。debug中用-u即可查看。
2、PSP是DOS管理程序的核心数据结构，这里段号隔了3，是因为代码长度计算后需要占用3个段（3x16字节）。
3、​​INT 21h(CD 21)是DOS系统的核心功能调用入口

4) (3)可以正确执行，因为有没有start，程序开始执行的位置都一样。其它的执行失败，未执行到程序段中的语句，执行到了其它不知来源的语句。
  失败的运行结果如下图：（这里只贴了其中一个）
  ![](/imgs/20250417-28-expt5-p28.jpg)
  成功的（3）如下图：
  ![](/imgs/20250417-29-expt5-p29.jpg)

5. 写了代码，运行成功
```asm
assume cs:code,ds:a,ss:b,es:c

a segment
    db 1,2,3,4,5,6,7,8
a ends

b segment
    db 1,2,3,4,5,6,7,8
b ends

c segment
    db 0,0,0,0,0,0,0,0
c ends

code segment

start:  
        mov bx,0
        mov cx,8

s:      mov ax,a
        mov ds,ax
        mov dx,ds:[bx]

        mov ax,b
        mov ss,ax
        add dx,ss:[bx]

        mov ax,c
        mov es,ax
        mov es:[bx],dx
        inc bx
        loop s

    mov ax,4c00h
    int 21h
code ends

end start
```
![](/imgs/20250417-30-expt5-30.jpg)
```asm
```

6. 写了代码，运行成功
```asm
assume cs:code,ds:a,ss:b

a segment
    dw 1,2,3,4,5,6,7,8,9,0ah,0bh,0ch,0dh,0eh,0fh,0ffh
a ends

b segment
    dw 0,0,0,0,0,0,0,0
b ends

code segment

start:  
        mov ax,b
        mov ss,ax
        mov sp,16

        mov bx,0
        mov cx,8

s:      mov ax,a
        mov ds,ax
        mov ax,ds:[bx]
        push ax
        add bx,2
        loop s
    mov ax,4c00h
    int 21h
code ends

end start
```
![](/imgs/20250417-31-expt5-31.jpg)


