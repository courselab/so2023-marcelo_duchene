.code16                  # Define o código como de 16 bits

.section .text
.globl _start            # Define _start como o ponto de entrada global

_start:
    mov $msg, %si        # Carrega o endereço da mensagem em SI
    call print_string    # Chama a função print_string para exibir a mensagem
    call halt             # Chama a função halt para finalizar o programa

print_string:
    lodsb                # Carrega o próximo caractere da mensagem em AL
    or %al, %al          # Verifica se AL é zero (fim da mensagem)
    jz end_print         # Se for zero, retorna
    mov $0x0e, %ah       # Seleciona o modo de terminal do BIOS
    int $0x10            # Chama a função de vídeo do BIOS para exibir o caractere atual
    jmp print_string     # Repete o processo para o próximo caractere

end_print:
    ret                  # Retorna da função print_string

halt:
    hlt                  # Para a execução do programa
    jmp halt             # Medida de segurança para garantir que o programa pare

msg:
    .ascii "Hello World"  # Define a mensagem a ser exibida

    .fill 510 - (. - _start), 1, 0  # Preenche o resto do espaço do setor de inicialização com zeros
    .word 0xaa55                    # Assinatura de boot

