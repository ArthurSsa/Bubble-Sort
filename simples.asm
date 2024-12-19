# Bubble Sort em Assembly (MIPS)
.data
array:  .word 7, 3, 9, 1, 6  # Array de exemplo
size:   .word 5              # Tamanho do array
.text
.globl main

main:
    # Inicializar ponteiros e variáveis
    la   $t0, array          # $t0 aponta para o início do array
    lw   $t1, size           # $t1 é o tamanho do array
    subi $t1, $t1, 1         # Reduzir o tamanho em 1 para laços

outer_loop:
    li   $t2, 0              # $t2 é o índice do loop interno

inner_loop:
    lw   $t3, 0($t0)         # Carrega array[i] em $t3
    lw   $t4, 4($t0)         # Carrega array[i+1] em $t4

    ble  $t3, $t4, no_swap   # Se array[i] <= array[i+1], não troca
    sw   $t4, 0($t0)         # Troca os valores
    sw   $t3, 4($t0)

no_swap:
    addi $t0, $t0, 4         # Avança para o próximo elemento
    addi $t2, $t2, 1         # Incrementa o índice interno
    blt  $t2, $t1, inner_loop # Continua o loop interno

    # Reajusta para o próximo ciclo do loop externo
    la   $t0, array          # Reinicia o ponteiro para o início
    subi $t1, $t1, 1         # Decrementa o tamanho
    bgtz $t1, outer_loop     # Continua o loop externo se $t1 > 0

    # Finaliza o programa
    li   $v0, 10             # Chamada de saída
    syscall
