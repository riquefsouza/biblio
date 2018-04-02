#include "Inkey.ch"
#include "Achoice.ch"
#include "Fileio.ch"
#include "Setcurs.ch"
#include "Box.ch"

/* Declaracao de constantes */

 #define true .t.
 #define false .f.

 #define white "W+"
 #define lightblue "B+"
 #define blue "B"
 #define black "N"
 #define lightgray "W"
 #define red "R"
 #define yellow "GR+"

 #define TamLiv 150 
 #define TamUsu 133
 #define TamEmp 33

/* Declaracao de tipos */

 /* Registros de Enderecos */

     public cEndLogra    /* Logradouro (30) */
     public nEndNumero   /* Numero do Endereco (5) */
     public cEndCompl    /* Complemento (10) */
     public cEndBairro   /* Bairro do Endereco (20) */
     public cEndCep      /* Cep do Endereco (8) */
     
  /* Registro de Livros */

     public nLivNinsc      /* Numero de Inscricao do Livro (5) */
     public cLivTitulo     /* Titulo do Livro (30) */
     public cLivAutor      /* Autor do Livro (30) */
     public cLivArea       /* Area de atuacao do Livro (30) */
     public cLivPChave     /* Palavra-Chave para pesquisar o Livro (10) */
     public nLivEdicao     /* Edicao do Livro (4) */
     public nLivAnoPubli   /* Ano de publicacao do Livro (4) */
     public cLivEditora    /* Editora do Livro (30) */
     public nLivVolume     /* Volume do Livro (4) */
     public cLivEstado     /* Estado Atual - (D)isponivel ou (E)mprestado (1) */

  /* Registro de Usuarios */

     public nUsuNinsc      /* Numero de inscricao do Usuario (5) */
     public cUsuNome       /* Nome completo do Usuario (30) */
     public cUsuIdent      /* Identidade do Usuario (10) */
 /*  public Endereco : Enderecos;     Endereco completo do Usuario (73) */
     public cUsuTelefone   /* Telefone do Usuario (11) */
     public cUsuCategoria  /* Categoria - (A)luno,(P)rofessor,(F)uncionario (1) */
     public nUsuSituacao   /* Situacao - Numero de Livros em sua posse (1) */
  
  /* Registro de Emprestimos */

     public nEmpNinscUsuario /* Numero de inscricao do Usuario (5) */
     public nEmpNinscLivro   /* Numero de inscricao do Livro (5) */
     public cEmpDtEmprestimo /* Data de Emprestimo do Livro (10) */
     public cEmpDtDevolucao  /* Data de Devolucao do Livro (10) */
     public lEmpRemovido     /* Removido - Indica exclusao logica (1) */

/* Declaracao de variaveis globais */

 /* variaveis gerais */

 public nKey
 public cS
 public nI
 public nC

 /* variaveis de menu */

 public vMenu[10]  // 30
 public vSubMenu[10,10] // 35
 public nMenu

 /* variaveis de lista */

 public vLista[51]
 public nListapos
 public nListacol

 /* variaveis do modulo de livros */

 public cLivros
 public LivrosFile
 public nTamLivros
 public vLivros[10] // 30

 /* variaveis do modulo de Usuarios */

 public cUsuarios
 public UsuariosFile
 public nTamUsuarios
 public vUsuarios[11]  // 30

 /* variaveis do modulo de Emprestimos */

 public cEmprestimos
 public EmprestimosFile
 public nTamEmprestimos
 public vEmprestimos[5] // 10

 /* variaveis do modulo de Opcoes */

 public SobreFile
 public nTamSobre
