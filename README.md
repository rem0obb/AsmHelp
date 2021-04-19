# 💻 About the project
AsmHelp a simple basic help for those who are starting in assembly 
I am a simple student of assembly and I want to share my knowledge for 
those who have doubts or want to start.
We're covering here in this project just the `Linux(ELF) Assembly Intel x86`.
Feel free to have a look at [Assembly x86_64](https://www.cs.uaf.edu/2017/fall/cs301/reference/x86_64.html)

##### Note: To this guide, we gonna use `nasm` and `ld`. Search how to install them in you linux distribution. You can use `nasm` and `ld` manually, but I made a script to automate the building process of our executable. You dont need to use, but is there anyway. Just do the following `./simplenasm file.asm out.out`

# Index
   - [Basic Syntax](#basic-syntax)
   - [Sections](#basic-sections)
   - [Registers](#registers)
   - [Syscalls](#syscalls)
   - [Types-Memory-Allocation](#types-memory-allocation)
   - [Stack](#stack)
   - [Heap](#heap)
 
# Basic Syntax
Basically a assembly instruction is made by a `mnemonic register1, register2`, and we just keep putting and taking out values form these registers.
That `mnemonic` is a assembly instruction that will make some operation between (usually) two registers.

```asm
mov eax, ebx ; Will move the value from ebx to eax
```

There you know two basics registers, `eax` and `ebx` also that the `;` can be used to create comments

# Basic Sections
[`"Roughly, a section is a range of addresses, with no gaps; all data "in" those addresses is treated the same for some particular purpose."`](https://ftp.gnu.org/old-gnu/Manuals/gas-2.9.1/html_chapter/as_4.html).
Keeping it simple, basically are memory spaces that you can separate your instructions. Below we have some basics sections that must have in you code.
We define them using the keyword `section <name>`.


| Sections | Description |
| --- | --- |
| .data | .data - section is used for declaring initialized data or constants. This data does change at runtime you can declare various constant values, file names, or buffer size, etc., in this section. |
| .bss | .bss  - section is used for declaring uninitialized variables |
| .text | .text - section is used for keeping the actual code This section must begin with the declaration `global _start`, which tells to the linker the *entry point* of the program and then it'll starts the execution from that point. |

# Registers
First of all, what is a register?  [`"A processor register is a quickly accessible location available to a computer's processor. Registers usually consist of a small amount of fast storage, although some registers have specific hardware functions, and may be read-only or write-only."`](https://en.wikipedia.org/wiki/Processor_register). But following the logic of being simple, its basically a fast access "variable" that you can put or remove values.
In the x86 architecture we have 8 general purpose registers. Strong recommend [this](http://www.cs.virginia.edu/~evans/cs216/guides/x86.html) and [this](https://en.wikibooks.org/wiki/X86_Assembly/X86_Architecture) for a better understanding, not only for registers, but assembly in general.
The registers are the following:

| Register | Description |
| --- | --- |
| eax | Accumulator register -  Used in arithmetic operations |
| ebx | Base register - Used as a pointer to data |
| ecx | Counter register - Used in shift/rotate instructions and loops |
| edx | Data register - Used in arithmetic operations and I/O operations |
| esi | Source Index register - Used as a pointer to a source in stream operations |
| edi | Destination Index register -  Used as a pointer to a destination in stream operations |
| esp | Stack Pointer register - Pointer to the top of the stack |
| ebp | Stack Base Pointer register - Used to point to the base of the stack |

But most of the registers have lost their special purposes in the modern instruction set, except for `esp` and `ebp`.

# SysCalls

what is a syscall? well a syscall or system call are APIs for the interface between user space and kernel space. We already use system calls.we've already seen registers and the mov instruction respectively.

You can make use of Linux system calls in your assembly programs. You need to take the following steps for using Linux system calls in your program - 

   
    * Put the system call number in the EAX register.
    * Store the arguments to the system call in the registers EBX, ECX, etc.
    * Call the relevant interrupt (80h).
    * The result is usually returned in the EAX register.

The following table shows some of the system calls used in this tutorial -


|  %eax 	|  Name 	|  %ebx 	|  %ecx 	|  %edx |   %esx  |  %edi   |
| --- | --- | --- | --- | --- | --- | --- |
| 1 | sys_exit  | int | NULL | NULL | NULL | NULL | 
| 2 | sys_fork  | struct pt_regs | NULL | NULL | NULL | NULL |
| 3 | sys_read  | unsigned int | char * | size_t | NULL | NULL |
| 4 | sys_write | unsigned int | const char * | size_t | NULL | NULL | 
| 5 | sys_open  | const char * | int | int	| NULL | NULL |
| 6 | sys_close | unsigned int | NULL | NULL | NULL |  NULL |

let's go to our first assembly code, let's make a folder with all the codes used here, it will be in the codes folder
lets go !! 

```asm
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
   
```
congratulations on your ability to create your first assembly code !!
