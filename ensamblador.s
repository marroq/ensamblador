.data
msgBCodif: 	.asciiz "Codificando el siguinete programa:\n\n"
		.align 2

##### INICIO DEL PROGRAMA A CODIFICAR #####
### El programa tiene que quedar en una sola linea, separar las lineas con \n
#ORI
#programa:	.asciiz ".text\nmain:\nori $a0 $0 10\nori $v0 $0 1\nsyscall\nori $v0 $0 10\nsyscall"
#ADDIU
#programa:	.asciiz ".text\nmain:\naddiu $a0 $0 40\nori $v0 $0 1\nsyscall\nori $v0 $0 10\nsyscall"
#ANDI
#programa:	.asciiz ".text\nmain:\nandi $a0 $0 99\nori $v0 $0 1\nsyscall\nori $v0 $0 10\nsyscall"
#SLTI
#programa:	.asciiz ".text\nmain:\nslti $a0 $0 50\nori $v0 $0 1\nsyscall\nori $v0 $0 10\nsyscall"
#SLTIU
#programa:	.asciiz ".text\nmain:\nsltiu $a0 $0 0\nori $v0 $0 1\nsyscall\nori $v0 $0 10\nsyscall"
#ADD
#programa:	.asciiz ".text\nmain:\nadd $a0 $0 $0\nori $v0 $0 1\nsyscall\nori $v0 $0 10\nsyscall"
#ADDU
#programa:	.asciiz ".text\nmain:\naddu $a0 $0 $0\nori $v0 $0 1\nsyscall\nori $v0 $0 10\nsyscall"
#AND
#programa:	.asciiz ".text\nmain:\nand $a0 $0 $0\nori $v0 $0 1\nsyscall\nori $v0 $0 10\nsyscall"
#OR
#programa:	.asciiz ".text\nmain:\nor $a0 $0 $0\nori $v0 $0 1\nsyscall\nori $v0 $0 10\nsyscall"
#programa:	.asciiz ".text\nmain:\nori $t0 $0 5\nadd $t1 $t0 $0\nandi $a0 $t1 6\nori $v0 $0 1\nsyscall\nori $v0 $0 10\nsyscall"
#SUB
#programa:	.asciiz ".text\nmain:\nsub $a0 $0 $0\nori $v0 $0 1\nsyscall\nori $v0 $0 10\nsyscall"
#SUBU
#programa:	.asciiz ".text\nmain:\nsubu $a0 $0 $0\nori $v0 $0 1\nsyscall\nori $v0 $0 10\nsyscall"
#SLT
#programa:	.asciiz ".text\nmain:\nslt $a0 $0 $0\nori $v0 $0 1\nsyscall\nori $v0 $0 10\nsyscall"
#DIV/U- T.R.
#programa:	.asciiz ".text\nmain:\naddi $t0 $0 6\naddi $t1 $0 3\ndivu $t0 $t1\nmfhi $a0\nori $v0 $0 1\nsyscall\nori $v0 $0 10\nsyscall"
#MULT/U
programa:	.asciiz ".text\nmain:\naddi $t0 $0 6\naddi $t1 $0 3\nmult $t0 $t1\nmflo $a0\nori $v0 $0 1\nsyscall\nori $v0 $0 10\nsyscall"

##### FIN DEL PROGRAMA A CODIFICAR #####

errMsg: 		.asciiz "Error!!!\n"
msgFCodif: 	.asciiz "\n\nFinaliza la codificacion...\n\nEjecutando el programa codificado...\n"
	
		.align 2
data:		.space 200	# Reservo 200 bytes para datos
		.align 2
### MARS solo nos dejara pedir espacio en el area de data
### Debemos ir en MARS a Settings y activar Self-modifying code
text:		.space 400	# Reservo espacio para almacenar el programa compilado (100 instrucciones)
		.align 2

tabla:		.space 480	#20 labels como máximo de 20 caracteres máximo cada etiqueta
		.align 2

.text
main:
   la $a0 msgBCodif	# Imprimo el programa que voy a ensamblar
   jal print_str
   la $a0 programa
   jal print_str
   la $a0 msgFCodif
   jal print_str
	
   la $a0 programa	# Llamo a la funcion con sus respectivos argumentos
   la $a1 text
   la $a2 data
   jal ensamblador

   jr $v0		# Ejecuto el programa después de ser ensamblado
   j exit		# Termino la ejecucion

print_str:			# Funcion para imprimir strings, recibe la direccion del string en $a0
   li $v0 4
   syscall
   jr $ra

exit:
   li $v0 10
   syscall

###################################################
########### FIN DEL MAIN ##########################
###################################################

###################################################
######### Comienza la funcion ensamblador #########
###################################################

.data		# Palabras reservadas (instrucciones y directivas)
str_data:		.asciiz ".data"

str_text:		.asciiz ".text"
		.align 2
str_ori:		.asciiz "ori"
		.align 2
str_syscall:	.asciiz "syscall"
		.align 2
str_add:		.asciiz "add"
		.align 2
str_addu:		.asciiz "addu"
		.align 2
str_addiu:	.asciiz "addiu"
		.align 2		
str_and:		.asciiz "and"
		.align 2	
str_andi:		.asciiz "andi"
		.align 2
str_div:		.asciiz "div"
		.align 2
str_divu:		.asciiz "divu"
		.align 2
str_mult:		.asciiz "mult"
		.align 2
str_multu:	.asciiz "multu"
		.align 2
str_or:		.asciiz "or"
		.align 2
str_sll:		.asciiz "sll"
		.align 2
str_sllv:		.asciiz "sllv"
		.align 2
str_sra:		.asciiz "sra"
		.align 2
str_srl:		.asciiz "srl"
		.align 2
str_srlv:		.asciiz "srlv"
		.align 2
str_sub:		.asciiz "sub"
		.align 2
str_subu:		.asciiz "subu"
		.align 2
str_lui:		.asciiz "lui"
		.align 2
str_slt:		.asciiz "slt"
		.align 2
str_sltu:		.asciiz "sltu"
		.align 2
str_slti:		.asciiz "slti"
		.align 2
str_sltiu:		.asciiz "sltiu"
		.align 2
str_lw:		.asciiz "lw"
		.align 2
str_sw:		.asciiz "sw"
		.align 2
str_mfhi:		.asciiz "mfhi"
		.align 2
str_mflo:		.asciiz "mflo"
		.align 2

.text
###################################################
############ funcion ensamblador #######################
ensamblador:
# Entrada, almaceno variables a utilizar
   addi $sp $sp -40
   sw $a1 36($sp)
   sw $ra 32($sp)
   sw $s7 28($sp)
   sw $s6 24($sp)
   sw $s5 20($sp)
   sw $s4 16($sp)
   sw $s3 12($sp)
   sw $s2  8($sp)
   sw $s1  4($sp)
   sw $s0  0($sp)

# Transfiero los argumentos a un lugar seguro
   move $s0 $a0	# s0 -> codigo fuente
   move $s1 $a1	# s1 -> area de .text
   move $s2 $a2	# s2 -> area de .data
   li   $s3 '#' # s3 -> caracter para comentarios
   li   $s4 ' '	# s4 -> caracter espacio
   li   $s5 10  # s5 -> caracter "\n" -> EOL
   li   $s6 9   # s6 -> tabulador

# Inicio de la codificacion
# Asumo que empieza en modo .text
asm_text_loop:
   lb $t0 0($s0)
   addi $s0 $s0 1
   beq $t0 $0 asm_exit		# Salir cuando se llegue al final del archivo
   beq $t0 $s4 asm_text_loop	# Ignorar espacios en blanco
   beq $t0 $s5 asm_text_loop	# lineas en blanco
   beq $t0 $s6 asm_text_loop	# y tabuladores
   j asm_get_instruction

asm_data_loop:			# Implemente esta parte
   j asm_exit

asm_error:			# Manejo generico de errores
   la $a0 errMsg		# En caso de cualquier problema, imprimimos error y terminamos la ejecucion
   jal print_str
   j asm_exit

# Salida
asm_exit:
   lw $a1 36($sp)
   lw $ra 32($sp)
   lw $s7 28($sp)
   lw $s6 24($sp)
   lw $s5 20($sp)
   lw $s4 16($sp)
   lw $s3 12($sp)
   lw $s2  8($sp)
   lw $s1  4($sp)
   lw $s0  0($sp)

   move $v0 $a1			# Devolvemos el buffer (la dirección que recibimos en $a1)
   addi $sp $sp 40
   jr $ra
	
###########################################
###### Funciones ##########################
###########################################

###########################################
###### Guardar en tabla de simbolos ##############
guardarTabla:		
   li 	$t0 0			# contador de labels
   li	$t1 ':'			# los " : " no deben escribirse
   li	$t2 24			# cada label ocupa 24 bytes
   mult $t0 $t2
nextPosition:
   mflo	$t4 			# guardo el resultado de que label llevo, es decir, voy de 24 en 24
   lb 	$t3 tabla($t4)		# cargo el byte de la primera/siguiente posicion de la tabla de símbolos
   addi $t0 $t0 1
   mult	$t0 $t2
   bgt  $t3 $0 nextPosition
   move	$t0 $t4
nextChar:
   lb 	$t3 0($a0)		# cargo letra por letra de lo que venga en $a0
   beq 	$t3 $t1 saveAddress	# si encuentro " : " es porque ya terminé
   beq	$t3 $0 saveAddress	# si es un 0 = salto de línea \0, es porque ya terminé
   sb	$t3 tabla($t0)		# escribo letra por letra en mi espacio reservado llamado -tabla-
   addi	$a0 $a0 1		# avanzo al siguiente caracter del label
   addi $t0 $t0 1		# incremente el contrador de labels
   j nextChar
saveAddress:
   li 	$t6 '\0'		
   addi $t0 $t0 1		
   sb   $t6 tabla($t0)		# escribo el terminador de línea
   add	$t5 $t4 20		# para escribir la dirección del label
   sw 	$a1 tabla($t5)
   jr	$ra

###########################################
###### Obtener de la tabla de simbolos ############
obtenerTabla:	
   addi $sp $sp -8
   sw	$ra 0($sp)
   sw	$s0 4($sp)
   li 	$s0 0			# contador de labels	
   li	$t2 24			# cada label ocupa 24 bytes
   mult $s0 $t2
nextLabel:
   mflo $t4
   la 	$a1 tabla($t4)		# cargo la dirección del label   
   lb	$t9 0($a1)		# veo que tiene el primer caracter de la dirección cargada, esto para ver si no está vacío, entonces ya no hay más datos en la tabla
   beq 	$t9 $0 notExist
   addi $s0 $s0 1
   mult	$s0 $t2
   jal	strcmp			
   beq	$v0 1 exitObtener
   beq 	$v0 0 nextLabel
exitObtener:
   addi $t1 $s0 20		# me voy al área donde está la dirección del label
   la 	$v0 tabla($t1) 		# cargo la dirección del label solicitado
   lw 	$s0 4($sp)
   lw	$ra 0($sp)		
   addi $sp $sp 8
   jr	$ra
notExist:
   lw 	$s0 4($sp)
   lw	$ra 0($sp)		
   addi $sp $sp 8
   li	$v0 -1
   jr	$ra
   
###########################################
###### Seleccion de instrucciones #################
asm_get_instruction:		# Basicamente, un gran switch que indica que instruccion es
   addi $s0 $s0 -1		# Ya se habia sumado un 1 antes de llegar aqui, arreglamos eso

   move $a0 $s0			# verifico si es la directiva .data
   la $a1 str_data
   jal strcmp
   bne $v0 $0 asm_data_loop
   
   move $a0 $s0			# verifico si es la directiva .text
   la $a1 str_text
   jal strcmp
   bne $v0 $0 asm_text_loop

   move $a0 $s0			# verifico si es la instruccion syscall
   la $a1 str_syscall
   jal strcmp
   bne $v0 $0 asm_syscall
   
   move	$a0 $s0
   la 	$a1 str_add 		# verifico si es la instruccion add
   jal 	strcmp
   bne	$v0 $0 asm_add

   move	$a0 $s0
   la 	$a1 str_addu 		# verifico si es la instruccion addu
   jal 	strcmp
   bne	$v0 $0 asm_addu
   
   move $a0 $s0
   la 	$a1 str_addiu 		# verifico si es la instruccion addiu
   jal 	strcmp
   bne	$v0 $0 asm_addiu
   
   move $a0 $s0
   la 	$a1 str_and 		# verifico si es la instruccion and
   jal 	strcmp
   bne	$v0 $0 asm_and
   
   move $a0 $s0
   la 	$a1 str_andi		# verifico si es la instruccion andi
   jal 	strcmp
   bne	$v0 $0 asm_andi
   
   move $a0 $s0
   la 	$a1 str_div		# verifico si es la instruccion div
   jal 	strcmp
   bne	$v0 $0 asm_div
   
   move $a0 $s0
   la 	$a1 str_divu		# verifico si es la instruccion divu
   jal 	strcmp
   bne	$v0 $0 asm_divu
   
   move $a0 $s0
   la 	$a1 str_mult		# verifico si es la instruccion mult
   jal 	strcmp
   bne	$v0 $0 asm_mult
   
   move $a0 $s0
   la 	$a1 str_multu		# verifico si es la instruccion multu
   jal 	strcmp
   bne	$v0 $0 asm_multu
   
   move $a0 $s0
   la 	$a1 str_or		# verifico si es la instruccion or
   jal 	strcmp
   bne	$v0 $0 asm_or
   
   move $a0 $s0			# verifico si es la instruccion ori
   la $a1 str_ori
   jal strcmp
   bne $v0 $0 asm_ori
   
   move $a0 $s0
   la 	$a1 str_sll		# verifico si es la instruccion sll
   jal 	strcmp
   bne	$v0 $0 asm_sll
   
   move $a0 $s0
   la 	$a1 str_sllv		# verifico si es la instruccion sllv
   jal 	strcmp
   bne	$v0 $0 asm_sllv
   
   move $a0 $s0
   la 	$a1 str_sra		# verifico si es la instruccion sra
   jal 	strcmp
   bne	$v0 $0 asm_sra
   
   move $a0 $s0
   la 	$a1 str_srl		# verifico si es la instruccion srl
   jal 	strcmp
   bne	$v0 $0 asm_srl
   
   move $a0 $s0
   la 	$a1 str_srlv		# verifico si es la instruccion srlv
   jal 	strcmp
   bne	$v0 $0 asm_srlv
   
   move $a0 $s0
   la 	$a1 str_sub		# verifico si es la instruccion sub
   jal 	strcmp
   bne	$v0 $0 asm_sub
   
   move $a0 $s0
   la 	$a1 str_subu		# verifico si es la instruccion subu
   jal 	strcmp
   bne	$v0 $0 asm_subu
   
   move $a0 $s0
   la 	$a1 str_lui		# verifico si es la instruccion lui
   jal 	strcmp
   bne	$v0 $0 asm_lui
   
   move $a0 $s0
   la 	$a1 str_slt		# verifico si es la instruccion slt
   jal 	strcmp
   bne	$v0 $0 asm_slt
   
   move $a0 $s0
   la 	$a1 str_sltu		# verifico si es la instruccion sltu
   jal 	strcmp
   bne	$v0 $0 asm_sltu
   
   move $a0 $s0
   la 	$a1 str_slti		# verifico si es la instruccion slti
   jal 	strcmp
   bne	$v0 $0 asm_slti
   
   move $a0 $s0
   la 	$a1 str_sltiu		# verifico si es la instruccion sltiu
   jal 	strcmp
   bne	$v0 $0 asm_sltiu
   
   move $a0 $s0
   la 	$a1 str_lw		# verifico si es la instruccion lw
   jal 	strcmp
   bne	$v0 $0 asm_lw
   
   move $a0 $s0
   la 	$a1 str_sw		# verifico si es la instruccion sw
   jal 	strcmp
   bne	$v0 $0 asm_sw
   
   move $a0 $s0
   la 	$a1 str_mfhi		# verifico si es la instruccion mfhi
   jal 	strcmp
   bne	$v0 $0 asm_mfhi
   
   move $a0 $s0
   la 	$a1 str_mflo		# verifico si es la instruccion mflo
   jal 	strcmp
   bne	$v0 $0 asm_mflo
   
   move $a0 $s0			# verifico si es un label
   jal asm_label_check
   bne $v0 $0 asm_label

   j asm_error			# si no es ninguna me voy a error

###########################################
######### asm_label #######################
asm_label:			# codigo a ejecutarse en caso que sea un label
   lb $t0 0($s0)		# la tabla de simbolos se debe llenar con las etiquetas
   addi $s0 $s0 1
   bne $t0 $s5 asm_label
   j asm_text_loop

###########################################
######### asm_syscall #####################
asm_syscall:			# esta instruccion es la mas facil de codificar
   la $t0 0x0000000c
   sw $t0 0($s1)
   addi $s1 $s1 4
   j asm_text_loop

###########################################
######### asm_ori #########################
asm_ori:
   li $s7 0x0d		# codigo de ori 0x0d

   sll $s7 $s7 10	# shift porque son 5b de rt + 5b de rs
   addi $s0 $s0 1	# elimino el espacio
   jal asm_regs     	# me devuelve el numero del registro
   add $s7 $s7 $v0	# almaceno el numero del registro en rs

   addi $s0 $s0 1	# elimino el espacio
   jal asm_regs     	# me devuelve el numero del registro
   sll $v0 $v0 5	# pongo rs en la posicion que debe ir (van cruzados)
   or  $s7 $s7 $v0	# almaceno el numero del registro en rt
 
   sll $s7 $s7 16	# le hago shift de 16 para hacer espacio al imm
   addi $s0 $s0 1	# elimino el espacio
   jal ascii_to_int	# hago la conversion de ascii a int
   addu $s7 $s7 $v0 	# concateno el imm con el resto que ya tenia
   sw $s7 0($s1)	# almaceno la instruccion codificada
   addi $s1 $s1 4
   j asm_text_loop
   
###########################################
######### asm_add ##########################
asm_add:
   li	$s7 0
   addi	$s0 $s0 1	# elimino el espacio
   jal 	asm_regs	# me devuelve el numero del registro
   add 	$s7 $s7 $v0	# almaceno el numero del registro rd
   
   addi $s0 $s0 1	# elimino el espacio
   jal 	asm_regs	
   sll 	$v0 $v0 10	# pongo rs en la posición que debe ir
   or 	$s7 $s7 $v0	# almaceno rs
   
   addi $s0 $s0 1	#elimino el espacio
   jal 	asm_regs
   sll 	$v0 $v0 5	# pongo rt en la posicion que debe ir
   or 	$s7 $s7 $v0	# almeceno rt
   
   sll 	$s7 $s7 11	# corro 11 espacios para guardar el código de función
   addu	$s7 $s7 32	# sumo el codigo de funcion de add
   sw 	$s7 0($s1)	# almaceno la instruccion codificada
   addi $s1 $s1 4
   j asm_text_loop
   
###########################################
######### asm_addu #########################
asm_addu:
   li	$s7 0
   addi	$s0 $s0 1	# elimino el espacio
   jal 	asm_regs	# me devuelve el numero del registro
   add 	$s7 $s7 $v0	# almaceno el numero del registro rd
   
   addi $s0 $s0 1	# elimino el espacio
   jal 	asm_regs	
   sll 	$v0 $v0 10	# pongo rs en la posición que debe ir
   or 	$s7 $s7 $v0	# almaceno rs
   
   addi $s0 $s0 1	#elimino el espacio
   jal 	asm_regs
   sll 	$v0 $v0 5	# pongo rt en la posicion que debe ir
   or 	$s7 $s7 $v0	# almeceno rt
   
   sll 	$s7 $s7 11	# corro 11 espacios para guardar el código de función
   addu	$s7 $s7 33	# sumo el codigo de funcion de addu
   sw 	$s7 0($s1)	# almaceno la instruccion codificada
   addi $s1 $s1 4
   j asm_text_loop
   
###########################################
######### asm_addiu #########################
asm_addiu:
   li $s7 0x09		# codigo de addiu 0x09
	
   sll $s7 $s7 10	# shift porque son 5b de rt + 5b de rs
   addi $s0 $s0 1	# elimino el espacio
   jal asm_regs     	# me devuelve el numero del registro
   add $s7 $s7 $v0	# almaceno el numero del registro en rs

   addi $s0 $s0 1	# elimino el espacio
   jal asm_regs     	# me devuelve el numero del registro
   sll $v0 $v0 5	# pongo rs en la posicion que debe ir (van cruzados)
   or  $s7 $s7 $v0	# almaceno el numero del registro en rt
 
   sll $s7 $s7 16	# le hago shift de 16 para hacer espacio al imm
   addi $s0 $s0 1	# elimino el espacio
   jal ascii_to_int	# hago la conversion de ascii a int
   addu $s7 $s7 $v0 	# concateno el imm con el resto que ya tenia
   sw $s7 0($s1)	# almaceno la instruccion codificada
   addi $s1 $s1 4
   j asm_text_loop
   
###########################################
######### asm_and ##########################
asm_and:
   li	$s7 0
   addi	$s0 $s0 1	# elimino el espacio
   jal 	asm_regs	# me devuelve el numero del registro
   add 	$s7 $s7 $v0	# almaceno el numero del registro rd
   
   addi $s0 $s0 1	# elimino el espacio
   jal 	asm_regs	
   sll 	$v0 $v0 10	# pongo rs en la posición que debe ir
   or 	$s7 $s7 $v0	# almaceno rs
   
   addi $s0 $s0 1	#elimino el espacio
   jal 	asm_regs
   sll 	$v0 $v0 5	# pongo rt en la posicion que debe ir
   or 	$s7 $s7 $v0	# almeceno rt
   
   sll 	$s7 $s7 11	# corro 11 espacios para guardar el código de función
   addu	$s7 $s7 36	# sumo el codigo de funcion de and
   sw 	$s7 0($s1)	# almaceno la instruccion codificada
   addi $s1 $s1 4
   j asm_text_loop

###########################################
######### asm_andi #########################
asm_andi:
   li $s7 0x0c		# codigo de andi 0x0c
	
   sll $s7 $s7 10	# shift porque son 5b de rt + 5b de rs
   addi $s0 $s0 1	# elimino el espacio
   jal asm_regs     	# me devuelve el numero del registro
   add $s7 $s7 $v0	# almaceno el numero del registro en rs

   addi $s0 $s0 1	# elimino el espacio
   jal asm_regs     	# me devuelve el numero del registro
   sll $v0 $v0 5	# pongo rs en la posicion que debe ir (van cruzados)
   or  $s7 $s7 $v0	# almaceno el numero del registro en rt
 	
   sll $s7 $s7 16	# le hago shift de 16 para hacer espacio al imm
   addi $s0 $s0 1	# elimino el espacio
   jal ascii_to_int	# hago la conversion de ascii a int
   addu $s7 $s7 $v0 	# concateno el imm con el resto que ya tenia
   sw $s7 0($s1)	# almaceno la instruccion codificada
   addi $s1 $s1 4
   j asm_text_loop
   
###########################################
######### asm_div ##########################
asm_div:
   li $s7 0
   
   addi	$s0 $s0 1	# elimino el espacio
   jal 	asm_regs	# me devuelve el numero del registro
   add 	$s7 $s7 $v0	# almaceno el numero del registro rs
   
   addi	$s0 $s0 1	# elimino el espacio
   sll 	$s7 $s7 5	# corro rs 5 espacios
   jal 	asm_regs	# me devuelve el numero del registro
   add  $s7 $s7 $v0	# almaceno rt 
   
   sll 	$s7 $s7 16	# pongo a rs y rt en sus posiciones
   addu $s7 $s7 26	# almaceno el codigo de la funcion
   sw $s7 0($s1)	# almaceno la instruccion codificada
   addi $s1 $s1 4
   j asm_text_loop

###########################################
######### asm_divu ##########################
asm_divu:
   li $s7 0
   
   addi	$s0 $s0 1	# elimino el espacio
   jal 	asm_regs	# me devuelve el numero del registro
   add 	$s7 $s7 $v0	# almaceno el numero del registro rs
   
   addi	$s0 $s0 1	# elimino el espacio
   sll 	$s7 $s7 5	# corro rs 5 espacios
   jal 	asm_regs	# me devuelve el numero del registro
   add  $s7 $s7 $v0	# almaceno rt 
   
   sll 	$s7 $s7 16	# pongo a rs y rt en sus posiciones
   addu $s7 $s7 27	# almaceno el codigo de la funcion
   sw $s7 0($s1)	# almaceno la instruccion codificada
   addi $s1 $s1 4
   j asm_text_loop

###########################################
######### asm_mult ##########################
asm_mult:
   li $s7 0
   
   addi	$s0 $s0 1	# elimino el espacio
   jal 	asm_regs	# me devuelve el numero del registro
   add 	$s7 $s7 $v0	# almaceno el numero del registro rs
   
   addi	$s0 $s0 1	# elimino el espacio
   sll 	$s7 $s7 5	# corro rs 5 espacios
   jal 	asm_regs	# me devuelve el numero del registro
   add  $s7 $s7 $v0	# almaceno rt 
   
   sll 	$s7 $s7 16	# pongo a rs y rt en sus posiciones
   addu $s7 $s7 24	# almaceno el codigo de la funcion
   sw $s7 0($s1)	# almaceno la instruccion codificada
   addi $s1 $s1 4
   j asm_text_loop

###########################################
######### asm_multu ##########################
asm_multu:
   li $s7 0
   
   addi	$s0 $s0 1	# elimino el espacio
   jal 	asm_regs	# me devuelve el numero del registro
   add 	$s7 $s7 $v0	# almaceno el numero del registro rs
   
   addi	$s0 $s0 1	# elimino el espacio
   sll 	$s7 $s7 5	# corro rs 5 espacios
   jal 	asm_regs	# me devuelve el numero del registro
   add  $s7 $s7 $v0	# almaceno rt 
   
   sll 	$s7 $s7 16	# pongo a rs y rt en sus posiciones
   addu $s7 $s7 25	# almaceno el codigo de la funcion
   sw $s7 0($s1)	# almaceno la instruccion codificada
   addi $s1 $s1 4
   j asm_text_loop
   
###########################################
######### asm_or ###########################
asm_or:
   li	$s7 0
   addi	$s0 $s0 1	# elimino el espacio
   jal 	asm_regs	# me devuelve el numero del registro
   add 	$s7 $s7 $v0	# almaceno el numero del registro rd
   
   addi $s0 $s0 1	# elimino el espacio
   jal 	asm_regs	
   sll 	$v0 $v0 10	# pongo rs en la posición que debe ir
   or 	$s7 $s7 $v0	# almaceno rs
   
   addi $s0 $s0 1	#elimino el espacio
   jal 	asm_regs
   sll 	$v0 $v0 5	# pongo rt en la posicion que debe ir
   or 	$s7 $s7 $v0	# almeceno rt
   
   sll 	$s7 $s7 11	# corro 11 espacios para guardar el código de función
   addu	$s7 $s7 37	# sumo el codigo de funcion de or
   sw 	$s7 0($s1)	# almaceno la instruccion codificada
   addi $s1 $s1 4
   j asm_text_loop
   
###########################################
######### asm_sll ##########################
asm_sll:

###########################################
######### asm_sllv ##########################
asm_sllv:

###########################################
######### asm_sra ##########################
asm_sra:

###########################################
######### asm_srl ##########################
asm_srl:

###########################################
######### asm_srlv ##########################
asm_srlv:

###########################################
######### asm_sub ##########################
asm_sub:
   li	$s7 0
   addi	$s0 $s0 1	# elimino el espacio
   jal 	asm_regs	# me devuelve el numero del registro
   add 	$s7 $s7 $v0	# almaceno el numero del registro rd
   
   addi $s0 $s0 1	# elimino el espacio
   jal 	asm_regs	
   sll 	$v0 $v0 10	# pongo rs en la posición que debe ir
   or 	$s7 $s7 $v0	# almaceno rs
   
   addi $s0 $s0 1	#elimino el espacio
   jal 	asm_regs
   sll 	$v0 $v0 5	# pongo rt en la posicion que debe ir
   or 	$s7 $s7 $v0	# almeceno rt
   
   sll 	$s7 $s7 11	# corro 11 espacios para guardar el código de función
   addu	$s7 $s7 34	# sumo el codigo de funcion de sub
   sw 	$s7 0($s1)	# almaceno la instruccion codificada
   addi $s1 $s1 4
   j asm_text_loop

###########################################
######### asm_subu ##########################
asm_subu:
   li	$s7 0
   addi	$s0 $s0 1	# elimino el espacio
   jal 	asm_regs	# me devuelve el numero del registro
   add 	$s7 $s7 $v0	# almaceno el numero del registro rd
   
   addi $s0 $s0 1	# elimino el espacio
   jal 	asm_regs	
   sll 	$v0 $v0 10	# pongo rs en la posición que debe ir
   or 	$s7 $s7 $v0	# almaceno rs
   
   addi $s0 $s0 1	#elimino el espacio
   jal 	asm_regs
   sll 	$v0 $v0 5	# pongo rt en la posicion que debe ir
   or 	$s7 $s7 $v0	# almeceno rt
   
   sll 	$s7 $s7 11	# corro 11 espacios para guardar el código de función
   addu	$s7 $s7 35	# sumo el codigo de funcion de subu
   sw 	$s7 0($s1)	# almaceno la instruccion codificada
   addi $s1 $s1 4
   j asm_text_loop

###########################################
######### asm_lui ##########################
asm_lui:

###########################################
######### asm_slt ##########################
asm_slt:
   li	$s7 0
   addi	$s0 $s0 1	# elimino el espacio
   jal 	asm_regs	# me devuelve el numero del registro
   add 	$s7 $s7 $v0	# almaceno el numero del registro rd
   
   addi $s0 $s0 1	# elimino el espacio
   jal 	asm_regs	
   sll 	$v0 $v0 10	# pongo rs en la posición que debe ir
   or 	$s7 $s7 $v0	# almaceno rs
   
   addi $s0 $s0 1	#elimino el espacio
   jal 	asm_regs
   sll 	$v0 $v0 5	# pongo rt en la posicion que debe ir
   or 	$s7 $s7 $v0	# almeceno rt
   
   sll 	$s7 $s7 11	# corro 11 espacios para guardar el código de función
   addu	$s7 $s7 42	# sumo el codigo de funcion de slt
   sw 	$s7 0($s1)	# almaceno la instruccion codificada
   addi $s1 $s1 4
   j asm_text_loop

###########################################
######### asm_sltu ##########################
asm_sltu:
   li	$s7 0
   addi	$s0 $s0 1	# elimino el espacio
   jal 	asm_regs	# me devuelve el numero del registro
   add 	$s7 $s7 $v0	# almaceno el numero del registro rd
   
   addi $s0 $s0 1	# elimino el espacio
   jal 	asm_regs	
   sll 	$v0 $v0 10	# pongo rs en la posición que debe ir
   or 	$s7 $s7 $v0	# almaceno rs
   
   addi $s0 $s0 1	#elimino el espacio
   jal 	asm_regs
   sll 	$v0 $v0 5	# pongo rt en la posicion que debe ir
   or 	$s7 $s7 $v0	# almeceno rt
   
   sll 	$s7 $s7 11	# corro 11 espacios para guardar el código de función
   addu	$s7 $s7 43	# sumo el codigo de funcion de sltu
   sw 	$s7 0($s1)	# almaceno la instruccion codificada
   addi $s1 $s1 4
   j asm_text_loop

###########################################
######### asm_slti ###########################
asm_slti:
   li $s7 0x0a		# codigo de slti 0x0a
	
   sll $s7 $s7 10	# shift porque son 5b de rt + 5b de rs
   addi $s0 $s0 1	# elimino el espacio
   jal asm_regs     	# me devuelve el numero del registro
   add $s7 $s7 $v0	# almaceno el numero del registro en rs

   addi $s0 $s0 1	# elimino el espacio
   jal asm_regs     	# me devuelve el numero del registro
   sll $v0 $v0 5	# pongo rs en la posicion que debe ir (van cruzados)
   or  $s7 $s7 $v0	# almaceno el numero del registro en rt
 
   sll $s7 $s7 16	# le hago shift de 16 para hacer espacio al imm
   addi $s0 $s0 1	# elimino el espacio
   jal ascii_to_int	# hago la conversion de ascii a int
   addu $s7 $s7 $v0 	# concateno el imm con el resto que ya tenia
   sw $s7 0($s1)	# almaceno la instruccion codificada
   addi $s1 $s1 4
   j asm_text_loop
   
###########################################
######### asm_sltiu ##########################
asm_sltiu:
   li $s7 0x0b		# codigo de sltiu 0x0b

   sll $s7 $s7 10	# shift porque son 5b de rt + 5b de rs
   addi $s0 $s0 1	# elimino el espacio
   jal asm_regs     	# me devuelve el numero del registro
   add $s7 $s7 $v0	# almaceno el numero del registro en rs

   addi $s0 $s0 1	# elimino el espacio
   jal asm_regs     	# me devuelve el numero del registro
   sll $v0 $v0 5	# pongo rs en la posicion que debe ir (van cruzados)
   or  $s7 $s7 $v0	# almaceno el numero del registro en rt
 
   sll $s7 $s7 16	# le hago shift de 16 para hacer espacio al imm
   addi $s0 $s0 1	# elimino el espacio
   jal ascii_to_int	# hago la conversion de ascii a int
   addu $s7 $s7 $v0 	# concateno el imm con el resto que ya tenia
   sw $s7 0($s1)	# almaceno la instruccion codificada
   addi $s1 $s1 4
   j asm_text_loop
   
###########################################
######### asm_lw ##########################
asm_lw:

###########################################
######### asm_sw ##########################
asm_sw:

###########################################
######### asm_mfhi ##########################
asm_mfhi:
   li $s7 0
   
   addi $s0 $s0 1	# elimino el espacio
   jal asm_regs    	# me devuelve el numero del registro
   sll $v0 $v0 11	# hago un corrimiento de 11 posiciones en el valor del registro
   or $s7 $s7 $v0	# coloco el registro en su posicion
   
   addu $s7 $s7 16	# sumo el codigo de mfhi
   sw 	$s7 0($s1)	# almaceno la instruccion codificada
   addi $s1 $s1 4
   j asm_text_loop

###########################################
######### asm_mflo ##########################
asm_mflo:
   li $s7 0
   
   addi $s0 $s0 1	# elimino el espacio
   jal asm_regs     	# me devuelve el numero del registro
   sll $v0 $v0 11	# hago un corrimiento de 11 posiciones en el valor del registro
   or $s7 $s7 $v0	# coloco el registro en su posicion
   
   addu $s7 $s7 18	# sumo el codigo de mflo
   sw 	$s7 0($s1)	# almaceno la instruccion codificada
   addi $s1 $s1 4
   j asm_text_loop

###########################################
############# asm_regs ####################
asm_regs:		# pasa de $xN -> N ej. $s0 -> 16
   addi $sp $sp -4	
   sw $ra 0($sp)
   li $t7 '$'		# voy a utilizarlo para verificar que viene un registro
   li $t6 'a'		# aX -> argumentos
   li $t4 '0'		# cero
   li $t3 's'		# sX -> valores de variables
   li $t2 't'		# tX -> valores temporales
   li $t1 'k'		# kX
   li $t8 'f'		# fp
   li $t9 'r'		# ra

   lb 	$t0 0($s0)
   addi $s0 $s0 1
   bne 	$t0 $t7 asm_regs_error	# si no empieza con $ no es valido
   lb 	$t0 0($s0)
   addi $s0 $s0 1
   beq 	$t0 $t4 asm_regs_zero
   beq 	$t0 $t6 asm_regs_at	#validare primero si no es $at el que viene
continue:
   li $t5 'v'			# vX -> valores de retorno
   beq 	$t0 $t5 asm_regs_vx	# verifico a que grupo pertence para sumarle un offset
   beq 	$t0 $t6 asm_regs_ax	
   beq	$t0 $t2 asm_regs_tx
   beq 	$t0 $t3 asm_regs_sp 	# validare primero si no es $sp el que viene
continue2:
   beq 	$t0 $t3 asm_regs_sx
   beq 	$t0 $t1 asm_regs_kx
   li 	$t7 'g'			# cargo gp
   beq  $t0 $t7 asm_regs_gp
   beq 	$t0 $t8 asm_regs_fp
   beq 	$t0 $t9 asm_regs_ra	
   j asm_regs_error		# no es ninguno, entonces es error

asm_regs_zero:			# caso trivial, $0 -> 0
   li 	$v0 0
   j 	asm_regs_exit

asm_regs_ax:			# sumamos 4 porque... $a0 -> 4, $a1 -> 5, etc.
   jal 	ascii_to_int
   addi $v0 $v0 4
   j 	asm_regs_exit

asm_regs_vx:
   jal 	ascii_to_int
   addi $v0 $v0 2
   j 	asm_regs_exit
   
asm_regs_sx:
   jal 	ascii_to_int
   addi $v0 $v0 16
   j 	asm_regs_exit
   
asm_regs_tx:
   jal 	ascii_to_int
   addi $v0 $v0 8
   beq	$v0 16 t8_9	# si el registro es $t8
   beq	$v0 17 t8_9	# si el registro es $t9
   j 	asm_regs_exit
t8_9:
   addi	$v0 $v0 8	# le sumo 8 porque tengo que saltarme  todos los $s
   j	asm_regs_exit

asm_regs_kx:
   jal 	ascii_to_int
   addi $v0 $v0 26
   j 	asm_regs_exit   

asm_regs_at:
   lb 	$t7 0($s0)
   li 	$t5 't'
   beq	$t7 $t5 es_at
   j continue
es_at:
   li	$v0 1
   j	asm_regs_exit

asm_regs_gp:
   li 	$v0 28
   j 	asm_regs_exit
	   
asm_regs_sp:
   lb 	$t7 0($s0)
   li 	$t5 'p'
   beq	$t7 $t5 es_sp
   j continue2
es_sp:
   li	$v0 29
   j	asm_regs_exit
   
asm_regs_fp:
   li 	$v0 30
   j	asm_regs_exit
   
asm_regs_ra:
   li	$v0 31
   j 	asm_regs_exit

asm_regs_exit:
   lw $ra 0($sp)
   addi $sp $sp 4
   jr $ra

asm_regs_error:
   addi $sp $sp 4
   j asm_error

###########################################
######### ascii_to_int ####################
###########################################
ascii_to_int:   				# the infamous atoi, with no validations!
li $t1 0				# init with zero
li $t2 '0'	
li $t3 '9'	
li $t4 10
li $v0 0

ascii_to_int_loop:
   lb $t0 0($s0)
   beq $t0 $0  ascii_to_int_exit
   blt $t0 $t2 ascii_to_int_exit	# only accept numbers
   bgt $t0 $t3 ascii_to_int_exit	# only accept numbers
   addi $s0 $s0 1			# advance the char pointer
   addi $t0 $t0 -48			# get real number (without the '0' offset)
   mul  $v0 $v0 $t4			# multiply by 10
   add  $v0 $v0 $t0			# add real number
   j ascii_to_int_loop
   
ascii_to_int_exit:
   jr $ra

###########################################
######### strcmp ##########################
###########################################
strcmp:				# Compara 2 cadenas de caracteres
   li $t2 ' '		
   li $t3 10

strcmp_loop:
   lb $t0 0($a0)
   lb $t1 0($a1)
   beq $t0 $t2 strcmp_true	# Un par de caracteres que no son letras
   beq $t0 $t3 strcmp_true
   beq $t0 $0  strcmp_true	# Fin de cadena
   bne $t0 $t1 strcmp_false	# Es diferente
   addi $a0 $a0 1
   addi $a1 $a1 1
   j strcmp_loop
   
strcmp_true:
   move $s0 $a0			# Esta funcion no es portable
   li $v0 1
   jr $ra

strcmp_false:
   li $v0 0
   jr $ra

###########################################
######### asm_label_check #################
###########################################
asm_label_check:			# Verifica si la cadena es un label
   li $t1 ':'
   li $t2 ' '
   li $t3 10

asm_label_loop:
   lb $t0 0($a0)
   addi $a0 $a0 1
   beq $t0 $t1 asm_label_true
   beq $t0 $t2 asm_label_false
   beq $t0 $t3 asm_label_false
   j asm_label_loop

asm_label_true:
   move $s0 $a0
   li $v0 1
   jr $ra

asm_label_false:
   li $v0 0
   jr $ra

#### FIN DEL CODIGO #####
