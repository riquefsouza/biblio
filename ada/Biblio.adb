--
--  Nome : Sistema de Automacao de Biblioteca (Biblio)
--  Autor : Henrique Figueiredo de Souza
--  Linguagem : Ada
--  Compilador : Gnat
--  Data de Realizacao : 4 de setembro de 1999
--  Ultima Atualizacao : 15 de fevereiro de 2000
--  Versao do Sistema : 1.0
--  Nome do(s) Arquivo(s) e Como Compilar (Nesta ordem):
--  01. FuncoesC.adb --> "gcc -O3 -c -gnatp -gnatn -s -m486 funcoesc.adb"
--  02. Rotinas.ads  --> "gcc -gnatc -c rotinas.ads"
--  03. Rotinas.adb  --> "gcc -c rotinas.adb"
--  04. Graficos.ads --> "gcc -gnatc -c graficos.ads"
--  05. Graficos.adb --> "gcc -c graficos.adb"
--  06. PLivros.ads  --> "gcc -gnatc -c plivros.ads"
--  07. PLivros.adb  --> "gcc -c plivros.adb"
--  08. PUsuario.ads --> "gcc -gnatc -c pusuario.ads"
--  09. PUsuario.adb --> "gcc -c pusuario.adb"
--  10. PEmprest.ads --> "gcc -gnatc -c pemprest.ads"
--  11. PEmprest.adb --> "gcc -c pemprest.adb"
--  12. POpcoes.ads  --> "gcc -gnatc -c popcoes.ads"
--  13. POpcoes.adb  --> "gcc -c popcoes.adb"
--  14. Biblio.adb   --> "gcc -c biblio.adb"
--  15. Biblio.adb   --> "gnatmake biblio.adb"
--
--  Descricao :
--  O Sistema e composto dos seguintes modulos:
--  1.Modulo de Acervos da Biblioteca
--    Onde se realiza a manutencao dos livros da biblioteca
--  2.Modulo de Usuarios da Bilioteca
--    Onde se realiza a manutencao dos usuarios da biblioteca
--  3.Modulo de Emprestimos e Devolucoes da Biblioteca
--    Onde se efetua os emprestimos e devolucoes da biblioteca
--  4.Modulo de Opcoes do sistema
--    Onde e possivel ver sobre o sistema e sair dele
--
-- programa Biblio

with FuncoesC, MEmprest; use FuncoesC, MEmprest;
with Rotinas, MOpcoes, MLivros; use Rotinas, MOpcoes, MLivros;
with MUsuario, Graficos; use MUsuario, Graficos;
with Ada.Text_IO; use Ada.Text_IO;
with Text_IO; use Text_IO;
with Direct_IO;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;
with Ada.FLoat_Text_IO; use Ada.Float_Text_IO;
with Ada.Characters; use Ada.Characters;
with Ada.Strings; use Ada.Strings;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with Ada.Calendar; use Ada.Calendar;

procedure biblio is

-- Declaracao de Procedimentos --

procedure ControlaMenus(tipo: in character;ultpos: in integer;tf: in boolean);

------------------------------------------------------------------------

--
-- Nome : ControlaMenus
-- Descricao : procedimento que faz todo o controle de manuseio dos submenus.
-- Parametros :
-- tipo - indica qual o submenu selecionado do menu
-- ultpos - indica a ultima posicao da opcao de submenu selecionada
-- tf - indica se vai redesenhar a tela de fundo
--
procedure ControlaMenus(tipo: in character;ultpos: in integer;tf: in boolean) is
begin

if tf=true then
  teladefundo("±",white,blue); 
end if;

if tipo='A' then
    Menu(4,2,black,light_gray,red,light_gray,1,yellow,light_gray,1);
    rodape("Controle do Acervo da Biblioteca."," ",white,blue);
    formulario("",3,3,4,20,black,light_gray,"±",light_gray,black);
    case SubMenu(1,3,16,4,5,ultpos,yellow,light_gray,black,light_gray) is
      when 1 => ControlaMenus('O',1,true);
      when 2 => ControlaMenus('U',1,true);
      when 3 => formLivros(1,"Cadastrar Livros",
        "Cadastro dos Livros do Acervo da Biblioteca.");
      when 4 => formLivros(2,"Alterar Livros",
        "Altera os Livros do Acervo da Biblioteca.");
      when 5 => ControlaMenus('5',1,false);
      when others => null;
    end case;
elsif tipo='U' then
    Menu(4,2,black,light_gray,red,light_gray,10,yellow,light_gray,2);
    rodape("Controle de Usuarios da Biblioteca."," ",white,blue);
    formulario("",3,12,4,22,black,light_gray,"±",light_gray,black);
    case SubMenu(2,3,18,4,14,ultpos,yellow,light_gray,black,light_gray) is
      when 1 => ControlaMenus('A',1,true);
      when 2 => ControlaMenus('E',1,true);
      when 3 => formUsuarios(1,"Cadastrar Usuarios",
        "Cadastro dos Usuarios da Biblioteca.");
      when 4 => formUsuarios(2,"Alterar Usuarios",
        "Altera os Usuarios da Biblioteca.");
      when 5 => ControlaMenus('6',1,false);
      when others => null;
    end case;
elsif tipo='E' then
    Menu(4,2,black,light_gray,red,light_gray,21,yellow,light_gray,3);
    rodape("Controle de Emprestimos e Devolucoes da Biblioteca."," ",
    white,blue);
    formulario("",3,23,4,37,black,light_gray,"±",light_gray,black);
    case SubMenu(3,3,16,4,25,ultpos,yellow,light_gray,black,light_gray) is
      when 1 => ControlaMenus('U',1,true);
      when 2 => ControlaMenus('O',1,true);
      when 3 => formEmprestimos(1,"Emprestar Livros",
        "Efetua os Emprestimos de Livros da Biblioteca.");
      when 4 => formEmprestimos(2,"Devolver Livros",
        "Efetua a Devolucao dos Livros da Biblioteca.");
      when 5 => formEmprestimos(3,"Consultar Emprestimos e Devolucoes",
       "Consulta os Emprestimos e Devolucoes dos Livros da Biblioteca.");
      when others => null;
    end case;
elsif tipo='O' then
    Menu(4,2,black,light_gray,red,light_gray,48,yellow,light_gray,4);
    rodape("Opcoes do Sistema de Biblioteca."," ",white,blue);
    formulario("",3,50,3,18,black,light_gray,"±",light_gray,black);
    case SubMenu(4,2,16,4,52,ultpos,yellow,light_gray,black,light_gray) is
      when 1 => ControlaMenus('E',1,true);
      when 2 => ControlaMenus('A',1,true);
      when 3 => formSobre;
      when 4 => formSair;
      when others => null; 
    end case;
elsif tipo='5' then
    formulario("",6,23,6,20,black,light_gray,"±",light_gray,black);
    case SubMenu(5,5,18,7,25,ultpos,yellow,light_gray,black,light_gray) is
      when 1 => ControlaMenus('A',3,true);
      when 2 => ControlaMenus('U',1,true);
      when 4 => formLivros(3,"Consultar Livros por Titulo",
        "Consulta os Livros por Titulo do Acervo da Biblioteca.");
      when 5 => formLivros(4,"Consultar Livros por Autor",
        "Consulta os Livros por Autor do Acervo da Biblioteca.");
      when 6 => formLivros(5,"Consultar Livros por Area",
        "Consulta os Livros por Area do Acervo da Biblioteca.");
      when 7 => formLivros(6,"Consultar Livros por Palavra-chave",
        "Consulta os Livros por Palavra-chave do Acervo da Biblioteca.");
      when 3 => formLivros(7,"Consultar Todos os Livros",
        "Consulta Todos os Livros do Acervo da Biblioteca.");
      when others => null;
    end case;
elsif tipo='6' then
    formulario("",6,34,5,26,black,light_gray,"±",light_gray,black);
    case SubMenu(6,4,24,7,36,ultpos,yellow,light_gray,black,light_gray) is
      when 1 => ControlaMenus('U',3,true);
      when 2 => ControlaMenus('E',1,true);
      when 4 => formUsuarios(3,"Consultar Usuarios por Numero de Inscricao",
        "Consulta os Usuarios por Numero de Inscricao.");
      when 5 => formUsuarios(4,"Consultar Usuarios por Nome",
        "Consulta os Usuarios por Nome.");
      when 6 => formUsuarios(5,"Consultar Usuarios por Identidade",
        "Consulta os Usuarios por Numero de Identidade.");
      when 3 => formUsuarios(6,"Consultar Todos os Usuarios",
        "Consulta Todos os Usuarios da Biblioteca.");
      when others => null;
    end case;
end if;

end ControlaMenus;

--------------------------------------------------------------------------

-- Bloco principal do programa --

begin
  clrscr;
  teladefundo("±",white,blue); 
  cabecalho("Sistema de Automacao de Biblioteca"," ",white,blue);
  rodape(""," ",white,blue);
  DatadoSistema(1,1,white,blue);
  HoradoSistema(1,73,white,blue);

  vMenu(1):=to_ustring("Acervo");
  vMenu(2):=to_ustring("Usuarios");
  vMenu(3):=to_ustring("Emprestimos e Devolucoes");
  vMenu(4):=to_ustring("Opcoes");

  vSubMenu(1,1):=to_ustring("Cadastrar livros");
  vSubMenu(1,2):=to_ustring("Alterar livros");
  vSubMenu(1,3):=to_ustring("Consultar livros >");

  vSubMenu(2,1):=to_ustring("Cadastrar usuarios");
  vSubMenu(2,2):=to_ustring("Alterar usuarios");
  vSubMenu(2,3):=to_ustring("Consultar usuarios >");

  vSubMenu(3,1):=to_ustring("Emprestar livros");
  vSubMenu(3,2):=to_ustring("Devolver livros");
  vSubMenu(3,3):=to_ustring("Consultar Emprestimos e Devolucoes");

  vSubMenu(4,1):=to_ustring("Sobre o sistema");
  vSubMenu(4,2):=to_ustring("Sair do sistema");

  vSubMenu(5,1):=to_ustring("Todos os livros");
  vSubMenu(5,2):=to_ustring("Por Titulo");
  vSubMenu(5,3):=to_ustring("Por Autor");
  vSubMenu(5,4):=to_ustring("Por Area");
  vSubMenu(5,5):=to_ustring("Por Palavra-chave");

  vSubMenu(6,1):=to_ustring("Todos os Usuarios");
  vSubMenu(6,2):=to_ustring("Por Numero de Inscricao");
  vSubMenu(6,3):=to_ustring("Por Nome");
  vSubMenu(6,4):=to_ustring("Por Identidade");

  Menu(4,2,black,light_gray,red,light_gray,0,white,black,0);
  formSplash;
  teladefundo("±",white,blue);   

 loop

   inkey(Fk,Ch,'O','O');
   
   if key=AltA then
      ControlaMenus('A',1,true);
      teladefundo("±",white,blue); 
      Menu(4,2,black,light_gray,red,light_gray,0,white,black,0);
   elsif key=AltU then
      ControlaMenus('U',1,true);
      teladefundo("±",white,blue); 
      Menu(4,2,black,light_gray,red,light_gray,0,white,black,0);     
   elsif key=AltE then
      ControlaMenus('E',1,true);
      teladefundo("±",white,blue); 
      Menu(4,2,black,light_gray,red,light_gray,0,white,black,0);      
   elsif key=AltO then
      ControlaMenus('O',1,true);
      teladefundo("±",white,blue); 
      Menu(4,2,black,light_gray,red,light_gray,0,white,black,0);      
   end if;

  exit when Key = Esc;
 end loop;
 
end biblio;
