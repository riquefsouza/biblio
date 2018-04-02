with FuncoesC; use FuncoesC;
with MLivros, MUsuario; use MLivros, MUsuario;
with rotinas, graficos; use rotinas, graficos;
with Ada.Text_IO; use Ada.Text_IO;
with Text_IO; use Text_IO;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;
with Ada.FLoat_Text_IO; use Ada.Float_Text_IO;
with Ada.Characters; use Ada.Characters;
with Ada.Strings; use Ada.Strings;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with Ada.Calendar; use Ada.Calendar;

package MEmprest is

-- Declaracao de funcoes --

function PesEmprestimos(nCodUsuario,nCodLivro: in integer) return integer;
function RetDataAtual return ustring; 
function ConverteData(dt: in ustring) return integer; 
function SomaDias(dt1: in ustring;qtddias: in integer) return ustring; 
function SubtraiDatas(dt1: in ustring;dt2: in ustring) return integer; 

-- Declaracao de Procedimentos --

procedure formEmprestimos(tipo: in integer;titulo,rod: in string);
procedure Limpar_Emprestimos; 
procedure Rotulos_formEmprestimos(tipo,l: in integer); 
procedure Controles_formEmprestimos(tipo: in string;tipo2,pos,
          col: in integer;rod: in string;foco: in boolean); 
procedure Atribuir_vEmprestimos(limpar: in boolean); 
procedure SalvarEmprestimos(tipo: in integer); 

end MEmprest;
