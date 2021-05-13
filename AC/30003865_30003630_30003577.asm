.data
#GENERATOR.asm
#Alterar o seguinte mapa consoante a vossa forma (4x4), em que cada entrada (x,y) deve ser a localizacao de "1". 
#Considera-se um mapa e forma (4x4). Caso a sua forma 2D seja maior que 4x4, o codigo tera de ser modificado de forma concordante.
#Neste exemplo especifico, considerou-se a forma 2D identificada no trabalho como a forma "1".

#
framebuffer: .space 1000

#espaco pre-alocado para guardar bitmap na memoria [!]
map: .space 100000

#Definicao das entradas (x,y) que compoe a forma 2D
figure_x: .byte 0,1,2,3,4
figure_y: .byte 0,0,0,0,0

#Numero de celulas a 1 da forma escolhida. Neste caso, para a forma 1, temos 4 valores (0,0), (1,0), (2,0) e (1,1)
fig_cells: .byte 5

#Dimensao do bitmap e' dada por l^2, onde l representa a dimensao do lado, que deve ser sempre impar.
#Para este caso, l=11. 
d: .word 11

#Strings para prints de fim de programa
textencontrou: .asciiz "\nEncontrou a peca na posicao: "
textnaoencontrou: .asciiz "\nA peca nao esta no mapa."

#Aloca espa�o para guarda coordenadas da pe�a
encontrada: .space 4


.text

#Gerar um mapa aleatorio com 0's e 1's
jal GetRandomMap

#Faz print do resultado do mapa random (descomentar a linha seguinte)
#jal PrintMap

#Coloca a forma 2D no mapa gerado, numa posicao aleatoria
jal GetMapwPiece

#Faz print do resultado no mapa com a forma
jal PrintMap

#Encontra a pe�a
jal Find

#Coloca o mapa no Bitmap Display
jal PrintBitmap

j exit


GetRandomMap:
#Gera um mapa aleatorio com 0's e 1's
	
	#protege as variaveis usadas
	addi $sp,$sp,-8	
	sw $s1,0($sp)
	sw $s2,4($sp)
	sw $s0,8($sp)
	

	#$t1 - area do mapa
	lw $t1, d
	
	multu $t1,$t1
	
	#$t2 - Numero total de entradas no mapa 
	mflo $t2

	#Guarda em $s0 o endere�o do mapa a preencher 
	la $s0, map

	#inicia o contador iterador no array com todas as entradas do mapa 
	li $t4,0
	
	#Prepara a execucao de randoms para 
	li $v0, 42 # Codigo associado a' gerac�o de nnmeros inteiros aleatorios
	li $a0, 1	
	addi $a1, $t2, 1 #fin [!]

	#Percorre todos as entradas, determinando se sao preenchidas a "0" ou a "1". 
	#(Este codigo pode ser modificado para se tornar o preenchimento mais ou menos denso de 1's, 
	# correndo-se o risco, no caso mais denso, de existirem varias formas 2D iguais as que procuramos)
	#Neste momento, guarda 4 zeros, e depois, de forma aleatoria, coloca um "1" ou um "0".
	LOOP0:	
		beq $t4,$t2,return01     		
		addi $s0, $s0, 1		
		sb $zero, ($s0) 	#Guarda 0 nesta posicao
		addi $t4,$t4,1
		
		beq $t4,$t2,return01
		addi $s0, $s0, 1		
		sb $zero, ($s0) 	#Guarda 0 nesta posicao
		addi $t4,$t4,1
		
		beq $t4,$t2,return01
		addi $s0, $s0, 1		
		sb $zero, ($s0) 	#Guarda 0 nesta posicao		
		addi $t4,$t4,1
		
		#beq $t4,$t2,return01
		#addi $s0, $s0, 1		
		#sb $zero, ($s0) 	#Guarda 0 nesta posicao	
		#addi $t4,$t4,1		
		
		beq $t4,$t2,return01    
		addi $s0, $s0, 1 
		li $a1, 2		
		syscall
		
		#guarda random "1" ou "0" - comentar esta linha para ter um mapa sem ruido
		sb $a0, ($s0) 		
						
		addi $t4,$t4,1
		j LOOP0

	return01:
	

	lw $s1,0($sp)
	lw $s2,4($sp)
	lw $s0,8($sp)	
	addi $sp,$sp,8
	 	
	jr $ra

GetMapwPiece:

	#protege variaveis usadas
	addi $sp,$sp,-16
	sw $s7,0($sp)
	sw $s4,4($sp)
	sw $s0,8($sp)
	sw $s5,12($sp)
	sw $s6,16($sp)
	

	#lado do mapa - $s0
	lw $s0, d
	multu $s0,$s0
	
	#area do mapa
	mflo $t2
	
	#encontra aletoriamente uma posicao para a forma 2D ($s4)
	li $v0, 42
	li $a0, 1
	addi $a1, $t2, 1
	syscall
	move $s4, $a0 # em $s4 fica a posicao da forma	
	
	#Descomentar a proxima linha para colocar a forma numa posicao conhecida (15) - para debuging 
	#Atencao que a posicao da forma conta a partir de 0. 
	#li $s4, 15
	
	li $a0, 1
	li $a1, 2
	syscall

	move $v0, $a0 #guarda em $vo a rotacao da forma (parametro para jal rotate)
	
	#verifica se a forma deve ser rodada de 180 graus consoante o random anterior
	bne $v0, $zero, nrotate
		
		#prepara a chamada da funcao rotate, guardando $ra
		addi $sp, $sp, -4
		sw $ra, ($sp) 
		#Roda a forma de 180 graus
		jal rotate
	
	#recupera o $ra do $sp
	lw $ra, ($sp) 
	addi $sp, $sp, 4
	
	
	nrotate:
	
	#vai buscar o inicio do mapa (endereco) e guarda em $t7
	la $t7, map
	
	#carrega os endereco das posicoes (x,y) da forma 	
	la $s5, figure_x
	la $s6, figure_y	
	
	#carrega o numero de entradas da forma
	lb $s7, fig_cells
	
	#faz um loop que precorre todas as entradas da forma ($s7) e devolve um mapa com a forma inserida.
	LOOP2:	
		beq $s1, $s7, return02
				
		#vai buscar os valores da primeira entrada para x e para y		
		lb $t5, ($s5) #x
		lb $t6, ($s6) #y relativos da cada ponto da forma
		
		
		divu $s4, $s0 		
		#posicao x da forma no mapa dada a posicao absoluta da forma encontrada anteriormente
		mfhi $t3
		
		#posicao y da forma no mapa dada a posicao absoluta da forma encontrada anteriormente
		mflo $t8
		
				
		#posicao x,y final do elemento (posicao do elemento na forma + posicao da forma no mapa): 
		add $t5, $t5, $t3 #x
		add $t6, $t8, $t6 #y
	
		li $t9, 1
		
		multu $t6, $s0
		mflo $t3
		#$s2 - posicao final no array da entrada da forma de cada iteracao do loop
		add $t0, $t3, $t5
		#$t6 - endereco dessa entrada						
		add $t6, $t7, $t0
		
		#escrita do valor 1 nesse endereco
		sb $t9, ($t6)
		
		addi $s1, $s1, 1 #iteracao no loop		
		addi $s5, $s5, 1 #iteracao do endereco x
		addi $s6, $s6, 1 #iteracao do endereco y	
			
		j LOOP2	
	
	return02:
	

	lw $s7,0($sp)
	lw $s4,4($sp)
	lw $s0,8($sp)
	lw $s5,12($sp)
	lw $s6,16($sp)
	
	addi $sp,$sp,16	
		
	jr $ra		

PrintMap:
#imprime o bitmap com "0" e "1" no ecr�
	

	#lado do mapa - $s0
	lw $t1, d
	multu $t1,$t1
	# area do mapa
	mflo $t2
	
	
	#inicializa a iteracao
	li $t4,0
	
	la $t7, map
	
	#Faz print do bitmap, iterando por todas as celulas
	LOOP1:	
		beq $t4,$t2,return2
		lb $a0, ($t7)
		addi $t7, $t7, 1 
		li  $v0, 1          		
		#imprime o valor que esta no bitmap ($t7)
		syscall
		
		li $v0, 0xB
		addi $a0, $zero, 0x20
		#imprime um espa�o de separacao horizontal
		syscall		

		li $v0, 1
		addi $t4, $t4,1
		divu $t4, $t1	#procura o resto para saber se tem que introduzir uma quebra de linha            
		mfhi $t3				
		#se chegou ao fim da linha imprime um carrier - return - nova linha
		bne $zero, $t3, next
			li $v0, 0xB
			addi $a0, $zero, 0xA
			syscall
			li $v0, 1				
		
		next:
		
		j LOOP1

	return2:	

	jr $ra


rotate:
#roda uma forma de 180 graus - igual a simetria em x e simetria em y
	
	#carrega entradas em x e dimensao da forma
	la $t1, figure_x
	lb $t3, fig_cells 
	
	move $t4, $zero
	#itera em cada entrada em x para fazer simetria em x
	LOOP3:
		beq, $t3, $t4, exit2		
		
		#faz simetria em x, usando $t5 para guardar o valor		
		lb $t5, ($t1)
		#partindo do principio que a forma tem 4 entradas de lado, a simetria deve ser 4-x, 
		#sendo x a posicao actual deste "1" 
		li $t6, 5
		#subtrai a 4 a posicao actual
		sub $t5, $t6, $t5
		
		#guarda a entrada de novo no map.
		sb $t5, ($t1)
		
		#itera
		addi $t4, $t4, 1
		addi $t1, $t1, 1
		j LOOP3
	exit2:
	
	#carrega entradas em y e posicao da forma
	la $t1, figure_y
	
	move $t4, $zero
	#itera em cada entrada em y para fazer simetria em y (igual ao codigo para x)
	LOOP4:
		beq, $t3, $t4, exit3				
		lb $t5, ($t1)
		li $t6, 4
		sub $t5, $t6, $t5
		sb $t5, ($t1)
		
		addi $t4, $t4, 1
		addi $t1, $t1, 1
		j LOOP4
	exit3:


	jr $ra

Find:
	
	#protege variaveis usadas
	addi $sp, $sp, -20
	sw $s0, 0($sp)
	sw $s1, 4($sp)
	sw $s2, 8($sp)
	sw $s3, 12($sp)
	sw $s4, 16($sp)
	
	#�rea do mapa/n�mero de entradas do mapa
	lw $s4, d
	multu $s4,$s4
	mflo $s0
	
	#vai buscar o inicio do mapa (endereco) e guarda em $s2
	la $s2, map
	
	#contador das entradas j� visitadas
	li $s1, 0
	
	#contador de pe�as encontradas
	li $s3, 0
	
	Findloop:		#itera sobre o mapa para encontrar a pe�a
		slt $t0, $s1, $s0	#verifica se o contador � maior que o tamanho do mapa
		bne $t0, 1, Acabou	#se o contador for maior que o tamanho do mapa prosegue para a termina��o do programa
		add $t2, $s2, $s1		#calcula endere�o da posi��o atual
		lb $t0, 0($t2)			
		bne $t0, 1, nPieceLogic    	#se encontra n�o encontra um "1" ignora a dete��o da pe�a
			#j PieceLogicrodada     #a pe�a rodada � igual � pe�a normal por isso descomentar esta linha dar� dois outputs iguais no entanto 
						#as duas fun��es funcionam de maneira parecida mas diferente, para verificiar que esta funciona � ncess�rio comentar a pen�ltima linha da
						#na label PrintEncontrou pois o programa foi otimizado utilizando apenas o m�todo de PieceLogic
			j PieceLogic		
		nPieceLogic:
		addi $s1, $s1, 1 #itera��o no loop
		j Findloop
	
	PieceLogic:
	move $t1, $s1
	addi $s1, $s1, 4  	#salta o tamanho da pe�a
	PieceLogicloop:
		beq $t1, $s1, PrintEncontrou		# se a variavel de itera��o voltar � posi��o inicial � porque a pe�a est� completa
		
		divu $s1, $s4		     #procura o resto para saber se a pe�a       
		mfhi $t3	   	     #foi quebrada pela mudan�a de linha
		beq $zero, $t3, Findloop     #em ess�ncia deteta se o valor atual tem coordenada x=0
		
		add $t2, $s2, $s1
		lb $t0, 0($t2)		     #verifica o valor da posi��o atual
		beq $t0, $0, Findloop	     #se valor atual for zero -> n�o existe a pe�a -> volta para o loop normal
		
		
		addi $s1, $s1, -1  	     #recua posi��o a posi��o at� � posi��o inicial	
		
		j PieceLogicloop
	
	PieceLogicrodada:
	move $t1, $s1
	addi $t1, $t1, 4	#salta o tamanho da pe�a
	rodadaloop:
		beq $t1, $s1, PrintEncontrou  	#se o contador chegar ao fim da pe�a � porque encontrou a pe�a
		addi $s1, $s1, 1		#itera at� � posi��o final
		
		divu $s1, $s4		     #procura o resto para saber se a pe�a       
		mfhi $t3	   	     #foi quebrada pela mudan�a de linha
		beq $zero, $t3, Findloop     #em ess�ncia deteta se o valor atual tem coordenada x=0
		
		add $t2, $s2, $s1		#an�logo ao PieceLogic
		lb $t0, 0($t2)			#verifica o valor da posi��o atual
		beq $t0, $0, Findloop		#e sai se for 0
		j rodadaloop
		
	
	PrintEncontrou:
	#output que indica que a pe�a foi encontrada
	li $v0, 4
	la $a0, textencontrou
	syscall
	la $t3, encontrada	#guarda a localiza��o da pe�a na mem�ria para que seja utilizada na fun��o do bitmap display
	sb $t1, 0($t3)
	#afixa a coordenada x
	divu $t1, $s4
	mfhi $a0
	li $v0, 1
	#afixa uma v�rgula
	syscall
	li $v0, 11
	li $a0, 44
	#afixa a coordenada y
	syscall
	li $v0, 1
	mflo $a0
	syscall
	
	addi $s3, $s3, 1    #um contador do n�mero de pe�as que foram encontradas, que � relevante para o final da procura
	addi $s1, $s1, 4    #salta novamente casas � frente para o fim da pe�a (linha a comentar para utilizar PieceLogicrodada)
	j Findloop
	
	Acabou:
	move $a1, $s3
	bne $s3, $0, finalreturn    #ignora o output de pe�a n�o encontrada caso se tenha encontrado alguma pe�a
	li $v0, 4
	la $a0, textnaoencontrou
	syscall
	
	finalreturn:
	lw $s0, 0($sp)
	lw $s1, 4($sp)
	lw $s2, 8($sp)
	lw $s3, 12($sp)
	lw $s4, 16($sp)
	addi $sp, $sp, 20
	
	jr $ra

PrintBitmap:

	addi $sp, $sp, -12
	sw $s0, 0($sp)
	sw $s1, 4($sp)
	sw $ra, 8($sp)
	
	la $a0, encontrada
	lb $s0, ($a0)		#prepara a posi��o da pe�a encontrada no bitmap
	lw $t1, d		# Constante comprimento e altura
	move $t6, $t1		# Tamanho m�ximo restante para uma linha no Bitmap Display(contador decrescente)
	
	multu $t1,$t1
	mflo $t2 		#�rea do mapa/valor da �ltima entrada

	li $t4, 0 		# Prepara iterador
	la $t7, map 		# Carrega endere�o do mapa
	la $t3, framebuffer	# Carrega endere�o para o bitmap display
	li $t5, 0xcccccccc 	# Cor Branca
	
	BitmapLoop:
		beq $t4, $t2, conclui 		# Acabou array
		bne $t4, $s0, nDesenhaPeca  	#quando o contador do BitmapLoop for igual � localiza��o absoluta da pe�a (que foi encontrada anteriormente) altera o procedimento 
			jal DesenhaPeca		#procedimento para obter uma cor diferente
		nDesenhaPeca:
		lb $t0, ($t7)			# Obtem valor na posi��o
		
		beq $t0, $0, saltapixel		#se encontrar um zero ent�o n�o coloca cor nenhuma no bitmap display

		sw 	$t5, ($t3) 		# Grava cor nesse endere�o, word por a cor escolhida � de 32bits
		saltapixel:
		addi $t6,$t6, -1		#decrementa o contador da linha
		bne $t6, $0, continualinha
			addi $t3, $t3, 84 	#Pr�xima linha do Bitmap Display
			move $t6, $t1		#d� reset ao contador da linha	
		continualinha:
		
		addi $t3, $t3, 4 	#Pr�xima word do framebuffer (Bitmap Display)
		addi $t7, $t7, 1 	#avan�a para o pr�ximo byte do mapa
		addi $t4, $t4, 1 	#incrementa o iterador do loop
		j BitmapLoop
		
	DesenhaPeca:
		beq $a1, $0, nDesenhaPeca	#verifica se a pe�a est� no mapa utilizando a 
		li $s0, 0xfff00000 		#cor vermelha
		add $t8, $0, $0
		DesenhaLoop:
			beq $t8, 5, BitmapLoop 		#verifica se j� colocou os 5 pixeis da pe�a
			sw $s0, ($t3)			#guarda a c�r vermelha da pe�a no framebuffer
			
			addi $t6,$t6, -1		#decrementa o contador da linha
			bne $t6, $0, continualinha2
				addi $t3, $t3, 84 	#Pr�xima linha do Bitmap Display
				move $t6, $t1		#d� reset ao contador da linha
			continualinha2:
		
			addi $t3, $t3, 4 	#Pr�xima word do framebuffer (Bitmap Display)
			addi $t7, $t7, 1 	#avan�a para o pr�ximo byte do mapa
			addi $t4, $t4, 1 	#incrementa o iterador do BitmapLoop
			addi $t8, $t8, 1	#itera dentro do DesenhaLoop
			
			j DesenhaLoop
	
	conclui:
	lw $s0, 0($sp)
	lw $s1, 4($sp)
	lw $ra, 8($sp)
	addi $sp, $sp, 12
	
	jr $ra
exit:

