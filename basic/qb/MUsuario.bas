' Modulo de Usuarios

'$include:'biblio.inc'

'-------------------------------------------------------------------------
' Nome : AtribuirvUsuarios
' Descricao : procedimento que atribui ou limpa o vetor de Usuarios.
' Parametros :
' limpar - indica se vai limpar ou atribuir os vetores
'-------------------------------------------------------------------------
SUB AtribuirvUsuarios (limpar AS INTEGER)

IF limpar = false THEN

      S = LTRIM$(STR$(Usuarios.Ninsc))
      vUsuarios(1) = S
      vUsuarios(2) = Usuarios.Nome
      vUsuarios(3) = Usuarios.Ident
      vUsuarios(4) = Usuarios.Endereco.logra
      S = LTRIM$(STR$(Usuarios.Endereco.numero))
      vUsuarios(5) = S
      vUsuarios(6) = Usuarios.Endereco.compl
      vUsuarios(7) = Usuarios.Endereco.Bairro
      vUsuarios(8) = Usuarios.Endereco.Cep
      vUsuarios(9) = Usuarios.Telefone
      vUsuarios(10) = Usuarios.Categoria
      S = LTRIM$(STR$(Usuarios.Situacao))
      vUsuarios(11) = S
ELSE
  vUsuarios(2) = Repete$(" ", 30)
  vUsuarios(3) = Repete$(" ", 10)
  vUsuarios(4) = Repete$(" ", 30)
  vUsuarios(5) = Repete$(" ", 5)
  vUsuarios(6) = Repete$(" ", 10)
  vUsuarios(7) = Repete$(" ", 20)
  vUsuarios(8) = Repete$(" ", 8)
  vUsuarios(9) = Repete$(" ", 11)
  vUsuarios(10) = Repete$(" ", 1)
  vUsuarios(11) = Repete$(" ", 1)
END IF
END SUB

'--------------------------------------------------------------------
' Nome : ControlesformUsuarios
' Descricao : procedimento que realiza todo o controle de manuseio do
' formulario de Usuarios.
' Parametros :
' tipo - indica qual a acao do formulario
' tipo2 - indica a acao original do formulario nao manipulado pela funcao
' posi - indica a ultima posicao da linha da lista de usuarios
' col - indica a ultima posicao da coluna da lista de usuarios
' rod - o texto do rodape sobre o formulario
' foco - se os objetos do formulario estao focados ou nao
'--------------------------------------------------------------------
SUB ControlesformUsuarios (tipo AS STRING, tipo2 AS INTEGER, posi AS INTEGER, col AS INTEGER, rod AS STRING, foco AS INTEGER)

IF tipo = "1" THEN

      S = Digita$(S, 5, 5, 28, 5, black, lightgray, "N", 0)'N insc
      i = VAL(S)
      Usuarios.Ninsc = i
      IF (LEN(S) > 0) AND (S <> Repete$(" ", LEN(S))) THEN
         DesenhaBotao 20, 48, black, white, black, blue, " Salvar ", false
         IF PesUsuarios("N", "Ninsc", i, "", 0) <> -1 THEN
                AtribuirvUsuarios false
                RotulosformUsuarios 0
                rodape rod, " ", white, blue
                ControlesformUsuarios "2", tipo2, posi, col, rod, false
         ELSE
            S = LTRIM$(STR$(i))
            AtribuirvUsuarios true
            RotulosformUsuarios 0
            rodape "Numero de Inscricao, nao encontrado !", " ", yellow, red
            ControlesformUsuarios "Fechar", tipo2, posi, col, rod, true
         END IF
      ELSE
        ControlesformUsuarios "Fechar", tipo2, posi, col, rod, true
      END IF
ELSEIF tipo = "2" THEN      
        IF tipo2 = 1 THEN
            nTamUsuarios = LOF(UsuariosFile) / LEN(Usuarios)
            IF nTamUsuarios = 0 THEN
               Usuarios.Ninsc = 1
            ELSE
               Usuarios.Ninsc = nTamUsuarios + 1
            END IF
            i = Usuarios.Ninsc
            S = LTRIM$(STR$(Usuarios.Ninsc))
            Etexto 27, 6, black, lightgray, S
            S = ""
        ELSEIF tipo2 = 2 THEN
            AbrirArquivo 2
            IF PesUsuarios("N", "Ninsc", i, "", 0) = -1 THEN
              rodape "Numero de Inscricao, nao encontrado !", " ", yellow, red
            END IF
        END IF
          DigitaformUsuarios

      ControlesformUsuarios "Salvar", tipo2, posi, col, rod, true

ELSEIF tipo = "3" THEN

      S = ""
      S = Digita$(S, 5, 5, 28, 5, black, lightgray, "N", 0)'N insc
      i = VAL(S)
      Usuarios.Ninsc = i
      IF (LEN(S) > 0) AND (S <> Repete$(" ", LEN(S))) THEN
         IF PesBinaria(i) <> -1 THEN
              AtribuirvUsuarios false
              RotulosformUsuarios 2
              rodape rod, " ", white, blue
         ELSE
            AtribuirvUsuarios true
            RotulosformUsuarios 2
            rodape "Numero de Inscricao, nao encontrado !", " ", yellow, red
         END IF
      END IF
        ControlesformUsuarios "Fechar", tipo2, posi, col, rod, true

ELSEIF tipo = "4" THEN

      S = ""
      S = Digita$(S, 30, 30, 13, 5, black, lightgray, "T", 0)
      Usuarios.Nome = S
      IF (LEN(S) > 0) AND (S <> Repete$(" ", LEN(S))) THEN
         IF PesUsuarios("S", "Nome", 0, S, LEN(S)) <> -1 THEN
              AtribuirvUsuarios false
              RotulosformUsuarios 2
              rodape rod, " ", white, blue
         ELSE
            AtribuirvUsuarios true
            RotulosformUsuarios 2
            rodape "Nome do Usuario, nao encontrado !", " ", yellow, red
         END IF
      END IF
        ControlesformUsuarios "Fechar", tipo2, posi, col, rod, true

ELSEIF tipo = "5" THEN

      S = ""
      S = Digita$(S, 10, 10, 19, 5, black, lightgray, "N", 0)
      Usuarios.Ident = S
      IF (LEN(S) > 0) AND (S <> Repete$(" ", LEN(S))) THEN
         IF PesUsuarios("N", "Ident", 0, S, LEN(S)) <> -1 THEN
              AtribuirvUsuarios false
              RotulosformUsuarios 2
              rodape rod, " ", white, blue
         ELSE
            AtribuirvUsuarios true
            RotulosformUsuarios 2
            rodape "Identidade do Usuario, nao encontrada !", " ", yellow, red
         END IF
      END IF
        ControlesformUsuarios "Fechar", tipo2, posi, col, rod, true

ELSEIF tipo = "6" THEN
    listapos = posi
    listacol = col
    IF lista(2, 6, 5, 13, 70, nTamUsuarios + 2, 194, white, blue, foco) = 1 THEN
        desenhalista 2, 6, 5, 13, 70, white, blue, posi, col, false
        ControlesformUsuarios "Fechar", tipo2, posi, col, rod, true
    END IF
ELSEIF tipo = "Salvar" THEN

    SELECT CASE Botao(20, 48, black, white, black, blue, " Salvar ", foco)
      CASE 1
          DesenhaBotao 20, 48, black, white, black, blue, " Salvar ", false
          ControlesformUsuarios "Fechar", tipo2, posi, col, rod, true
      CASE 2
          SalvarUsuarios tipo2
          DesenhaBotao 20, 48, black, white, black, blue, " Salvar ", false
          ControlesformUsuarios "Fechar", tipo2, posi, col, rod, true
    END SELECT
ELSEIF tipo = "Fechar" THEN

    SELECT CASE Botao(20, 63, black, white, black, blue, " Fechar ", foco)
      CASE 1
          DesenhaBotao 20, 63, black, white, black, blue, " Fechar ", false
          IF tipo2 = 1 THEN
            ControlesformUsuarios "2", tipo2, posi, col, rod, true
          ELSEIF tipo2 = 2 THEN
            ControlesformUsuarios "1", tipo2, posi, col, rod, false
          ELSEIF tipo2 = 3 THEN
            ControlesformUsuarios "3", tipo2, posi, col, rod, false
          ELSEIF tipo2 = 4 THEN
            ControlesformUsuarios "4", tipo2, posi, col, rod, false
          ELSEIF tipo2 = 5 THEN
            ControlesformUsuarios "5", tipo2, posi, col, rod, false
          ELSEIF tipo2 = 6 THEN
            ControlesformUsuarios "6", tipo2, posi, col, rod, true
          END IF
      CASE 2
         rodape "", " ", white, blue
         CLOSE UsuariosFile
         '------------------
         teladefundo "±", white, lightblue
         '-------------------
    END SELECT
END IF

END SUB

'-------------------------------------------------------------------------
' Nome : DigitaformUsuarios
' Descricao : procedimento que realiza o cotrole de digitacao dos dados no
' formulario de usuarios.
'-------------------------------------------------------------------------
SUB DigitaformUsuarios
        S = Usuarios.Nome
        S = Digita$(S, 30, 30, 43, 5, black, lightgray, "T", 0)
        Usuarios.Nome = S
        S = Usuarios.Ident
        S = Digita$(S, 10, 10, 19, 7, black, lightgray, "N", 0)
        Usuarios.Ident = S
        S = Usuarios.Telefone
        S = Digita$(S, 11, 11, 43, 7, black, lightgray, "N", 0)
        Usuarios.Telefone = S
        S = Usuarios.Endereco.logra
        S = Digita$(S, 30, 30, 19, 11, black, lightgray, "T", 0)
        Usuarios.Endereco.logra = S
        S = LTRIM$(STR$(Usuarios.Endereco.numero))
        S = Digita$(S, 5, 5, 61, 11, black, lightgray, "N", 0)
        i = VAL(S)
        Usuarios.Endereco.numero = i
        S = Usuarios.Endereco.compl
        S = Digita$(S, 10, 10, 20, 13, black, lightgray, "T", 0)
        Usuarios.Endereco.compl = S
        S = Usuarios.Endereco.Bairro
        S = Digita$(S, 20, 20, 42, 13, black, lightgray, "T", 0)
        Usuarios.Endereco.Bairro = S
        S = Usuarios.Endereco.Cep
        S = Digita$(S, 8, 8, 70, 13, black, lightgray, "N", 0)
        Usuarios.Endereco.Cep = S
        S = Usuarios.Categoria
        S = Digita$(S, 1, 1, 18, 16, black, lightgray, "T", 0)
        Usuarios.Categoria = S
        S = LTRIM$(STR$(Usuarios.Situacao))
        S = Digita$(S, 1, 1, 17, 18, black, lightgray, "N", 0)
        i = VAL(S)
        Usuarios.Situacao = i
        S = ""
END SUB

'-------------------------------------------------------------------------
' Nome : formUsuarios
' Descricao : procedimento que desenha o formulario de Usuarios na tela, e
' tambem indica qual acao a tomar.
' Parametros :
' tipo - indica qual a acao do formulario
' titulo - o titulo do formulario
' rod - o texto do rodape sobre o formulario
'-------------------------------------------------------------------------
SUB formUsuarios (tipo AS INTEGER, Titulo AS STRING, rod AS STRING)

  teladefundo "±", white, lightblue
  rodape rod, " ", white, blue
  formulario CHR$(180) + Titulo + CHR$(195), 4, 2, 18, 76, white, blue, "±", lightgray, black

  vUsuarios(1) = Repete$(" ", 5)
  AtribuirvUsuarios true
  AbrirArquivo 2
  IF (tipo = 1) OR (tipo = 2) THEN
     RotulosformUsuarios 0
     DesenhaBotao 20, 48, black, white, black, blue, " Salvar ", false
     DesenhaBotao 20, 63, black, white, black, blue, " Fechar ", false
  END IF
  IF (tipo = 3) OR (tipo = 4) OR (tipo = 5) THEN
     DesenhaBotao 20, 63, black, white, black, blue, " Fechar ", false
     RotulosformUsuarios 2
     Etexto 2, 7, white, blue, CHR$(195) + Repete$(CHR$(196), 75) + CHR$(180)
  END IF
  IF tipo = 6 THEN
     DesenhaBotao 20, 63, black, white, black, blue, " Fechar ", false
  END IF
  IF tipo = 3 THEN
     Etexto 5, 6, white, blue, "Numero de Inscricao : "
     Etexto 27, 6, black, lightgray, Repete$(" ", 5)
  END IF
  IF tipo = 4 THEN
     Etexto 5, 6, white, blue, "Nome : "
     Etexto 12, 6, black, lightgray, Repete$(" ", 30)
  END IF
  IF tipo = 5 THEN
     Etexto 5, 6, white, blue, "Identidade : "
     Etexto 18, 6, black, lightgray, Repete$(" ", 10)
  END IF

  LimparUsuarios
  IF tipo = 1 THEN
     ControlesformUsuarios "2", 1, 0, 0, rod, false'cadastrar
  ELSEIF tipo = 2 THEN
     ControlesformUsuarios "1", 2, 0, 0, rod, false'alterar
  ELSEIF tipo = 3 THEN
     ControlesformUsuarios "3", 3, 0, 0, rod, false'consultar por NInsc
  ELSEIF tipo = 4 THEN
     ControlesformUsuarios "4", 4, 0, 0, rod, false'consultar por Nome
  ELSEIF tipo = 5 THEN
     ControlesformUsuarios "5", 5, 0, 0, rod, false'consultar por Identidade
  ELSEIF tipo = 6 THEN
     ControlesformUsuarios "6", 6, 0, 0, rod, true'consultar todos
  END IF
END SUB

'---------------------------------------------------------------------
' Nome : LimparUsuarios
' Descricao : procedimento limpa as variaveis do registro de usuarios.
'---------------------------------------------------------------------
SUB LimparUsuarios

     Usuarios.Ninsc = 0
     Usuarios.Nome = ""
     Usuarios.Ident = "0"
     Usuarios.Endereco.logra = ""
     Usuarios.Endereco.numero = 0
     Usuarios.Endereco.compl = ""
     Usuarios.Endereco.Bairro = ""
     Usuarios.Endereco.Cep = "0"
     Usuarios.Telefone = "0"
     Usuarios.Categoria = " "
     Usuarios.Situacao = 0

END SUB

'--------------------------------------------------------------------
' Nome : PesBinaria
' Descricao : funcao que realiza uma pesquisa binaria
' por numero de inscricao do usuario.
' Parametros :
' Chave - numero de inscricao do usuario a pesquisar
'--------------------------------------------------------------------
FUNCTION PesBinaria (chave AS INTEGER)
DIM inicio AS INTEGER
DIM fim AS INTEGER
DIM meio AS INTEGER
DIM achou AS INTEGER

 inicio = 1
 fim = nTamUsuarios + 1
 achou = false
 DO WHILE ((NOT achou) AND (inicio <= fim))
   meio = ((inicio + fim) / 2)
   SEEK UsuariosFile, (meio - 1) + 1
   GET UsuariosFile, , Usuarios
   IF (chave = Usuarios.Ninsc) THEN
      achou = true
   ELSE
      IF (chave > Usuarios.Ninsc) THEN
        inicio = meio + 1
      ELSE
        fim = meio - 1
      END IF
   END IF
 LOOP
 IF achou = true THEN
    PesBinaria = meio - 1
 ELSE
    PesBinaria = -1
 END IF
END FUNCTION

'----------------------------------------------------------------------
' Nome : PesUsuarios
' Descricao : funcao que pesquisa as informacoes contidas no arquivo de
' usuarios.
' Parametros :
' tipo - indica se e o valor e (N)umerico ou (S)tring
' campo - qual o campo a ser pesquisado
' nCod2 - codigo do campo se numerico
' sCod2 - codigo do campo se string
' nTamsCod - tamanho caracteres do campo de string
'--------------------------------------------------------------------------
FUNCTION PesUsuarios (tipo AS STRING, campo AS STRING, nCod2 AS INTEGER, sCod2 AS STRING, nTamsCod AS INTEGER)
DIM nPosicao AS INTEGER
DIM nCod AS INTEGER
DIM sCod AS STRING
DIM bFlag AS INTEGER

SEEK UsuariosFile, 0 + 1
nPosicao = 0
bFlag = false
nCod = 0
sCod = ""
DO WHILE NOT EOF(UsuariosFile)
   GET UsuariosFile, , Usuarios
   IF tipo = "N" THEN
       IF campo = "Ninsc" THEN
          nCod = Usuarios.Ninsc
       END IF
       IF (nCod = nCod2) THEN
          PesUsuarios = nPosicao
          SEEK UsuariosFile, nPosicao + 1
          bFlag = true
          EXIT DO
       END IF
   ELSEIF tipo = "S" THEN
       IF campo = "Nome" THEN
          sCod = Usuarios.Nome
       ELSEIF campo = "Ident" THEN
          sCod = Usuarios.Ident
       END IF
       IF (MID$(sCod, 1, nTamsCod) = sCod2) THEN
          PesUsuarios = nPosicao
          SEEK UsuariosFile, nPosicao + 1
          bFlag = true
          EXIT DO
       END IF
   END IF
   nPosicao = nPosicao + 1
LOOP
 IF (EOF(UsuariosFile)) AND (bFlag = false) THEN
    PesUsuarios = -1
 END IF
END FUNCTION

'-------------------------------------------------------------------------
' Nome : RotulosformUsuarios
' Descricao : procedimento que escreve os rotulos do formulario de Usuarios.
' Parametros :
' l - indica um acrescimo na linha do rotulo
'-------------------------------------------------------------------------
SUB RotulosformUsuarios (l AS INTEGER)

  Etexto 5, 6 + l, white, blue, "Numero de Inscricao : "
  Etexto 27, 6 + l, black, lightgray, vUsuarios(1)
  Etexto 35, 6 + l, white, blue, "Nome : "
  Etexto 42, 6 + l, black, lightgray, vUsuarios(2)
  Etexto 5, 8 + l, white, blue, "Identidade : "
  Etexto 18, 8 + l, black, lightgray, vUsuarios(3)
  Etexto 2, 10 + l, white, blue, CHR$(195) + Repete$("Ä", 75) + CHR$(180)
  Etexto 5, 10 + l, white, blue, "Endereco"
  Etexto 5, 12 + l, white, blue, "Logradouro : "
  Etexto 18, 12 + l, black, lightgray, vUsuarios(4)
  Etexto 51, 12 + l, white, blue, "Numero : "
  Etexto 60, 12 + l, black, lightgray, vUsuarios(5)
  Etexto 5, 14 + l, white, blue, "Complemento : "
  Etexto 19, 14 + l, black, lightgray, vUsuarios(6)
  Etexto 32, 14 + l, white, blue, "Bairro : "
  Etexto 41, 14 + l, black, lightgray, vUsuarios(7)
  Etexto 63, 14 + l, white, blue, "Cep : "
  Etexto 69, 14 + l, black, lightgray, vUsuarios(8)
  Etexto 2, 16 + l, white, blue, CHR$(195) + Repete$("Ä", 75) + CHR$(180)
  Etexto 31, 8 + l, white, blue, "Telefone : "
  Etexto 42, 8 + l, black, lightgray, vUsuarios(9)
  Etexto 5, 17 + l, white, blue, "Categoria : "
  Etexto 17, 17 + l, black, lightgray, vUsuarios(10)
  Etexto 20, 17 + l, white, blue, "(A)luno ou (P)rofessor ou (F)uncionario"
  Etexto 5, 19 + l, white, blue, "Situacao : "
  Etexto 16, 19 + l, black, lightgray, vUsuarios(11)

END SUB

'-----------------------------------------------------------
' Nome : SalvarUsuarios
' Descricao : procedimento que salva os dados digitados no
' formulario de usuarios.
' Parametros :
' tipo - indica qual acao a salvar
'-----------------------------------------------------------
SUB SalvarUsuarios (tipo AS INTEGER)

IF VerificaUsuarios = true THEN
 IF (Usuarios.Categoria = "A") OR (Usuarios.Categoria = "P") OR (Usuarios.Categoria = "F") THEN
    IF tipo = 1 THEN
        SEEK UsuariosFile, nTamUsuarios + 1
        PUT UsuariosFile, , Usuarios
        AtribuirvUsuarios true
        RotulosformUsuarios 0
        LimparUsuarios
    ELSEIF tipo = 2 THEN
       PUT UsuariosFile, , Usuarios
    END IF
 END IF
ELSE
  rodape "Categoria, Cadastrada Incorretamente !", " ", yellow, red
END IF

END SUB

'-------------------------------------------------------------------------
' Nome : VerificaUsuarios
' Descricao : funcao que verifica se os dados no formulario de usuarios
' foram digitados.
'-------------------------------------------------------------------------
FUNCTION VerificaUsuarios
  S = LTRIM$(STR$(Usuarios.Ninsc))
  IF (LEN(S) = 0) AND (S = Repete$(" ", LEN(S))) THEN
      rodape "Numero de Inscricao, nao cadastrado !", " ", yellow, red
      VerificaUsuarios = false
      EXIT FUNCTION
  END IF
  IF (LEN(Usuarios.Nome) = 0) AND (Usuarios.Nome = Repete$(" ", LEN(Usuarios.Nome))) THEN
      rodape "Nome do Usuario, nao cadastrado !", " ", yellow, red
      VerificaUsuarios = false
      EXIT FUNCTION
  END IF
  IF (LEN(Usuarios.Ident) = 0) AND (Usuarios.Ident = Repete$(" ", LEN(Usuarios.Ident))) THEN
      rodape "Identidade, nao cadastrada !", " ", yellow, red
      VerificaUsuarios = false
      EXIT FUNCTION
  END IF
  IF (LEN(Usuarios.Endereco.logra) = 0) AND (Usuarios.Endereco.logra = Repete$(" ", LEN(Usuarios.Endereco.logra))) THEN
      rodape "Logradouro, nao cadastrado !", " ", yellow, red
      VerificaUsuarios = false
      EXIT FUNCTION
  END IF
  S = LTRIM$(STR$(Usuarios.Endereco.numero))
  IF (LEN(S) = 0) AND (S = Repete$(" ", LEN(S))) THEN
      rodape "Numero do Endereco, nao cadastrado !", " ", yellow, red
      VerificaUsuarios = false
      EXIT FUNCTION
  END IF
  IF (LEN(Usuarios.Endereco.compl) = 0) AND (Usuarios.Endereco.compl = Repete$(" ", LEN(Usuarios.Endereco.compl))) THEN
      rodape "Complemento do Endereco, nao cadastrado !", " ", yellow, red
      VerificaUsuarios = false
      EXIT FUNCTION
  END IF
  IF (LEN(Usuarios.Endereco.Bairro) = 0) AND (Usuarios.Endereco.Bairro = Repete$(" ", LEN(Usuarios.Endereco.Bairro))) THEN
      rodape "Bairro, nao cadastrado !", " ", yellow, red
      VerificaUsuarios = false
      EXIT FUNCTION
  END IF
  IF (LEN(Usuarios.Endereco.Cep) = 0) AND (Usuarios.Endereco.Cep = Repete$(" ", LEN(Usuarios.Endereco.Cep))) THEN
      rodape "Cep, nao cadastrado !", " ", yellow, red
      VerificaUsuarios = false
      EXIT FUNCTION
  END IF
  IF (LEN(Usuarios.Telefone) = 0) AND (Usuarios.Telefone = Repete$(" ", LEN(Usuarios.Telefone))) THEN
      rodape "Telefone, nao cadastrado !", " ", yellow, red
      VerificaUsuarios = false
      EXIT FUNCTION
  END IF
  IF (LEN(Usuarios.Categoria) = 0) AND (Usuarios.Categoria = Repete$(" ", LEN(Usuarios.Categoria))) THEN
      rodape "Categoria, nao cadastrada !", " ", yellow, red
      VerificaUsuarios = false
      EXIT FUNCTION
  END IF

 VerificaUsuarios = true
END FUNCTION
