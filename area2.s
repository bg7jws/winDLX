;ʵ������Բ�����
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
addi            r1,r0,Prompt          ;��Promptд��Ĵ���R1
sw              PrintfPar2,r1         ;
addi            r14,r0,PrintfPar2     ;��PrintPar2д��R14
trap            5                     ;���ݵ���5

;��һ��������               
addi            r1,r0,Prompt1         ;��Prompt1д��Ĵ���R1 
jal             InputDouble           ;�������뺯�������һ��˫���ȸ�����
movd           f8,f2                  ;����һ��������д��f8��

;�ڶ���������
addi           r1,r0,Prompt2          ;��Prompt2д��Ĵ���R1
 jal            InputDouble           ;�������뺯������ڶ���˫���ȸ�����
movd           f4,f2                  ;���ڶ���������д��f4��

;������������
addi           r1,r0,Prompt3          ;��Prompt3д��Ĵ���R1
 jal            InputDouble           ;�������뺯�����������˫���ȸ�����
movd           f6,f2                  ;��������������д��f6��


;���㻷�� 
multd           f4,f4,f8              ;f4��f8������˽������f4 PI*a
multd           f4,f4,f6              ;f4��������b
;multd           f4,f4,f10             ;���в���ʹ��

;��ʽ��Ϊ��׼���             
 addi            r1,r0,Prompt4         ;
 sw             PrintfPar2,r1          ;
 addi            r14,r0,PrintfPar2     ;
 trap            5                     ;
 sd	            PrintfValue,f4     ;
addi	        r14,r0,PrintfPar       ;
 trap	        5                      ;
 j              main                   ;ת��main




�˳�����ȫ�����������������޸���ɡ�
��һ���֣����ݶζ���������Ҫ��ʾ���ַ�����
�ڶ����֣����ݶζ�����ʾ��ʽ�ͱ����ռ�
������������ʾ��ʾ��Ϣprompt
Ȼ����ʾ����PIֵ����F8������������Բ����A��B�ֱ����F4��F6
��Բ�����ʽΪPI*A*B����F8*F4����F4,��ִ��F6*F4����F4.
����ʽ�����result�������F4��ֵ��
J main���¿�ʼִ�пɽ�����һ�μ��㡣
�˳�����windowsXP�����°�װwindlx����area2.s��inputdouble.sͬʱ�����ڴ�����������������ȷ��
