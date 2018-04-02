'Declaracao de funcoes de rotinas

DECLARE FUNCTION ConverteData! (dt AS STRING)
DECLARE FUNCTION DiadaSemana$ (dt AS STRING)
DECLARE FUNCTION Deletar$ (str AS STRING, ini AS INTEGER, tam AS INTEGER)
DECLARE FUNCTION inkeyEx$ ()
DECLARE FUNCTION inserir$ (origem AS STRING, alvo AS STRING, ini AS INTEGER)
DECLARE FUNCTION RetDataAtual$ ()
DECLARE FUNCTION Repete$ (St AS STRING, tam AS INTEGER)
DECLARE FUNCTION SomaDias$ (dt1 AS STRING, qtddias AS INTEGER)
DECLARE FUNCTION SubtraiDatas! (dt1 AS STRING, dt2 AS STRING)
DECLARE FUNCTION Trim$ (str1 AS STRING)
DECLARE FUNCTION Zeros$ (S AS STRING, tam AS INTEGER)

'Declaracao de funcoes de Graficos

DECLARE FUNCTION Digita$ (S AS STRING, JanelaTam AS INTEGER, maxtam AS INTEGER, x AS INTEGER, y AS INTEGER, fg AS INTEGER, bg AS INTEGER, FT AS STRING, fundo AS INTEGER)
DECLARE FUNCTION Botao (topo AS INTEGER, esquerda AS INTEGER, fg AS INTEGER, bg AS INTEGER, sfg AS INTEGER, sbg AS INTEGER, texto AS STRING, foco AS INTEGER)
DECLARE FUNCTION TiposLista$ (tipo AS INTEGER, largura AS INTEGER, posi AS INTEGER, col AS INTEGER)
DECLARE FUNCTION lista (tipo AS INTEGER, topo AS INTEGER, esquerda AS INTEGER, altura AS INTEGER, largura AS INTEGER, tlinhas AS INTEGER, tcolunas AS INTEGER, fg AS INTEGER, bg AS INTEGER, foco AS INTEGER)
DECLARE FUNCTION SubMenu (numero AS INTEGER, qtd AS INTEGER, maxtam AS INTEGER, topo AS INTEGER, esquerda AS INTEGER, ultpos AS INTEGER, lfg AS INTEGER, lbg AS INTEGER, fg AS INTEGER, bg AS INTEGER)

'Declaracao de funcoes de MLivros

DECLARE FUNCTION PesLivros (tipo AS STRING, campo AS STRING, nCod2 AS INTEGER, sCod2 AS STRING, nTamsCod AS INTEGER)
DECLARE FUNCTION VerificaLivros ()

'Declaracao de funcoes de MUsuarios

DECLARE FUNCTION PesUsuarios! (tipo AS STRING, campo AS STRING, nCod2 AS INTEGER, sCod2 AS STRING, nTamsCod AS INTEGER)
DECLARE FUNCTION PesBinaria! (chave AS INTEGER)
DECLARE FUNCTION VerificaUsuarios! ()

'Declaracao de funcoes de MEmprest

DECLARE FUNCTION PesEmprestimos! (nCodUsuario AS INTEGER, nCodLivro AS INTEGER)

'Declaracao de procedimentos de biblio

DECLARE SUB ControlaMenus (tipo AS STRING, ultpos AS INTEGER, tf AS INTEGER)

'Declaracao de procedimentos de rotinas

DECLARE SUB cabecalho (texto AS STRING, tipo AS STRING, fg AS INTEGER, bg AS INTEGER)
DECLARE SUB center (y AS INTEGER, S AS STRING, fg AS INTEGER, bg AS INTEGER)
DECLARE SUB DatadoSistema (l AS INTEGER, c AS INTEGER, fg AS INTEGER, bg AS INTEGER)
DECLARE SUB EscreveRapido (x AS INTEGER, y AS INTEGER, S AS STRING, fg AS INTEGER, bg AS INTEGER)
DECLARE SUB Etexto (c AS INTEGER, l AS INTEGER, fg AS INTEGER, bg AS INTEGER, texto AS STRING)
DECLARE SUB HoradoSistema (l AS INTEGER, c AS INTEGER, fg AS INTEGER, bg AS INTEGER)
DECLARE SUB rodape (texto AS STRING, tipo AS STRING, fg AS INTEGER, bg AS INTEGER)
DECLARE SUB SetString (backgroundchar AS INTEGER)
DECLARE SUB teladefundo (tipo AS STRING, fg AS INTEGER, bg AS INTEGER)
DECLARE SUB XY (x AS INTEGER, y AS INTEGER)

'Declaracao de procedimentos de Graficos

DECLARE SUB Menu (qtd AS INTEGER, topo AS INTEGER, fg AS INTEGER, bg AS INTEGER, lfg AS INTEGER, lbg AS INTEGER, pos2 AS INTEGER, mfg AS INTEGER, mbg AS INTEGER, cont2 AS INTEGER)
DECLARE SUB formulario (Titulo AS STRING, topo AS INTEGER, esquerda AS INTEGER, altura AS INTEGER, largura AS INTEGER, fg AS INTEGER, bg AS INTEGER, sombra AS STRING, sfg AS INTEGER, sbg AS INTEGER)
DECLARE SUB DesenhaBotao (topo AS INTEGER, esquerda AS INTEGER, fg AS INTEGER, bg AS INTEGER, sfg AS INTEGER, sbg AS INTEGER, texto AS STRING, foco AS INTEGER)
DECLARE SUB desenhalista (tipo AS INTEGER, topo AS INTEGER, esquerda AS INTEGER, altura AS INTEGER, largura AS INTEGER, fg AS INTEGER, bg AS INTEGER, posi AS INTEGER, col AS INTEGER, foco AS INTEGER)
DECLARE SUB AbrirArquivo (tipo AS INTEGER)
DECLARE SUB formSplash ()
DECLARE SUB EscreveRapido (x AS INTEGER, y AS INTEGER, S AS STRING, fg AS INTEGER, bg AS INTEGER)
DECLARE SUB Etexto (c AS INTEGER, l AS INTEGER, fg AS INTEGER, bg AS INTEGER, texto AS STRING)
DECLARE SUB SetString (fundo AS INTEGER)

'Declaracao de procedimentos de MLivros

DECLARE SUB formLivros (tipo AS INTEGER, Titulo AS STRING, rod AS STRING)
DECLARE SUB ControlesformLivros (tipo AS STRING, tipo2 AS INTEGER, posi AS INTEGER, col AS INTEGER, rod AS STRING, foco AS INTEGER)
DECLARE SUB Atribuirvlivros (limpar AS INTEGER)
DECLARE SUB DigitaformLivros ()
DECLARE SUB SalvarLivros (tipo AS INTEGER)
DECLARE SUB Rotulosformlivros (l AS INTEGER)
DECLARE SUB LimparLivros ()

'Declaracao de procedimentos de MUsuario

DECLARE SUB formUsuarios (tipo AS INTEGER, Titulo AS STRING, rod AS STRING)
DECLARE SUB AtribuirvUsuarios (limpar AS INTEGER)
DECLARE SUB RotulosformUsuarios (l AS INTEGER)
DECLARE SUB LimparUsuarios ()
DECLARE SUB ControlesformUsuarios (tipo AS STRING, tipo2 AS INTEGER, posi AS INTEGER, col AS INTEGER, rod AS STRING, foco AS INTEGER)
DECLARE SUB DigitaformUsuarios ()
DECLARE SUB SalvarUsuarios (tipo AS INTEGER)

'Declaracao de procedimentos de MEmprest

DECLARE SUB AtribuirvEmprestimos (limpar AS INTEGER)
DECLARE SUB RotulosformEmprestimos (tipo AS INTEGER, l AS INTEGER)
DECLARE SUB LimparEmprestimos ()
DECLARE SUB ControlesformEmprestimos (tipo AS STRING, tipo2 AS INTEGER, posi AS INTEGER, col AS INTEGER, rod AS STRING, foco AS INTEGER)
DECLARE SUB SalvarEmprestimos (tipo AS INTEGER)
DECLARE SUB formEmprestimos (tipo AS INTEGER, Titulo AS STRING, rod AS STRING)

'Declaracao de procedimentos de MOpcoes

DECLARE SUB formSair ()
DECLARE SUB ControlesformSair (tipo AS STRING, foco AS INTEGER)
DECLARE SUB formSobre ()
DECLARE SUB LerArquivoSobre ()
DECLARE SUB ControlesformSobre (tipo AS STRING, posi AS INTEGER, col AS INTEGER, foco AS INTEGER)

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

CONST true = 1
CONST false = 0

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



