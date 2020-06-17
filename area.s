;实现求球体面积
.data
Prompt:         .asciiz         "Sphere surface area:\n\n"
Prompt1:	       .asciiz 	     "pi:  "
Prompt2:        .asciiz         "parameter:  "
Prompt3:	       .asciiz 	     "radius:  "
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
multd           f4,f4,f8              ;f4、f8两数相乘结果存入f4
multd           f10,f6,f6             ;f6自乘写入f10
multd           f4,f4,f10             ;f4、f10两数相乘结果存入f4中

;格式化为标准输出             
 addi            r1,r0,Prompt4         ;
 sw             PrintfPar2,r1          ;
 addi            r14,r0,PrintfPar2     ;
 trap            5                     ;
 sd	            PrintfValue,f4     ;
addi	        r14,r0,PrintfPar       ;
 trap	        5                      ;
 j              main                   ;转到main
