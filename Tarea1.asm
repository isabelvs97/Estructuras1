#Tarea 1
#Isabel Vargas Sibaja, B57628
#Crear un array B con los números pares que contiene A e imprimir la cantidad de números pares que hay.

.data
res:       .asciiz  "Numero de elementos en B= "
newLine:   .asciiz "\n"
coma:	   .asciiz ", "
arrA: 	   .word 1,2,7,-8,4,5,12,11,-2,6,3,0     #Array de prueba
arrB: 	   .word 0                           #Se crea array para ingresar números pares 

	
.text
main:
	la $a0, arrA 		#Cargamos dirección del array A a $ao
	la $a1, arrB  		#Cargamos dirección del array B a $a1	
	jal EvenOrOdd 		#Ejecuto función EvenOrOdd
	j final
				
	
		
		
		
EvenOrOdd:
	
	addi $sp, $sp, -4	#Reservo espacio en la pila
	sw $a0, 0($sp) 		#Guardo dirección de array A en la pila
	j Loop			#Inicio loop para determinar números pares
		
		
	Loop:
		lw $t0, 0($sp)		#Cargo en $t0 la dirección del array A
		lw $t1, 0($t0)		#Cargo en $t1 el valor en la posición del array A
		
		slt $t5, $t1,$0
		bne $t5,$zero, inc
		
		beq $t1, $0, End	#Si el número no es 0, continúo, sino termino el loop
		andi $t2, $t1,1		#Máscara and 
		beq $t2, $0, even	#SI $t2=0, entonces el número es par y va a función even
		j inc 			#Salto a función de incremento	
	
		
	even:
		sw $t1,0($a1)		#Almaceno el número en array B
		addi $a1, $a1, 4	#Aumento en 4 $a1 para ingresar ahí próximo número par
		addi $t3, $t3,1		#Sumo uno al contador cada vez que hay un número par
		j inc
		
	inc:
		lw $a0, 0($sp) 		#Restauro valor de la pila
		addi $sp, $sp, 4	#Devuelvo $sp a su valor original
		addi $a0, $a0, 4	#Sumo 4 para evaluar siguiente valor en el array
		j EvenOrOdd
		
End:
	la $a0,res      	 #Se carga en el registro $a0 la dirección de la variable res
	jal print_string	 #Imprimimos string
		
	move $a0, $t3		#Carga a $a0 el valor del contador
	jal print_int		#Imprimimos cantidad de números con función print_int
		
	sll $t4, $t3, 2		#Multiplicamos contador por 4 para devolver dirección de a1 a valor original
	sub $a1, $a1, $t4	#Devolvemos registro a valor original restandole $t4
	j final 	 	#Terminamos programa

		
print_string:
	li $v0, 4		#Código para imprimir string
	syscall			#Se imprime en consola	
	jr $ra			#Se vuelve a la función que llamó 
	
print_int:
	li $v0, 1		#Código para imprimir números enteros
	syscall			#Se imprime en consola
	jr $ra			#Se vuelve a la función que llamó
		
final:
		
	li $v0, 10		#Código para terminar el programa
	syscall
	
		
		
		
		
