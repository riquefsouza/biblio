'Modulo de Graficos

'$INCLUDE: 'biblio.inc'

'--------------------------------------------------------------------
' Nome : AbrirArquivo
' Descricao : procedimento que Abri o tipo de arquivo selecionado.
' Parametros :
' tipo - indica o numero de qual arquivo a ser aberto
'--------------------------------------------------------------------
SUB AbrirArquivo (tipo AS INTEGER)

  IF tipo = 1 THEN
     CLOSE LivrosFile
     OPEN "Livros.dat" FOR RANDOM AS #1 LEN = LEN(Livros)
     nTamLivros = LOF(LivrosFile) / LEN(Livros)
  END IF
  IF tipo = 2 THEN
     CLOSE UsuariosFile
     OPEN "Usuarios.dat" FOR RANDOM AS #2 LEN = LEN(Usuarios)
     nTamUsuarios = LOF(UsuariosFile) / LEN(Usuarios)
  END IF
  IF tipo = 3 THEN
     CLOSE EmprestiFile
     OPEN "Empresti.dat" FOR RANDOM AS #3 LEN = LEN(Emprestimos)
     nTamEmprestimos = LOF(EmprestiFile) / LEN(Emprestimos)
  END IF
  IF tipo = 4 THEN
     CLOSE SobreFile
     OPEN "Sobre.dat" FOR INPUT AS #4
  END IF

END SUB

'--------------------------------------------------------------------
' Nome : Botao
' Descricao : funcao que realiza a acao de apertar o botao.
' Parametros :
' topo - posicao da linha inicial na tela
' esquerda - posicao da coluna inicial na tela
' fg - cor do texto
' bg - cor de fundo
' sfg - cor do texto da sombra
' sbg - cor de fundo da sombra
' texto - o texto a ser escrito no botao
' foco - indica se o botao esta focado ou nao
'--------------------------------------------------------------------
FUNCTION Botao (topo AS INTEGER, esquerda AS INTEGER, fg AS INTEGER, bg AS INTEGER, sfg AS INTEGER, sbg AS INTEGER, texto AS STRING, foco AS INTEGER)
DIM tam AS INTEGER
DIM cont AS INTEGER

tam = LEN(texto)
DesenhaBotao topo, esquerda, fg, bg, sfg, sbg, texto, foco

DO

sKey$ = inkeyEx$

IF foco = true THEN
  IF sKey$ = "CarriageReturn" THEN
      Etexto esquerda + 1, topo, fg, bg, CHR$(16) + texto + CHR$(17)
      Etexto esquerda, topo, sfg, sbg, " "
      FOR cont = 1 TO tam + 2
        Etexto esquerda + cont, topo + 1, sfg, sbg, " "
      NEXT cont
      SLEEP 1
      Botao = 2
      EXIT DO
  END IF
END IF

LOOP UNTIL sKey$ = "Tab"
 IF sKey$ = "Tab" THEN
    Botao = 1
 END IF

END FUNCTION

'--------------------------------------------------------------------
' Nome : DesenhaBotao
' Descricao : procedimento que desenha um botao na tela
' Parametros :
' topo - posicao da linha inicial na tela
' esquerda - posicao da coluna inicial na tela
' fg - cor do texto
' bg - cor de fundo
' sfg - cor do texto da sombra
' sbg - cor de fundo da sombra
' texto - o texto a ser escrito no botao
' foco - indica se o botao esta focado ou nao
'--------------------------------------------------------------------
SUB DesenhaBotao (topo AS INTEGER, esquerda AS INTEGER, fg AS INTEGER, bg AS INTEGER, sfg AS INTEGER, sbg AS INTEGER, texto AS STRING, foco AS INTEGER)
DIM tam  AS INTEGER
DIM cont AS INTEGER

tam = LEN(texto)
IF foco = false THEN
   Etexto esquerda, topo, fg, bg, " " + texto + " "
END IF
IF foco = true THEN
  Etexto esquerda, topo, fg, bg, CHR$(16) + texto + CHR$(17)
END IF
Etexto esquerda + tam + 2, topo, sfg, sbg, CHR$(220)
FOR cont = 1 TO tam + 2
  Etexto esquerda + cont, topo + 1, sfg, sbg, CHR$(223)
NEXT cont
END SUB

'--------------------------------------------------------------------
' Nome : DesenhaLista
' Descricao : procedimento que desenha uma Lista rolavel na tela
' Parametros :
' tipo - indica o numero de qual arquivo a ser aberto
' topo - posicao da linha inicial na tela
' esquerda - posicao da coluna inicial na tela
' altura - indica a altura da lista
' largura - indica a largura da lista
' fg - cor do texto
' bg - cor de fundo
' posi - indica a ultima posicao da linha da lista na tela
' col - indica a ultima posicao da coluna da lista na tela
' foco - indica se a lista esta focada ou nao
'--------------------------------------------------------------------
SUB desenhalista (tipo AS INTEGER, topo AS INTEGER, esquerda AS INTEGER, altura AS INTEGER, largura AS INTEGER, fg AS INTEGER, bg AS INTEGER, posi AS INTEGER, col AS INTEGER, foco AS INTEGER)
DIM cont AS INTEGER
DIM posicao AS STRING
DIM coluna AS STRING
DIM sLista AS STRING

IF foco = true THEN
   Etexto esquerda - 1, topo - 1, fg, bg, "Ú"
   Etexto esquerda + largura + 1, topo - 1, fg, bg, "¿"
   Etexto esquerda - 1, topo + altura, fg, bg, "À"
   Etexto esquerda + largura + 1, topo + altura, fg, bg, "Ù"
ELSE
   Etexto esquerda - 1, topo - 1, fg, bg, " "
   Etexto esquerda + largura + 1, topo - 1, fg, bg, " "
   Etexto esquerda - 1, topo + altura, fg, bg, " "
   Etexto esquerda + largura + 1, topo + altura, fg, bg, " "
END IF
AbrirArquivo tipo
sLista = TiposLista(tipo, largura, posi + 1, col + 1)
Etexto esquerda, topo, fg, bg, sLista + Repete$(" ", largura - LEN(sLista))
FOR cont = 1 TO altura - 2
  sLista = TiposLista(tipo, largura, posi + cont + 1, col + 1)
  Etexto esquerda, topo + cont, fg, bg, sLista + Repete$(" ", largura - LEN(sLista))
NEXT cont
sLista = TiposLista(tipo, largura, posi + altura, col + 1)
Etexto esquerda, topo + altura - 1, fg, bg, sLista + Repete$(" ", largura - LEN(sLista))

posicao = LTRIM$(STR$(posi + 1))
Etexto esquerda, topo + altura + 1, fg, bg, "Linha : " + Repete$("0", 4 - LEN(posicao)) + posicao
coluna = LTRIM$(STR$(col + 1))
Etexto esquerda + 14, topo + altura + 1, fg, bg, "Coluna : " + Repete$("0", 4 - LEN(coluna)) + coluna

END SUB

'------------------------------------------------------------------------
' Nome : Digita
' Descricao : Procedimento que permite ter um maior controle da digitacao
' de um texto, tambem permitindo indicar um texto maior do que o permitido
' pelo espaco limite definido.
' Parametros :
' S - e o resultado da digitacao
' JanelaTam - indica o tamanho maximo de visualizacao do texto digitado
' MaxTam - indica o tamanho maximo do texto a ser digitado
' X - posicao da coluna na tela
' Y - posicao da linha na tela
' fg - cor do texto
' bg - cor de fundo
' FT - indica o tipo de caracter a ser digitado se (N)umero ou (T)exto
' fundo - Indica o caracter de fundo, da janela de digitacao
'--------------------------------------------------------------------------
FUNCTION Digita$ (S AS STRING, JanelaTam AS INTEGER, maxtam AS INTEGER, x AS INTEGER, y AS INTEGER, fg AS INTEGER, bg AS INTEGER, FT AS STRING, fundo AS INTEGER)
DIM xx AS INTEGER
DIM t AS INTEGER
DIM j AS INTEGER
DIM p AS INTEGER
DIM InsertOn AS INTEGER
DIM compensacao AS INTEGER
DIM tempstr AS STRING
DIM sret AS STRING

'-------------------------------------------
j = LEN(S) + 1
FOR t = j TO maxtam
   vs(t) = CHR$(fundo)
NEXT t
vs(0) = CHR$(maxtam)

'----------------------------
FOR t = 1 TO maxtam
  S = S + vs(t)
NEXT t
S = LTRIM$(S)
'----------------------------

tempstr = MID$(S, 1, JanelaTam)
EscreveRapido x, y, tempstr, fg, bg
p = 1
compensacao = 1
InsertOn = true

DO

xx = x + (p - compensacao)
IF (p - compensacao) = JanelaTam THEN
   xx = xx - 1
END IF

'XY XX, y
'---------------------
DIM xsmall AS INTEGER
xsmall = 0
DO
   xsmall = xx - 80
   IF xsmall > 0 THEN
      y = y + 1
      xx = xsmall
   END IF
LOOP UNTIL xsmall <= 0
LOCATE y + 1, xx - 1
'--------------------

sKey$ = inkeyEx$

IF FT = "N" THEN
   IF sKey$ = "TextKey" THEN
      BEEP
      sKey$ = "NullKey"
   ELSEIF (ch = "-") AND ((p > 1) OR (vs(1) = "-")) THEN
     BEEP
     sKey$ = "NullKey"
   ELSEIF (ch = ".") THEN
      IF NOT ((INSTR(1, S, ".") = 0) OR (INSTR(1, S, ".") = p)) THEN
         BEEP
         sKey$ = "NullKey"
      ELSEIF (INSTR(1, S, ".") = p) THEN
         S = Deletar$(S, p, 1)
      END IF
   END IF
END IF

SELECT CASE sKey$
CASE "NumberKey", "TextKey", "SpaceKey"
     IF (LEN(S) = maxtam) THEN
        IF p = maxtam THEN
           S = Deletar$(S, maxtam, 1)
           S = S + ch
           IF p = JanelaTam + compensacao THEN
             compensacao = compensacao + 1
           END IF
           tempstr = MID$(S, compensacao, JanelaTam)
           EscreveRapido x, y, tempstr, fg, bg
        ELSE
           IF InsertOn THEN
              S = Deletar$(S, maxtam, 1)
              S = inserir$(ch, S, p)
              IF p = JanelaTam + compensacao THEN
                 compensacao = compensacao + 1
              END IF
              IF p < maxtam THEN
                 p = p + 1
              END IF
              tempstr = MID$(S, compensacao, JanelaTam)
              EscreveRapido x, y, tempstr, fg, bg
           ELSE
              S = Deletar$(S, p, 1)
              S = inserir$(ch, S, p)
              IF p = JanelaTam + compensacao THEN
                 compensacao = compensacao + 1
              END IF
              IF p < maxtam THEN
                 p = p + 1
              END IF
              tempstr = MID$(S, compensacao, JanelaTam)
              EscreveRapido x, y, tempstr, fg, bg
           END IF
        END IF
     ELSE
           IF InsertOn THEN
              S = inserir$(ch, S, p)
           ELSE
               S = Deletar$(S, p, 1)
               S = inserir$(ch, S, p)
           END IF
           IF p = JanelaTam + compensacao THEN
               compensacao = compensacao + 1
           END IF
           IF p < maxtam THEN
              p = p + 1
           END IF
           tempstr = MID$(S, compensacao, JanelaTam)
           EscreveRapido x, y, tempstr, fg, bg
     END IF
CASE "Bksp"
      IF p > 1 THEN
         p = p - 1
         S = Deletar$(S, p, 1)
         S = S + CHR$(fundo)
         IF compensacao > 1 THEN
           compensacao = compensacao - 1
         END IF
         tempstr = MID$(S, compensacao, JanelaTam)
         EscreveRapido x, y, tempstr, fg, bg
         ch = " "
      ELSE
         BEEP
         ch = " "
         p = 1
      END IF
CASE "LeftArrow"
     IF p > 1 THEN
         p = p - 1
         IF p < compensacao THEN
             compensacao = compensacao - 1
             tempstr = MID$(S, compensacao, JanelaTam)
             EscreveRapido x, y, tempstr, fg, bg
         END IF
     ELSE
        SetString fundo
        'EXIT FUNCTION
     END IF

CASE "RightArrow"
      IF (vs(p) <> CHR$(fundo)) AND (p < maxtam) THEN
         p = p + 1
         IF p = (JanelaTam + compensacao) THEN
             compensacao = compensacao + 1
             tempstr = MID$(S, compensacao, JanelaTam)
             EscreveRapido x, y, tempstr, fg, bg
         END IF
      ELSE
         SetString fundo
         'EXIT FUNCTION
      END IF

CASE "DeleteKey"
      S = Deletar$(S, p, 1)
      S = S + CHR$(fundo)
      IF ((LEN(S) + 1) - compensacao) >= JanelaTam THEN
          tempstr = MID$(S, compensacao, JanelaTam)
          EscreveRapido x, y, tempstr, fg, bg
      ELSE
          tempstr = MID$(S, compensacao, JanelaTam)
          EscreveRapido x, y, tempstr, fg, bg
      END IF

CASE "InsertKey"
        IF InsertOn = true THEN
           InsertOn = false
        ELSE
           InsertOn = true
        END IF

CASE ELSE
  IF sKey$ = "UpArrow" OR sKey$ = "DownArrow" THEN
      BEEP
  ELSEIF sKey$ = "PgDn" OR sKey$ = "PgUp" OR sKey$ = "NullKey" THEN
      BEEP
  ELSEIF sKey$ = "Esc" OR sKey$ = "F1" OR sKey$ = "F2" THEN
      BEEP
  ELSEIF sKey$ = "F3" OR sKey$ = "F4" OR sKey$ = "F5" OR sKey$ = "F6" THEN
      BEEP
  ELSEIF sKey$ = "F7" OR sKey$ = "F8" OR sKey$ = "F9" OR sKey$ = "F10" THEN
      BEEP
  END IF

END SELECT

LOOP UNTIL (sKey$ = "CarriageReturn" OR sKey$ = "Tab")

SetString fundo

'----------------
LOCATE y, x, 0
Digita = Trim$(S)
'---------------

END FUNCTION

'--------------------------------------------------------------------
' Nome : formSplash
' Descricao : procedimento que desenha a tela inicial do sistema.
'--------------------------------------------------------------------
SUB formSplash

'cursor_off('C')
  formulario "", 6, 10, 12, 58, white, blue, "±", lightgray, black
  Etexto 13, 8, yellow, blue, " ²²²²²²²     ²    ²²²²²²²     ²       ²    ²²²²²² "
  Etexto 13, 9, yellow, blue, "²²²    ²²²   ²²  ²²²    ²²²   ²²      ²²  ²²²  ²²²"
  Etexto 13, 10, yellow, blue, "²²²²²²²²²    ²²  ²²²²²²²²²    ²²      ²²  ²²    ²²"
  Etexto 13, 11, yellow, blue, "²²²    ²²²   ²²  ²²²    ²²²   ²²²     ²²  ²²    ²²"
  Etexto 13, 12, yellow, blue, "²²²²   ²²²   ²²  ²²²²   ²²²   ²²²²    ²²  ²²²  ²²²"
  Etexto 13, 13, yellow, blue, " ²²²²²²²²²   ²²   ²²²²²²²²²   ²²²²²²  ²²   ²²²²²² "
  Etexto 13, 15, yellow, blue, "Programa Desenvolvido por Henrique Figueiredo de Souza"
  Etexto 13, 16, yellow, blue, "Todos os Direito Reservados - 1999  Versao 1.0"
  Etexto 13, 17, yellow, blue, "Linguagem Usada Nesta Versao << BASIC >>"
  SLEEP 2
END SUB

'---------------------------------------------------------------------
' Nome : formulario
' Descricao : procedimento que desenha um formulario na tela.
' Parametros :
' titulo - titulo do formulario
' topo - posicao da linha inicial na tela
' esquerda - posicao da coluna inicial na tela
' altura - a altura do formulario
' largura - a largura do formulario
' fg - cor do texto
' bg - cor de fundo
' sombra - o caracter que vai ser a sobra do formulario
' sfg - cor do texto da sombra
' sbg - cor de fundo da sombra
'---------------------------------------------------------------------
SUB formulario (Titulo AS STRING, topo AS INTEGER, esquerda AS INTEGER, altura AS INTEGER, largura AS INTEGER, fg AS INTEGER, bg AS INTEGER, sombra AS STRING, sfg AS INTEGER, sbg AS INTEGER)
DIM cont AS INTEGER
DIM cont2 AS INTEGER

  Etexto esquerda, topo, fg, bg, "Ú"
  FOR cont = 1 TO largura - 1
     LOCATE topo, esquerda + cont
     PRINT "Ä"
  NEXT cont
  LOCATE topo, esquerda + 2
  PRINT Titulo
  LOCATE topo, esquerda + largura
  PRINT "¿"
  FOR cont = 1 TO altura - 1
    LOCATE topo + cont, esquerda
    PRINT "³"
    FOR cont2 = 1 TO largura - 1
        LOCATE topo + cont, esquerda + cont2
        PRINT " "
    NEXT cont2
    LOCATE topo + cont, esquerda + largura
    PRINT "³"
    Etexto esquerda + largura + 1, topo + cont, sfg, sbg, sombra
    COLOR fg, bg
  NEXT cont
  LOCATE topo + altura, esquerda
  PRINT "À"
  FOR cont = 1 TO largura - 1
     Etexto esquerda + cont, topo + altura, fg, bg, "Ä"
     Etexto esquerda + cont + 1, topo + altura + 1, sfg, sbg, sombra
  NEXT cont
  Etexto esquerda + largura, topo + altura, fg, bg, "Ù"
  Etexto esquerda + largura + 1, topo + altura, sfg, sbg, sombra
  LOCATE topo + altura + 1, esquerda + largura + 1
  PRINT sombra
END SUB

'--------------------------------------------------------------------
' Nome : Lista
' Descricao : funcao que executa a acao de rolamento da lista.
' Parametros :
' tipo - indica o numero de qual arquivo a ser aberto
' topo - posicao da linha inicial na tela
' esquerda - posicao da coluna inicial na tela
' largura - indica a largura da lista
' tlinhas - indica o numero total de linhas da lista
' tcolunas - indica o numero total de colunas da lista
' fg - cor do texto
' bg - cor de fundo
' listapos - indica a ultima posicao da linha da lista na tela
' litacol - indica a ultima posicao da coluna da lista na tela
' foco - indica se a lista esta focada ou nao
'--------------------------------------------------------------------
FUNCTION lista (tipo AS INTEGER, topo AS INTEGER, esquerda AS INTEGER, altura AS INTEGER, largura AS INTEGER, tlinhas AS INTEGER, tcolunas AS INTEGER, fg AS INTEGER, bg AS INTEGER, foco AS INTEGER)
DIM cont2 AS INTEGER
DIM posicao AS STRING
DIM coluna AS STRING
DIM sLista AS STRING

desenhalista tipo, topo, esquerda, altura, largura, fg, bg, listapos, listacol, foco

DO

sKey$ = inkeyEx$

  IF sKey$ = "UpArrow" THEN
     IF listapos > 0 THEN
         listapos = listapos - 1
         FOR cont2 = 0 TO altura - 1
            sLista = TiposLista$(tipo, largura, listapos + cont2 + 1, listacol + 1)
            Etexto esquerda, topo + cont2, fg, bg, sLista + Repete$(" ", largura - LEN(sLista))
         NEXT cont2
         posicao = LTRIM$(STR$(listapos + 1))
         Etexto esquerda, topo + altura + 1, fg, bg, "Linha : " + Repete$("0", 4 - LEN(posicao)) + posicao
     END IF
  END IF

  IF sKey$ = "DownArrow" THEN
     IF listapos < (tlinhas - altura) THEN
         listapos = listapos + 1
         FOR cont2 = 0 TO altura - 1
            sLista = TiposLista$(tipo, largura, listapos + cont2 + 1, listacol + 1)
            Etexto esquerda, topo + cont2, fg, bg, sLista + Repete$(" ", largura - LEN(sLista))
         NEXT cont2
         posicao = LTRIM$(STR$(listapos + 1))
         Etexto esquerda, topo + altura + 1, fg, bg, "Linha : " + Repete$("0", 4 - LEN(posicao)) + posicao
     END IF
  END IF

  IF sKey$ = "RightArrow" THEN
     IF listacol < (tcolunas - largura) THEN
         listacol = listacol + 1
         FOR cont2 = 0 TO altura - 1
           sLista = TiposLista$(tipo, largura, listapos + cont2 + 1, listacol + 1)
           Etexto esquerda, topo + cont2, fg, bg, sLista + Repete$(" ", largura - LEN(sLista))
         NEXT cont2
         coluna = LTRIM$(STR$(listacol + 1))
         Etexto esquerda + 14, topo + altura + 1, fg, bg, "Coluna : " + Repete$("0", 4 - LEN(coluna)) + coluna
     END IF
  END IF

  IF sKey$ = "LeftArrow" THEN
     IF listacol > 0 THEN
         listacol = listacol - 1
         FOR cont2 = 0 TO altura - 1
           sLista = TiposLista$(tipo, largura, listapos + cont2 + 1, listacol + 1)
           Etexto esquerda, topo + cont2, fg, bg, sLista + Repete$(" ", largura - LEN(sLista))
         NEXT cont2
         coluna = LTRIM$(STR$(listacol + 1))
         Etexto esquerda + 14, topo + altura + 1, fg, bg, "Coluna : " + Repete$("0", 4 - LEN(coluna)) + coluna
     END IF
  END IF

LOOP UNTIL sKey$ = "Tab"
IF sKey$ = "Tab" THEN
  lista = 1
END IF
END FUNCTION

'-------------------------------------------------------------------
' Nome : Menu
' Descricao : procedimento que escreve a linha de opcoes do menu.
' Parametros :
' qtd - indica a quantidade de opcoes no menu
' topo - posicao da linha inicial na tela
' fg - cor do texto
' bg - cor de fundo
' lfg - cor do texto do primeiro caracter de cada opcao do menu
' lbg - cor de fundo do primeiro caracter de cada opcao do menu
' pos2 - indica a ultima opcao de menu referenciada pelo usuario
' mfg - cor do texto do selecionado
' mbg - cor de fundo do selecionado
' cont2 - indica a ultima posicao da descricao da opcao de menu
' referenciada pelo usuario
'-------------------------------------------------------------------
SUB Menu (qtd AS INTEGER, topo AS INTEGER, fg AS INTEGER, bg AS INTEGER, lfg AS INTEGER, lbg AS INTEGER, pos2 AS INTEGER, mfg AS INTEGER, mbg AS INTEGER, cont2 AS INTEGER)
DIM cont AS INTEGER
DIM pos1 AS INTEGER
DIM entre AS INTEGER

   FOR cont = 1 TO 80
      Etexto cont, topo, fg, bg, " "
   NEXT cont
   pos1 = 0
   entre = 0
   FOR cont = 1 TO qtd
      Etexto (pos1 + 4 + entre), topo, lfg, lbg, MID$(vMenu(cont), 1, 1)
      Etexto (pos1 + 5 + entre), topo, fg, bg, MID$(vMenu(cont), 2, LEN(vMenu(cont)))
      entre = entre + 3
      pos1 = pos1 + LEN(vMenu(cont))
   NEXT cont
   IF pos2 > 0 THEN
      Etexto (pos2 + 2), topo, lfg, mbg, (" " + MID$(vMenu(cont2), 1, 1))
      Etexto (pos2 + 4), topo, mfg, mbg, (MID$(vMenu(cont2), 2, LEN(vMenu(cont2))) + " ")
   END IF
END SUB

'--------------------------------------------------------------------
' Nome : TiposLista
' Descricao : funcao que indica quais arquivos serao usados com a lista,
' como tambem a formatacao do cabecalho desses arquivos na lista
' Parametros :
' tipo - indica o numero de qual arquivo a ser aberto
' largura - indica a largura do texto
' posi - indica a posicao do texto na lista
' col - indica a posicao da coluna do texto na lista
'--------------------------------------------------------------------
FUNCTION TiposLista$ (tipo AS INTEGER, largura AS INTEGER, posi AS INTEGER, col AS INTEGER)
DIM sAux AS STRING

IF tipo = 1 THEN
    IF posi = 1 THEN
        sAux = "Numero de Inscricao ³ Titulo                         ³ "
        sAux = sAux + "Autor                          ³ "
        sAux = sAux + "Area                           ³ Palavra-Chave ³ "
        sAux = sAux + "Edicao ³ Ano de Publicacao ³ "
        sAux = sAux + "Editora                        ³ Volume ³ Estado Atual"
        TiposLista = MID$(sAux, col, largura)
    END IF
    IF posi = 2 THEN
      TiposLista = Repete$("-", largura)
    END IF
    IF posi > 2 THEN
      IF nTamLivros > posi - 3 THEN
        SEEK LivrosFile, posi - 3 + 1
        GET LivrosFile, , Livros

          S = LTRIM$(STR$(Livros.Ninsc))
          sAux = Repete(" ", 19 - LEN(S)) + S + " ³ "
          sAux = sAux + Livros.Titulo + Repete$(" ", 31 - LEN(Livros.Titulo)) + "³ "
          sAux = sAux + Livros.Autor + Repete$(" ", 31 - LEN(Livros.Autor)) + "³ "
          sAux = sAux + Livros.Area + Repete$(" ", 31 - LEN(Livros.Area)) + "³ "
          sAux = sAux + Livros.Pchave + Repete$(" ", 14 - LEN(Livros.Pchave)) + "³ "
          S = LTRIM$(STR$(Edicao))
          sAux = sAux + Repete$(" ", 6 - LEN(S)) + S + " ³ "
          S = LTRIM$(STR$(Livros.AnoPubli))
          sAux = sAux + Repete$(" ", 17 - LEN(S)) + S + " ³ "
          sAux = sAux + Livros.Editora + Repete$(" ", 31 - LEN(Livros.Editora)) + "³ "
          S = LTRIM$(STR$(Livros.Volume))
          sAux = sAux + Repete$(" ", 6 - LEN(S)) + S + " ³ "
          IF Livros.Estado = "D" THEN
             sAux = sAux + "Disponivel"
          ELSE
             sAux = sAux + "Emprestado"
          END IF

         TiposLista = MID$(sAux, col, largura)
      ELSE
         TiposLista = ""
      END IF
    END IF
ELSEIF tipo = 2 THEN

    IF posi = 1 THEN
        sAux = "Numero de Inscricao ³ Nome                           ³ "
        sAux = sAux + "Identidade ³ Logradouro                     ³ "
        sAux = sAux + "Numero ³ Complemento ³ "
        sAux = sAux + "Bairro               ³ Cep      ³ "
        sAux = sAux + "Telefone    ³ Categoria   ³ Situacao"
        TiposLista = MID$(sAux, col, largura)
    END IF
    IF posi = 2 THEN
      TiposLista = Repete$("-", largura)
    END IF
    IF posi > 2 THEN
      IF nTamUsuarios > posi - 3 THEN
        SEEK UsuariosFile, posi - 3 + 1
        GET UsuariosFile, , Usuarios

          S = LTRIM$(STR$(Usuarios.Ninsc))
          sAux = Repete$(" ", 19 - LEN(S)) + S + " ³ "
          sAux = sAux + Usuarios.Nome + Repete$(" ", 31 - LEN(Usuarios.Nome)) + "³ "
          sAux = sAux + Repete$(" ", 10 - LEN(Usuarios.Ident)) + Usuarios.Ident + " ³ "
          sAux = sAux + Usuarios.Endereco.logra + Repete$(" ", 31 - LEN(Usuarios.Endereco.logra)) + "³ "
          S = LTRIM$(STR$(Usuarios.Endereco.numero))
          sAux = sAux + Repete$(" ", 6 - LEN(S)) + S + " ³ "
          sAux = sAux + Usuarios.Endereco.compl + Repete$(" ", 12 - LEN(Usuarios.Endereco.compl)) + "³ "
          sAux = sAux + Usuarios.Endereco.Bairro + Repete$(" ", 21 - LEN(Usuarios.Endereco.Bairro)) + "³ "
          sAux = sAux + Repete$(" ", 8 - LEN(Usuarios.Endereco.Cep)) + Usuarios.Endereco.Cep + " ³"
          sAux = sAux + Repete$(" ", 12 - LEN(Usuarios.Telefone)) + Usuarios.Telefone + " ³ "
          IF Usuarios.Categoria = "A" THEN
             sAux = sAux + "Aluno" + Repete$(" ", 12 - LEN("Aluno")) + "³ "
          ELSEIF Usuarios.Categoria = "P" THEN
             sAux = sAux + "Professor" + Repete$(" ", 12 - LEN("Professor")) + "³ "
          ELSEIF Usuarios.Categoria = "F" THEN
             sAux = sAux + "Funcionario" + Repete$(" ", 12 - LEN("Funcionario")) + "³ "
          END IF
          S = LTRIM$(STR$(Usuarios.Situacao))
          sAux = sAux + Repete$(" ", 8 - LEN(S)) + S
         
         TiposLista = MID$(sAux, col, largura)
      ELSE
         TiposLista = ""
      END IF
    END IF

ELSEIF tipo = 3 THEN
    IF posi = 1 THEN
        sAux = "Numero de Inscricao do Usuario ³ "
        sAux = sAux + "Numero de Inscricao do Livro ³ "
        sAux = sAux + "Data do Emprestimo ³ Data da Devolucao ³ "
        sAux = sAux + "Removido"
        TiposLista = MID$(sAux, col, largura)
    END IF
    IF posi = 2 THEN
      TiposLista = Repete$("-", largura)
    END IF
    IF posi > 2 THEN
      IF nTamEmprestimos > posi - 3 THEN
        SEEK EmprestiFile, posi - 3 + 1
        GET EmprestiFile, , Emprestimos

          S = ""
          S = LTRIM$(STR$(Emprestimos.NinscUsuario))
          sAux = Repete$(" ", 30 - LEN(S)) + S + " ³ "
          S = LTRIM$(STR$(Emprestimos.NinscLivro))
          sAux = sAux + Repete$(" ", 28 - LEN(S)) + S + " ³ "
          sAux = sAux + Emprestimos.DtEmprestimo + Repete$(" ", 19 - LEN(Emprestimos.DtEmprestimo)) + "³ "
          sAux = sAux + Emprestimos.DtDevolucao + Repete$(" ", 18 - LEN(Emprestimos.DtDevolucao)) + "³ "
          IF Emprestimos.Removido = true THEN
             sAux = sAux + "Sim"
          ELSE
             sAux = sAux + "Nao"
          END IF

         TiposLista = MID$(sAux, col, largura)
      ELSE
         TiposLista = ""
      END IF
    END IF

ELSEIF tipo = 4 THEN
    TiposLista = MID$(vLista(posi - 1), col, LEN(vLista(posi - 1)))
END IF
END FUNCTION

'-----------------------------------------------------------------------
' Nome : SubMenu
' Descricao : funcao que permite criar um controle de submenu, retornando
' a opcao selecionada.
' Parametros :
' numero - indica qual e o submenu
' qtd - indica a quantidade de linhas do submenu
' maxtam - indica a largura maxima do submenu
' topo - posicao da linha inicial na tela
' esquerda - posicao da coluna inicial na tela
' ultpos - indica a ultima opcao referenciada pelo usuario
' lfg - cor do texto selecionado
' lbg - cor de fundo selecionado
' fg - cor do texto
' bg - cor de fundo
'------------------------------------------------------------------------
FUNCTION SubMenu (numero AS INTEGER, qtd AS INTEGER, maxtam AS INTEGER, topo AS INTEGER, esquerda AS INTEGER, ultpos AS INTEGER, lfg AS INTEGER, lbg AS INTEGER, fg AS INTEGER, bg AS INTEGER)
DIM cont AS INTEGER
DIM cont2 AS INTEGER

 COLOR fg, bg

 FOR cont = 0 TO qtd - 1
    LOCATE topo + cont, esquerda
    PRINT (vSubMenu(numero, cont + 1) + Repete$(" ", (maxtam - LEN(vSubMenu(numero, cont + 1)))))
 NEXT cont
 Etexto esquerda, topo + ultpos - 1, lfg, lbg, vSubMenu(numero, ultpos) + Repete$(" ", maxtam - LEN(vSubMenu(numero, ultpos)))

 cont = ultpos - 2
 cont2 = ultpos - 1

 DO
   sKey$ = inkeyEx$

   IF sKey$ = "UpArrow" THEN
       cont = cont - 1
       cont2 = cont2 - 1
       IF cont2 = -1 THEN
          cont = -2
          cont2 = qtd - 1
       END IF

       Etexto esquerda, topo + cont + 2, fg, bg, vSubMenu(numero, cont + 3) + Repete$(" ", maxtam - LEN(vSubMenu(numero, cont + 3)))
       Etexto esquerda, topo + cont2, lfg, lbg, vSubMenu(numero, cont2 + 1) + Repete$(" ", maxtam - LEN(vSubMenu(numero, cont2 + 1)))

       IF cont = -2 THEN
          cont = qtd - 2
       END IF
   END IF
   IF sKey$ = "DownArrow" THEN
       cont = cont + 1
       cont2 = cont2 + 1
       IF cont2 = qtd THEN
          cont2 = 0
       END IF
       Etexto esquerda, topo + cont, fg, bg, vSubMenu(numero, cont + 1) + Repete$(" ", maxtam - LEN(vSubMenu(numero, cont + 1)))
       Etexto esquerda, topo + cont2, lfg, lbg, vSubMenu(numero, cont2 + 1) + Repete$(" ", maxtam - LEN(vSubMenu(numero, cont2 + 1)))

       IF cont = qtd - 1 THEN
          cont = -1
       END IF
   END IF

LOOP UNTIL (sKey$ = "CarriageReturn" OR sKey$ = "LeftArrow" OR sKey$ = "RightArrow")
 IF sKey$ = "LeftArrow" THEN
   SubMenu = 1
 ELSEIF sKey$ = "RightArrow" THEN
   SubMenu = 2
 ELSEIF sKey$ = "CarriageReturn" THEN
    SubMenu = cont2 + 3
 END IF
END FUNCTION
