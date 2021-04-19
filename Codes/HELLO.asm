section .data
   msg db "Hello, Word!!", 0xa ;Declaring_variable 
   len equ $-msg ;Size of bytes 

section .text
   global _start

_start:
  
   mov edx, len ; Moving len to edx
   mov ecx, msg ; Moving msg to ecx
   mov ebx, 1 ; Stdout to ebx
   mov eax, 4 ; Moving sys_write to eax 
   int 0x80; Call Kernel

   mov eax, 1; moving sys_exit to eax
   int 0x80; Call Kernel
