#include <stdio.h>
#include <stdlib.h>
#include <stdarg.h>
#include <conio.h>
#include <string.h>
#include <time.h>
#include <dos.h>
#include <ctype.h>
#include <dir.h>
#include <math.h>

/*
#include <process.h>
#include <fcntl.h>
#include <stddef.h>
#include <alloc.h>
#include <sys\types.h>
*/

/* declaracao de constantes */

 #define true 1
 #define false 0

 #define white 15
 #define lightblue 9
 #define blue 1
 #define black 0
 #define lightgray 7
 #define red 4
 #define yellow 14

/* Declaracao de tipos */

/*
  enum modocursor{ _SOLIDCURSOR, _NORMALCURSOR, _NOCURSOR };
*/

  enum Keys { NullKey, F1, F2, F3, F4, F5, F6, F7, F8, F9, F10,
           CarriageReturn, Tab, ShiftTab, Bksp, UpArrow,
           DownArrow, RightArrow, LeftArrow, DeleteKey,
           InsertKey, HomeKey, Esc, EndKey, TextKey,
           NumberKey, SpaceKey, PgUp, PgDn, CtrlA, AltA,
           AltE, AltU, AltS, AltO };

  typedef int boolean;

  /* Registro de Enderecos */

  struct Enderecos {
     char Logra[30];     /* Logradouro */
     int Numero;         /* Numero do Endereco (5) */
     char Compl[10];     /* Complemento (10) */
     char Bairro[20];    /* Bairro do Endereco (20) */
     char Cep[8];        /* Cep do Endereco (8) */
  };

  /* Registro de Livros */

  struct LivrosRec {
     int Ninsc;          /* Numero de Inscricao do Livro (5) */
     char Titulo[30];    /* Titulo do Livro (30) */
     char Autor[30];     /* Autor do Livro (30) */
     char Area[30];      /* Area de atuacao do Livro (30) */
     char PChave[10];    /* Palavra-Chave para pesquisar o Livro (10) */
     int Edicao;         /* Edicao do Livro (4) */
     int AnoPubli;       /* Ano de Publicacao do Livro (4) */
     char Editora[30];   /* Editora do Livro (30) */
     int Volume;         /* Volume do Livro (4) */
     char Estado;        /* Estado Atual - (D)isponivel ou (E)mprestado */
  };

  /* Registro de Usuarios */

  struct UsuariosRec {
     int Ninsc;                 /* Numero de inscricao do Usuario (5) */
     char Nome[30];             /* Nome completo do Usuario (30) */
     char Ident[10];            /* Identidade do Usuario (10) */
     struct Enderecos Endereco; /* Endereco completo do Usuario (73) */
     char Telefone[11];         /* Telefone do Usuario (11) */
     char Categoria;      /* Categoria - (A)luno,(P)rofessor,(F)uncionario */
     int Situacao;        /* Situacao - Numero de Livros em sua posse (1) */
  };

  /* Registro de Emprestimos */

  struct EmprestimosRec {
     int NinscUsuario;      /* Numero de inscricao do Usuario (5) */
     int NinscLivro;        /* Numero de inscricao do Livro (5) */
     char DtEmprestimo[10]; /* Data de Emprestimo do Livro (10) */
     char DtDevolucao[10];  /* Data de Devolucao do Livro (10) */
     boolean Removido;      /* Removido - Indica exclusao logica */
  };

/* Declaracao de variaveis globais */

 /* variaveis gerais */

 extern enum Keys sKey;
 extern char ch;
 extern char *S;  
 extern int I;

 /* variaveis de menu */

 extern char *vMenu[10];  /* 30 */
 extern char *vSubMenu[10][10];  /* 35 */

 /* variaveis de lista */

 extern char *vLista[50];
 extern int Listapos;
 extern int Listacol;

 /* variaveis do modulo de livros */

 extern struct LivrosRec Livros;
 extern FILE *LivrosFile;  /* File of LivrosRec */
 extern int nTamLivros;
 extern char *vLivros[11];  /* 30 */

 /* variaveis do modulo de Usuarios */

 extern struct UsuariosRec Usuarios;
 extern FILE *UsuariosFile;  /* File of UsuariosRec */
 extern int nTamUsuarios;
 extern char *vUsuarios[12];  /* 30 */

 /* variaveis do modulo de Emprestimos */

 extern struct EmprestimosRec Emprestimos;
 extern FILE *EmprestimosFile; /* File of EmprestimosRec */
 extern int nTamEmprestimos;
 extern char *vEmprestimos[6];  /* 10 */

 /* variaveis do modulo de Opcoes */

 extern FILE *SobreFile;

/* Declaracao de funcoes de rotinas */

/* void _setcursortype(enum modocursor tipo); */
char *copy(char *string,int ini,int tam);
char *deletar(char *str,int ini,int tam);
char *inserir(char origem,char *alvo,int ini);
int posstr(char origem,char *alvo);
char *rtrimstr(char *str);
char *repete(char *st,int tam);
char *somastr(int num,...);
char *setstring(char *str,int fundo);
char *RetDataAtual(void); 
int ConverteData(char *dt); 
char *SomaDias(char *dt1,int qtddias); 
int SubtraiDatas(char *dt1,char *dt2); 
int tamArquivo(FILE *Arq,int tam);

/* Declaracao de funcoes de graficos */

char *digita(char *str,int janelatam,int maxtam,int x,int y,
                  int fg,int bg,char ft,int fundo);
int SubMenu(int numero,int qtd,int maxtam,int topo,int esquerda,int ultpos,
            int lfg,int lbg,int fg,int bg);
int Botao(int topo,int esquerda,int fg,int bg,int sfg,int sbg,
          char *texto,boolean foco);
int Lista(int tipo,int topo,int esquerda,int altura,int largura,int tlinhas,
          int tcolunas,int fg,int bg,boolean foco);
char *TiposLista(int tipo,int largura,int pos,int col);

/* Declaracao de funcoes do Modulo de Livros */

int PesLivros(char tipo,char *campo, int nCod2,char *sCod2,
              int nTamsCod);
boolean VerificaLivros(void);

/* Declaracao de funcoes do Modulo de Usuarios */

int PesUsuarios(char tipo,char *campo,int nCod2,char *sCod2,
                int nTamsCod); 
int PesBinaria(int Chave);
boolean VerificaUsuarios(void);

/* Declaracao de funcoes do Modulo de Emprestimos */

int PesEmprestimos(int nCodUsuario,int nCodLivro);

/* Declaracao de Procedimentos de Biblio */

void ControlaMenus(char tipo,int ultpos,boolean tf);

/* Declaracao de Procedimentos de rotinas */

void escreverapido(int x,int y,char *str,int fg,int bg);
void center(int y,char *s,int fg,int bg);
void beep(int freq,int time);
void inkey(char begincursor,char endcursor);
void xy(int x,int y);
void postexto(int c,int l,int fg,int bg);
void etexto(int c,int l,int fg,int bg,char *texto);
void teladefundo(char *tipo,int fg,int bg);
void cabecalho(char *texto,char *tipo,int fg,int bg);
void rodape(char *texto,char *tipo,int fg,int bg);
void datadosistema(int l,int c,int fg,int bg);
void horadosistema(int l,int c,int fg,int bg);
void AbrirArquivo(int Tipo);

/* Declaracao de Procedimentos de graficos */

void formulario(char *titulo,int topo,int esquerda,
                     int altura,int largura,int fg,int bg,
                     char sombra,int sfg,int sbg);
void menu(int qtd,int topo,int fg,int bg,int lfg,int lbg,
          int pos2,int mfg,int mbg,int cont2);
void DesenhaBotao(int topo,int esquerda,int fg,int bg,int sfg,int sbg,
                  char *texto,boolean foco);
void DesenhaLista(int tipo,int topo,int esquerda,int altura,int largura,
                  int fg,int bg,int pos,int col,boolean foco);
void formSplash(void);

/* Declaracao de Procedimentos do Modulo de Livros */

void formLivros(int tipo,char *titulo,char *rod);
void Limpar_Livros(void);
void Rotulos_formLivros(int l);
void Controles_formLivros(char *tipo,int tipo2,int pos,int col,char *rod,
                          boolean foco);
void Atribuir_vLivros(boolean limpar);
void Digita_formLivros(void);
void SalvarLivros(int tipo);

/* Declaracao de Procedimentos do Modulo de Usuarios */

void formUsuarios(int tipo,char *titulo,char *rod);
void Limpar_Usuarios(void); 
void Rotulos_formUsuarios(int l); 
void Controles_formUsuarios(char *tipo,int tipo2,int pos,
                            int col,char *rod,boolean foco);
void Atribuir_vUsuarios(boolean limpar); 
void Digita_formUsuarios(void); 
void SalvarUsuarios(int tipo);

/* Declaracao de Procedimentos do Modulo de Emprestimos e Devolucoes */

void formEmprestimos(int tipo,char *titulo,char *rod);
void Limpar_Emprestimos(void); 
void Rotulos_formEmprestimos(int tipo,int l); 
void Controles_formEmprestimos(char *tipo,int tipo2,int pos,
     int col,char *rod,boolean foco); 
void Atribuir_vEmprestimos(boolean limpar); 
void SalvarEmprestimos(int tipo);

/* Declaracao de Procedimentos do Modulo de Opcoes */

void formSair(void);
void Controles_formSair(char *tipo,boolean foco); 
void formSobre(void); 
void LerArquivoSobre(void); 
void Controles_formSobre(char *tipo,int pos,int col,boolean foco); 
