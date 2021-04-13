# 💻 AsmHelp 

## ℹ️ Info \
    AsmHelp a simple basic help for those who are starting in assembly 
    I am a simple student of assembly and I want to share my knowledge for 
    those who have doubts or want to start.
    
 
## 🆘 Help \
    Well, the reading is simple ... 
    i'll talk about soon i give an example, real codes in assembly will be seen 
    throughout the  publications that i will be adding here on AsmHelp.
    
## 🤖 Indices \
   | ?  | Description |
   | -- | -- |
   | Basic-Syntax | Basic syntax in assembly sections |
   | Registers | Registers in assembly are for general data manipulation | 
   | Types and Memmory Allocation |  Types and Memmory Allocation |
   | Syscalls | syscalls call the kernel |
   

--------------------------------------------------------------------
    
# 📖 Topics >>
    
## Basic Syntax
 
| Basic Syntax | Description |
| --- | --- |
| section .data | .Data - section is used for declaring initialized data or constants. This data does change at runtime You can declare various constant values, file names, or buffer size, etc., in this section. |
| section .bss | .Bss  - section is used for declaring variables |
| section .text | .Text - section is used for keeping the actual code This section must begin with the declaration global _start, which tells the kernel where the program execution begins. |

```
Comment in asm using ";"
Assembly language statements are entered one statement per line. format −

Label   Mnemonic   Operands   ;Comment
```

```assembly
; Example                       
                               
section .data                  
                              
section .bss                   
                              
section .text                  
    global _start:              
                               
start:                         

```
--------------------------------------------------------------------------------
Ps -> Compiller using  ```nasm -f elf64 <file> && ld <file.o> -o <file> ``` 

--------------------------------------------------------------------------------
I made a script in shellscript where you can compile quickly
I will leave it on git to use it, just do the following```_nasm file.asm file 64``` if  system for 32 bits replaces 64 for 32
