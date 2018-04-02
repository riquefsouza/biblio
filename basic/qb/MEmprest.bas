' Modulo de Emprestimos

'$include:'biblio.inc'

'-------------------------------------------------------------------------
' Nome : AtribuirvEmprestimos
' Descricao : procedimento que atribui ou limpa o vetor de Emprestimos.
' Parametros :
' limpar - indica se vai limpar ou atribuir os vetores
'-------------------------------------------------------------------------
SUB AtribuirvEmprestimos (limpar AS INTEGER)

IF limpar = false THEN
  vEmprestimos(3) = Emprestimos.DtEmprestimo
  vEmprestimos(4) = Emprestimos.DtDevolucao
ELSE
  vEmprestimos(2) = Repete$(" ", 5)
  vEmprestimos(3) = Repete$(" ", 10)
  vEmprestimos(4) = Repete$(" ", 10)
END IF
END SUB

'-------------------------------------------------------------------------
' Nome : ControlesformEmprestimos
' Descricao : procedimento que realiza todo o controle de manuseio do
' formulario de Emprestimos.
' Parametros :
' tipo - indica qual a acao do formulario
' tipo2 - indica a acao original do formulario nao manipulado pela funcao
' pos - indica a ultima posicao da linha da lista de emprestimos
' col - indica a ultima posicao da coluna da lista de emprestimos
' rod - o texto do rodape sobre o formulario
' foco - se os objetos do formulario estao focados ou nao
'-------------------------------------------------------------------------
SUB ControlesformEmprestimos (tipo AS STRING, tipo2 AS INTEGER, posi AS INTEGER, col AS INTEGER, rod AS STRING, foco AS INTEGER)
DIM sDiasAtraso AS STRING
DIM sMulta AS STRING
DIM nDiasAtraso AS INTEGER
DIM nMulta AS SINGLE

IF tipo = "1" THEN
  S = ""
  rodape "", " ", white, blue
  Etexto 61, 8, white, blue, ""
  Etexto 55, 12, white, blue, ""
  Etexto 23, 16, black, lightgray, ""
  Etexto 59, 16, black, lightgray, ""
  S = Digita$(S, 5, 5, 39, 5, black, lightgray, "N", 0)
  i = VAL(S)
  Usuarios.Ninsc = i
  Emprestimos.NinscUsuario = i
  IF (LEN(S) > 0) AND (S <> Repete$(" ", LEN(S))) THEN
    IF PesUsuarios("N", "Ninsc", i, "", 0) <> -1 THEN
      Etexto 16, 8, black, lightgray, Usuarios.Nome
      IF Usuarios.Categoria = "F" THEN
         Etexto 61, 8, white, blue, "Funcionario"
      ELSEIF Usuarios.Categoria = "A" THEN
         Etexto 61, 8, white, blue, "Aluno      "
      ELSEIF Usuarios.Categoria = "P" THEN
         Etexto 61, 8, white, blue, "Professor  "
      END IF

      S = ""
      S = Digita$(S, 5, 5, 37, 9, black, lightgray, "N", 0)
      i = VAL(S)
      Livros.Ninsc = i
      Emprestimos.NinscLivro = i
      IF (LEN(S) > 0) AND (S <> Repete$(" ", LEN(S))) THEN
        IF PesLivros("N", "Ninsc", i, "", 0) <> -1 THEN
           Etexto 13, 12, black, lightgray, Livros.Titulo
           IF Livros.Estado = "D" THEN
             Etexto 55, 12, white, blue, "Disponivel"
           ELSE
             Etexto 55, 12, white, blue, "Emprestado"
           END IF
           'Emprestimo

           IF tipo2 = 1 THEN
              IF Livros.Estado = "D" THEN
                IF Usuarios.Situacao < 4 THEN
                   IF Usuarios.Categoria = "F" THEN
                     Emprestimos.DtDevolucao = SomaDias(RetDataAtual$, 7)
                   ELSEIF Usuarios.Categoria = "A" THEN
                     Emprestimos.DtDevolucao = SomaDias(RetDataAtual$, 14)
                   ELSEIF Usuarios.Categoria = "P" THEN
                     Emprestimos.DtDevolucao = SomaDias(RetDataAtual$, 30)
                   END IF
                   Emprestimos.DtEmprestimo = RetDataAtual$
                   Usuarios.Situacao = Usuarios.Situacao + 1
                   Livros.Estado = "E"
                   Etexto 27, 14, black, lightgray, Emprestimos.DtEmprestimo
                   Etexto 61, 14, black, lightgray, Emprestimos.DtDevolucao
                   ControlesformEmprestimos "Emprestar", tipo2, posi, col, rod, true
                ELSE
                   rodape "Usuario com 4 livros em sua posse, Impossivel Efetuar Emprestimo !", " ", yellow, red
                   ControlesformEmprestimos "Fechar", tipo2, posi, col, rod, true
                END IF
              ELSE
                rodape "O livro ja esta emprestado, Impossivel Efetuar Emprestimo !", " ", yellow, red
                ControlesformEmprestimos "Fechar", tipo2, posi, col, rod, true
              END IF
             'Devolucao
           ELSEIF tipo2 = 2 THEN
              IF PesEmprestimos(Usuarios.Ninsc, Livros.Ninsc) <> -1 THEN
                 IF Livros.Estado = "E" THEN
                   IF ((Usuarios.Situacao >= 1) AND (Usuarios.Situacao <= 4)) THEN
                      IF ConverteData(Emprestimos.DtDevolucao) < ConverteData(RetDataAtual$) THEN
                         nDiasAtraso = 0
                         nMulta = 0!
                         nDiasAtraso = SubtraiDatas(Emprestimos.DtDevolucao, RetDataAtual$)
                         nMulta = (.5 * nDiasAtraso)
                      ELSE
                         nDiasAtraso = 0
                         nMulta = 0!
                      END IF
                      sDiasAtraso = LTRIM$(STR$(nDiasAtraso))
                      sMulta = LTRIM$(STR$(nMulta))
                      Etexto 27, 14, black, lightgray, Emprestimos.DtEmprestimo
                      Etexto 61, 14, black, lightgray, Emprestimos.DtDevolucao
                      Etexto 23, 16, black, lightgray, sDiasAtraso
                      Etexto 59, 16, black, lightgray, sMulta
                      Usuarios.Situacao = Usuarios.Situacao - 1
                      Livros.Estado = "D"
                      ControlesformEmprestimos "Devolver", tipo2, posi, col, rod, true
                   ELSE
                      rodape "Usuario com 0 livros em sua posse, Impossivel Efetuar Devolucao !", " ", yellow, red
                      ControlesformEmprestimos "Fechar", tipo2, posi, col, rod, true
                   END IF
                 ELSE
                   rodape "O livro ja esta disponivel, Impossivel Efetuar Devolucao !", " ", yellow, red
                   ControlesformEmprestimos "Fechar", tipo2, posi, col, rod, true
                 END IF
              ELSE
                 rodape "Emprestimo inexistente, Impossivel Efetuar Devolucao !", " ", yellow, red
                 ControlesformEmprestimos "Fechar", tipo2, posi, col, rod, true
              END IF
           END IF
             '---
        ELSE
          S = LTRIM$(STR$(i))
          AtribuirvEmprestimos true
          RotulosformEmprestimos tipo2, 0
          rodape "Numero de Inscricao do Livro, nao encontrado !", " ", yellow, red
          ControlesformEmprestimos "Fechar", tipo2, posi, col, rod, true
        END IF
      ELSE
        ControlesformEmprestimos "Fechar", tipo2, posi, col, rod, true
      END IF
    ELSE
      S = LTRIM$(STR$(i))
      AtribuirvEmprestimos true
      RotulosformEmprestimos tipo2, 0
      rodape "Numero de Inscricao do Usuario, nao encontrado !", " ", yellow, red
      ControlesformEmprestimos "Fechar", tipo2, posi, col, rod, true
    END IF
  ELSE
    ControlesformEmprestimos "Fechar", tipo2, posi, col, rod, true
  END IF
ELSEIF tipo = "2" THEN
   listapos = posi
   listacol = col
   IF lista(3, 6, 5, 13, 70, nTamEmprestimos + 2, 113, white, blue, foco) = 1 THEN
        desenhalista 3, 6, 5, 13, 70, white, blue, posi, col, false
        ControlesformEmprestimos "Fechar", tipo2, posi, col, rod, true
   END IF
ELSEIF tipo = "Emprestar" THEN
    SELECT CASE Botao(20, 45, black, white, black, blue, " Emprestar ", foco)
      CASE 1
          DesenhaBotao 20, 45, black, white, black, blue, " Emprestar ", false
          ControlesformEmprestimos "Fechar", tipo2, posi, col, rod, true
      CASE 2
         IF PesEmprestimos(Usuarios.Ninsc, Livros.Ninsc) <> -1 THEN
            Emprestimos.Removido = false
            SalvarEmprestimos 2
         ELSE
            Emprestimos.Removido = false
            nTamEmprestimos = LOF(EmprestiFile) / LEN(Emprestimos)
            SalvarEmprestimos 1
         END IF
         DesenhaBotao 20, 45, black, white, black, blue, " Emprestar ", false
         ControlesformEmprestimos "Fechar", tipo2, posi, col, rod, true
    END SELECT
ELSEIF tipo = "Devolver" THEN
    SELECT CASE Botao(20, 45, black, white, black, blue, " Devolver ", foco)
      CASE 1
          DesenhaBotao 20, 45, black, white, black, blue, " Devolver ", false
          ControlesformEmprestimos "Fechar", tipo2, posi, col, rod, true
      CASE 2
          Emprestimos.Removido = true
          SalvarEmprestimos 2
          DesenhaBotao 20, 45, black, white, black, blue, " Devolver ", false
          ControlesformEmprestimos "Fechar", tipo2, posi, col, rod, true
    END SELECT
ELSEIF tipo = "Fechar" THEN
   SELECT CASE Botao(20, 60, black, white, black, blue, " Fechar ", foco)
      CASE 1
          DesenhaBotao 20, 60, black, white, black, blue, " Fechar ", false
          IF (tipo2 = 1) OR (tipo2 = 2) THEN
            ControlesformEmprestimos "1", tipo2, posi, col, rod, true
          ELSEIF tipo2 = 3 THEN
            ControlesformEmprestimos "2", tipo2, posi, col, rod, true
          END IF
      CASE 2
         rodape "", " ", white, blue
         CLOSE LivrosFile
         CLOSE UsuariosFile
         CLOSE EmprestimosFile
         '------------------
         teladefundo "±", white, lightblue
         '-------------------
   END SELECT
END IF

END SUB

'-------------------------------------------------------------------------
' Nome : formEmprestimos
' Descricao : procedimento que desenha o formulario de Emprestimos
' na tela, e tambem indica qual acao a tomar.
' Parametros :
' tipo - indica qual a acao do formulario
' titulo - o titulo do formulario
' rod - o texto do rodape sobre o formulario
'-------------------------------------------------------------------------
SUB formEmprestimos (tipo AS INTEGER, Titulo AS STRING, rod AS STRING)

  teladefundo "±", white, lightblue
  rodape rod, " ", white, blue
  formulario CHR$(180) + Titulo + CHR$(195), 4, 2, 18, 76, white, blue, "±", lightgray, black

  vEmprestimos(1) = Repete$(" ", 5)
  AtribuirvEmprestimos true
  AbrirArquivo 1
  AbrirArquivo 2
  AbrirArquivo 3
  IF tipo = 1 THEN
     RotulosformEmprestimos 1, 0
     DesenhaBotao 20, 45, black, white, black, blue, " Emprestar ", false
     DesenhaBotao 20, 60, black, white, black, blue, " Fechar ", false
  END IF
  IF tipo = 2 THEN
     RotulosformEmprestimos 2, 0
     DesenhaBotao 20, 45, black, white, black, blue, " Devolver ", false
     DesenhaBotao 20, 60, black, white, black, blue, " Fechar ", false
  END IF
  IF tipo = 3 THEN
     DesenhaBotao 20, 60, black, white, black, blue, " Fechar ", false
  END IF
  LimparEmprestimos
  IF tipo = 1 THEN
     ControlesformEmprestimos "1", 1, 0, 0, rod, false 'Emprestar
  ELSEIF tipo = 2 THEN
     ControlesformEmprestimos "1", 2, 0, 0, rod, false 'Devolver
  ELSEIF tipo = 3 THEN
     ControlesformEmprestimos "2", 3, 0, 0, rod, true 'consultar todos
  END IF
END SUB

'-------------------------------------------------------------------------
' Nome : LimparEmprestimos
' Descricao : procedimento limpa as variaveis do registro de Emprestimos.
'-------------------------------------------------------------------------
SUB LimparEmprestimos

     Emprestimos.NinscUsuario = 0
     Emprestimos.NinscLivro = 0
     Emprestimos.DtEmprestimo = RetDataAtual$
     Emprestimos.Removido = false

END SUB

'-------------------------------------------------------------------------
' Nome : PesEmprestimos
' Descricao : funcao que pesquisa as informacoes contidas no arquivo de
' Emprestimos.
' Parametros :
' nCodUsuario - codigo do campo de numero de inscricao do usuario
' sCodLivro - codigo do campo de numero de inscricao do livro
'-------------------------------------------------------------------------
FUNCTION PesEmprestimos (nCodUsuario AS INTEGER, nCodLivro AS INTEGER)
DIM nPosicao AS INTEGER
DIM bFlag AS INTEGER

SEEK EmprestimosFile, 0 + 1
nPosicao = 0
bFlag = false
DO WHILE NOT EOF(EmprestimosFile)
   GET EmprestimosFile, , Emprestimos
   IF (Emprestimos.NinscUsuario = nCodUsuario) AND (Emprestimos.NinscLivro = nCodLivro) THEN
      PesEmprestimos = nPosicao
      SEEK EmprestimosFile, nPosicao + 1
      bFlag = true
      EXIT DO
   END IF
   nPosicao = nPosicao + 1
LOOP
 IF (EOF(EmprestimosFile)) AND (bFlag = false) THEN
    Emprestimos.NinscUsuario = nCodUsuario
    Emprestimos.NinscLivro = nCodLivro
    PesEmprestimos = -1
 END IF
END FUNCTION

'--------------------------------------------------------------------
' Nome : RotulosformEmprestimos
' Descricao : procedimento que escreve os rotulos do formulario de
' Emprestimos.
' Parametros :
' tipo - indica qual a acao do formulario
' l - indica um acrescimo na linha do rotulo
'--------------------------------------------------------------------
SUB RotulosformEmprestimos (tipo AS INTEGER, l AS INTEGER)
IF (tipo = 1) OR (tipo = 2) THEN
  Etexto 5, 6 + l, white, blue, "Numero de Inscricao do Usuario : "
  Etexto 38, 6 + l, black, lightgray, vEmprestimos(1)
  Etexto 5, 8 + l, white, blue, "Usuario : "
  Etexto 16, 8 + l, black, lightgray, Repete$(" ", 30)
  Etexto 49, 8 + l, white, blue, "Categoria : "
  Etexto 5, 10 + l, white, blue, "Numero de Inscricao do Livro : "
  Etexto 36, 10 + l, black, lightgray, vEmprestimos(2)
  Etexto 5, 12 + l, white, blue, "Livro : "
  Etexto 13, 12 + l, black, lightgray, Repete$(" ", 30)
  Etexto 46, 12 + l, white, blue, "Estado : "
  Etexto 5, 14 + l, white, blue, "Data do Emprestimo : "
  Etexto 27, 14 + l, black, lightgray, vEmprestimos(3)
  Etexto 40, 14 + l, white, blue, "Data de Devolucao : "
  Etexto 61, 14 + l, black, lightgray, vEmprestimos(4)
END IF
IF tipo = 2 THEN
  Etexto 5, 16 + l, white, blue, "Dias em Atraso : "
  Etexto 23, 16 + l, black, lightgray, Repete$(" ", 4)
  Etexto 31, 16 + l, white, blue, "Multa por dias em atraso : "
  Etexto 59, 16 + l, black, lightgray, Repete$(" ", 7)
END IF
END SUB

'--------------------------------------------------------------------
' Nome : SalvarEmprestimos
' Descricao : procedimento que salva os dados digitados no
' formulario de emprestimos.
' Parametros :
' tipo - indica qual acao a salvar
'--------------------------------------------------------------------
SUB SalvarEmprestimos (tipo AS INTEGER)

    PUT LivrosFile, , Livros
    PUT UsuariosFile, , Usuarios
    IF tipo = 1 THEN
        SEEK EmprestimosFile, nTamEmprestimos + 1
        PUT EmprestimosFile, , Emprestimos
        AtribuirvEmprestimos true
        RotulosformEmprestimos 1, 0
    ELSEIF tipo = 2 THEN
        PUT EmprestimosFile, , Emprestimos
        AtribuirvEmprestimos true
        RotulosformEmprestimos 1, 0
    END IF
END SUB
