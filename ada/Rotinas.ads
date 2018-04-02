with FuncoesC; use FuncoesC;
with Ada.Text_IO; use Ada.Text_IO;
with Text_IO; use Text_IO;
with Direct_IO;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;
with Ada.FLoat_Text_IO; use Ada.Float_Text_IO;
with Ada.Characters; use Ada.Characters;
with Ada.Strings; use Ada.Strings;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with Ada.Calendar; use Ada.Calendar;

package Rotinas is

-- Declaracao de tipos --

  subtype ustring is unbounded_string;

  function To_Ustring(Source : String)  return Unbounded_String
                                        renames To_Unbounded_String;

  type Keys is ( NullKey, F1, F2, F3, F4, F5, F6, F7, F8, F9, F10,
           CarriageReturn, Tab, ShiftTab, Bksp, UpArrow,
           DownArrow, RightArrow, LeftArrow, DeleteKey,
           InsertKey, HomeKey, Esc, EndKey, TextKey,
           NumberKey, SpaceKey, PgUp, PgDn, CtrlA, AltA,
           AltE, AltU, AltS, AltO);

  -- Registro de Enderecos --

  type Enderecos is
   Record
     Logra : ustring; -- (1..30);  -- Logradouro --
     Numero : integer:=0;       -- Numero do Endereco (5) --
     Compl : ustring; -- (1..10);  -- Complemento --
     Bairro : ustring; -- (1..20); -- Bairro do Endereco --
     Cep : ustring; -- (1..8);     -- Cep do Endereco (8) --
   end record;

  -- Registro de Livros --

  type LivrosRec is
   Record
     Ninsc : integer:=0;      -- Numero de Inscricao do Livro (5) --
     Titulo : ustring; -- (1..30);  -- Titulo do Livro --
     Autor : ustring; -- (1..30);   -- Autor do Livro --
     Area : ustring; -- (1..30);    -- Area de atuacao do Livro --
     PChave : ustring; -- (1..10);  -- Palavra-Chave para pesquisar o Livro --
     Edicao : integer:=0;        -- Edicao do Livro (4) --
     AnoPubli : integer:=0;      -- Ano de Publicacao do Livro (4) --
     Editora : ustring; -- (1..30); -- Editora do Livro --
     Volume : integer:=0;        -- Volume do Livro (4) --
     Estado : character;      -- Estado Atual - (D)isponivel ou (E)mprestado --
   end record;

  -- Registro de Usuarios --

  type UsuariosRec is
   Record
     Ninsc : integer:=0;       -- Numero de inscricao do Usuario (5) --
     Nome : ustring; -- (1..30);     -- Nome completo do Usuario --
     Ident : ustring; -- (1..10);    -- Identidade do Usuario (10) --
     Endereco : Enderecos;     -- Endereco completo do Usuario (73) --
     Telefone : ustring; -- (1..11); -- Telefone do Usuario (11) --
     Categoria : character;    -- Categoria - (A)luno,(P)rofessor,(F)uncionario --
     Situacao : integer:=0;       -- Situacao - Numero de Livros em sua posse (1) --
   end record;

  -- Registro de Emprestimos --

  type EmprestimosRec is
   Record
     NinscUsuario : integer:=0;    -- Numero de inscricao do Usuario (5) --
     NinscLivro : integer:=0;      -- Numero de inscricao do Livro (5) --
     DtEmprestimo : ustring; -- (1..10); -- Data de Emprestimo do Livro --
     DtDevolucao : ustring; -- (1..10);  -- Data de Devolucao do Livro --
     Removido : boolean:=false;          -- Removido - Indica exclusao logica --
   end record;

 -- variaveis gerais --

 Key : Keys;
 Fk : boolean;
 Ch : character;
 S : ustring;
 I,C : integer := 0;

 -- variaveis de menu --

 vMenu : array(1..10) of ustring;  -- (1..30);
 vSubMenu : array(1..10,1..10) of ustring;  -- (1..35);

 -- variaveis de lista --

 vLista : array(0..50) of ustring; -- (1..255)
 Listapos, Listacol : integer:=0;

 -- variaveis do modulo de livros --

 subtype Bloco_Livros is String(1 .. 150);
 package LivrosIO is new Direct_IO(Bloco_Livros); use LivrosIO;
 LivrosFile : LivrosIO.File_Type;
 nTamLivros : integer:=0;
 bLivros : Bloco_Livros;
 Livros : LivrosRec;
 vLivros : array(1..10) of ustring; -- (1..30);

 -- variaveis do modulo de Usuarios --

 subtype Bloco_Usuarios is String(1 .. 133);
 package UsuariosIO is new Direct_IO(Bloco_Usuarios); use UsuariosIO;
 UsuariosFile : UsuariosIO.File_Type; 
 nTamUsuarios : integer:=0;
 bUsuarios : Bloco_Usuarios;
 Usuarios : UsuariosRec;
 vUsuarios : array(1..11) of ustring; -- (1..30);

 -- variaveis do modulo de Emprestimos --

 subtype Bloco_Emprestimos is String(1 .. 33);
 package EmprestimosIO is new Direct_IO(Bloco_Emprestimos); use EmprestimosIO;
 bEmprestimos : Bloco_Emprestimos;
 EmprestimosFile : EmprestimosIO.File_Type;  
 nTamEmprestimos : integer:=0;
 Emprestimos : EmprestimosRec;
 vEmprestimos : array(1..5) of ustring;  -- (1..10);

 -- variaveis do modulo de Opcoes --

 SobreFile : Text_IO.File_Type; 

-- Declaracao de funcoes --

function itam(it: in integer) return integer;
procedure itostr(num: in integer;str: in out ustring);
function Repete(St: in string;Tam: in integer) return string;
function copy(stg: in ustring;ini,tam: in integer) return string;
function posstr(origem: in character;alvo: in ustring) return integer;

-- Declaracao de Procedimentos --

procedure EscreveRapido(x,y: in integer;S: in out ustring;fg: in foreground_color;
                    bg: in background_color);
procedure center(y: in integer;S: in string;fg: in foreground_color;
                 bg: in background_color);
procedure beep;
procedure esperar(freq: in integer);  
procedure deletar(str: in out ustring;ini,tam: in integer);
procedure inserir(origem: in character;alvo: in out ustring;ini: in integer);
procedure InKey(chavefuncional: in out boolean;
                ch: in out character;cursorinicio,cursorfim: in character);
procedure Etexto(c,l: in integer;fg: in foreground_color;
                 bg: in background_color;texto: in string); 
procedure TeladeFundo(tipo: in string;fg: in foreground_color;
                      bg: in background_color); 
procedure cabecalho(texto: in string;tipo: in string;
                    fg: in foreground_color;bg: in background_color); 
procedure rodape(texto: in string;tipo: in string;fg: in foreground_color;
                 bg: in background_color); 
procedure DatadoSistema(l,c: in integer;fg: in foreground_color;
                        bg: in background_color); 
procedure HoradoSistema(l,c: in integer;fg: in foreground_color;
                        bg: in background_color); 
procedure AbrirArquivo(Tipo: in integer);
procedure fAtribuir(nTipo: in integer;ltipo: in boolean);

end Rotinas;
