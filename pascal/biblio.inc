{ Declaracao de tipos }

type

  ModoCursor = (nenhum,normal,solido);

  Keys = ( NullKey, F1, F2, F3, F4, F5, F6, F7, F8, F9, F10,
           CarriageReturn, Tab, ShiftTab, Bksp, UpArrow,
           DownArrow, RightArrow, LeftArrow, DeleteKey,
           InsertKey, HomeKey, Esc, EndKey, TextKey,
           NumberKey, SpaceKey, PgUp, PgDn, CtrlA, AltA,
           AltE, AltU, AltS, AltO);

  { Registro de Enderecos }

  Enderecos = Record
     Logra : String[30];     { Logradouro (30) }
     Numero : integer;       { Numero do Endereco (5) }
     Compl : String[10];     { Complemento (10) }
     Bairro : String[20];    { Bairro do Endereco (20) }
     Cep : String[8];        { Cep do Endereco (8) }
  end;

  { Registro de Livros }

  LivrosRec = Record
     Ninsc : integer;        { Numero de Inscricao do Livro (5) }
     Titulo : string[30];    { Titulo do Livro (30) }
     Autor : string[30];     { Autor do Livro (30) }
     Area : string[30];      { Area de atuacao do Livro (30) }
     PChave : string[10];    { Palavra-Chave para pesquisar o Livro (10) }
     Edicao : integer;       { Edicao do Livro (4) }
     AnoPubli : integer;     { Ano de Publicacao do Livro (4) }
     Editora : String[30];   { Editora do Livro (30) }
     Volume : integer;       { Volume do Livro (4) }
     Estado : char;          { Estado Atual - (D)isponivel ou (E)mprestado (1) }
  end;

  { Registro de Usuarios }

  UsuariosRec = Record
     Ninsc : integer;        { Numero de inscricao do Usuario (5) }
     Nome : String[30];      { Nome completo do Usuario (30) }
     Ident : String[10];     { Identidade do Usuario (10) }
     Endereco : Enderecos;   { Endereco completo do Usuario (73) }
     Telefone : String[11];  { Telefone do Usuario (11) }
     Categoria : char;       { Categoria - (A)luno,(P)rofessor,(F)uncionario (1) }
     Situacao : integer;     { Situacao - Numero de Livros em sua posse (1) }
  end;

  { Registro de Emprestimos }

  EmprestimosRec = Record
     NinscUsuario : integer;    { Numero de inscricao do Usuario (5) }
     NinscLivro : integer;      { Numero de inscricao do Livro (5) }
     DtEmprestimo : String[10]; { Data de Emprestimo do Livro (10) }
     DtDevolucao : String[10];  { Data de Devolucao do Livro (10) }
     Removido : boolean;        { Removido - Indica exclusao logica }
  end;

{ Declaracao de variaveis globais }

var

 { variaveis gerais }

 Key : Keys;
 Fk:boolean;
 Ch:char;
 S:string;
 I,C:integer;

 { variaveis de menu }

 vMenu : array[1..10] of String[30];
 vSubMenu : array[1..10,1..10] of String[35];

 { variaveis de lista }

 vLista : array[0..50] of String;

 { variaveis do modulo de livros }

 Livros : LivrosRec;
 LivrosFile : File of LivrosRec;
 nTamLivros : integer;
 vLivros : array[1..10] of string[30];

 { variaveis do modulo de Usuarios }

 Usuarios : UsuariosRec;
 UsuariosFile : File of UsuariosRec;
 nTamUsuarios : integer;
 vUsuarios : array[1..11] of String[30];

 { variaveis do modulo de Emprestimos }

 Emprestimos : EmprestimosRec;
 EmprestimosFile : File of EmprestimosRec;
 nTamEmprestimos : integer;
 vEmprestimos : array[1..5] of String[10];

 { variaveis do modulo de Opcoes }

 SobreFile : Text;

{ Declaracao de funcoes de rotinas }

function Zeros(s:string;tam:integer):String; forward;
function Repete(St:string;Tam:integer):String; forward;
function RetDataAtual:string; forward;
function ConverteData(dt:string):integer; forward;
function SomaDias(dt1:string;qtddias:integer):string; forward;
function SubtraiDatas(dt1:string;dt2:string):integer; forward;

{ Declaracao de funcoes de graficos }

function SubMenu(numero,qtd,maxtam,topo,esquerda,ultpos,lfg,lbg,
               fg,bg:integer):integer; forward;
function Botao(topo,esquerda,fg,bg,sfg,sbg:integer;
                texto:string;foco:boolean):integer; forward;
function Lista(tipo,topo,esquerda,altura,largura,tlinhas,tcolunas,
               fg,bg:integer;
               var Listapos,Listacol:integer;foco:boolean): integer; forward;
function TiposLista(tipo,largura,pos,col:integer):string; forward;

{ Declaracao de funcoes de MLivros }

function PesLivros(tipo:char;campo:string;nCod2:integer;sCod2:string;
                   nTamsCod:integer):integer; forward;
function VerificaLivros:boolean; forward;

{ Declaracao de funcoes de MUSuario }

function PesUsuarios(tipo:char;campo:string;nCod2:integer;sCod2:string;
                   nTamsCod:integer):integer; forward;
function PesBinaria(Chave:integer):integer; forward;
function VerificaUsuarios:boolean; forward;

{ Declaracao de funcoes de MEmprest }

function PesEmprestimos(nCodUsuario,nCodLivro:integer):integer; forward;

{ Declaracao de Procedimentos de Biblio }

procedure ControlaMenus(tipo:char;ultpos:integer;tf:boolean); forward;

{ Declaracao de Procedimentos de rotinas }

procedure EscreveRapido(x,y:integer;
                        var S:String;fg,bg:Integer); forward;
Procedure SetaCursor(tipo:ModoCursor); forward;
procedure center(y:integer;s:string;fg,bg:integer); forward;
procedure beep(freq,time:integer); forward;
procedure InKey(var chavefuncional:boolean;
                var ch:char;cursorinicio,cursorfim:char); forward;
procedure Etexto(c,l,fg,bg:integer;texto:string); forward;
procedure TeladeFundo(tipo:char;fg,bg:integer); forward;
procedure cabecalho(texto:string;tipo:char;fg,bg:integer); forward;
procedure rodape(texto:string;tipo:char;fg,bg:integer); forward;
procedure DatadoSistema(l,c,fg,bg:integer); forward;
procedure HoradoSistema(l,c,fg,bg:integer); forward;
procedure AbrirArquivo(Tipo:integer); forward;

{ Declaracao de Procedimentos de graficos }

procedure Digita( var S: string;JanelaTam,MaxTam,X,Y : Integer;
                  fg,bg : Integer;FT : Char; Fundo : integer); forward;
procedure formulario(titulo:string;topo,esquerda,
                     altura,largura,fg,bg:integer;
                     sombra:char;sfg,sbg:integer); forward;
procedure Menu(qtd,topo,fg,bg,lfg,lbg,pos2,mfg,mbg,cont2:integer); forward;
procedure DesenhaBotao(topo,esquerda,fg,bg,sfg,sbg:integer;
                       texto:string;foco:boolean); forward;
procedure DesenhaLista(tipo,topo,esquerda,altura,largura,
                       fg,bg,pos,col:integer;foco:boolean); forward;
procedure formSplash; forward;

{ Declaracao de Procedimentos de MLivros }

procedure formLivros(tipo:integer;titulo,rod:string); forward;
procedure Limpar_Livros; forward;
procedure Rotulos_formLivros(l:integer); forward;
procedure Controles_formLivros(tipo:string;tipo2,pos,col:integer;rod:string;
                               foco:boolean); forward;
procedure Atribuir_vLivros(limpar:boolean); forward;
procedure Digita_formLivros; forward;
procedure SalvarLivros(tipo:integer); forward;

{ Declaracao de Procedimentos de MUsuario }

procedure formUsuarios(tipo:integer;titulo,rod:string); forward;
procedure Limpar_Usuarios; forward;
procedure Rotulos_formUsuarios(l:integer); forward;
procedure Controles_formUsuarios(tipo:string;tipo2,pos,
          col:integer;rod:string;foco:boolean); forward;
procedure Atribuir_vUsuarios(limpar:boolean); forward;
procedure Digita_formUsuarios; forward;
procedure SalvarUsuarios(tipo:integer); forward;

{ Declaracao de Procedimentos de MEmprest }

procedure formEmprestimos(tipo:integer;titulo,rod:string); forward;
procedure Limpar_Emprestimos; forward;
procedure Rotulos_formEmprestimos(tipo,l:integer); forward;
procedure Controles_formEmprestimos(tipo:string;tipo2,pos,
          col:integer;rod:string;foco:boolean); forward;
procedure Atribuir_vEmprestimos(limpar:boolean); forward;
procedure SalvarEmprestimos(tipo:integer); forward;

{ Declaracao de Procedimentos de MOpcoes }

procedure formSair; forward;
procedure Controles_formSair(tipo:string;foco:boolean); forward;
procedure formSobre; forward;
procedure LerArquivoSobre; forward;
procedure Controles_formSobre(tipo:string;pos,col:integer;
                              foco:boolean); forward;
