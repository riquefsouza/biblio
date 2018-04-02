' Nome : Sistema de Automacao de Biblioteca (Biblio)
' Autor : Henrique Figueiredo de Souza
' Linguagem : Basic
' intepretador : QBasic
' Compilador : QuickBasic
' Data de Realizacao : 4 de setembro de 1999
' Ultima Atualizacao : 15 de fevereiro de 2000
' Versao do Sistema : 1.0
' Nome do(s) Arquivo(s) e Como Compilar (nesta ordem) :
' 1. Biblio.bas --> "qbasic /run biblio.bas" (interpretado)
'
' Descricao :
' O Sistema e composto dos seguintes modulos:
' 1.Modulo de Livros da Biblioteca
'   Onde se realiza a manutencao dos livros da biblioteca
' 2.Modulo de Usuarios da Bilioteca
'   Onde se realiza a manutencao dos usuarios da biblioteca
' 3.Modulo de Emprestimos e Devolucoes da Biblioteca
'   Onde se efetua os emprestimos e devolucoes da biblioteca
' 4.Modulo de Opcoes do sistema
'   Onde e possivel ver sobre o sistema e sair dele
'
'programa Biblio

'Declaracao de procedimentos

DECLARE SUB EscreveRapido (x AS INTEGER, y AS INTEGER, S AS STRING, fg AS INTEGER, bg AS INTEGER)
DECLARE SUB center (y AS INTEGER, S AS STRING, fg AS INTEGER, bg AS INTEGER)
DECLARE SUB SetString (backgroundchar AS INTEGER)
DECLARE SUB XY (x AS INTEGER, y AS INTEGER)
DECLARE SUB teladefundo (tipo AS STRING, fg AS INTEGER, bg AS INTEGER)
DECLARE SUB Etexto (c AS INTEGER, l AS INTEGER, fg AS INTEGER, bg AS INTEGER, texto AS STRING)
DECLARE SUB cabecalho (texto AS STRING, tipo AS STRING, fg AS INTEGER, bg AS INTEGER)
DECLARE SUB rodape (texto AS STRING, tipo AS STRING, fg AS INTEGER, bg AS INTEGER)
DECLARE SUB DatadoSistema (l AS INTEGER, c AS INTEGER, fg AS INTEGER, bg AS INTEGER)
DECLARE SUB HoradoSistema (l AS INTEGER, c AS INTEGER, fg AS INTEGER, bg AS INTEGER)
DECLARE SUB Menu (qtd AS INTEGER, topo AS INTEGER, fg AS INTEGER, bg AS INTEGER, lfg AS INTEGER, lbg AS INTEGER, pos2 AS INTEGER, mfg AS INTEGER, mbg AS INTEGER, cont2 AS INTEGER)
DECLARE SUB formulario (Titulo AS STRING, topo AS INTEGER, esquerda AS INTEGER, altura AS INTEGER, largura AS INTEGER, fg AS INTEGER, bg AS INTEGER, sombra AS STRING, sfg AS INTEGER, sbg AS INTEGER)
DECLARE SUB ControlaMenus (tipo AS STRING, ultpos AS INTEGER, tf AS INTEGER)
DECLARE SUB formSplash ()
DECLARE SUB DesenhaBotao (topo AS INTEGER, esquerda AS INTEGER, fg AS INTEGER, bg AS INTEGER, sfg AS INTEGER, sbg AS INTEGER, texto AS STRING, foco AS INTEGER)
DECLARE SUB desenhalista (tipo AS INTEGER, topo AS INTEGER, esquerda AS INTEGER, altura AS INTEGER, largura AS INTEGER, fg AS INTEGER, bg AS INTEGER, posi AS INTEGER, col AS INTEGER, foco AS INTEGER)
DECLARE SUB AbrirArquivo (tipo AS INTEGER)
DECLARE SUB formSair ()
DECLARE SUB ControlesformSair (tipo AS STRING, foco AS INTEGER)
DECLARE SUB formSobre ()
DECLARE SUB LerArquivoSobre ()
DECLARE SUB ControlesformSobre (tipo AS STRING, posi AS INTEGER, col AS INTEGER, foco AS INTEGER)
DECLARE SUB formLivros (tipo AS INTEGER, Titulo AS STRING, rod AS STRING)
DECLARE SUB ControlesformLivros (tipo AS STRING, tipo2 AS INTEGER, posi AS INTEGER, col AS INTEGER, rod AS STRING, foco AS INTEGER)
DECLARE SUB Atribuirvlivros (limpar AS INTEGER)
DECLARE SUB DigitaformLivros ()
DECLARE SUB SalvarLivros (tipo AS INTEGER)
DECLARE SUB Rotulosformlivros (l AS INTEGER)
DECLARE SUB LimparLivros ()
DECLARE SUB AtribuirvUsuarios (limpar AS INTEGER)
DECLARE SUB RotulosformUsuarios (l AS INTEGER)
DECLARE SUB LimparUsuarios ()
DECLARE SUB ControlesformUsuarios (tipo AS STRING, tipo2 AS INTEGER, posi AS INTEGER, col AS INTEGER, rod AS STRING, foco AS INTEGER)
DECLARE SUB DigitaformUsuarios ()
DECLARE SUB SalvarUsuarios (tipo AS INTEGER)
DECLARE SUB AtribuirvEmprestimos (limpar AS INTEGER)
DECLARE SUB RotulosformEmprestimos (tipo AS INTEGER, l AS INTEGER)
DECLARE SUB LimparEmprestimos ()
DECLARE SUB ControlesformEmprestimos (tipo AS STRING, tipo2 AS INTEGER, posi AS INTEGER, col AS INTEGER, rod AS STRING, foco AS INTEGER)
DECLARE SUB SalvarEmprestimos (tipo AS INTEGER)
DECLARE SUB formEmprestimos (tipo AS INTEGER, Titulo AS STRING, rod AS STRING)
DECLARE SUB formUsuarios (tipo AS INTEGER, Titulo AS STRING, rod AS STRING)

'Declaracao de funcoes

DECLARE FUNCTION inkeyEx$ ()
DECLARE FUNCTION Digita$ (S AS STRING, JanelaTam AS INTEGER, maxtam AS INTEGER, x AS INTEGER, y AS INTEGER, fg AS INTEGER, bg AS INTEGER, FT AS STRING, fundo AS INTEGER)
DECLARE FUNCTION SubMenu (numero AS INTEGER, qtd AS INTEGER, maxtam AS INTEGER, topo AS INTEGER, esquerda AS INTEGER, ultpos AS INTEGER, lfg AS INTEGER, lbg AS INTEGER, fg AS INTEGER, bg AS INTEGER)
DECLARE FUNCTION Trim$ (str1 AS STRING)
DECLARE FUNCTION Repete$ (St AS STRING, tam AS INTEGER)
DECLARE FUNCTION Deletar$ (str AS STRING, ini AS INTEGER, tam AS INTEGER)
DECLARE FUNCTION inserir$ (origem AS STRING, alvo AS STRING, ini AS INTEGER)
DECLARE FUNCTION Botao (topo AS INTEGER, esquerda AS INTEGER, fg AS INTEGER, bg AS INTEGER, sfg AS INTEGER, sbg AS INTEGER, texto AS STRING, foco AS INTEGER)
DECLARE FUNCTION TiposLista$ (tipo AS INTEGER, largura AS INTEGER, posi AS INTEGER, col AS INTEGER)
DECLARE FUNCTION lista (tipo AS INTEGER, topo AS INTEGER, esquerda AS INTEGER, altura AS INTEGER, largura AS INTEGER, tlinhas AS INTEGER, tcolunas AS INTEGER, fg AS INTEGER, bg AS INTEGER, foco AS INTEGER)
DECLARE FUNCTION PesLivros (tipo AS STRING, campo AS STRING, nCod2 AS INTEGER, sCod2 AS STRING, nTamsCod AS INTEGER)
DECLARE FUNCTION VerificaLivros ()
DECLARE FUNCTION PesUsuarios! (tipo AS STRING, campo AS STRING, nCod2 AS INTEGER, sCod2 AS STRING, nTamsCod AS INTEGER)
DECLARE FUNCTION PesBinaria! (chave AS INTEGER)
DECLARE FUNCTION VerificaUsuarios! ()
DECLARE FUNCTION RetDataAtual$ ()
DECLARE FUNCTION ConverteData! (dt AS STRING)
DECLARE FUNCTION SubtraiDatas! (dt1 AS STRING, dt2 AS STRING)
DECLARE FUNCTION SomaDias$ (dt1 AS STRING, qtddias AS INTEGER)
DECLARE FUNCTION PesEmprestimos! (nCodUsuario AS INTEGER, nCodLivro AS INTEGER)
DECLARE FUNCTION Zeros$ (S AS STRING, tam AS INTEGER)
DECLARE FUNCTION DiadaSemana$ (dt AS STRING)

'Declaracao de tipos

'Registro de Enderecos

TYPE Enderecos
     logra AS STRING * 30   'Logradouro
     numero AS INTEGER      'Numero do Endereco (5)
     compl AS STRING * 10   'Complemento
     Bairro AS STRING * 20  'Bairro do Endereco
     Cep AS STRING * 8      'Cep do Endereco (8)
END TYPE

'Registro de Livros

TYPE LivrosRec
     Ninsc AS INTEGER       'Numero de Inscricao do Livro (5)
     Titulo AS STRING * 30  'Titulo do Livro
     Autor AS STRING * 30   'Autor do Livro
     Area AS STRING * 30    'Area de atuacao do Livro
     Pchave AS STRING * 10  'Palavra-Chave para pesquisar o Livro
     Edicao AS INTEGER      'Edicao do Livro (4)
     AnoPubli AS INTEGER    'Ano de Publicacao do Livro (4)
     Editora AS STRING * 30 'Editora do Livro
     Volume AS INTEGER      'Volume do Livro (4)
     Estado AS STRING * 1   'Estado Atual - (D)isponivel ou (E)mprestado
END TYPE

'Registro de Usuarios

TYPE UsuariosRec
     Ninsc AS INTEGER        'Numero de inscricao do Usuario (5)
     Nome AS STRING * 30     'Nome completo do Usuario
     Ident AS STRING * 10    'Identidade do Usuario (10)
     Endereco AS Enderecos   'Endereco completo do Usuario (73)
     Telefone AS STRING * 11 'Telefone do Usuario (11)
     Categoria AS STRING * 1 'Categoria - (A)luno,(P)rofessor,(F)uncionario
     Situacao AS INTEGER     'Situacao - Numero de Livros em sua posse (1)
END TYPE

'Registro de Emprestimos

TYPE EmprestimosRec
     NinscUsuario AS INTEGER     'Numero de inscricao do Usuario (5)
     NinscLivro AS INTEGER       'Numero de inscricao do Livro (5)
     DtEmprestimo AS STRING * 10 'Data de Emprestimo do Livro
     DtDevolucao AS STRING * 10  'Data de Devolucao do Livro
     Removido AS INTEGER         'Removido - Indica exclusao logica
END TYPE

'Declaracao de variaveis globais

'variaveis gerais

 COMMON SHARED sKey AS STRING
 COMMON SHARED ch AS STRING
 COMMON SHARED S AS STRING
 COMMON SHARED vs() AS STRING
 COMMON SHARED i AS INTEGER

'variaveis de menu

 COMMON SHARED vMenu() AS STRING
 COMMON SHARED vSubMenu() AS STRING

'variaveis de lista

 COMMON SHARED vLista() AS STRING
 COMMON SHARED listapos AS INTEGER
 COMMON SHARED listacol AS INTEGER

'variaveis do modulo de livros

 COMMON SHARED Livros AS LivrosRec
 COMMON SHARED nTamLivros AS INTEGER
 COMMON SHARED vLivros() AS STRING

'variaveis do modulo de Usuarios

 COMMON SHARED Usuarios AS UsuariosRec
 COMMON SHARED nTamUsuarios AS INTEGER
 COMMON SHARED vUsuarios() AS STRING

'variaveis do modulo de Emprestimos

 COMMON SHARED Emprestimos AS EmprestimosRec
 COMMON SHARED nTamEmprestimos AS INTEGER
 COMMON SHARED vEmprestimos() AS STRING

'Declaracao de dimensoes

 DIM vs(0 TO 300) AS STRING
 DIM vMenu(1 TO 10) AS STRING
 DIM vSubMenu(1 TO 10, 1 TO 10) AS STRING
 DIM vLista(0 TO 50) AS STRING
 DIM vLivros(1 TO 10) AS STRING
 DIM vUsuarios(1 TO 11) AS STRING
 DIM vEmprestimos(1 TO 5) AS STRING

'Declaracao de constantes

CONST TRUE = 1
CONST FALSE = 0

CONST white = 15
CONST lightblue = 9
CONST blue = 1
CONST black = 0
CONST lightgray = 7
CONST red = 4
CONST yellow = 14

CONST LivrosFile = 1
CONST UsuariosFile = 2
CONST EmprestimosFile = 3
CONST SobreFile = 4

'-----------------------------------------------------------------

'Bloco principal do programa

  CLS
  teladefundo "±", white, lightblue
  cabecalho "Sistema de Automacao de Biblioteca", " ", white, blue
  rodape "", " ", white, blue
  DatadoSistema 1, 1, white, blue
  HoradoSistema 1, 73, white, blue

  vMenu(1) = "Acervo"
  vMenu(2) = "Usuarios"
  vMenu(3) = "Emprestimos e Devolucoes"
  vMenu(4) = "Opcoes"
                  
  vSubMenu(1, 1) = "Cadastrar livros"
  vSubMenu(1, 2) = "Alterar livros"
  vSubMenu(1, 3) = "Consultar livros >"

  vSubMenu(2, 1) = "Cadastrar usuarios"
  vSubMenu(2, 2) = "Alterar usuarios"
  vSubMenu(2, 3) = "Consultar usuarios >"

  vSubMenu(3, 1) = "Emprestar livros"
  vSubMenu(3, 2) = "Devolver livros"
  vSubMenu(3, 3) = "Consultar Emprestimos e Devolucoes"

  vSubMenu(4, 1) = "Sobre o sistema"
  vSubMenu(4, 2) = "Sair do sistema"

  vSubMenu(5, 1) = "Todos os livros"
  vSubMenu(5, 2) = "Por Titulo"
  vSubMenu(5, 3) = "Por Autor"
  vSubMenu(5, 4) = "Por Area"
  vSubMenu(5, 5) = "Por Palavra-chave"

  vSubMenu(6, 1) = "Todos os Usuarios"
  vSubMenu(6, 2) = "Por Numero de Inscricao"
  vSubMenu(6, 3) = "Por Nome"
  vSubMenu(6, 4) = "Por Identidade"

  Menu 4, 2, black, lightgray, red, lightgray, 0, white, black, 0
  formSplash
 
  teladefundo "±", white, lightblue
  Menu 4, 2, black, lightgray, red, lightgray, 0, white, black, 0

DO
  
   sKey$ = inkeyEx$

   IF sKey$ = "AltA" THEN
      ControlaMenus "A", 1, TRUE
      teladefundo "±", white, lightblue
      Menu 4, 2, black, lightgray, red, lightgray, 0, white, black, 0
   END IF
   IF sKey$ = "AltU" THEN
      ControlaMenus "U", 1, TRUE
      teladefundo "±", white, lightblue
      Menu 4, 2, black, lightgray, red, lightgray, 0, white, black, 0
   END IF
   IF sKey$ = "AltE" THEN
      ControlaMenus "E", 1, TRUE
      teladefundo "±", white, lightblue
      Menu 4, 2, black, lightgray, red, lightgray, 0, white, black, 0
   END IF
   IF sKey$ = "AltO" THEN
      ControlaMenus "O", 1, TRUE
      teladefundo "±", white, lightblue
      Menu 4, 2, black, lightgray, red, lightgray, 0, white, black, 0
   END IF
    
LOOP UNTIL sKey$ = "Esc"

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

'-------------------------------------------------------------------------
' Nome : AtribuirvEmprestimos
' Descricao : procedimento que atribui ou limpa o vetor de Emprestimos.
' Parametros :
' limpar - indica se vai limpar ou atribuir os vetores
'-------------------------------------------------------------------------
SUB AtribuirvEmprestimos (limpar AS INTEGER)

IF limpar = FALSE THEN
  vEmprestimos(3) = Emprestimos.DtEmprestimo
  vEmprestimos(4) = Emprestimos.DtDevolucao
ELSE
  vEmprestimos(2) = Repete$(" ", 5)
  vEmprestimos(3) = Repete$(" ", 10)
  vEmprestimos(4) = Repete$(" ", 10)
END IF
END SUB

'--------------------------------------------------------------------
' Nome : AtribuirvLivros
' Descricao : procedimento que atribui ou limpa o vetor de livros.
' Parametros :
' limpar - indica se vai limpar ou atribuir os vetores
'--------------------------------------------------------------------
SUB Atribuirvlivros (limpar AS INTEGER)
IF limpar = FALSE THEN
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
' Nome : AtribuirvUsuarios
' Descricao : procedimento que atribui ou limpa o vetor de Usuarios.
' Parametros :
' limpar - indica se vai limpar ou atribuir os vetores
'-------------------------------------------------------------------------
SUB AtribuirvUsuarios (limpar AS INTEGER)

IF limpar = FALSE THEN

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

IF foco = TRUE THEN
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

'---------------------------------------------------------------------------
' Nome : ControlaMenus
' Descricao : procedimento que faz todo o controle de manuseio dos submenus.
' Parametros :
' tipo - indica qual o submenu selecionado do menu
' ultpos - indica a ultima posicao da opcao de submenu selecionada
' tf - indica se vai redesenhar a tela de fundo
'---------------------------------------------------------------------------
SUB ControlaMenus (tipo AS STRING, ultpos AS INTEGER, tf AS INTEGER)

IF tf = TRUE THEN
  teladefundo "±", white, lightblue
END IF

IF tipo = "A" THEN
    rodape "Controle do Acervo da Biblioteca.", " ", white, blue
    formulario "", 3, 3, 4, 20, black, lightgray, "±", lightgray, black
    Menu 4, 2, black, lightgray, red, lightgray, 1, yellow, lightgray, 1
    SELECT CASE SubMenu(1, 3, 16, 4, 5, ultpos, yellow, lightgray, black, lightgray)
      CASE 1
          ControlaMenus "O", 1, TRUE
      CASE 2
          ControlaMenus "U", 1, TRUE
      CASE 3
          formLivros 1, "Cadastrar Livros", "Cadastro dos Livros do Acervo da Biblioteca."
      CASE 4
          formLivros 2, "Alterar Livros", "Altera os Livros do Acervo da Biblioteca."
      CASE 5
          ControlaMenus "5", 1, FALSE
    END SELECT
ELSEIF tipo = "U" THEN
    Menu 4, 2, black, lightgray, red, lightgray, 10, yellow, lightgray, 2
    rodape "Controle de Usuarios da Biblioteca.", " ", white, blue
    formulario "", 3, 12, 4, 22, black, lightgray, "±", lightgray, black
    SELECT CASE SubMenu(2, 3, 18, 4, 14, ultpos, yellow, lightgray, black, lightgray)
      CASE 1
          ControlaMenus "A", 1, TRUE
      CASE 2
          ControlaMenus "E", 1, TRUE
      CASE 3
          formUsuarios 1, "Cadastrar Usuarios", "Cadastro dos Usuarios da Biblioteca."
      CASE 4
          formUsuarios 2, "Alterar Usuarios", "Altera os Usuarios da Biblioteca."
      CASE 5
          ControlaMenus "6", 1, FALSE
    END SELECT
ELSEIF tipo = "E" THEN
    Menu 4, 2, black, lightgray, red, lightgray, 21, yellow, lightgray, 3
    rodape "Controle de Emprestimos e Devolucoes da Biblioteca.", " ", white, blue
    formulario "", 3, 23, 4, 37, black, lightgray, "±", lightgray, black
    SELECT CASE SubMenu(3, 3, 16, 4, 25, ultpos, yellow, lightgray, black, lightgray)
      CASE 1
          ControlaMenus "U", 1, TRUE
      CASE 2
          ControlaMenus "O", 1, TRUE
      CASE 3
          formEmprestimos 1, "Emprestar Livros", "Efetua os Emprestimos de Livros da Biblioteca."
      CASE 4
          formEmprestimos 2, "Devolver Livros", "Efetua a Devolucao dos Livros da Biblioteca."
      CASE 5
          formEmprestimos 3, "Consultar Emprestimos e Devolucoes", "Consulta os Emprestimos e Devolucoes dos Livros da Biblioteca."
    END SELECT
ELSEIF tipo = "O" THEN
    Menu 4, 2, black, lightgray, red, lightgray, 48, yellow, lightgray, 4
    rodape "Opcoes do Sistema de Biblioteca.", " ", white, blue
    formulario "", 3, 50, 3, 18, black, lightgray, "±", lightgray, black
    SELECT CASE SubMenu(4, 2, 16, 4, 52, ultpos, yellow, lightgray, black, lightgray)
      CASE 1
          ControlaMenus "E", 1, TRUE
      CASE 2
          ControlaMenus "A", 1, TRUE
      CASE 3
          formSobre
      CASE 4
          formSair
    END SELECT
ELSEIF tipo = "5" THEN
    formulario "", 6, 23, 6, 20, black, lightgray, "±", lightgray, black
    SELECT CASE SubMenu(5, 5, 18, 7, 25, ultpos, yellow, lightgray, black, lightgray)
      CASE 1
          ControlaMenus "A", 3, TRUE
      CASE 2
          ControlaMenus "U", 1, TRUE
      CASE 4
          formLivros 3, "Consultar Livros por Titulo", "Consulta os Livros por Titulo do Acervo da Biblioteca."
      CASE 5
          formLivros 4, "Consultar Livros por Autor", "Consulta os Livros por Autor do Acervo da Biblioteca."
      CASE 6
          formLivros 5, "Consultar Livros por Area", "Consulta os Livros por Area do Acervo da Biblioteca."
      CASE 7
          formLivros 6, "Consultar Livros por Palavra-chave", "Consulta os Livros por Palavra-chave do Acervo da Biblioteca."
      CASE 3
          formLivros 7, "Consultar Todos os Livros", "Consulta Todos os Livros do Acervo da Biblioteca."
    END SELECT
ELSEIF tipo = "6" THEN
    formulario "", 6, 34, 5, 26, black, lightgray, "±", lightgray, black
    SELECT CASE SubMenu(6, 4, 24, 7, 36, ultpos, yellow, lightgray, black, lightgray)
      CASE 1
          ControlaMenus "U", 3, TRUE
      CASE 2
          ControlaMenus "E", 1, TRUE
      CASE 4
          formUsuarios 3, "Consultar Usuarios por Numero de Inscricao", "Consulta os Usuarios por Numero de Inscricao."
      CASE 5
          formUsuarios 4, "Consultar Usuarios por Nome", "Consulta os Usuarios por Nome."
      CASE 6
          formUsuarios 5, "Consultar Usuarios por Identidade", "Consulta os Usuarios por Numero de Identidade."
      CASE 3
          formUsuarios 6, "Consultar Todos os Usuarios", "Consulta Todos os Usuarios da Biblioteca."
    END SELECT
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
                   ControlesformEmprestimos "Emprestar", tipo2, posi, col, rod, TRUE
                ELSE
                   rodape "Usuario com 4 livros em sua posse, Impossivel Efetuar Emprestimo !", " ", yellow, red
                   ControlesformEmprestimos "Fechar", tipo2, posi, col, rod, TRUE
                END IF
              ELSE
                rodape "O livro ja esta emprestado, Impossivel Efetuar Emprestimo !", " ", yellow, red
                ControlesformEmprestimos "Fechar", tipo2, posi, col, rod, TRUE
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
                      ControlesformEmprestimos "Devolver", tipo2, posi, col, rod, TRUE
                   ELSE
                      rodape "Usuario com 0 livros em sua posse, Impossivel Efetuar Devolucao !", " ", yellow, red
                      ControlesformEmprestimos "Fechar", tipo2, posi, col, rod, TRUE
                   END IF
                 ELSE
                   rodape "O livro ja esta disponivel, Impossivel Efetuar Devolucao !", " ", yellow, red
                   ControlesformEmprestimos "Fechar", tipo2, posi, col, rod, TRUE
                 END IF
              ELSE
                 rodape "Emprestimo inexistente, Impossivel Efetuar Devolucao !", " ", yellow, red
                 ControlesformEmprestimos "Fechar", tipo2, posi, col, rod, TRUE
              END IF
           END IF
             '---
        ELSE
          S = LTRIM$(STR$(i))
          AtribuirvEmprestimos TRUE
          RotulosformEmprestimos tipo2, 0
          rodape "Numero de Inscricao do Livro, nao encontrado !", " ", yellow, red
          ControlesformEmprestimos "Fechar", tipo2, posi, col, rod, TRUE
        END IF
      ELSE
        ControlesformEmprestimos "Fechar", tipo2, posi, col, rod, TRUE
      END IF
    ELSE
      S = LTRIM$(STR$(i))
      AtribuirvEmprestimos TRUE
      RotulosformEmprestimos tipo2, 0
      rodape "Numero de Inscricao do Usuario, nao encontrado !", " ", yellow, red
      ControlesformEmprestimos "Fechar", tipo2, posi, col, rod, TRUE
    END IF
  ELSE
    ControlesformEmprestimos "Fechar", tipo2, posi, col, rod, TRUE
  END IF
ELSEIF tipo = "2" THEN
   listapos = posi
   listacol = col
   IF lista(3, 6, 5, 13, 70, nTamEmprestimos + 2, 113, white, blue, foco) = 1 THEN
        desenhalista 3, 6, 5, 13, 70, white, blue, posi, col, FALSE
        ControlesformEmprestimos "Fechar", tipo2, posi, col, rod, TRUE
   END IF
ELSEIF tipo = "Emprestar" THEN
    SELECT CASE Botao(20, 45, black, white, black, blue, " Emprestar ", foco)
      CASE 1
          DesenhaBotao 20, 45, black, white, black, blue, " Emprestar ", FALSE
          ControlesformEmprestimos "Fechar", tipo2, posi, col, rod, TRUE
      CASE 2
         IF PesEmprestimos(Usuarios.Ninsc, Livros.Ninsc) <> -1 THEN
            Emprestimos.Removido = FALSE
            SalvarEmprestimos 2
         ELSE
            Emprestimos.Removido = FALSE
            nTamEmprestimos = LOF(EmprestiFile) / LEN(Emprestimos)
            SalvarEmprestimos 1
         END IF
         DesenhaBotao 20, 45, black, white, black, blue, " Emprestar ", FALSE
         ControlesformEmprestimos "Fechar", tipo2, posi, col, rod, TRUE
    END SELECT
ELSEIF tipo = "Devolver" THEN
    SELECT CASE Botao(20, 45, black, white, black, blue, " Devolver ", foco)
      CASE 1
          DesenhaBotao 20, 45, black, white, black, blue, " Devolver ", FALSE
          ControlesformEmprestimos "Fechar", tipo2, posi, col, rod, TRUE
      CASE 2
          Emprestimos.Removido = TRUE
          SalvarEmprestimos 2
          DesenhaBotao 20, 45, black, white, black, blue, " Devolver ", FALSE
          ControlesformEmprestimos "Fechar", tipo2, posi, col, rod, TRUE
    END SELECT
ELSEIF tipo = "Fechar" THEN
   SELECT CASE Botao(20, 60, black, white, black, blue, " Fechar ", foco)
      CASE 1
          DesenhaBotao 20, 60, black, white, black, blue, " Fechar ", FALSE
          IF (tipo2 = 1) OR (tipo2 = 2) THEN
            ControlesformEmprestimos "1", tipo2, posi, col, rod, TRUE
          ELSEIF tipo2 = 3 THEN
            ControlesformEmprestimos "2", tipo2, posi, col, rod, TRUE
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
         DesenhaBotao 20, 45, black, white, black, blue, " Salvar ", FALSE
         IF PesLivros("N", "Ninsc", i, "", 0) <> -1 THEN
            Atribuirvlivros FALSE
            Rotulosformlivros 0
            rodape rod, " ", white, blue
            ControlesformLivros "2", tipo2, posi, col, rod, FALSE
         ELSE
            S = LTRIM$(STR$(i))
            Atribuirvlivros TRUE
            Rotulosformlivros 0
            rodape "Numero de Inscricao, nao encontrado !", " ", yellow, red
            ControlesformLivros "Fechar", tipo2, posi, col, rod, TRUE
         END IF
      ELSE
        ControlesformLivros "Fechar", tipo2, posi, col, rod, TRUE
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

      ControlesformLivros "Salvar", tipo2, posi, col, rod, TRUE
ELSEIF tipo = "3" THEN
      S = ""
      S = Digita$(S, 30, 30, 15, 5, black, lightgray, "T", 0)
      Livros.Titulo = S
      IF (LEN(Livros.Titulo) > 0) AND (Livros.Titulo <> Repete$(" ", LEN(Livros.Titulo))) THEN
         IF PesLivros("S", "Titulo", 0, Livros.Titulo, LEN(Livros.Titulo)) <> -1 THEN
              Atribuirvlivros FALSE
              Rotulosformlivros 2
              rodape rod, " ", white, blue
         ELSE
            Atribuirvlivros TRUE
            Rotulosformlivros 2
            rodape "Titulo do Livro, nao encontrado !", " ", yellow, red
         END IF
      END IF
      ControlesformLivros "Fechar", tipo2, posi, col, rod, TRUE
ELSEIF tipo = "4" THEN
      S = ""
      S = Digita$(S, 30, 30, 14, 5, black, lightgray, "T", 0)
      Livros.Autor = S
      IF (LEN(S) > 0) AND (S <> Repete$(" ", LEN(S))) THEN
         IF PesLivros("S", "Autor", 0, S, LEN(S)) <> -1 THEN
              Atribuirvlivros FALSE
              Rotulosformlivros 2
              rodape rod, " ", white, blue
         ELSE
            Atribuirvlivros TRUE
            Rotulosformlivros 2
            rodape "Autor do Livro, nao encontrado !", " ", yellow, red
         END IF
      END IF
      ControlesformLivros "Fechar", tipo2, posi, col, rod, TRUE
ELSEIF tipo = "5" THEN
      S = ""
      S = Digita$(S, 4, 4, 13, 5, black, lightgray, "T", 0)
      Livros.Area = S
      IF (LEN(S) > 0) AND (S <> Repete$(" ", LEN(S))) THEN
         IF PesLivros("S", "Area", 0, S, LEN(S)) <> -1 THEN
              Atribuirvlivros FALSE
              Rotulosformlivros 2
              rodape rod, " ", white, blue
         ELSE
            Atribuirvlivros TRUE
            Rotulosformlivros 2
            rodape "Area do Livro, nao encontrada !", " ", yellow, red
         END IF
      END IF
      ControlesformLivros "Fechar", tipo2, posi, col, rod, TRUE
ELSEIF tipo = "6" THEN
      S = ""
      S = Digita$(S, 10, 10, 22, 5, black, lightgray, "T", 0)
      Livros.Pchave = S
      IF (LEN(S) > 0) AND (S <> Repete$(" ", LEN(S))) THEN
         IF PesLivros("S", "Pchave", 0, S, LEN(S)) <> -1 THEN
              Atribuirvlivros FALSE
              Rotulosformlivros 2
              rodape rod, " ", white, blue
         ELSE
            Atribuirvlivros TRUE
            Rotulosformlivros 2
            rodape "Palavra-Chave do Livro, nao encontrado !", " ", yellow, red
         END IF
      END IF
      ControlesformLivros "Fechar", tipo2, posi, col, rod, TRUE
ELSEIF tipo = "7" THEN
    listapos = posi
    listacol = col
    IF lista(1, 6, 5, 13, 70, nTamLivros + 2, 220, white, blue, foco) = 1 THEN
        desenhalista 1, 6, 5, 13, 70, white, blue, posi, col, FALSE
        ControlesformLivros "Fechar", tipo2, posi, col, rod, TRUE
    END IF
ELSEIF tipo = "Salvar" THEN
    SELECT CASE Botao(20, 45, black, white, black, blue, " Salvar ", foco)
      CASE 1
          DesenhaBotao 20, 45, black, white, black, blue, " Salvar ", FALSE
          ControlesformLivros "Fechar", tipo2, posi, col, rod, TRUE
      CASE 2
          SalvarLivros tipo2
          DesenhaBotao 20, 45, black, white, black, blue, " Salvar ", FALSE
          ControlesformLivros "Fechar", tipo2, posi, col, rod, TRUE
    END SELECT
ELSEIF tipo = "Fechar" THEN
   SELECT CASE Botao(20, 60, black, white, black, blue, " Fechar ", foco)
      CASE 1
          DesenhaBotao 20, 60, black, white, black, blue, " Fechar ", FALSE
          IF tipo2 = 1 THEN
            ControlesformLivros "2", tipo2, posi, col, rod, TRUE
          ELSEIF tipo2 = 2 THEN
            ControlesformLivros "1", tipo2, posi, col, rod, FALSE
          ELSEIF tipo2 = 3 THEN
            ControlesformLivros "3", tipo2, posi, col, rod, FALSE
          ELSEIF tipo2 = 4 THEN
            ControlesformLivros "4", tipo2, posi, col, rod, FALSE
          ELSEIF tipo2 = 5 THEN
            ControlesformLivros "5", tipo2, posi, col, rod, FALSE
          ELSEIF tipo2 = 6 THEN
            ControlesformLivros "6", tipo2, posi, col, rod, FALSE
          ELSEIF tipo2 = 7 THEN
            ControlesformLivros "7", tipo2, posi, col, rod, TRUE
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

'--------------------------------------------------------------------
' Nome : ControlesformSair
' Descricao : procedimento que realiza todo o controle de manuseio do
' formulario de Saida.
' Parametros :
' tipo - indica qual acao a executar
' foco - indica quais objeto terao foco
'--------------------------------------------------------------------
SUB ControlesformSair (tipo AS STRING, foco AS INTEGER)

IF tipo = " Sim " THEN
    SELECT CASE Botao(14, 30, black, white, black, blue, " Sim ", foco)
      CASE 1
          DesenhaBotao 14, 30, black, white, black, blue, " Sim ", FALSE
          ControlesformSair " Nao ", TRUE
      CASE 2
          COLOR lightgray, black
          CLS
          formSplash
          'Cursor_small("C");
          COLOR lightgray, black
          CLS
          END
    END SELECT
ELSEIF tipo = " Nao " THEN
    SELECT CASE Botao(14, 40, black, white, black, blue, " Nao ", foco)
      CASE 1
          DesenhaBotao 14, 40, black, white, black, blue, " Nao ", FALSE
          ControlesformSair " Sim ", TRUE
      CASE 2
          rodape "", " ", white, blue
    END SELECT
END IF

END SUB

'--------------------------------------------------------------------
' Nome : ControlesformSobre
' Descricao : procedimento que realiza todo o controle de manuseio do
' formulario de Sobre.
' Parametros :
' tipo - indica qual acao a executar
' pos - indica a ultima posicao da linha da lista de sobre
' col - indica a ultima posicao da coluna da lista de sobre
' foco - indica quais objeto terao foco
'--------------------------------------------------------------------
SUB ControlesformSobre (tipo AS STRING, posi AS INTEGER, col AS INTEGER, foco AS INTEGER)

IF tipo = "Fechar" THEN
    SELECT CASE Botao(20, 63, black, white, black, blue, " Fechar ", foco)
      CASE 1
          DesenhaBotao 20, 63, black, white, black, blue, " Fechar ", FALSE
          ControlesformSobre "Lista", posi, col, TRUE
      CASE 2
          CLOSE 4
          rodape "", " ", white, blue
          teladefundo "±", white, lightblue
    END SELECT
ELSEIF tipo = "Lista" THEN
    listapos = posi
    listacol = col
    IF lista(4, 6, 5, 13, 70, 43, 70, white, blue, foco) = 1 THEN
       desenhalista 4, 6, 5, 13, 70, white, blue, posi, col, FALSE
       ControlesformSobre "Fechar", posi, col, TRUE
    END IF
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
         DesenhaBotao 20, 48, black, white, black, blue, " Salvar ", FALSE
         IF PesUsuarios("N", "Ninsc", i, "", 0) <> -1 THEN
                AtribuirvUsuarios FALSE
                RotulosformUsuarios 0
                rodape rod, " ", white, blue
                ControlesformUsuarios "2", tipo2, posi, col, rod, FALSE
         ELSE
            S = LTRIM$(STR$(i))
            AtribuirvUsuarios TRUE
            RotulosformUsuarios 0
            rodape "Numero de Inscricao, nao encontrado !", " ", yellow, red
            ControlesformUsuarios "Fechar", tipo2, posi, col, rod, TRUE
         END IF
      ELSE
        ControlesformUsuarios "Fechar", tipo2, posi, col, rod, TRUE
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

      ControlesformUsuarios "Salvar", tipo2, posi, col, rod, TRUE

ELSEIF tipo = "3" THEN

      S = ""
      S = Digita$(S, 5, 5, 28, 5, black, lightgray, "N", 0)'N insc
      i = VAL(S)
      Usuarios.Ninsc = i
      IF (LEN(S) > 0) AND (S <> Repete$(" ", LEN(S))) THEN
         IF PesBinaria(i) <> -1 THEN
              AtribuirvUsuarios FALSE
              RotulosformUsuarios 2
              rodape rod, " ", white, blue
         ELSE
            AtribuirvUsuarios TRUE
            RotulosformUsuarios 2
            rodape "Numero de Inscricao, nao encontrado !", " ", yellow, red
         END IF
      END IF
        ControlesformUsuarios "Fechar", tipo2, posi, col, rod, TRUE

ELSEIF tipo = "4" THEN

      S = ""
      S = Digita$(S, 30, 30, 13, 5, black, lightgray, "T", 0)
      Usuarios.Nome = S
      IF (LEN(S) > 0) AND (S <> Repete$(" ", LEN(S))) THEN
         IF PesUsuarios("S", "Nome", 0, S, LEN(S)) <> -1 THEN
              AtribuirvUsuarios FALSE
              RotulosformUsuarios 2
              rodape rod, " ", white, blue
         ELSE
            AtribuirvUsuarios TRUE
            RotulosformUsuarios 2
            rodape "Nome do Usuario, nao encontrado !", " ", yellow, red
         END IF
      END IF
        ControlesformUsuarios "Fechar", tipo2, posi, col, rod, TRUE

ELSEIF tipo = "5" THEN

      S = ""
      S = Digita$(S, 10, 10, 19, 5, black, lightgray, "N", 0)
      Usuarios.Ident = S
      IF (LEN(S) > 0) AND (S <> Repete$(" ", LEN(S))) THEN
         IF PesUsuarios("N", "Ident", 0, S, LEN(S)) <> -1 THEN
              AtribuirvUsuarios FALSE
              RotulosformUsuarios 2
              rodape rod, " ", white, blue
         ELSE
            AtribuirvUsuarios TRUE
            RotulosformUsuarios 2
            rodape "Identidade do Usuario, nao encontrada !", " ", yellow, red
         END IF
      END IF
        ControlesformUsuarios "Fechar", tipo2, posi, col, rod, TRUE

ELSEIF tipo = "6" THEN
    listapos = posi
    listacol = col
    IF lista(2, 6, 5, 13, 70, nTamUsuarios + 2, 194, white, blue, foco) = 1 THEN
        desenhalista 2, 6, 5, 13, 70, white, blue, posi, col, FALSE
        ControlesformUsuarios "Fechar", tipo2, posi, col, rod, TRUE
    END IF
ELSEIF tipo = "Salvar" THEN

    SELECT CASE Botao(20, 48, black, white, black, blue, " Salvar ", foco)
      CASE 1
          DesenhaBotao 20, 48, black, white, black, blue, " Salvar ", FALSE
          ControlesformUsuarios "Fechar", tipo2, posi, col, rod, TRUE
      CASE 2
          SalvarUsuarios tipo2
          DesenhaBotao 20, 48, black, white, black, blue, " Salvar ", FALSE
          ControlesformUsuarios "Fechar", tipo2, posi, col, rod, TRUE
    END SELECT
ELSEIF tipo = "Fechar" THEN

    SELECT CASE Botao(20, 63, black, white, black, blue, " Fechar ", foco)
      CASE 1
          DesenhaBotao 20, 63, black, white, black, blue, " Fechar ", FALSE
          IF tipo2 = 1 THEN
            ControlesformUsuarios "2", tipo2, posi, col, rod, TRUE
          ELSEIF tipo2 = 2 THEN
            ControlesformUsuarios "1", tipo2, posi, col, rod, FALSE
          ELSEIF tipo2 = 3 THEN
            ControlesformUsuarios "3", tipo2, posi, col, rod, FALSE
          ELSEIF tipo2 = 4 THEN
            ControlesformUsuarios "4", tipo2, posi, col, rod, FALSE
          ELSEIF tipo2 = 5 THEN
            ControlesformUsuarios "5", tipo2, posi, col, rod, FALSE
          ELSEIF tipo2 = 6 THEN
            ControlesformUsuarios "6", tipo2, posi, col, rod, TRUE
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
IF foco = FALSE THEN
   Etexto esquerda, topo, fg, bg, " " + texto + " "
END IF
IF foco = TRUE THEN
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

IF foco = TRUE THEN
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
 bFlag = 0
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
    DO WHILE bFlag = 0
       jx = (ndias / 7)
       ix = (ndias MOD 7)
       IF (jx < 7) AND (ix < 7) THEN
          bFlag = 1
          ix = ix + 1
       END IF
       IF (jx < 7) AND (ix = 0) THEN
          bFlag = 1
          ix = 0
       END IF
       ndias = jx
    LOOP
 END IF
 DiadaSemana = ds(ix)
END FUNCTION

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
InsertOn = TRUE

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
        IF InsertOn = TRUE THEN
           InsertOn = FALSE
        ELSE
           InsertOn = TRUE
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
  AtribuirvEmprestimos TRUE
  AbrirArquivo 1
  AbrirArquivo 2
  AbrirArquivo 3
  IF tipo = 1 THEN
     RotulosformEmprestimos 1, 0
     DesenhaBotao 20, 45, black, white, black, blue, " Emprestar ", FALSE
     DesenhaBotao 20, 60, black, white, black, blue, " Fechar ", FALSE
  END IF
  IF tipo = 2 THEN
     RotulosformEmprestimos 2, 0
     DesenhaBotao 20, 45, black, white, black, blue, " Devolver ", FALSE
     DesenhaBotao 20, 60, black, white, black, blue, " Fechar ", FALSE
  END IF
  IF tipo = 3 THEN
     DesenhaBotao 20, 60, black, white, black, blue, " Fechar ", FALSE
  END IF
  LimparEmprestimos
  IF tipo = 1 THEN
     ControlesformEmprestimos "1", 1, 0, 0, rod, FALSE 'Emprestar
  ELSEIF tipo = 2 THEN
     ControlesformEmprestimos "1", 2, 0, 0, rod, FALSE 'Devolver
  ELSEIF tipo = 3 THEN
     ControlesformEmprestimos "2", 3, 0, 0, rod, TRUE 'consultar todos
  END IF
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
  Atribuirvlivros TRUE
  AbrirArquivo 1
  IF (tipo = 1) OR (tipo = 2) THEN
     Rotulosformlivros 0
     DesenhaBotao 20, 45, black, white, black, blue, " Salvar ", FALSE
     DesenhaBotao 20, 60, black, white, black, blue, " Fechar ", FALSE
  END IF
  IF (tipo = 3) OR (tipo = 4) OR (tipo = 5) OR (tipo = 6) THEN
     DesenhaBotao 20, 60, black, white, black, blue, " Fechar ", FALSE
     Rotulosformlivros 2
     Etexto 2, 7, white, blue, CHR$(195) + Repete$(CHR$(196), 75) + CHR$(180)
  END IF
  IF tipo = 7 THEN
     DesenhaBotao 20, 60, black, white, black, blue, " Fechar ", FALSE
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
     ControlesformLivros "2", 1, 0, 0, rod, FALSE'cadastrar
  ELSEIF tipo = 2 THEN
     ControlesformLivros "1", 2, 0, 0, rod, FALSE'alterar
  ELSEIF tipo = 3 THEN
     ControlesformLivros "3", 3, 0, 0, rod, FALSE'consultar por titulo
  ELSEIF tipo = 4 THEN
     ControlesformLivros "4", 4, 0, 0, rod, FALSE'consultar por Autor
  ELSEIF tipo = 5 THEN
     ControlesformLivros "5", 5, 0, 0, rod, FALSE'consultar por Area
  ELSEIF tipo = 6 THEN
     ControlesformLivros "6", 6, 0, 0, rod, FALSE'consultar por Palavra-chave
  ELSEIF tipo = 7 THEN
     ControlesformLivros "7", 7, 0, 0, rod, TRUE'consultar todos
  END IF
END SUB

'--------------------------------------------------------------------
' Nome : formSair
' Descricao : procedimento que desenha o formulario de sair.
'--------------------------------------------------------------------
SUB formSair
  teladefundo "±", white, lightblue
  rodape "Alerta !, Aviso de Saida do Sistema.", " ", yellow, red
  formulario CHR$(180) + "Sair do Sistema" + CHR$(195), 10, 25, 6, 27, white, blue, "±", lightgray, black
  Etexto 27, 12, white, blue, "Deseja Sair do Sistema ?"
  DesenhaBotao 14, 40, black, white, black, blue, " Nao ", FALSE
  ControlesformSair " Sim ", TRUE
END SUB

'--------------------------------------------------------------------
' Nome : formSobre
' Descricao : procedimento que desenha o formulario de Sobre.
'--------------------------------------------------------------------
SUB formSobre
  teladefundo "±", white, lightblue
  rodape "Informacoes sobre o sistema.", " ", white, blue
  formulario CHR$(180) + "Sobre o Sistema" + CHR$(195), 4, 2, 18, 76, white, blue, "±", lightgray, black
  LerArquivoSobre
  DesenhaBotao 20, 63, black, white, black, blue, " Fechar ", FALSE
  ControlesformSobre "Lista", 0, 0, TRUE
END SUB

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
  AtribuirvUsuarios TRUE
  AbrirArquivo 2
  IF (tipo = 1) OR (tipo = 2) THEN
     RotulosformUsuarios 0
     DesenhaBotao 20, 48, black, white, black, blue, " Salvar ", FALSE
     DesenhaBotao 20, 63, black, white, black, blue, " Fechar ", FALSE
  END IF
  IF (tipo = 3) OR (tipo = 4) OR (tipo = 5) THEN
     DesenhaBotao 20, 63, black, white, black, blue, " Fechar ", FALSE
     RotulosformUsuarios 2
     Etexto 2, 7, white, blue, CHR$(195) + Repete$(CHR$(196), 75) + CHR$(180)
  END IF
  IF tipo = 6 THEN
     DesenhaBotao 20, 63, black, white, black, blue, " Fechar ", FALSE
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
     ControlesformUsuarios "2", 1, 0, 0, rod, FALSE'cadastrar
  ELSEIF tipo = 2 THEN
     ControlesformUsuarios "1", 2, 0, 0, rod, FALSE'alterar
  ELSEIF tipo = 3 THEN
     ControlesformUsuarios "3", 3, 0, 0, rod, FALSE'consultar por NInsc
  ELSEIF tipo = 4 THEN
     ControlesformUsuarios "4", 4, 0, 0, rod, FALSE'consultar por Nome
  ELSEIF tipo = 5 THEN
     ControlesformUsuarios "5", 5, 0, 0, rod, FALSE'consultar por Identidade
  ELSEIF tipo = 6 THEN
     ControlesformUsuarios "6", 6, 0, 0, rod, TRUE'consultar todos
  END IF
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
' Nome : LerArquivoSobre
' Descricao : procedimento que le o arquivo de sobre a atribui ao vetor
' de lista.
'---------------------------------------------------------------------
SUB LerArquivoSobre
DIM cont AS INTEGER
DIM linha AS STRING

 AbrirArquivo SobreFile
 cont = 0
 DO WHILE NOT EOF(SobreFile)
   LINE INPUT #4, linha
   vLista(cont) = linha
   cont = cont + 1
 LOOP
END SUB

'-------------------------------------------------------------------------
' Nome : LimparEmprestimos
' Descricao : procedimento limpa as variaveis do registro de Emprestimos.
'-------------------------------------------------------------------------
SUB LimparEmprestimos

     Emprestimos.NinscUsuario = 0
     Emprestimos.NinscLivro = 0
     Emprestimos.DtEmprestimo = RetDataAtual$
     Emprestimos.Removido = FALSE

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
 achou = FALSE
 DO WHILE ((NOT achou) AND (inicio <= fim))
   meio = ((inicio + fim) / 2)
   SEEK UsuariosFile, (meio - 1) + 1
   GET UsuariosFile, , Usuarios
   IF (chave = Usuarios.Ninsc) THEN
      achou = TRUE
   ELSE
      IF (chave > Usuarios.Ninsc) THEN
        inicio = meio + 1
      ELSE
        fim = meio - 1
      END IF
   END IF
 LOOP
 IF achou = TRUE THEN
    PesBinaria = meio - 1
 ELSE
    PesBinaria = -1
 END IF
END FUNCTION

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
bFlag = FALSE
DO WHILE NOT EOF(EmprestimosFile)
   GET EmprestimosFile, , Emprestimos
   IF (Emprestimos.NinscUsuario = nCodUsuario) AND (Emprestimos.NinscLivro = nCodLivro) THEN
      PesEmprestimos = nPosicao
      SEEK EmprestimosFile, nPosicao + 1
      bFlag = TRUE
      EXIT DO
   END IF
   nPosicao = nPosicao + 1
LOOP
 IF (EOF(EmprestimosFile)) AND (bFlag = FALSE) THEN
    Emprestimos.NinscUsuario = nCodUsuario
    Emprestimos.NinscLivro = nCodLivro
    PesEmprestimos = -1
 END IF
END FUNCTION

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
bFlag = FALSE
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
          bFlag = TRUE
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
          bFlag = TRUE
          EXIT DO
       END IF
   END IF
   nPosicao = nPosicao + 1
LOOP
 IF EOF(LivrosFile) AND bFlag = FALSE THEN
    PesLivros = -1
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
bFlag = FALSE
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
          bFlag = TRUE
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
          bFlag = TRUE
          EXIT DO
       END IF
   END IF
   nPosicao = nPosicao + 1
LOOP
 IF (EOF(UsuariosFile)) AND (bFlag = FALSE) THEN
    PesUsuarios = -1
 END IF
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
        AtribuirvEmprestimos TRUE
        RotulosformEmprestimos 1, 0
    ELSEIF tipo = 2 THEN
        PUT EmprestimosFile, , Emprestimos
        AtribuirvEmprestimos TRUE
        RotulosformEmprestimos 1, 0
    END IF
END SUB

'--------------------------------------------------------------------
' Nome : SalvarLivros
' Descricao : procedimento que salva os dados digitados no
' formulario de livros.
' Parametros :
' tipo - indica qual acao a salvar
'--------------------------------------------------------------------
SUB SalvarLivros (tipo AS INTEGER)
IF VerificaLivros = TRUE THEN
 IF (Livros.Estado = "D") OR (Livros.Estado = "E") THEN
    IF tipo = 1 THEN
        SEEK LivrosFile, nTamLivros + 1
        PUT LivrosFile, , Livros
        Atribuirvlivros TRUE
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

'-----------------------------------------------------------
' Nome : SalvarUsuarios
' Descricao : procedimento que salva os dados digitados no
' formulario de usuarios.
' Parametros :
' tipo - indica qual acao a salvar
'-----------------------------------------------------------
SUB SalvarUsuarios (tipo AS INTEGER)

IF VerificaUsuarios = TRUE THEN
 IF (Usuarios.Categoria = "A") OR (Usuarios.Categoria = "P") OR (Usuarios.Categoria = "F") THEN
    IF tipo = 1 THEN
        SEEK UsuariosFile, nTamUsuarios + 1
        PUT UsuariosFile, , Usuarios
        AtribuirvUsuarios TRUE
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
          IF Emprestimos.Removido = TRUE THEN
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
' Nome : VerificaLivros
' Descricao : funcao que verifica se os dados no formulario de livros
' foram digitados.
'--------------------------------------------------------------------
FUNCTION VerificaLivros
  S = LTRIM$(STR$(Livros.Ninsc))
  IF (LEN(S) = 0) AND (S = Repete$(" ", LEN(S))) THEN
      rodape "Numero de Inscricao, nao cadastrado !", " ", yellow, red
      VerificaLivros = FALSE
      EXIT FUNCTION
  END IF
  IF (LEN(Livros.Titulo) = 0) AND (Livros.Titulo = Repete$(" ", LEN(Livros.Titulo))) THEN
      rodape "Titulo, nao cadastrado !", " ", yellow, red
      VerificaLivros = FALSE
      EXIT FUNCTION
  END IF
  IF (LEN(Livros.Autor) = 0) AND (Livros.Autor = Repete$(" ", LEN(Livros.Autor))) THEN
      rodape "Autor, nao cadastrado !", " ", yellow, red
      VerificaLivros = FALSE
      EXIT FUNCTION
  END IF
  IF (LEN(Livros.Area) = 0) AND (Livros.Area = Repete$(" ", LEN(Livros.Area))) THEN
      rodape "Area, nao cadastrada !", " ", yellow, red
      VerificaLivros = FALSE
      EXIT FUNCTION
  END IF
  IF (LEN(Livros.Pchave) = 0) AND (Livros.Pchave = Repete$(" ", LEN(Livros.Pchave))) THEN
      rodape "Palavra-Chave, nao cadastrada !", " ", yellow, red
      VerificaLivros = FALSE
      EXIT FUNCTION
  END IF
  S = LTRIM$(STR$(Livros.Edicao))
  IF (LEN(S) = 0) AND (S = Repete$(" ", LEN(S))) THEN
      rodape "Edicao, nao cadastrada !", " ", yellow, red
      VerificaLivros = FALSE
      EXIT FUNCTION
  END IF
  S = LTRIM$(STR$(Livros.AnoPubli))
  IF (LEN(S) = 0) AND (Livros.Titulo = Repete$(" ", LEN(Livros.Titulo))) THEN
      rodape "Ano de Publicacao, nao cadastrado !", " ", yellow, red
      VerificaLivros = FALSE
      EXIT FUNCTION
  END IF
  IF (LEN(Livros.Editora) = 0) AND (Livros.Editora = Repete$(" ", LEN(Livros.Editora))) THEN
      rodape "Editora, nao cadastrada !", " ", yellow, red
      VerificaLivros = FALSE
      EXIT FUNCTION
  END IF
  S = LTRIM$(STR$(Livros.Volume))
  IF (LEN(S) = 0) AND (S = Repete$(" ", LEN(S))) THEN
      rodape "Volume, nao cadastrado !", " ", yellow, red
      VerificaLivros = FALSE
      EXIT FUNCTION
  END IF
  IF (LEN(Livros.Estado) = 0) AND (Livros.Estado = Repete$(" ", LEN(Livros.Estado))) THEN
      rodape "Estado, nao cadastrado !", " ", yellow, red
      VerificaLivros = FALSE
      EXIT FUNCTION
  END IF

 VerificaLivros = TRUE
END FUNCTION

'-------------------------------------------------------------------------
' Nome : VerificaUsuarios
' Descricao : funcao que verifica se os dados no formulario de usuarios
' foram digitados.
'-------------------------------------------------------------------------
FUNCTION VerificaUsuarios
  S = LTRIM$(STR$(Usuarios.Ninsc))
  IF (LEN(S) = 0) AND (S = Repete$(" ", LEN(S))) THEN
      rodape "Numero de Inscricao, nao cadastrado !", " ", yellow, red
      VerificaUsuarios = FALSE
      EXIT FUNCTION
  END IF
  IF (LEN(Usuarios.Nome) = 0) AND (Usuarios.Nome = Repete$(" ", LEN(Usuarios.Nome))) THEN
      rodape "Nome do Usuario, nao cadastrado !", " ", yellow, red
      VerificaUsuarios = FALSE
      EXIT FUNCTION
  END IF
  IF (LEN(Usuarios.Ident) = 0) AND (Usuarios.Ident = Repete$(" ", LEN(Usuarios.Ident))) THEN
      rodape "Identidade, nao cadastrada !", " ", yellow, red
      VerificaUsuarios = FALSE
      EXIT FUNCTION
  END IF
  IF (LEN(Usuarios.Endereco.logra) = 0) AND (Usuarios.Endereco.logra = Repete$(" ", LEN(Usuarios.Endereco.logra))) THEN
      rodape "Logradouro, nao cadastrado !", " ", yellow, red
      VerificaUsuarios = FALSE
      EXIT FUNCTION
  END IF
  S = LTRIM$(STR$(Usuarios.Endereco.numero))
  IF (LEN(S) = 0) AND (S = Repete$(" ", LEN(S))) THEN
      rodape "Numero do Endereco, nao cadastrado !", " ", yellow, red
      VerificaUsuarios = FALSE
      EXIT FUNCTION
  END IF
  IF (LEN(Usuarios.Endereco.compl) = 0) AND (Usuarios.Endereco.compl = Repete$(" ", LEN(Usuarios.Endereco.compl))) THEN
      rodape "Complemento do Endereco, nao cadastrado !", " ", yellow, red
      VerificaUsuarios = FALSE
      EXIT FUNCTION
  END IF
  IF (LEN(Usuarios.Endereco.Bairro) = 0) AND (Usuarios.Endereco.Bairro = Repete$(" ", LEN(Usuarios.Endereco.Bairro))) THEN
      rodape "Bairro, nao cadastrado !", " ", yellow, red
      VerificaUsuarios = FALSE
      EXIT FUNCTION
  END IF
  IF (LEN(Usuarios.Endereco.Cep) = 0) AND (Usuarios.Endereco.Cep = Repete$(" ", LEN(Usuarios.Endereco.Cep))) THEN
      rodape "Cep, nao cadastrado !", " ", yellow, red
      VerificaUsuarios = FALSE
      EXIT FUNCTION
  END IF
  IF (LEN(Usuarios.Telefone) = 0) AND (Usuarios.Telefone = Repete$(" ", LEN(Usuarios.Telefone))) THEN
      rodape "Telefone, nao cadastrado !", " ", yellow, red
      VerificaUsuarios = FALSE
      EXIT FUNCTION
  END IF
  IF (LEN(Usuarios.Categoria) = 0) AND (Usuarios.Categoria = Repete$(" ", LEN(Usuarios.Categoria))) THEN
      rodape "Categoria, nao cadastrada !", " ", yellow, red
      VerificaUsuarios = FALSE
      EXIT FUNCTION
  END IF

 VerificaUsuarios = TRUE
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

