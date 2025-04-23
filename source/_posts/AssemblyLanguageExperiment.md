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
    - [实验6](#实验6)
      - [实验内容](#实验内容-7)
      - [实验过程及结论](#实验过程及结论-6)
    - [实验7](#实验7)
      - [实验内容](#实验内容-8)
      - [实验过程及结论](#实验过程及结论-7)
    - [实验8](#实验8)
      - [实验内容](#实验内容-9)
      - [实验过程及结论](#实验过程及结论-8)
    - [实验9](#实验9)
      - [实验内容](#实验内容-10)
      - [实验过程及结论](#实验过程及结论-9)

## 实验来源
《汇编语言》（第3版，王爽著）P92
![](/imgs/20250416001.jpg)

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
![](/imgs/20250414-1-expt1-p1.jpg)
![](/imgs/20250414-2-expt1-p2.jpg)
#### 实验过程及结论
1. 
1) Dosbox中默认输入数据时就是十六进制，不需要加入“H”。
2) al、bl代表的是ax寄存器低位（8位）、bx寄存器低位（8位）
3) al/bl进行运算时，如果遇到进位溢出，那么高位不会自动变化，只是改变了标志位。
2. 可利用jmp指令实现循环
3. 由于DosBox是模拟的环境，这里在ROM中查找生产日期的实验未成功，因为FFFF00H~FFFFFH内存地址存的值是空。
4. 在A0000~BFFFF区间写入数据时，指令无效，因为这部分是显存地址的所在空间（A0000~BFFFF）.
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

### 实验6
#### 实验内容
![](/imgs/20250418001-expt6-1.jpg)

#### 实验过程及结论
1.  略
2.  
p155-158中有关7.8的讲解很清晰，这里套用了7.8的代码。
解决7.9中问题的代码如下：
```asm
assume cs:codesg,ds:datasg,ss:stacksg

stacksg segment
    dw 0,0,0,0,0,0,0,0
stacksg ends

datasg segment
    db '1. display      '
    db '2. brows        '
    db '3. replaces     '
    db '4. modify       '
datasg ends

codesg segment
start:  mov ax,stacksg
        mov ss,ax
        mov sp,16
        mov ax,datasg
        mov ds,ax
        mov bx,0

        mov cx,4
s0:     push cx
        mov si,3

        mov cx,4
s:      mov al,[bx+si]
        and al,11011111b
        mov [bx+si],al
        inc si
        loop s

        add bx,16
        pop cx
        loop s0

    mov ax,4c00h
    int 21h
codesg ends

end start
```
程序执行前datasg值如下图：
![](/imgs/20250418002-expt6-2.jpg)
程序执行后datasg值如下图：
![](/imgs/20250418003-expt6-3.jpg)


### 实验7
#### 实验内容
![](/imgs/2025042301-expt7-1.jpg)
![](/imgs/2025042302-expt7-2.jpg)
![](/imgs/2025042303-expt7-3.jpg)
#### 实验过程及结论
最终代码
```masm
assume ds:data,ss:stack,es:table,cs:code
data segment
    db '1975','1976','1977','1978','1979','1980','1981','1982','1983','1984'
    db '1985','1986','1987','1988','1989','1990','1991','1992','1993','1994','1995'
    ;以上为表示 年份 的字符串

    dd 16,22,382,1356,2390,8000,16000,24486,50065,97479
    dd 140417,197514,345980,590827,803530,1183000,1843000,2759000,3753000,4649000,5937000
    ;以上为表示 收入 的字符串

    dw 3,7,9,13,28,38,130,220,476,778
    dw 1001,1442,2258,2793,4037,5635,8226,11542,14430,15257,17800
    ;以上为表示 雇员数 的字符串

data ends

stack segment
    dw 0,0,0,0,0,0,0,0
    ;提前申请栈空间
stack ends

table segment
    db 21 dup('year summ ne ?? ')
    ;data段中数据最终要写入的数据段

table ends

code segment

start:  
    mov ax,data
    mov ds,ax

    mov ax,stack
    mov ss,ax
    mov sp,16

    mov ax,table
    mov es,ax

    mov di,0
    mov cx,21
    ;di：行号-1，共21行，di的最大值为20。使用di来标记当前操作的行号（或者年份），di=0为1975年，di=1为1976年，以此递推，

s0: push cx
    mov bx,0        
    mov cx,di

s1: add bx,16
    loop s1
    ;在table段中，不同个表结构是连续存放的，每个表结构16字节
    ;计算当前要操作的表结构偏移地址bx,bx=di*16

    mov dx,0
    mov cx,di
s2: add dx,4         
    loop s2
    
    ;在data段中，同一个字段是连续存放的，“年份”字段每个字段占4个字节，
    ;计算当前要操作的data段中“年份”字段偏移地址bx=di*4
    ;先保存现有的bx值，因为等会儿其它操作需用到bx
    ;如果把"push bx"放到复制年份的循环中，栈不平衡（push少pop多），
    ;为了栈平衡，这里做了改动，ds段的偏移值计算出后先用dx存储（因为dx暂时用不到，其它x类寄存器要用到），到循环中后再对bx进行push、pop操作

    mov cx,4
    mov si,0       
    ;“年份”字段是用db定义的，每个字段有4个字节，每次操作1个字节，用al，每个字段需重复操作4次，cx=4
s3: push bx
    mov bx,dx
    mov al,ds:[bx].0h[si]  
    pop bx
    mov byte ptr es:[bx].0h[si],al
    inc si
    loop s3

    ;复制年份
    ;es:[bx].0h[si]， 其中 bx：table不同行的基址，                             0h：该行中不同字段的基址，        si：该字段中不同字符的基址
    ;ds:[bx].54h[si]，其中 bx：di x 字段长度，某字段连续空间中该字段不同行的基址  0h：不同字段连续空间的基址，      si：该字段中不同字符的基址

    push bx
    mov bx,0
    mov cx,di
s4:add bx,4         
    loop s4
    ;“收入”字段是用dd定义的，每个字段占了2个字，4个字节，每次操作1个字（2字节），用2个寄存器，每个字段需操作1次
 
    mov ax,ds:[bx].54h[0]
    mov dx,ds:[bx].54h[2] 
    pop bx
    mov word ptr es:[bx].5h[0],ax
    mov word ptr es:[bx].5h[2],dx
    ;复制收入

    push bx
    mov bx,0
    mov cx,di
s5: add bx,2        
    loop s5
    ;“雇员数”字段是用dw定义的，每个字段占了2个字节，每次操作1个字（2字节），用1个寄存器，每个字段需操作1次
    ;计算当前要操作的data段中“年份”字段偏移地址bx=di*2

    mov ax,ds:[bx].0a8h
    pop bx
    mov word ptr es:[bx].0ah,ax
    ;复制雇员数

    ;人均收入=收入/雇员数，被除数4字节，用dx存高位，ax存低位，除数2字节，用bx存储，商存到ax中，余数存到dx中
    mov dx,es:[bx].7h
    mov ax,es:[bx].5h
    mov cx,es:[bx].0ah
    div cx
    mov word ptr  es:[bx].0dh,ax
    ;依次计算人均收入并填入

    inc di
    pop cx
    loop s0
    
    mov ax,4c00h
    int 21h
code ends
end start

```
结果图
![](/imgs/2025042304-expt7-4.jpg)

在完成该实验的过程中犯了很多大大小小的错误哈哈哈，将犯了错的知识点总结如下：
1.数据类型与空间大小对应
data段中定义数据时，使用db、dw、dd定义的数据类型大小各不同，在对数据进行复制时需注意按照数据类型进行指定操作，
如：db定义的是byte，1字节，dw定义的是word，2字节，dd定义的是dword，4字节。
在进行复制操作时，db需用半个寄存器，比如al、ah等，dw需用1个寄存器，如ax、bx等，dd需用两个寄存器。
从寄存器➡内存地址时，需指定类型，这样系统才知道要复制多少个字节；
从内存地址➡寄存器时，不需指定，因为默认会按寄存器复制相应的数据，如al复制1个字节，ax则复制2个字节。

2.栈使用
使用栈操作push、pop时，需注意“栈平衡”，不然值可能不是你想要的，操作时细心一些就好。

3.使用灵活的定位内存地址方法时，注意只有特定寄存器（bx、si、di、bp）才能进行定位操作，且需注意每个寄存器的特点。

4.除法操作，需注意不同位数下被除数、除数、商、余数的存放位置。


### 实验8
#### 实验内容
![](/imgs/2025042305-expt8-1.jpg)
#### 实验过程及结论
![](/imgs/2025042308-expt8-2.jpg)
程序可以正确返回，运行过程如下：
（为了方便叙述，采用上图中的行号）
程序开始，运行到r5（第5行，后面也这样写，实际这里是cs:00）
r6 无操作
r7 无操作
r8 将s的偏移地址赋给di
r9 将s2的偏移地址赋给si
r10 将s2指向的代码赋给ax
r11 将ax的值赋给s所在位置，即第6行所在位置
r12 段内短转移至s位置，此时s位置为 jmp short s1.因为jmp short XXX语句记录的相对位移。
在s2处的jmp short s1，相对位移是address(s1)-address(s2)，这里位移是上移3位（-3）
。此时该语句在s位置，s位置上移3位就是r3的mov ax,4c00h。
从这里开始执行，最后执行为int 21h，程序结束。可将代码编译、链接为.exe文件进行debug调试，在执行到r12，后面是r6，执行完r6之后，直接就是r3，ax没被置为0，被置为了正常退出的值4c00h。
![](/imgs/2025042309-expt8-3.jpg)

### 实验9
#### 实验内容
![](/imgs/2025042305-expt8-1.jpg)
![](/imgs/2025042306-expt9-1.jpg)
![](/imgs/2025042307-expt9-2.jpg)
#### 实验过程及结论
根据实验描述，编辑代码如下：
```asm
assume cs:code,ds:data
data segment
db 'HELLO DOSBOX!'
data ends

code segment
start:
    mov ax, 0B800h
    mov es, ax
    mov di, (12 * 80 + 35)*2  
    ;第12行第35列（居中）

    mov ax,data
    mov ds,ax
    mov si,0
    mov cx,13
s:  
    mov al,ds:[si]
    inc si
    mov es:[di],al
    mov byte ptr es:[di+1], 0cah
    add di,2
    loop s

    mov ax, 4C00h
    int 21h
code ends
end start
```
这里我的内容没有和书上一样，而是改成了"HELLO DOSBOX!"，效果图如下：
![](/imgs/2025042309-expt8-3.jpg)
![](/imgs/2025042310-expt9-4.gif)



