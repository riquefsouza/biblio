with FuncoesC, rotinas; use FuncoesC, rotinas;
with Ada.Text_IO; use Ada.Text_IO;
with Text_IO; use Text_IO;
with Direct_IO;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;
with Ada.FLoat_Text_IO; use Ada.Float_Text_IO;
with Ada.Characters; use Ada.Characters;
with Ada.Strings; use Ada.Strings;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with Ada.Calendar; use Ada.Calendar;

package Graficos is

-- Declaracao de funcoes --

function SubMenu(numero,qtd,maxtam,topo,esquerda,ultpos: in integer;
          lfg: in foreground_color;lbg: in background_color;
          fg: in foreground_color;bg: in background_color) return integer; 
function Botao(topo,esquerda: in integer;
               fg: in foreground_color;bg: in background_color;
               sfg: in foreground_color;sbg: in background_color;
               texto: in string;foco: in boolean) return integer;
function TiposLista(tipo,largura,pos,col:in integer) return ustring;
function Lista(tipo,topo,esquerda,altura,largura,tlinhas,tcolunas: in integer;
               fg: in foreground_color;bg: in background_color;               
               foco: in boolean) return integer; 

-- Declaracao de Procedimentos --

procedure Digita( S: in out ustring;JanelaTam,MaxTam,X,Y: in Integer;
                  fg: in foreground_color;bg: in background_color;
                  FT: in Character;fundo : in integer);
procedure formulario(titulo: in string;topo,esquerda,altura,largura: in integer;
                     fg: in foreground_color;bg: in background_color;
                     sombra: in string;
                     sfg: in foreground_color;sbg: in background_color);
procedure Menu(qtd,topo: in integer;
               fg: in foreground_color;bg: in background_color;
               lfg: in foreground_color;lbg: in background_color;
               pos2: in integer;mfg: in foreground_color;
               mbg: in background_color;cont2: in integer); 
procedure DesenhaBotao(topo,esquerda: in integer;
                       fg: in foreground_color;bg: in background_color;
                       sfg: in foreground_color;sbg: in background_color;
                       texto: in string;foco: in boolean); 
procedure DesenhaLista(tipo,topo,esquerda,altura,largura: in integer;
                       fg: in foreground_color;bg: in background_color;
                       pos,col: in integer;foco: in boolean); 
procedure formSplash;

end Graficos;
