.data
array:  .word 7, 3, 9, 1, 6  # Array de exemplo
size:   .word 5              # Tamanho do array
temp:   .space 20            # Array temporário para merge
.text
.globl main

main:
    la   $a0, array          # Endereço do array principal
    la   $a1, temp           # Endereço do array temporário
    li   $a2, 0              # Índice inicial (low)
    lw   $a3, size           # Tamanho do array
    subi $a3, $a3, 1         # Ajusta o índice final (high)
    jal  merge_sort          # Chama o Merge Sort

    # Finaliza o programa
    li   $v0, 10             # Chamada para sair
    syscall

# Função Merge Sort
merge_sort:
    bge  $a2, $a3, return_ms # Se low >= high, retorna

    # Calcula o índice do meio
    add  $t0, $a2, $a3       # t0 = low + high
    srl  $t0, $t0, 1         # t0 = (low + high) / 2

    # Ordena a metade esquerda
    move $t1, $a3            # Salva high
    move $a3, $t0            # Atualiza high = middle
    jal  merge_sort          # Recursão para a metade esquerda

    # Ordena a metade direita
    move $a2, $t0            # Atualiza low = middle + 1
    move $a3, $t1            # Restaura high original
    jal  merge_sort          # Recursão para a metade direita

    # Mescla as duas metades
    move $a2, $t1            # Atualiza low e high
    move $a3, $t1
    jal  merge               # Chama a função de merge

return_ms:
    jr   $ra                 # Retorna

# Função Merge
merge:
    # Inicializa índices
    move $t0, $a2            # i = low
    add  $t1, $a2, 1         # j = middle + 1
    move $t2, $a3            # k = low

merge_loop:
    bgt  $t0, $a3, merge_end # Se i > high, fim do merge

    # Verifica qual elemento é menor
    lw   $t3, 0($a0)         # array[i]
    lw   $t4, 0($a0)         # array[j]
    ble  $t3, $t4, copy_left # Se array[i] <= array[j]

    # Copia array[j] para temp[k]
    sw   $t4, 0($a1)         # temp[k] = array[j]
    addi $t1, $t1, 1         # j++

    j    merge_next

copy_left:
    # Copia array[i] para temp[k]
    sw   $t3, 0($a1)         # temp[k] = array[i]
    addi $t0, $t0, 1         # i++

merge_next:
    addi $t2, $t2, 4         # k++

    j    merge_loop          # Próxima iteração

merge_end:
    # Copia elementos restantes da metade esquerda (se houver)
    lw   $t3, 0($t0)
    sw   $t3, 0($a1)
    addi $t0, $t0, 1
    addi $t2, $t2, 4

    # Copia elementos restantes da metade direita (se houver)
    lw   $t4, 0($t1)
    sw   $t4, 0($a1)
    addi $t1, $t1, 1
    addi $t2, $t2, 4

    # Copia de temp para array original
    lw   $t5, 0($a1)
    sw   $t5, 0($a0)
    addi $a1, $a1, 4
    addi $a0, $a0, 4

    jr   $ra                 # Retorna
