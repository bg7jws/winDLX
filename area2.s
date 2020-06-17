;实现求椭圆的面积
.data
Prompt:         .asciiz         "ellipse area:\n\n"
Prompt1:	       .asciiz 	     "pi:  "
Prompt2:        .asciiz         "a radius:  "
Prompt3:	       .asciiz 	     "b radius:  "
Prompt4:        .asciiz         "\n\nresult: "

;*** Data for printf-Trap
PrintfFormat:  	.asciiz 	     "%lf\n\n"
		        .align		  4
PrintfPar:	        .word   	     PrintfFormat
PrintfValue:	    .space		  8
PrintfPar2:       .space          4

.text
.global main

main:
;
addi            r1,r0,Prompt          ;将Prompt写入寄存器R1
sw              PrintfPar2,r1         ;
addi            r14,r0,PrintfPar2     ;将PrintPar2写入R14
trap            5                     ;自陷调用5

;第一个操作数               
addi            r1,r0,Prompt1         ;将Prompt1写入寄存器R1 
jal             InputDouble           ;调用输入函数输入第一个双精度浮点数
movd           f8,f2                  ;将第一个操作数写入f8中

;第二个操作数
addi           r1,r0,Prompt2          ;将Prompt2写入寄存器R1
 jal            InputDouble           ;调用输入函数输入第二个双精度浮点数
movd           f4,f2                  ;将第二个操作数写入f4中

;第三个操作数
addi           r1,r0,Prompt3          ;将Prompt3写入寄存器R1
 jal            InputDouble           ;调用输入函数输入第三个双精度浮点数
movd           f6,f2                  ;将第三个操作数写入f6中


;运算环节 
multd           f4,f4,f8              ;f4、f8两数相乘结果存入f4 PI*a
multd           f4,f4,f6              ;f4继续乘以b
;multd           f4,f4,f10             ;此行不再使用

;格式化为标准输出             
 addi            r1,r0,Prompt4         ;
 sw             PrintfPar2,r1          ;
 addi            r14,r0,PrintfPar2     ;
 trap            5                     ;
 sd	            PrintfValue,f4     ;
addi	        r14,r0,PrintfPar       ;
 trap	        5                      ;
 j              main                   ;转到main




此程序完全根据球体表面积程序修改完成。
第一部分，数据段定义所有需要显示的字符串。
第二部分，数据段定义显示格式和变量空间
主程序首先显示提示信息prompt
然后提示输入PI值存入F8，而后输入椭圆半轴A和B分别存入F4和F6
椭圆面积公式为PI*A*B，即F8*F4存入F4,再执行F6*F4存入F4.
最后格式化输出result后面跟上F4的值。
J main重新开始执行可进行下一次计算。
此程序在windowsXP环境下安装windlx，将area2.s和inputdouble.s同时调入内存运行正常，计算正确。
