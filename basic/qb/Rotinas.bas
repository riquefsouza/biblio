' Modulo de Rotinas

'$INCLUDE: 'biblio.inc'

'-----------------------------------------------------------------------
' Nome : cabecalho
' Descricao : procedimento que escreve o texto de cabecalho do sistema.
' Parametros :
' texto - o texto a ser escrito
' tipo - o caracter de fundo.
' fg - cor do texto
' bg - cor de fundo
'-----------------------------------------------------------------------
SUB cabecalho (texto AS STRING, tipo AS STRING, fg AS INTEGER, bg AS INTEGER)
DIM c AS INTEGER

FOR c = 1 TO 80
  Etexto c, 1, fg, bg, tipo
NEXT c
center 1, texto, fg, bg
END SUB

'-------------------------------------------------------------
' Nome: Center
' Descricao : Procedimento que centraliza um texto na tela.
' Parametros :
' y - posicao de linha na tela
' s - texto a ser centralizado
' fg - cor do texto
' bg - cod de fundo
'--------------------------------------------------------------
SUB center (y AS INTEGER, S AS STRING, fg AS INTEGER, bg AS INTEGER)
DIM x AS INTEGER

x = 40 - (LEN(S) / 2)
Etexto x, y, fg, bg, S

END SUB

'--------------------------------------------------------------------
' Nome : ConverteData
' Descricao : funcao que converte a data em string para numero.
' Parametros :
' dt - data a ser convertida
'---------------------------------------------------------------------
FUNCTION ConverteData (dt AS STRING)
DIM sAux AS STRING
DIM nAux AS INTEGER

 sAux = MID$(dt, 7, 4) + MID$(dt, 4, 2) + MID$(dt, 1, 2)
 nAux = VAL(sAux)
 ConverteData = nAux
END FUNCTION

'------------------------------------------------------------------------
' Nome : DatadoSistema
' Descricao : procedimento que escreve a data do sistema na tela.
' Parametros :
' l - posicao da linha na tela
' c - posicao da coluna na tela
' fg - cor do texto
' bg - cor de fundo
'------------------------------------------------------------------------
SUB DatadoSistema (l AS INTEGER, c AS INTEGER, fg AS INTEGER, bg AS INTEGER)
DIM atdata AS STRING
DIM ds AS STRING

 atdata = DATE$
 atdata = MID$(atdata, 4, 2) + "/" + LEFT$(atdata, 2) + "/" + RIGHT$(atdata, 4)
 ds = DiadaSemana(atdata)
 atdata = ds + ", " + atdata
 Etexto c, l, fg, bg, atdata

END SUB

'--------------------------------------------------------------------
' Nome : Deletar$
' Descricao : procedimento que exclui um pedaco de uma string
' Parametros :
' str - a string
' ini - o inicio do corte
' tam - quantas strings a cortar
'--------------------------------------------------------------------
FUNCTION Deletar$ (str AS STRING, ini AS INTEGER, tam AS INTEGER)
DIM St AS STRING
DIM Ik AS INTEGER

FOR Ik = 1 TO ini - 1
  St = St + MID$(str, Ik, 1)
NEXT Ik

FOR Ik = ini + tam TO LEN(str)
   St = St + MID$(str, Ik, 1)
NEXT Ik

Deletar$ = St

END FUNCTION

'----------------------------------------------------------------------
' Nome : DiadaSemana
' Descricao : funcao que retorna o dia da semana de uma data em relacao
' a uma data base.
' Parametros :
' dt - indica a data para a qual deseja saber o dia da semana.
'----------------------------------------------------------------------
FUNCTION DiadaSemana$ (dt AS STRING)
DIM ds(1 TO 7) AS STRING
DIM ndias, ix, jx, antdiv AS INTEGER
DIM bFlag AS INTEGER

 ix = 0
 ndias = 0
 bFlag = false
 ds(1) = "Domingo"
 ds(2) = "Segunda"
 ds(3) = "Terca"
 ds(4) = "Quarta"
 ds(5) = "Quinta"
 ds(6) = "Sexta"
 ds(7) = "Sabado"
 ndias = SubtraiDatas("01/01/1995", dt)
 IF (ndias >= 1) AND (ndias <= 6) THEN
    ix = ndias
 ELSE
    DO WHILE bFlag = false
       jx = (ndias / 7)
       ix = (ndias MOD 7)
       IF (jx < 7) AND (ix < 7) THEN
          bFlag = true
          ix = ix + 1
       END IF
       IF (jx < 7) AND (ix = 0) THEN
          bFlag = true
          ix = 0
       END IF
       ndias = jx
    LOOP
 END IF
 DiadaSemana = ds(ix)
END FUNCTION

'-------------------------------------------------------------------------
' Nome : EscreveRapido
' Descricao : Procedimento que permite ter um controle do posicionamento
' do cursor, sem piscadas ou erros de repeticao de visualizacao.
' Parametros :
' x - posicao de coluna na tela
' y - posicao de linha na tela
' S - o resultado do que foi digitado
' fg - cor do texto
' bg - cor de fundo
'-------------------------------------------------------------------------
SUB EscreveRapido (x AS INTEGER, y AS INTEGER, S AS STRING, fg AS INTEGER, bg AS INTEGER)
COLOR fg, bg
LOCATE y + 1, x - 1, 1
PRINT S;
END SUB

'----------------------------------------------------------------------
' Nome : Etexto
' Descricao : procedimento que escreve o texto na tela com determinada cor.
' Parametros :
' c - posicao de coluna do texto
' l - posicao de linha do texto
' fg - cor do texto
' bg - cor de fundo
' texto - o texto a ser escrito
'-----------------------------------------------------------------------
SUB Etexto (c AS INTEGER, l AS INTEGER, fg AS INTEGER, bg AS INTEGER, texto AS STRING)
COLOR fg, bg
LOCATE l, c
PRINT texto;
END SUB

'----------------------------------------------------------------
' Nome : HoradoSistema
' Descricao : procedimento que escreve a Hora do sistema na tela.
' Parametros :
' l - posicao da linha na tela
' c - posicao da coluna na tela
' fg - cor do texto
' bg - cor de fundo
'----------------------------------------------------------------
SUB HoradoSistema (l AS INTEGER, c AS INTEGER, fg AS INTEGER, bg AS INTEGER)
  Etexto c, l, fg, bg, TIME$
END SUB

'--------------------------------------------------------------------
' Nome: InkeyEx
' Descricao : Procedimento que identifica uma tecla do teclado.
'---------------------------------------------------------------------
FUNCTION inkeyEx$

ch$ = INKEY$

SELECT CASE ch$
    CASE CHR$(0) + CHR$(15)
         inkeyEx$ = "ShiftTab"
    CASE CHR$(0) + CHR$(18)
         inkeyEx$ = "AltE"
    CASE CHR$(0) + CHR$(22)
         inkeyEx$ = "AltU"
    CASE CHR$(0) + CHR$(24)
         inkeyEx$ = "AltO"
    CASE CHR$(0) + CHR$(30)
         inkeyEx$ = "AltA"
    CASE CHR$(0) + CHR$(31)
         inkeyEx$ = "AltS"
    CASE CHR$(0) + CHR$(72)
         inkeyEx$ = "UpArrow"
    CASE CHR$(0) + CHR$(80)
         inkeyEx$ = "DownArrow"
    CASE CHR$(0) + CHR$(82)
         inkeyEx$ = "InsertKey"
    CASE CHR$(0) + CHR$(75)
         inkeyEx$ = "LeftArrow"
    CASE CHR$(0) + CHR$(77)
         inkeyEx$ = "RightArrow"
    CASE CHR$(0) + CHR$(73)
         inkeyEx$ = "PgUp"
    CASE CHR$(0) + CHR$(81)
         inkeyEx$ = "PgDn"
    CASE CHR$(0) + CHR$(71)
         inkeyEx$ = "HomeKey"
    CASE CHR$(0) + CHR$(79)
         inkeyEx$ = "EndKey"
    CASE CHR$(0) + CHR$(83)
         inkeyEx$ = "DeleteKey"
    CASE CHR$(0) + CHR$(82)
         inkeyEx$ = "InsertKey"
    CASE CHR$(0) + CHR$(59)
         inkeyEx$ = "F1"
    CASE CHR$(0) + CHR$(60)
         inkeyEx$ = "F2"
    CASE CHR$(0) + CHR$(61)
         inkeyEx$ = "F3"
    CASE CHR$(0) + CHR$(62)
         inkeyEx$ = "F4"
    CASE CHR$(0) + CHR$(63)
         inkeyEx$ = "F5"
    CASE CHR$(0) + CHR$(64)
         inkeyEx$ = "F6"
    CASE CHR$(0) + CHR$(65)
         inkeyEx$ = "F7"
    CASE CHR$(0) + CHR$(66)
         inkeyEx$ = "F8"
    CASE CHR$(0) + CHR$(67)
         inkeyEx$ = "F9"
    CASE CHR$(0) + CHR$(68)
         inkeyEx$ = "F10"
'----------------------------
     CASE CHR$(1)
          inkeyEx$ = "CtrlA"
     CASE CHR$(8)
          inkeyEx$ = "Bksp"
     CASE CHR$(9)
          inkeyEx$ = "Tab"
     CASE CHR$(13)
          inkeyEx$ = "CarriageReturn"
     CASE CHR$(27)
          inkeyEx$ = "Esc"
     CASE CHR$(32)
          inkeyEx$ = "SpaceKey"
     CASE CHR$(33) TO CHR$(44), CHR$(47), CHR$(58) TO CHR$(254)
          inkeyEx$ = "TextKey"
     CASE CHR$(45) TO CHR$(46), CHR$(48) TO CHR$(57)
          inkeyEx$ = "NumberKey"
   END SELECT
END FUNCTION

'--------------------------------------------------------------------
' Nome : inserir$
' Descricao : procedimento que inclui uma string na outra
' Parametros :
' origem - indica a string que vai ser incluida
' alvo - indica a string que vai receber a inclusao
' ini - a posicao de inclusao
'--------------------------------------------------------------------
FUNCTION inserir$ (origem AS STRING, alvo AS STRING, ini AS INTEGER)
DIM Ig AS INTEGER
DIM s1 AS STRING
DIM s2 AS STRING

FOR Ig = 1 TO ini - 1
  s1 = s1 + MID$(alvo, Ig, 1)
NEXT Ig
s2 = s1 + origem
FOR Ig = LEN(s1) + 1 TO LEN(alvo)
  s2 = s2 + MID$(alvo, Ig, 1)
NEXT Ig
inserir = s2
END FUNCTION

'--------------------------------------------------------------------
' Nome : Repete
' Descricao : funcao que retorna um texto repetido n vezes.
' Parametros :
' St - indica o texto a ser repetido
' Tam - quantas vezes o texto se repetira
'--------------------------------------------------------------------
FUNCTION Repete$ (St AS STRING, tam AS INTEGER)
DIM cont AS INTEGER
DIM Esp AS STRING

 cont = 1
 Esp = ""
 DO WHILE (cont <= tam)
    Esp = Esp + St
    cont = cont + 1
 LOOP
 Repete = Esp
END FUNCTION

'--------------------------------------------------------------------
' Nome : RetDataAtual
' Descricao : funcao que retorna a data atual do sistema
'--------------------------------------------------------------------
FUNCTION RetDataAtual$
DIM atdat AS STRING
  atdat = DATE$
  RetDataAtual = MID$(atdat, 4, 2) + "/" + LEFT$(atdat, 2) + "/" + MID$(atdat, 7, 2)
END FUNCTION

'-----------------------------------------------------------------------
' Nome : rodape
' Descricao : procedimento que escreve o texto no rodape da tela.
' Parametros :
' texto - o texto a ser escrito
' tipo - o caracter de fundo.
' fg - cor do texto
' bg - cor de fundo
'-----------------------------------------------------------------------
SUB rodape (texto AS STRING, tipo AS STRING, fg AS INTEGER, bg AS INTEGER)
DIM c AS INTEGER

FOR c = 1 TO 80
  Etexto c, 25, fg, bg, tipo
NEXT c
center 25, texto, fg, bg
END SUB

'--------------------------------------------------------------------
' Nome : SetString
' Descricao : funcao que escreve o caracter de fundo no vetor vs.
' Parametros :
' fundo - o inteiro que indica o fundo
'--------------------------------------------------------------------
SUB SetString (fundo AS INTEGER)
DIM cont AS INTEGER

cont = LEN(S)
WHILE vs(cont) = CHR$(fundo)
  cont = cont - 1
WEND
vs(0) = CHR$(cont)

'----------------------------
FOR cont = 1 TO LEN(S)
  S = S + vs(cont)
NEXT cont
'----------------------------

END SUB

'-------------------------------------------------------------------------
' Nome : SomaDias
' Descricao : funcao que soma um determinado numero de dias a uma data.
' Parametros :
' dt1 - a data a ser somada
' qtddias - numero de dias a serem somados
'-------------------------------------------------------------------------
FUNCTION SomaDias$ (dt1 AS STRING, qtddias AS INTEGER)
DIM dia AS INTEGER
DIM mes AS INTEGER
DIM ano AS INTEGER
DIM dia1 AS INTEGER
DIM mes1 AS INTEGER
DIM ano1 AS INTEGER
DIM dia2 AS INTEGER
DIM mes2 AS INTEGER
DIM ano2 AS INTEGER
DIM t AS INTEGER
DIM c AS INTEGER
DIM dias AS INTEGER
DIM sAux AS STRING
DIM sAux2 AS STRING
DIM udiames(1 TO 12) AS INTEGER

 dias = 0
 udiames(1) = 31
 udiames(2) = 28
 udiames(3) = 31
 udiames(4) = 30
 udiames(5) = 31
 udiames(6) = 30
 udiames(7) = 31
 udiames(8) = 31
 udiames(9) = 30
 udiames(10) = 31
 udiames(11) = 30
 udiames(12) = 31

 t = VAL(MID$(dt1, 1, 2))
 dia1 = t
 t = VAL(MID$(dt1, 4, 2))
 mes1 = t
 t = VAL(MID$(dt1, 7, 4))
 ano1 = t

 ano2 = ano1 + (qtddias / 365)

 FOR ano = ano1 TO ano2
    FOR mes = mes1 TO 12
       'ano bissexto
       IF (ano MOD 4) = 0 THEN
         udiames(2) = 29
       END IF
       FOR dia = dia1 TO udiames(mes)
            dias = dias + 1
            IF dias = qtddias + 1 THEN
                sAux = LTRIM$(STR$(dia))
                sAux2 = Zeros(sAux, 2) + "/"
                sAux = LTRIM$(STR$(mes))
                sAux2 = sAux2 + Zeros(sAux, 2) + "/"
                sAux = LTRIM$(STR$(ano))
                sAux2 = sAux2 + Zeros(sAux, 4)
                SomaDias = sAux2
                EXIT FUNCTION
            END IF
       NEXT dia
       dia1 = 1
    NEXT mes
    mes1 = 1
 NEXT ano

END FUNCTION

'--------------------------------------------------------------------
' Nome : SubtraiDatas
' Descricao : funcao que subtrai duas datas e retorna o numero de dias
' Parametros :
' dt1 - data inicial
' dt2 - data final
'---------------------------------------------------------------------
FUNCTION SubtraiDatas (dt1 AS STRING, dt2 AS STRING)
DIM dia AS INTEGER
DIM mes AS INTEGER
DIM ano AS INTEGER
DIM dia1 AS INTEGER
DIM mes1 AS INTEGER
DIM ano1 AS INTEGER
DIM dia2 AS INTEGER
DIM mes2 AS INTEGER
DIM ano2 AS INTEGER
DIM t AS INTEGER
DIM c AS INTEGER
DIM dias AS INTEGER
DIM udiames(1 TO 12) AS INTEGER

 dias = 0
 udiames(1) = 31
 udiames(2) = 28
 udiames(3) = 31
 udiames(4) = 30
 udiames(5) = 31
 udiames(6) = 30
 udiames(7) = 31
 udiames(8) = 31
 udiames(9) = 30
 udiames(10) = 31
 udiames(11) = 30
 udiames(12) = 31

 t = VAL(MID$(dt1, 1, 2))
 dia1 = t
 t = VAL(MID$(dt1, 4, 2))
 mes1 = t
 t = VAL(MID$(dt1, 7, 4))
 ano1 = t

 t = VAL(MID$(dt2, 1, 2))
 dia2 = t
 t = VAL(MID$(dt2, 4, 2))
 mes2 = t
 t = VAL(MID$(dt2, 7, 4))
 ano2 = t

 FOR ano = ano1 TO ano2
    FOR mes = mes1 TO 12
       'ano bissexto
       IF (ano MOD 4) = 0 THEN
         udiames(2) = 29
       END IF
       'data final
       IF (ano = ano2) AND (mes = mes2) THEN
         udiames(mes2) = dia2
       END IF
       FOR dia = dia1 TO udiames(mes)
          dias = dias + 1
       NEXT dia
       IF (ano = ano2) AND (mes = mes2) THEN
           SubtraiDatas = dias - 1
           EXIT FUNCTION
       END IF
       dia1 = 1
    NEXT mes
    mes1 = 1
 NEXT ano

END FUNCTION

'---------------------------------------------------------------------
' Nome : Teladefundo
' Descricao : procedimento que desenha os caracteres do fundo da tela.
' Parametros :
' tipo - o caracter a ser escrito no fundo
' fg - cor do texto
' bg - cor de fundo
'---------------------------------------------------------------------
SUB teladefundo (tipo AS STRING, fg AS INTEGER, bg AS INTEGER)
DIM l AS INTEGER
DIM c AS INTEGER

FOR l = 3 TO 24
  FOR c = 1 TO 80
    Etexto c, l, fg, bg, tipo
  NEXT c
NEXT l
END SUB

'--------------------------------------------------------------------
' Nome : Trim
' Descricao : Funcao que apaga os espacos em branco das strings de
' tamanho fixo.
' Parametros :
' str1 - indica a string
'--------------------------------------------------------------------
FUNCTION Trim$ (str1 AS STRING)
DIM it AS INTEGER
DIM st1 AS STRING

FOR it = LEN(str1) TO 1 STEP -1
 st1 = MID$(str1, it, 1)
 IF st1 <> " " THEN
    st1 = MID$(str1, 1, it)
    EXIT FOR
 END IF
NEXT it

Trim$ = st1

END FUNCTION

'--------------------------------------------------------------------
' Nome : Zeros
' Descricao : funcao que escreve zeros na frente de uma string.
' Parametros :
' s - a string a receber zeros a frente
' tam - o tamanho da string
'--------------------------------------------------------------------
FUNCTION Zeros$ (S AS STRING, tam AS INTEGER)
DIM cont AS INTEGER
DIM aux AS STRING

  aux = ""
  IF tam <> LEN(S) THEN
      FOR cont = 1 TO tam - LEN(S)
        aux = aux + "0"
      NEXT cont
  END IF
  Zeros = aux + S
END FUNCTION

