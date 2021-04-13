# 💻 AsmHelp 

## ℹ️ Info ->
    AsmHelp a simple basic help for those who are starting in assembly 
    I am a simple student of assembly and I want to share my knowledge for 
    those who have doubts or want to start.
    
 
## 🆘 Help ->
    Well, the reading is simple ... 
    i'll talk about soon i give an example, real codes in assembly will be seen 
    throughout the  publications that i will be adding here on AsmHelp.
 
## 🤖 Indices ->
    -------------------------
    Basic-Syntax
    -------------------------
    Registers
    -------------------------
    Types and Memmory Allocation
    -------------------------
    Syscalls
    -------------------------

--------------------------------------------------------------------
    
# 📖 Topics >>
    
## Basic Syntax
 
| Basic Syntax | Description |
| --- | --- |
| section .data | ``.Data - section is used for declaring initialized data or constants. This data does change at runtime You can declare various constant values, file names, or buffer size, etc., in this section.`` |
| section .bss | ``.Bss  - section is used for declaring variables`` |
| section .text | ``.Text - section is used for keeping the actual code This section must begin with the declaration global _start, which tells the kernel where the program execution begins.`` |

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
