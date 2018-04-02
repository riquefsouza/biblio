with FuncoesC; use FuncoesC;
with rotinas, graficos; use rotinas, graficos;
with Text_io; use Text_io;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;

package MOpcoes is

-- Modulo de Opcoes --

procedure formSair;
procedure Controles_formSair(tipo: in string;foco: in boolean); 
procedure formSobre; 
procedure LerArquivoSobre; 
procedure Controles_formSobre(tipo: in string;pos,col: in integer;
                              foco: in boolean); 

end MOpcoes;
