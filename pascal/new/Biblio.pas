{
  Nome : Sistema de Automacao de Biblioteca (Biblio)
  Autor : Henrique Figueiredo de Souza
  Linguagem : Pascal
  Compiladores : Borland Turbo Pascal
                 Free Pascal Compiler
  Data de Realizacao : 4 de setembro de 1999
  Ultima Atualizacao : 15 de fevereiro de 2000
  Versao do Sistema : 1.0
  Nome do(s) Arquivo(s) e Como Compilar (nesta ordem) :
  1. Biblio.pas --> "tpc biblio.pas"
  1. Biblio.pas --> "ppc386 biblio.pas"

  Descricao :
  O Sistema e composto dos seguintes modulos:
  1.Modulo de Livros da Biblioteca
    Onde se realiza a manutencao dos livros da biblioteca
  2.Modulo de Usuarios da Bilioteca
    Onde se realiza a manutencao dos usuarios da biblioteca
  3.Modulo de Emprestimos e Devolucoes da Biblioteca
    Onde se efetua os emprestimos e devolucoes da biblioteca
  4.Modulo de Opcoes do sistema
    Onde e possivel ver sobre o sistema e sair dele
}
program Biblio;

uses crt, rotinas1, grafico1, rotinas2;   

procedure pConMenusArq(nultpos:integer; btf:boolean); forward;
procedure pConMenusUsr(nultpos:integer; btf:boolean); forward;
procedure pConMenusEmp(nultpos:integer; btf:boolean); forward;
procedure pConMenusOpc(nultpos:integer; btf:boolean); forward;
procedure pConMenus5(nultpos:integer; btf:boolean); forward;
procedure pConMenus6(nultpos:integer; btf:boolean); forward;

{---------------------------------------------------------------------}

{
 Nome : pConMenus
 Descricao : procedimento que faz todo o controle de manuseio dos submenus.
 Parametros :
 cnum - indica qual o submenu selecionado do menu
 nultpos - indica a ultima posicao da opcao de submenu selecionada
 btf - indica se vai redesenhar a tela de fundo
}
procedure pConMenusArq(nultpos:integer;btf:boolean);
begin

if btf=true then
  pTelaFundo(sCFundo,mnCor[5,1],mnCor[5,2]);

    pMenu(2,4,mnCor[4,1],mnCor[4,2],mnCor[2,1],mnCor[2,2],1,
    mnCor[3,1],mnCor[3,2],1);
    pRodape('Controle do Acervo da Biblioteca.',' ',mnCor[6,1],mnCor[6,2]);
    pFrm('',3,3,4,20,chr(177),mnCor[4,1],mnCor[4,2],lightgray,black);
    case fnSubMenu(1,4,5,3,16,nultpos,mnCor[3,1],mnCor[3,2],
         mnCor[4,1],mnCor[4,2]) of
      0:begin
         if fbVrfMouse(2,4,9,1)=true then
           pConMenusArq(1,true);
         if fbVrfMouse(2,13,20,1)=true then
           pConMenusUsr(1,true);
         if fbVrfMouse(2,24,47,1)=true then
           pConMenusEmp(1,true);
         if fbVrfMouse(2,51,56,1)=true then
           pConMenusOpc(1,true);
        end;
      1:pConMenusOpc(1,true);
      2:pConMenusUsr(1,true);
      3:pFrmLivros(1,'Cadastrar Livros',
        'Cadastro dos Livros do Acervo da Biblioteca.');
      4:pFrmLivros(2,'Alterar Livros',
        'Altera os Livros do Acervo da Biblioteca.');
      5:pConMenus5(1,false);
    end;

end;

procedure pConMenusUsr(nultpos:integer;btf:boolean);
begin

if btf=true then
  pTelaFundo(sCFundo,mnCor[5,1],mnCor[5,2]);

    pMenu(2,4,mnCor[4,1],mnCor[4,2],mnCor[2,1],mnCor[2,2],10,
    mnCor[3,1],mnCor[3,2],2);
    pRodape('Controle de Usuarios da Biblioteca.',' ',mnCor[6,1],mnCor[6,2]);
    pFrm('',3,12,4,22,chr(177),mnCor[4,1],mnCor[4,2],lightgray,black);
    case fnSubMenu(2,4,14,3,18,nultpos,mnCor[3,1],mnCor[3,2],
         mnCor[4,1],mnCor[4,2]) of
      0:begin
         if fbVrfMouse(2,4,9,1)=true then
           pConMenusArq(1,true);
         if fbVrfMouse(2,13,20,1)=true then
           pConMenusUsr(1,true);
         if fbVrfMouse(2,24,47,1)=true then
           pConMenusEmp(1,true);
         if fbVrfMouse(2,51,56,1)=true then
           pConMenusOpc(1,true);
        end;
      1:pConMenusArq(1,true);
      2:pConMenusEmp(1,true);
      3:pFrmUsuarios(1,'Cadastrar Usuarios',
        'Cadastro dos Usuarios da Biblioteca.');
      4:pFrmUsuarios(2,'Alterar Usuarios',
        'Altera os Usuarios da Biblioteca.');
      5:pConMenus6(1,false);
    end;
end;

procedure pConMenusEmp(nultpos:integer;btf:boolean);
begin

if btf=true then
  pTelaFundo(sCFundo,mnCor[5,1],mnCor[5,2]);

    pMenu(2,4,mnCor[4,1],mnCor[4,2],mnCor[2,1],mnCor[2,2],21,
    mnCor[3,1],mnCor[3,2],3);
    pRodape('Controle de Emprestimos e Devolucoes da Biblioteca.',' ',
    mnCor[6,1],mnCor[6,2]);
    pFrm('',3,23,4,37,chr(177),mnCor[4,1],mnCor[4,2],lightgray,black);
    case fnSubMenu(3,4,25,3,16,nultpos,mnCor[3,1],mnCor[3,2],
         mnCor[4,1],mnCor[4,2]) of
      0:begin
         if fbVrfMouse(2,4,9,1)=true then
           pConMenusArq(1,true);
         if fbVrfMouse(2,13,20,1)=true then
           pConMenusUsr(1,true);
         if fbVrfMouse(2,24,47,1)=true then
           pConMenusEmp(1,true);
         if fbVrfMouse(2,51,56,1)=true then
           pConMenusOpc(1,true);
        end;
      1:pConMenusUsr(1,true);
      2:pConMenusOpc(1,true);
      3:pFrmEmprestimos(1,'Emprestar Livros',
        'Efetua os Emprestimos de Livros da Biblioteca.');
      4:pFrmEmprestimos(2,'Devolver Livros',
        'Efetua a Devolucao dos Livros da Biblioteca.');
      5:pFrmEmprestimos(3,'Consultar Emprestimos e Devolucoes',
        'Consulta os Emprestimos e Devolucoes dos Livros da Biblioteca.');
    end;
end;

procedure pConMenusOpc(nultpos:integer;btf:boolean);
begin

if btf=true then
  pTelaFundo(sCFundo,mnCor[5,1],mnCor[5,2]);

    pMenu(2,4,mnCor[4,1],mnCor[4,2],mnCor[2,1],mnCor[2,2],48,
    mnCor[3,1],mnCor[3,2],4);
    pRodape('Opcoes do Sistema de Biblioteca.',' ',mnCor[6,1],mnCor[6,2]);
    pFrm('',3,50,12,21,chr(177),mnCor[4,1],mnCor[4,2],lightgray,black);
    case fnSubMenu(4,4,52,11,19,nultpos,mnCor[3,1],mnCor[3,2],
         mnCor[4,1],mnCor[4,2]) of
      0:begin
         if fbVrfMouse(2,4,9,1)=true then
           pConMenusArq(1,true);
         if fbVrfMouse(2,13,20,1)=true then
           pConMenusUsr(1,true);
         if fbVrfMouse(2,24,47,1)=true then
           pConMenusEmp(1,true);
         if fbVrfMouse(2,51,56,1)=true then
           pConMenusOpc(1,true);
        end;
      1:pConMenusEmp(1,true);
      2:pConMenusArq(1,true);
      3:pFrmConfig(true);
      4:pFrmCores;
      5:pFrmCalendario;
      6:pFrmCalculadora;
      8:pFrmTabAscii;
      9:pFrmQuebraCabeca;
      12:pFrmSobre;
      13:pFrmSair;
    end;
end;

procedure pConMenus5(nultpos:integer;btf:boolean);
begin

if btf=true then
  pTelaFundo(sCFundo,mnCor[5,1],mnCor[5,2]);

    pFrm('',6,23,6,20,chr(177),mnCor[4,1],mnCor[4,2],lightgray,black);
    case fnSubMenu(5,7,25,5,18,nultpos,mnCor[3,1],mnCor[3,2],
         mnCor[4,1],mnCor[4,2]) of
      1:pConMenusArq(3,true);
      2:pConMenusUsr(1,true);
      4:pFrmLivros(3,'Consultar Livros por Titulo',
        'Consulta os Livros por Titulo do Acervo da Biblioteca.');
      5:pFrmLivros(4,'Consultar Livros por Autor',
        'Consulta os Livros por Autor do Acervo da Biblioteca.');
      6:pFrmLivros(5,'Consultar Livros por Area',
        'Consulta os Livros por Area do Acervo da Biblioteca.');
      7:pFrmLivros(6,'Consultar Livros por Palavra-chave',
        'Consulta os Livros por Palavra-chave do Acervo da Biblioteca.');
      3:pFrmLivros(7,'Consultar Todos os Livros',
        'Consulta Todos os Livros do Acervo da Biblioteca.');
    end;
end;

procedure pConMenus6(nultpos:integer;btf:boolean);
begin

if btf=true then
  pTelaFundo(sCFundo,mnCor[5,1],mnCor[5,2]);

    pFrm('',6,34,5,26,chr(177),mnCor[4,1],mnCor[4,2],lightgray,black);
    case fnSubMenu(6,7,36,4,24,nultpos,mnCor[3,1],mnCor[3,2],
         mnCor[4,1],mnCor[4,2]) of
      1:pConMenusUsr(3,true);
      2:pConMenusEmp(1,true);
      4:pFrmUsuarios(3,'Consultar Usuarios por Numero de Inscricao',
        'Consulta os Usuarios por Numero de Inscricao.');
      5:pFrmUsuarios(4,'Consultar Usuarios por Nome',
        'Consulta os Usuarios por Nome.');
      6:pFrmUsuarios(5,'Consultar Usuarios por Identidade',
        'Consulta os Usuarios por Numero de Identidade.');
      3:pFrmUsuarios(6,'Consultar Todos os Usuarios',
        'Consulta Todos os Usuarios da Biblioteca.');

    end;
end;

{ Bloco principal do programa }

begin
  clrscr;
  pInicializa;

  if fnIniMouse=0 then
     pRodape('Mouse nao instalado.',' ',mnCor[6,1],mnCor[6,2])
  else
   begin
     pCursorMouse(liga);
     pMoveMouse(1,5);
   end;

  pTelaFundo(sCFundo,mnCor[5,1],mnCor[5,2]);
  pCabecalho('Sistema de Automacao de Biblioteca',' ',mnCor[1,1],mnCor[1,2]);
  pRodape('',' ',mnCor[6,1],mnCor[6,2]);
  pDataSistema(1,1,mnCor[1,1],mnCor[1,2]);
  pHoraSistema(1,nMaxlrg-7,mnCor[1,1],mnCor[1,2]);

  vsMenu[1]:='Acervo';
  vsMenu[2]:='Usuarios';
  vsMenu[3]:='Emprestimos e Devolucoes';
  vsMenu[4]:='Opcoes';

  msSubMenu[1,1]:='Cadastrar livros';
  msSubMenu[1,2]:='Alterar livros';
  msSubMenu[1,3]:='Consultar livros >';

  msSubMenu[2,1]:='Cadastrar usuarios';
  msSubMenu[2,2]:='Alterar usuarios';
  msSubMenu[2,3]:='Consultar usuarios >';

  msSubMenu[3,1]:='Emprestar livros';
  msSubMenu[3,2]:='Devolver livros';
  msSubMenu[3,3]:='Consultar Emprestimos e Devolucoes';

  msSubMenu[4,1]:='Configuracoes';
  msSubMenu[4,2]:='Cores do sistema';
  msSubMenu[4,3]:='Calendario';
  msSubMenu[4,4]:='Calculadora';
  msSubMenu[4,5]:=chr(196);
  msSubMenu[4,6]:='Tabela ASCII';
  msSubMenu[4,7]:='Quebra-cabeca';
  msSubMenu[4,8]:='Jogo da velha';
  msSubMenu[4,9]:=chr(196);
  msSubMenu[4,10]:='Sobre o sistema';
  msSubMenu[4,11]:='Sair do sistema';

  msSubMenu[5,1]:='Todos os livros';
  msSubMenu[5,2]:='Por Titulo';
  msSubMenu[5,3]:='Por Autor';
  msSubMenu[5,4]:='Por Area';
  msSubMenu[5,5]:='Por Palavra-chave';

  msSubMenu[6,1]:='Todos os Usuarios';
  msSubMenu[6,2]:='Por Numero de Inscricao';
  msSubMenu[6,3]:='Por Nome';
  msSubMenu[6,4]:='Por Identidade';

  pSetaCursor(nenhum);
  pMenu(2,4,mnCor[4,1],mnCor[4,2],mnCor[2,1],mnCor[2,2],0,
  mnCor[3,1],mnCor[3,2],0);
  {pFrmSplash;}

  Repeat
   if (keypressed=true) then
    begin
     pTelaFundo(sCFundo,mnCor[5,1],mnCor[5,2]);
     pMenu(2,4,mnCor[4,1],mnCor[4,2],mnCor[2,1],mnCor[2,2],0,
     mnCor[3,1],mnCor[3,2],0);
    end;

   if keypressed=true then
     nTecla:=fnTeclar
   else
     begin
      nTecla:=TNULL;
      pLerMouse;
     end;

   if (nTecla=TALTA) or (fbVrfMouse(2,4,9,1)=true) then
      pConMenusArq(1,true);
   if (nTecla=TALTU) or (fbVrfMouse(2,13,20,1)=true) then
      pConMenusUsr(1,true);
   if (nTecla=TALTE) or (fbVrfMouse(2,24,47,1)=true) then
      pConMenusEmp(1,true);
   if (nTecla=TALTO) or (fbVrfMouse(2,51,56,1)=true) then
      pConMenusOpc(1,true);

  until nTecla = TESC;

end.
