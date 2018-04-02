{
  Nome : Sistema de Automacao de Biblioteca (Biblio)
  Autor : Henrique Figueiredo de Souza
  Linguagem : Object Pascal
  Compilador : Free Pascal Compiler
  Data de Realizacao : 4 de setembro de 1999
  Ultima Atualizacao : 15 de fevereiro de 2000
  Versao do Sistema : 1.0
  Nome do(s) Arquivo(s) e Como Compilar (nesta ordem) :
  1. Biblio.pas --> "ppc386 biblio.pas"

  Descricao :
  O Sistema e composto dos seguintes modulos:
  1.Modulo de Acervos da Biblioteca
    Onde se realiza a manutencao dos livros da biblioteca
  2.Modulo de Usuarios da Bilioteca
    Onde se realiza a manutencao dos usuarios da biblioteca
  3.Modulo de Emprestimos e Devolucoes da Biblioteca
    Onde se efetua os emprestimos e devolucoes da biblioteca
  4.Modulo de Opcoes do sistema
    Onde e possivel ver sobre o sistema e sair dele
}
program Biblio;

uses Dos, crt, URotinas, UBiblio, ULivros, UUsuario, UEmprest, UOpcoes;

var

 { variaveis gerais }

 PRotinas : TRotinas;
 PBiblio : TBiblio;
 PLivros : TLivros;
 PUsuario : TUsuario;
 PEmprest : TEmprest;
 POpcoes : TOpcoes;

{ Declaracao de Procedimentos }

procedure ControlaMenus(tipo:char;ultpos:integer;tf:boolean); forward;

{-----------------------------------------------------------------}

{
 Nome : ControlaMenus
 Descricao : procedimento que faz todo o controle de manuseio dos submenus.
 Parametros :
 tipo - indica qual o submenu selecionado do menu
 ultpos - indica a ultima posicao da opcao de submenu selecionada
 tf - indica se vai redesenhar a tela de fundo
}
procedure ControlaMenus(tipo:char;ultpos:integer;tf:boolean);
begin

if tf=true then
  PRotinas.teladefundo('±',white,lightblue);

if tipo='A' then
  begin
    PBiblio.Menu(4,2,black,lightgray,red,lightgray,1,yellow,lightgray,1);
    PRotinas.rodape('Controle do Acervo da Biblioteca.',' ',white,blue);
    PBiblio.formulario('',3,3,4,20,black,lightgray,'±',lightgray,black);
    case PBiblio.SubMenu(1,3,16,4,5,ultpos,yellow,lightgray,black,lightgray) of
      1:ControlaMenus('O',1,true);
      2:ControlaMenus('U',1,true);
      3:PLivros.formLivros(1,'Cadastrar Livros',
        'Cadastro dos Livros do Acervo da Biblioteca.');
      4:PLivros.formLivros(2,'Alterar Livros',
        'Altera os Livros do Acervo da Biblioteca.');
      5:ControlaMenus('5',1,false);
    end;
  end
else if tipo='U' then
  begin
    PBiblio.Menu(4,2,black,lightgray,red,lightgray,10,yellow,lightgray,2);
    PRotinas.rodape('Controle de Usuarios da Biblioteca.',' ',white,blue);
    PBiblio.formulario('',3,12,4,22,black,lightgray,'±',lightgray,black);
    case PBiblio.SubMenu(2,3,18,4,14,ultpos,yellow,lightgray,black,lightgray) of
      1:ControlaMenus('A',1,true);
      2:ControlaMenus('E',1,true);
      3:PUsuario.formUsuarios(1,'Cadastrar Usuarios',
        'Cadastro dos Usuarios da Biblioteca.');
      4:PUsuario.formUsuarios(2,'Alterar Usuarios',
        'Altera os Usuarios da Biblioteca.');
      5:ControlaMenus('6',1,false);
    end;
  end
else if tipo='E' then
  begin
    PBiblio.Menu(4,2,black,lightgray,red,lightgray,21,yellow,lightgray,3);
    PRotinas.rodape('Controle de Emprestimos e Devolucoes da Biblioteca.',' ',
    white,blue);
    PBiblio.formulario('',3,23,4,37,black,lightgray,'±',lightgray,black);
    case PBiblio.SubMenu(3,3,16,4,25,ultpos,yellow,lightgray,black,lightgray) of
      1:ControlaMenus('U',1,true);
      2:ControlaMenus('O',1,true);
      3:PEmprest.formEmprestimos(1,'Emprestar Livros',
        'Efetua os Emprestimos de Livros da Biblioteca.');
      4:PEmprest.formEmprestimos(2,'Devolver Livros',
        'Efetua a Devolucao dos Livros da Biblioteca.');
      5:PEmprest.formEmprestimos(3,'Consultar Emprestimos e Devolucoes',
        'Consulta os Emprestimos e Devolucoes dos Livros da Biblioteca.');
    end;
  end
else if tipo='O' then
  begin
    PBiblio.Menu(4,2,black,lightgray,red,lightgray,48,yellow,lightgray,4);
    PRotinas.rodape('Opcoes do Sistema de Biblioteca.',' ',white,blue);
    PBiblio.formulario('',3,50,3,18,black,lightgray,'±',lightgray,black);
    case PBiblio.SubMenu(4,2,16,4,52,ultpos,yellow,lightgray,black,lightgray) of
      1:ControlaMenus('E',1,true);
      2:ControlaMenus('A',1,true);
      3:POpcoes.formSobre;
      4:POpcoes.formSair;
    end;
  end
else if tipo='5' then
  begin
    PBiblio.formulario('',6,23,6,20,black,lightgray,'±',lightgray,black);
    case PBiblio.SubMenu(5,5,18,7,25,ultpos,yellow,lightgray,black,lightgray) of
      1:ControlaMenus('A',3,true);
      2:ControlaMenus('U',1,true);
      4:PLivros.formLivros(3,'Consultar Livros por Titulo',
        'Consulta os Livros por Titulo do Acervo da Biblioteca.');
      5:PLivros.formLivros(4,'Consultar Livros por Autor',
        'Consulta os Livros por Autor do Acervo da Biblioteca.');
      6:PLivros.formLivros(5,'Consultar Livros por Area',
        'Consulta os Livros por Area do Acervo da Biblioteca.');
      7:PLivros.formLivros(6,'Consultar Livros por Palavra-chave',
        'Consulta os Livros por Palavra-chave do Acervo da Biblioteca.');
      3:PLivros.formLivros(7,'Consultar Todos os Livros',
        'Consulta Todos os Livros do Acervo da Biblioteca.');
    end;
  end
else if tipo='6' then
  begin
    PBiblio.formulario('',6,34,5,26,black,lightgray,'±',lightgray,black);
    case PBiblio.SubMenu(6,4,24,7,36,ultpos,yellow,lightgray,black,lightgray) of
      1:ControlaMenus('U',3,true);
      2:ControlaMenus('E',1,true);
      4:PUsuario.formUsuarios(3,'Consultar Usuarios por Numero de Inscricao',
        'Consulta os Usuarios por Numero de Inscricao.');
      5:PUsuario.formUsuarios(4,'Consultar Usuarios por Nome',
        'Consulta os Usuarios por Nome.');
      6:PUsuario.formUsuarios(5,'Consultar Usuarios por Identidade',
        'Consulta os Usuarios por Numero de Identidade.');
      3:PUsuario.formUsuarios(6,'Consultar Todos os Usuarios',
        'Consulta Todos os Usuarios da Biblioteca.');

    end;
  end;

end;

{ Bloco principal do programa }

begin
 clrscr;
   PRotinas.teladefundo('±',white,lightblue);
   PRotinas.cabecalho('Sistema de Automacao de Biblioteca',' ',white,blue);
   PRotinas.rodape('',' ',white,blue);
   PRotinas.DatadoSistema(1,1,white,blue);
   PRotinas.HoradoSistema(1,73,white,blue);

   PBiblio.vMenu[1]:='Acervo';
   PBiblio.vMenu[2]:='Usuarios';
   PBiblio.vMenu[3]:='Emprestimos e Devolucoes';
   PBiblio.vMenu[4]:='Opcoes';

   PBiblio.vSubMenu[1,1]:='Cadastrar livros';
   PBiblio.vSubMenu[1,2]:='Alterar livros';
   PBiblio.vSubMenu[1,3]:='Consultar livros >';

   PBiblio.vSubMenu[2,1]:='Cadastrar usuarios';
   PBiblio.vSubMenu[2,2]:='Alterar usuarios';
   PBiblio.vSubMenu[2,3]:='Consultar usuarios >';

   PBiblio.vSubMenu[3,1]:='Emprestar livros';
   PBiblio.vSubMenu[3,2]:='Devolver livros';
   PBiblio.vSubMenu[3,3]:='Consultar Emprestimos e Devolucoes';

   PBiblio.vSubMenu[4,1]:='Sobre o sistema';
   PBiblio.vSubMenu[4,2]:='Sair do sistema';

   PBiblio.vSubMenu[5,1]:='Todos os livros';
   PBiblio.vSubMenu[5,2]:='Por Titulo';
   PBiblio.vSubMenu[5,3]:='Por Autor';
   PBiblio.vSubMenu[5,4]:='Por Area';
   PBiblio.vSubMenu[5,5]:='Por Palavra-chave';

   PBiblio.vSubMenu[6,1]:='Todos os Usuarios';
   PBiblio.vSubMenu[6,2]:='Por Numero de Inscricao';
   PBiblio.vSubMenu[6,3]:='Por Nome';
   PBiblio.vSubMenu[6,4]:='Por Identidade';

   PBiblio.Menu(4,2,black,lightgray,red,lightgray,0,white,black,0);
   PBiblio.formSplash;

  Repeat
   PRotinas.teladefundo('±',white,lightblue);
   PBiblio.Menu(4,2,black,lightgray,red,lightgray,0,white,black,0);

   PRotinas.inkey(PBiblio.Fk,PBiblio.Ch,'O','O');

   if PRotinas.key=AltA then
      ControlaMenus('A',1,true);
   if PRotinas.key=AltU then
      ControlaMenus('U',1,true);
   if PRotinas.key=AltE then
      ControlaMenus('E',1,true);
   if PRotinas.key=AltO then
      ControlaMenus('O',1,true);

  until PRotinas.Key = Esc;

end.
