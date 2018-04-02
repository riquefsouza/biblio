' Modulo de Livros

'$include:'biblio.inc'

'-----------------------------------------------------------------
' Nome : AtribuirvLivros
' Descricao : procedimento que atribui ou limpa o vetor de livros.
' Parametros :
' limpar - indica se vai limpar ou atribuir os vetores
'--------------------------------------------------------------------
SUB Atribuirvlivros (limpar AS INTEGER)
IF limpar = false THEN
      S = LTRIM$(STR$(Livros.Ninsc))
      vLivros(1) = S
      vLivros(2) = Livros.Titulo
      vLivros(3) = Livros.Autor
      vLivros(4) = Livros.Area
      vLivros(5) = Livros.Pchave
      S = LTRIM$(STR$(Livros.Edicao))
      vLivros(6) = S
      S = LTRIM$(STR$(Livros.AnoPubli))
      vLivros(7) = S
      vLivros(8) = Livros.Editora
      S = LTRIM$(STR$(Livros.Volume))
      vLivros(9) = S
      vLivros(10) = Livros.Estado
ELSE
  vLivros(2) = Repete$(" ", 30)
  vLivros(3) = Repete$(" ", 30)
  vLivros(4) = Repete$(" ", 30)
  vLivros(5) = Repete$(" ", 10)
  vLivros(6) = Repete$(" ", 4)
  vLivros(7) = Repete$(" ", 4)
  vLivros(8) = Repete$(" ", 30)
  vLivros(9) = Repete$(" ", 4)
  vLivros(10) = Repete$(" ", 1)
END IF
END SUB

'-------------------------------------------------------------------------
' Nome : ControlesformLivros
' Descricao : procedimento que realiza todo o controle de manuseio do
' formulario de livros.
' Parametros :
' tipo - indica qual a acao do formulario
' tipo2 - indica a acao original do formulario nao manipulado pela funcao
' posi - indica a ultima posicao da linha da lista de livros
' col - indica a ultima posicao da coluna da lista de livros
' rod - o texto do rodape sobre o formulario
' foco - se os objetos do formulario estao focados ou nao
'-------------------------------------------------------------------------
SUB ControlesformLivros (tipo AS STRING, tipo2 AS INTEGER, posi AS INTEGER, col AS INTEGER, rod AS STRING, foco AS INTEGER)

IF tipo = "1" THEN
      S = Digita$(S, 5, 5, 28, 5, black, lightgray, "N", 0) '{ N insc }
      i = VAL(S)
      Livros.Ninsc = i
      IF (LEN(S) > 0) AND (S <> Repete$(" ", LEN(S))) THEN
         DesenhaBotao 20, 45, black, white, black, blue, " Salvar ", false
         IF PesLivros("N", "Ninsc", i, "", 0) <> -1 THEN
            Atribuirvlivros false
            Rotulosformlivros 0
            rodape rod, " ", white, blue
            ControlesformLivros "2", tipo2, posi, col, rod, false
         ELSE
            S = LTRIM$(STR$(i))
            Atribuirvlivros true
            Rotulosformlivros 0
            rodape "Numero de Inscricao, nao encontrado !", " ", yellow, red
            ControlesformLivros "Fechar", tipo2, posi, col, rod, true
         END IF
      ELSE
        ControlesformLivros "Fechar", tipo2, posi, col, rod, true
      END IF
ELSEIF tipo = "2" THEN
        IF tipo2 = 1 THEN
            nTamLivros = LOF(LivrosFile) / LEN(Livros)
            IF nTamLivros = 0 THEN
               Livros.Ninsc = 1
            ELSE
               Livros.Ninsc = nTamLivros + 1
            END IF
            i = Livros.Ninsc
            S = LTRIM$(STR$(Livros.Ninsc))
            Etexto 27, 6, black, lightgray, S
            S = ""
        ELSEIF tipo2 = 2 THEN
            AbrirArquivo 1
            IF PesLivros("N", "Ninsc", i, "", 0) = -1 THEN
              rodape "Numero de Inscricao, nao encontrado !", " ", yellow, red
            END IF
        END IF

        DigitaformLivros

      ControlesformLivros "Salvar", tipo2, posi, col, rod, true
ELSEIF tipo = "3" THEN
      S = ""
      S = Digita$(S, 30, 30, 15, 5, black, lightgray, "T", 0)
      Livros.Titulo = S
      IF (LEN(Livros.Titulo) > 0) AND (Livros.Titulo <> Repete$(" ", LEN(Livros.Titulo))) THEN
         IF PesLivros("S", "Titulo", 0, Livros.Titulo, LEN(Livros.Titulo)) <> -1 THEN
              Atribuirvlivros false
              Rotulosformlivros 2
              rodape rod, " ", white, blue
         ELSE
            Atribuirvlivros true
            Rotulosformlivros 2
            rodape "Titulo do Livro, nao encontrado !", " ", yellow, red
         END IF
      END IF
      ControlesformLivros "Fechar", tipo2, posi, col, rod, true
ELSEIF tipo = "4" THEN
      S = ""
      S = Digita$(S, 30, 30, 14, 5, black, lightgray, "T", 0)
      Livros.Autor = S
      IF (LEN(S) > 0) AND (S <> Repete$(" ", LEN(S))) THEN
         IF PesLivros("S", "Autor", 0, S, LEN(S)) <> -1 THEN
              Atribuirvlivros false
              Rotulosformlivros 2
              rodape rod, " ", white, blue
         ELSE
            Atribuirvlivros true
            Rotulosformlivros 2
            rodape "Autor do Livro, nao encontrado !", " ", yellow, red
         END IF
      END IF
      ControlesformLivros "Fechar", tipo2, posi, col, rod, true
ELSEIF tipo = "5" THEN
      S = ""
      S = Digita$(S, 4, 4, 13, 5, black, lightgray, "T", 0)
      Livros.Area = S
      IF (LEN(S) > 0) AND (S <> Repete$(" ", LEN(S))) THEN
         IF PesLivros("S", "Area", 0, S, LEN(S)) <> -1 THEN
              Atribuirvlivros false
              Rotulosformlivros 2
              rodape rod, " ", white, blue
         ELSE
            Atribuirvlivros true
            Rotulosformlivros 2
            rodape "Area do Livro, nao encontrada !", " ", yellow, red
         END IF
      END IF
      ControlesformLivros "Fechar", tipo2, posi, col, rod, true
ELSEIF tipo = "6" THEN
      S = ""
      S = Digita$(S, 10, 10, 22, 5, black, lightgray, "T", 0)
      Livros.Pchave = S
      IF (LEN(S) > 0) AND (S <> Repete$(" ", LEN(S))) THEN
         IF PesLivros("S", "Pchave", 0, S, LEN(S)) <> -1 THEN
              Atribuirvlivros false
              Rotulosformlivros 2
              rodape rod, " ", white, blue
         ELSE
            Atribuirvlivros true
            Rotulosformlivros 2
            rodape "Palavra-Chave do Livro, nao encontrado !", " ", yellow, red
         END IF
      END IF
      ControlesformLivros "Fechar", tipo2, posi, col, rod, true
ELSEIF tipo = "7" THEN
    listapos = posi
    listacol = col
    IF lista(1, 6, 5, 13, 70, nTamLivros + 2, 220, white, blue, foco) = 1 THEN
        desenhalista 1, 6, 5, 13, 70, white, blue, posi, col, false
        ControlesformLivros "Fechar", tipo2, posi, col, rod, true
    END IF
ELSEIF tipo = "Salvar" THEN
    SELECT CASE Botao(20, 45, black, white, black, blue, " Salvar ", foco)
      CASE 1
          DesenhaBotao 20, 45, black, white, black, blue, " Salvar ", false
          ControlesformLivros "Fechar", tipo2, posi, col, rod, true
      CASE 2
          SalvarLivros tipo2
          DesenhaBotao 20, 45, black, white, black, blue, " Salvar ", false
          ControlesformLivros "Fechar", tipo2, posi, col, rod, true
    END SELECT
ELSEIF tipo = "Fechar" THEN
   SELECT CASE Botao(20, 60, black, white, black, blue, " Fechar ", foco)
      CASE 1
          DesenhaBotao 20, 60, black, white, black, blue, " Fechar ", false
          IF tipo2 = 1 THEN
            ControlesformLivros "2", tipo2, posi, col, rod, true
          ELSEIF tipo2 = 2 THEN
            ControlesformLivros "1", tipo2, posi, col, rod, false
          ELSEIF tipo2 = 3 THEN
            ControlesformLivros "3", tipo2, posi, col, rod, false
          ELSEIF tipo2 = 4 THEN
            ControlesformLivros "4", tipo2, posi, col, rod, false
          ELSEIF tipo2 = 5 THEN
            ControlesformLivros "5", tipo2, posi, col, rod, false
          ELSEIF tipo2 = 6 THEN
            ControlesformLivros "6", tipo2, posi, col, rod, false
          ELSEIF tipo2 = 7 THEN
            ControlesformLivros "7", tipo2, posi, col, rod, true
          END IF
      CASE 2
         rodape "", " ", white, blue
         CLOSE 1
         '------------------
         teladefundo "±", white, lightblue
         '-------------------
   END SELECT
END IF
END SUB

'-------------------------------------------------------------------------
' Nome : DigitaformLivros
' Descricao : procedimento que realiza o cotrole de digitacao dos dados no
' formulario de livros.
'-------------------------------------------------------------------------
SUB DigitaformLivros
        S = Livros.Titulo
        S = Digita$(S, 30, 30, 45, 5, black, lightgray, "T", 0)
        Livros.Titulo = S
        S = Livros.Autor
        S = Digita$(S, 30, 30, 14, 7, black, lightgray, "T", 0)
        Livros.Autor = S
        S = Livros.Area
        S = Digita$(S, 30, 30, 13, 9, black, lightgray, "T", 0)
        Livros.Area = S
        S = Livros.Pchave
        S = Digita$(S, 10, 10, 22, 11, black, lightgray, "T", 0)
        Livros.Pchave = S
        S = LTRIM$(STR$(Livros.Edicao))
        S = Digita$(S, 4, 4, 45, 11, black, lightgray, "N", 0)
        i = VAL(S)
        Livros.Edicao = i
        S = LTRIM$(STR$(Livros.AnoPubli))
        S = Digita$(S, 4, 4, 26, 13, black, lightgray, "N", 0)
        i = VAL(S)
        Livros.AnoPubli = i
        S = Livros.Editora
        S = Digita$(S, 30, 30, 46, 13, black, lightgray, "T", 0)
        Livros.Editora = S
        S = LTRIM$(STR$(Livros.Volume))
        S = Digita$(S, 4, 4, 15, 15, black, lightgray, "N", 0)
        i = VAL(S)
        Livros.Volume = i
        S = Livros.Estado
        S = Digita$(S, 1, 1, 38, 15, black, lightgray, "T", 0)
        Livros.Estado = S
        S = ""
END SUB

'--------------------------------------------------------------------
' Nome : formLivros
' Descricao : procedimento que desenha o formulario de livros na tela, e
' tambem indica qual acao a tomar.
' Parametros :
' tipo - indica qual a acao do formulario
' titulo - o titulo do formulario
' rod - o texto do rodape sobre o formulario
'--------------------------------------------------------------------
SUB formLivros (tipo AS INTEGER, Titulo AS STRING, rod AS STRING)
  teladefundo "±", white, lightblue
  rodape rod, " ", white, blue
  formulario CHR$(180) + Titulo + CHR$(195), 4, 2, 18, 76, white, blue, "±", lightgray, black

  vLivros(1) = Repete$(" ", 5)
  Atribuirvlivros true
  AbrirArquivo 1
  IF (tipo = 1) OR (tipo = 2) THEN
     Rotulosformlivros 0
     DesenhaBotao 20, 45, black, white, black, blue, " Salvar ", false
     DesenhaBotao 20, 60, black, white, black, blue, " Fechar ", false
  END IF
  IF (tipo = 3) OR (tipo = 4) OR (tipo = 5) OR (tipo = 6) THEN
     DesenhaBotao 20, 60, black, white, black, blue, " Fechar ", false
     Rotulosformlivros 2
     Etexto 2, 7, white, blue, CHR$(195) + Repete$(CHR$(196), 75) + CHR$(180)
  END IF
  IF tipo = 7 THEN
     DesenhaBotao 20, 60, black, white, black, blue, " Fechar ", false
  END IF
  IF tipo = 3 THEN
     Etexto 5, 6, white, blue, "Titulo : "
     Etexto 14, 6, black, lightgray, Repete$(" ", 30)
  END IF
  IF tipo = 4 THEN
     Etexto 5, 6, white, blue, "Autor : "
     Etexto 13, 6, black, lightgray, Repete$(" ", 30)
  END IF
  IF tipo = 5 THEN
     Etexto 5, 6, white, blue, "Area : "
     Etexto 12, 6, black, lightgray, Repete$(" ", 30)
  END IF
  IF tipo = 6 THEN
     Etexto 5, 6, white, blue, "Palavra-Chave : "
     Etexto 21, 6, black, lightgray, Repete$(" ", 10)
  END IF

  LimparLivros
  IF tipo = 1 THEN
     ControlesformLivros "2", 1, 0, 0, rod, false'cadastrar
  ELSEIF tipo = 2 THEN
     ControlesformLivros "1", 2, 0, 0, rod, false'alterar
  ELSEIF tipo = 3 THEN
     ControlesformLivros "3", 3, 0, 0, rod, false'consultar por titulo
  ELSEIF tipo = 4 THEN
     ControlesformLivros "4", 4, 0, 0, rod, false'consultar por Autor
  ELSEIF tipo = 5 THEN
     ControlesformLivros "5", 5, 0, 0, rod, false'consultar por Area
  ELSEIF tipo = 6 THEN
     ControlesformLivros "6", 6, 0, 0, rod, false'consultar por Palavra-chave
  ELSEIF tipo = 7 THEN
     ControlesformLivros "7", 7, 0, 0, rod, true'consultar todos
  END IF
END SUB

'--------------------------------------------------------------------
' Nome : LimparLivros
' Descricao : procedimento limpa as variaveis do registro de livros.
'--------------------------------------------------------------------
SUB LimparLivros
     Livros.Ninsc = 0
     Livros.Titulo = ""
     Livros.Autor = ""
     Livros.Area = ""
     Livros.Pchave = ""
     Livros.Edicao = 0
     Livros.AnoPubli = 0
     Livros.Editora = ""
     Livros.Volume = 0
     Livros.Estado = " "

END SUB

'--------------------------------------------------------------------
' Nome : PesLivros
' Descricao : funcao que pesquisa as informacoes contidas no arquivo de
' livros
' Parametros :
' tipo - indica se e o valor e (N)umerico ou (S)tring
' campo - qual o campo a ser pesquisado
' nCod2 - codigo do campo se numerico
' sCod2 - codigo do campo se string
' nTamsCod - tamanho caracteres do campo de string
'--------------------------------------------------------------------
FUNCTION PesLivros (tipo AS STRING, campo AS STRING, nCod2 AS INTEGER, sCod2 AS STRING, nTamsCod AS INTEGER)
DIM nPosicao AS INTEGER
DIM nCod AS INTEGER
DIM sCod AS STRING
DIM bFlag AS INTEGER

SEEK LivrosFile, 0 + 1
nPosicao = 0
bFlag = false
nCod = 0
sCod = ""
DO WHILE NOT EOF(LivrosFile)
   GET LivrosFile, , Livros
   IF tipo = "N" THEN
       IF campo = "Ninsc" THEN
          nCod = Livros.Ninsc
       END IF
       IF (nCod = nCod2) THEN
          PesLivros = nPosicao
          SEEK LivrosFile, nPosicao + 1
          bFlag = true
          EXIT DO
       END IF
   ELSEIF tipo = "S" THEN
       IF campo = "Titulo" THEN
          sCod = Livros.Titulo
       ELSEIF campo = "Area" THEN
          sCod = Livros.Area
       ELSEIF campo = "Autor" THEN
          sCod = Livros.Autor
       ELSEIF campo = "Pchave" THEN
          sCod = Livros.Pchave
       END IF
       IF (MID$(sCod, 1, nTamsCod) = sCod2) THEN
          PesLivros = nPosicao
          SEEK LivrosFile, nPosicao + 1
          bFlag = true
          EXIT DO
       END IF
   END IF
   nPosicao = nPosicao + 1
LOOP
 IF EOF(LivrosFile) AND bFlag = false THEN
    PesLivros = -1
 END IF
END FUNCTION

'-------------------------------------------------------------------------
' Nome : RotulosformLivros
' Descricao : procedimento que escreve os rotulos do formulario de livros.
' Parametros :
' l - indica um acrescimo na linha do rotulo
'-------------------------------------------------------------------------
SUB Rotulosformlivros (l AS INTEGER)
  Etexto 5, 6 + l, white, blue, "Numero de Inscricao : "
  Etexto 27, 6 + l, black, lightgray, vLivros(1)
  Etexto 35, 6 + l, white, blue, "Titulo : "
  Etexto 44, 6 + l, black, lightgray, vLivros(2)
  Etexto 5, 8 + l, white, blue, "Autor : "
  Etexto 13, 8 + l, black, lightgray, vLivros(3)
  Etexto 5, 10 + l, white, blue, "Area : "
  Etexto 12, 10 + l, black, lightgray, vLivros(4)
  Etexto 5, 12 + l, white, blue, "Palavra-Chave : "
  Etexto 21, 12 + l, black, lightgray, vLivros(5)
  Etexto 35, 12 + l, white, blue, "Edicao : "
  Etexto 44, 12 + l, black, lightgray, vLivros(6)
  Etexto 5, 14 + l, white, blue, "Ano de Publicacao : "
  Etexto 25, 14 + l, black, lightgray, vLivros(7)
  Etexto 35, 14 + l, white, blue, "Editora : "
  Etexto 45, 14 + l, black, lightgray, vLivros(8)
  Etexto 5, 16 + l, white, blue, "Volume : "
  Etexto 14, 16 + l, black, lightgray, vLivros(9)
  Etexto 22, 16 + l, white, blue, "Estado Atual : "
  Etexto 37, 16 + l, black, lightgray, vLivros(10)
  Etexto 40, 16 + l, white, blue, "(D)isponivel ou (E)mprestado"

END SUB

'--------------------------------------------------------------------
' Nome : SalvarLivros
' Descricao : procedimento que salva os dados digitados no
' formulario de livros.
' Parametros :
' tipo - indica qual acao a salvar
'--------------------------------------------------------------------
SUB SalvarLivros (tipo AS INTEGER)
IF VerificaLivros = true THEN
 IF (Livros.Estado = "D") OR (Livros.Estado = "E") THEN
    IF tipo = 1 THEN
        SEEK LivrosFile, nTamLivros + 1
        PUT LivrosFile, , Livros
        Atribuirvlivros true
        Rotulosformlivros 0
        LimparLivros
    ELSEIF tipo = 2 THEN
       PUT LivrosFile, , Livros
    END IF
 ELSE
   rodape "Estado Atual, Cadastrado Incorretamente !", " ", yellow, red
 END IF
END IF

END SUB

'--------------------------------------------------------------------
' Nome : VerificaLivros
' Descricao : funcao que verifica se os dados no formulario de livros
' foram digitados.
'--------------------------------------------------------------------
FUNCTION VerificaLivros
  S = LTRIM$(STR$(Livros.Ninsc))
  IF (LEN(S) = 0) AND (S = Repete$(" ", LEN(S))) THEN
      rodape "Numero de Inscricao, nao cadastrado !", " ", yellow, red
      VerificaLivros = false
      EXIT FUNCTION
  END IF
  IF (LEN(Livros.Titulo) = 0) AND (Livros.Titulo = Repete$(" ", LEN(Livros.Titulo))) THEN
      rodape "Titulo, nao cadastrado !", " ", yellow, red
      VerificaLivros = false
      EXIT FUNCTION
  END IF
  IF (LEN(Livros.Autor) = 0) AND (Livros.Autor = Repete$(" ", LEN(Livros.Autor))) THEN
      rodape "Autor, nao cadastrado !", " ", yellow, red
      VerificaLivros = false
      EXIT FUNCTION
  END IF
  IF (LEN(Livros.Area) = 0) AND (Livros.Area = Repete$(" ", LEN(Livros.Area))) THEN
      rodape "Area, nao cadastrada !", " ", yellow, red
      VerificaLivros = false
      EXIT FUNCTION
  END IF
  IF (LEN(Livros.Pchave) = 0) AND (Livros.Pchave = Repete$(" ", LEN(Livros.Pchave))) THEN
      rodape "Palavra-Chave, nao cadastrada !", " ", yellow, red
      VerificaLivros = false
      EXIT FUNCTION
  END IF
  S = LTRIM$(STR$(Livros.Edicao))
  IF (LEN(S) = 0) AND (S = Repete$(" ", LEN(S))) THEN
      rodape "Edicao, nao cadastrada !", " ", yellow, red
      VerificaLivros = false
      EXIT FUNCTION
  END IF
  S = LTRIM$(STR$(Livros.AnoPubli))
  IF (LEN(S) = 0) AND (Livros.Titulo = Repete$(" ", LEN(Livros.Titulo))) THEN
      rodape "Ano de Publicacao, nao cadastrado !", " ", yellow, red
      VerificaLivros = false
      EXIT FUNCTION
  END IF
  IF (LEN(Livros.Editora) = 0) AND (Livros.Editora = Repete$(" ", LEN(Livros.Editora))) THEN
      rodape "Editora, nao cadastrada !", " ", yellow, red
      VerificaLivros = false
      EXIT FUNCTION
  END IF
  S = LTRIM$(STR$(Livros.Volume))
  IF (LEN(S) = 0) AND (S = Repete$(" ", LEN(S))) THEN
      rodape "Volume, nao cadastrado !", " ", yellow, red
      VerificaLivros = false
      EXIT FUNCTION
  END IF
  IF (LEN(Livros.Estado) = 0) AND (Livros.Estado = Repete$(" ", LEN(Livros.Estado))) THEN
      rodape "Estado, nao cadastrado !", " ", yellow, red
      VerificaLivros = false
      EXIT FUNCTION
  END IF

 VerificaLivros = true
END FUNCTION

