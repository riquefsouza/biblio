with FuncoesC; use FuncoesC;
with rotinas, graficos; use rotinas, graficos;
with Ada.Text_IO; use Ada.Text_IO;
with Text_IO; use Text_IO;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;
with Ada.FLoat_Text_IO; use Ada.Float_Text_IO;
with Ada.Characters; use Ada.Characters;
with Ada.Strings; use Ada.Strings;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;

package MUsuario is

-- Declaracao de funcoes --

function PesUsuarios(tipo: in character;campo: in string;nCod2: in integer;
                     sCod2: in string;nTamsCod: in integer) return integer; 
function PesBinaria(Chave: in integer) return integer; 
function VerificaUsuarios return boolean; 

-- Declaracao de Procedimentos --

procedure formUsuarios(tipo: in integer;titulo,rod: in string);
procedure Limpar_Usuarios; 
procedure Rotulos_formUsuarios(l: in integer); 
procedure Controles_formUsuarios(tipo: in string;tipo2,pos,
          col: in integer;rod: in string;foco: in boolean); 
procedure Atribuir_vUsuarios(limpar: in boolean); 
procedure Digita_formUsuarios; 
procedure SalvarUsuarios(tipo: in integer); 

end MUsuario;
