# 💻 About the project
AsmHelp a simple basic help for those who are starting in assembly 
I am a simple student of assembly and I want to share my knowledge for 
those who have doubts or want to start.
We're covering here in this project just the `Linux(ELF) Assembly Intel x86`.
Feel free to have a look at [Assembly x86_64](https://www.cs.uaf.edu/2017/fall/cs301/reference/x86_64.html)

##### Note: To this guide, we gonna use `nasm` and `ld`. Search how to install them in you linux distribution.

# Index
   - [Basic Syntax](#basic-syntax)
   - [Sections](#basic-sections)
   - [Registers](#registers)
   - [Syscalls](#syscalls)
   - [Types](#types)
   - [Stack](#stack)
   - [Heap](#heap)
   - [Memory Allocation](#memory-allocation)
 
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

Note: You can use `nasm -f elf_i386 <file>` to assemble and `ld <file.o> -o <output>` to link.
      But I made a script to automate build our elf executable. You dont need to use, but is there anyway. Just do the following `simplenasm file.asm out.out`

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
