.model tpascal

.data

vidtype db ?

.code

fastwrite proc far x:byte, y:byte, s:dword, fg:byte, bg:byte

public fastwrite

; calcula o deslocamento na memoria de video ((y-1)*80 + (x-1)) * 2
faststr: push ds
         xor bx,bx
         xor ax,ax
         mov bl,x     ; obtem x da area de armazenamento
         mov al,y     ; obtem y da area de armazenamento
         dec bx       ; diminui x de y para obter
         dec ax       ; o deslocamento correto
         mov cx,0080  ; multiplica a
         mul cx       ; soma por 2.
         mov di,ax    ; armazena o deslocamento inicial em DI.
; cria o byte de atributo
         mov bl,bg    ; obtem a cor de fundo
         mov al,fg    ; obtem a cor de frente
         mov cl,4     ; desloca a cor de frente
         shl bx,cl    ; para a metade superior do byte
         add bx,ax    ; acrescenta a cor de frente
         xchg bl,bh   ; move para o byte superior
         mov dx,3dah  ; carrega o endereco de saida CRT em dx.
; obtem o tipo de monitor
         xor ax,ax    ; atribui 0000h a ES
         mov es,ax
         mov ax,0449h ; atribui o deslocamento da
         mov si,ax    ; posicao do tipo de video
         mov ax,es:[si] ; se o tipo de video for 7
         cmp al,7     ; entao o monitor e
         jz mono      ; monocromatico
         mov ax,0b800h ; carrega o segmento
         mov es,ax    ; de cor em ES
         mov vidtype,1
         jmp chkstr   ; continua
mono:
         mov ax,0b000h ; carrega o segmento
         mov es,ax    ; monocromatico em ES
         mov vidtype,0
; carrega a cadeia e verifica o tamanho zero
chkstr:  lds si,s     ; carrega o endereco da cadeia em ds:si
         mov cl,[si]  ; especifica o tamanho da cadeia para cl.
         cmp cl,0     ; se o tamanho da cadeia for zero.
         jz endstr    ; encerra a rotina
         cld          ; desativa o sinalizador de direcao

nextchar:inc si       ; aponta para o proximo caracter
         mov bl,[si]  ; especifica-o para bl
         cmp vidtype,0; se monocromatico, nao verifica
         je movechar  ; repeticao de rastreio

wlow:    in al,dx     ; obtem a situacao de crt
         test al,1    ; a repeticao de rastreio esta desativada?
         jnz wlow     ; se desativada, espere para comecar
         cli          ; nenhuma interrupcao, por favor

whigh:   in al,dx     ; obtem a situacao de crt
         test al,1    ; a opcao de rastreio esta ativada ?
         jz whigh     ; se ativada, espere para interromper

movechar:mov ax,bx    ; move a cor e o caractere para ax
         stosw        ; move a cor e o caractere para a tela
         sti          ; as interrupcoes sao permitidas agora

         loop nextchar         ; terminado ?

endstr:  pop ds
         ret
fastwrite endp
code ends
     end
