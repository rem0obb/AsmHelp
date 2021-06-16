# 💻 Sobre o projeto
AsmHelp é uma ajuda simples para aqueles que estão começando em Assembly. 
Eu sou um simples estudante de Assembly e gostaria de compartilhar meu conhecimento
para aqueles que tem dúvidas ou queiram começar.
Neste projeto estamos cobrindo apenas sobre `Linux(ELF) Assembly Intel x86`.
Sinta-se à vontade para dar uma olhada em [Assembly x86_64](https://www.cs.uaf.edu/2017/fall/cs301/reference/x86_64.html)

##### Nota: Para este guia, nós iremos utilizar `nasm` e `ld`. Procure como instala-los em sua distribuição linux. Você pode utilizar o `nasm` e o `ld` manualmente, mas eu fiz um *script* para automatizar o processo de construção do nosso executavel. Você não precisa utiliza-lo, mas está lá de qualquer maneira. Apenas faça o seguinte `./_nasm file.asm out.out`.

# Índice
   - [Sintaxe Básica](#sintaxe-básica)
   - [Seções](#seções-básicas)
   - [Registradores](#registradores)
   - [Syscalls](#syscalls)
   - [Types-Variables-Allocation](#types-variables-allocation)
   - [Stack](#stack)
   - [Heap](#heap)

# Sintaxe Básica
Basicamente, uma instrução Assembly é escrita como esta: `mnemonic register1, register2`, e nós apenas ficamos colocando e retirando valores dos registrados.
Aquele `mnemonic` é uma instrução Assembly que irá fazer alguma operação entre (geralmente) dois registradores.

```asm
mov eax, ebx ; Irá mover o valor de ebx para eax
```

Agora você conhece dois registradores básicos, `eax` e `ebx`, e também que `;` pode ser utilizado para criar comentários.

# Seções Básicas
[`"Técnicamente, uma seção é um intervalo de endereços, sem brechas; toda infomação "nesses" endereços são tratados da mesma forma para determinado propósito."`](https://ftp.gnu.org/old-gnu/Manuals/gas-2.9.1/html_chapter/as_4.html).
Mantendo a simplicidade, são espaços de memória em que você pode separar suas instruções. Abaixo nós temos algumas seções básicas que precisam ter em seu código.
Nós as definimos usando a palavra chave `section <name>`.

| Seções | Descrição |
| --- | --- |
| .data | .data - seção usada para declarar dados ou constantes inicializados. Essas informações mudam em tempo de execução, você pode declarar vários valores constantes como nomes de arquivos, tamanhos de *buffers*, etc...
| .bss | .bss  - seção usada para declarar variaveis não inicializadas. |
| .text | .text - seção usada para manter o código real. Essa seção deve começar com a declaração `global _start`, que informa ao *linker* o *entry point* (ponto de entrada) do programa para que então o programa começe sua execução a partir dele. |

# Registradores
Em primeiro lugar, o que é um registrador?  [`"Um registrador é um local de acesso rápido disponível para o processador de um computador. Os registros geralmente consistem em uma pequena quantidade de armazenamento rápido, embora alguns tenham funções de hardware específicas e possam ser apenas para leitura ou gravação."`](https://en.wikipedia.org/wiki/Processor_register). Mas seguindo a ideia de simplicidade, um registrador é basicamente uma "variável" de acesso rápido que você pode colocar ou remover valores.
Na arquitetura x86, temos 8 registradores de propósito geral. Recomendo fortemente [isto](http://www.cs.virginia.edu/~evans/cs216/guides/x86.html) e [isto](https://en.wikibooks.org/wiki/X86_Assembly/X86_Architecture) para um entendimento melhor, não apenas para registradores, mas Assembly em geral.

Os registradores são os seguintes:

| Registrador | Significado | Descrição |
| --- | --- | --- |
| eax | Accumulator | Usado em operações aritméticas |
| ebx | Base | Usado como um ponteiro para informações |
| ecx | Counter | Usado em instruções de troca/rotação e *loops*. |
| edx | Data | Usado em operações aritméticas e operações I/O |
| esi | Source Index | Usado como um ponteiro para uma fonte em operações de fluxo |
| edi | Destination Index | Usado como um ponteiro para um destinno em operações de fluxos |
| esp | Stack Pointer | Pointeiro para o topo da *stack* |
| ebp | Stack Base Pointer | Usado para apontar para a base da *stack* |

Mas a maioria dos registradores perderam seus propósitos especiais no conjunto de instruções modernas, exceto `esp` e `ebp`.

# SysCalls

O que é um *syscall*? Bem, um *syscall* ou chamada de sistema são APIs para a interface entre o espaço do usuário e o espaço do kernel. Já utilizamos chamadas de sistema. Vimos também registradores e a instrução `mov` respectivamente.

Você pode fazer uso das chamadas de sistema do Linux nos seus programas em Assembly. Você precisa seguir os seguintes passos para utiliza-las em seus programas -

    * Coloque o número da chamada de sistema no registrador EAX.
    * Armazene os argumento para a chamada de sistema nos registradores EBX, ECX, etc.
    * Call the relevant interrupt (80h).
    * O resultado geralmente é retornado no registrado EAX.

A seguinte tabela mostra algumas das chamadas de sistema usadas nesse tutorial -


|  %eax 	|  Nome 	|  %ebx 	|  %ecx 	|  %edx |   %esx  |  %edi   |
| --- | --- | --- | --- | --- | --- | --- |
| 1 | sys_exit  | int | - | - | - | - | 
| 2 | sys_fork  | struct pt_regs | NULL | - | - | - |
| 3 | sys_read  | unsigned int | char * | size_t | - | - |
| 4 | sys_write | unsigned int | const char * | size_t | - | - | 
| 5 | sys_open  | const char * | int | int	| - | - |
| 6 | sys_close | unsigned int | - | - | - |  - |

vamos para o nosso primeiro código Assembly, vamos fazer uma pasta com todos os códigos usados, eles estarão na pasta `codes`!

```asm
section .data
   msg db "Hello, Wolrd!!", 0xa ;Declarando_variável 
   len equ $-msg ;Tamanho dos bytes 

section .text
   global _start

_start:

   mov edx, len ; Movendo len para edx
   mov ecx, msg ; Movendo msg para ecx
   mov ebx, 1 ; Stdout para ebx
   mov eax, 4 ; Movendo sys_write para eax
   int 0x80; Chamando Kernel

   mov eax, 1; moving sys_exit to eax
   int 0x80; Chamando Kernel
```
Parabéns por conseguir criar seu primeiro código Assembly!


# Types-Variables-Allocation
Espaço de armazenamento para variáveis. 
Storage space for variables. A pólitica de Assembly é usada para espaço de armazenamento. Pode ser usado para reservar e inicializar um ou mais bytes como ```db dw dd dq dt```.

A alocação dos dados de inicialização é a seguinte.

| sintaxe | - | - |
| --- | --- | --- |
| nome-variável  |  tipo  | valor inicial |

Bem como outras linguagens, faça o uso correto da alocação, para evitar erros durante a compilação.
A seguir nós veremos as instruções e suas funções na alocação.


| tipo | Significado | bytes alocados |
| --- | --- | :-: |
| DB  | Define Byte | 1 byte |
| DW  |  Define Word | 2 bytes |
| DD  |  Define Doublewordi | 4 bytes |
| DQ  |  Define Quadword | 8 bytes |
| DT  |  Define Ten Bytes | 10 bytes |

O que cada um aloca: Nós veremos no exemplo a seguir.

```asm
choice		DB	'y'
```
esse aloca caracteres, pode ser uma *string* como no exemplo do "hello, word" lembra?
it allocates characters in, 
it can be a string like in the example of 
"hello, world" remember?

----------------------------------------------------------

```asm
number		DW	12345
```

aloca números positivos

----------------------------------------------------------

```asm
number_negative	DW	-12345
```

aloca números negativos

----------------------------------------------------------

```asm
big_number	DQ	123456789
```

aloca números grandes

----------------------------------------------------------

```asm
real_number1	DD	1.234
```

aloca números flutuantes

----------------------------------------------------------

```asm
real_number2	DQ	123.456
```
aloca grandes números flutuantes

-----------------------------------------------------------
