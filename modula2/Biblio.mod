(*
  Nome : Sistema de Automacao de Biblioteca (Biblio)
  Autor : Henrique Figueiredo de Souza
  Linguagem : Modula-2
  Compilador : Gardens Point Modula-2 
  Data de Realizacao : 4 de setembro de 1999
  Ultima Atualizacao : 15 de fevereiro de 2000
  Versao do Sistema : 1.0
  Nome do(s) Arquivo(s) e Como Compilar (nesta ordem) :
  01. rotinas.def  --> "gpm rotinas.def"
  02. rotinas.mod  --> "gpm rotinas.mod"
  03. graficos.def --> "gpm graficos.def"
  04. graficos.mod --> "gpm graficos.mod"
  05. mlivros.def  --> "gpm mlivros.def"
  06. mlivros.mod  --> "gpm mlivros.mod"
  07. musuario.def --> "gpm musuario.def"
  08. musuario.mod --> "gpm musuario.mod"
  09. memprest.def --> "gpm memprest.def"
  10. memprest.mod --> "gpm memprest.mod"
  11. mopcoes.def  --> "gpm mopcoes.def"
  12. mopcoes.mod  --> "gpm mopcoes.mod"
  13. biblio.mod   --> "gpm biblio.mod"
  14. biblio.mod   --> "build biblio"

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
*)
MODULE Biblio;

FROM Rotinas IMPORT ModoCursor, Keys, Ss, LENGTH, Repete, Inkey, Etexto,
TeladeFundo, Cabecalho, Rodape, DatadoSistema, HoradoSistema, Formulario,
Cores, SetaCor;
FROM Graficos IMPORT Menu, formSplash;
FROM MLivros IMPORT formLivros;
FROM MUsuario IMPORT formUsuarios;
FROM MEmprest IMPORT formEmprestimos;
FROM MOpcoes IMPORT formSair, formSobre;
FROM ANSISYS IMPORT ClearScreen, GotoRowCol;
FROM StdStrings IMPORT String, Compare, CompareResult;
FROM Terminal IMPORT WriteString;

(* Declaracao de variaveis globais *)

VAR

 (* variaveis gerais *)

 Key : Keys;
 Fk : BOOLEAN;
 Ch : CHAR; 
 S : String;
 nBytes : CARDINAL;

 (* variaveis de menu *)

 vMenu : ARRAY[1..10] OF String;  (* 30 *)
 vSubMenu : ARRAY[1..10],[1..10] OF String; (* 35 *) 

(* Declaracao de funcoes *)

PROCEDURE SubMenu(numero,qtd,maxtam,topo,esquerda,ultpos:INTEGER;
                  lfg,lbg,fg,bg:Cores):INTEGER; FORWARD;

(* Declaracao de Procedimentos *)

PROCEDURE ControlaMenus(tipo:String;ultpos:INTEGER;tf:BOOLEAN); FORWARD;          

(*-----------------------------------------------------------------*)

(*
 Nome : SubMenu
 Descricao : funcao que permite criar um controle de submenu, retornando
 a opcao selecionada.
 Parametros :
 numero - indica qual e o submenu
 qtd - indica a quantidade de linhas do submenu
 maxtam - indica a largura maxima do submenu
 topo - posicao da linha inicial na tela
 esquerda - posicao da coluna inicial na tela
 ultpos - indica a ultima opcao referenciada pelo usuario
 lfg - cor do texto selecionado
 lbg - cor de fundo selecionado
 fg - cor do texto
 bg - cor de fundo
*)
PROCEDURE SubMenu(numero,qtd,maxtam,topo,esquerda,ultpos:INTEGER;
                  lfg,lbg,fg,bg:Cores):INTEGER;
VAR
 cont,cont2:INTEGER;
BEGIN
 SetaCor(fg);
 SetaCor(bg);
 FOR cont:=0 TO qtd-1 DO
  GotoRowCol(topo+cont,esquerda);
  WriteString(Ss(vSubMenu[numero,cont+1],Repete(" ",maxtam-LENGTH(vSubMenu[numero,cont+1]))));
 END;
 Etexto(esquerda,topo+ultpos-1,lfg,lbg,Ss(vSubMenu[numero,ultpos],
 Repete(" ",maxtam-LENGTH(vSubMenu[numero,ultpos]))));

 cont:=ultpos-2;
 cont2:=ultpos-1;
 REPEAT
   Inkey(Fk,Ch,'O','O',Key);

   IF Key=UpArrow THEN
       cont:=cont-1;
       cont2:=cont2-1;
       IF cont2=-1 THEN
          cont:=-2;
          cont2:=qtd-1;
       END;

       Etexto(esquerda,topo+cont+2,fg,bg,Ss(vSubMenu[numero,ABS(cont+3)],
       Repete(" ",maxtam-LENGTH(vSubMenu[numero,ABS(cont+3)]))));
       Etexto(esquerda,topo+cont2,lfg,lbg,Ss(vSubMenu[numero,ABS(cont2+1)],
       Repete(" ",maxtam-LENGTH(vSubMenu[numero,ABS(cont2+1)])))); 

       IF cont=-2 THEN
          cont:=qtd-2;
       END;
   END;
   IF Key=DownArrow THEN
       cont:=cont+1;
       cont2:=cont2+1;
       IF cont2=qtd THEN
          cont2:=0;
       END;
       Etexto(esquerda,topo+cont,fg,bg,Ss(vSubMenu[numero,cont+1],
       Repete(" ",maxtam-LENGTH(vSubMenu[numero,cont+1]))));
       Etexto(esquerda,topo+cont2,lfg,lbg,Ss(vSubMenu[numero,cont2+1],
       Repete(" ",maxtam-LENGTH(vSubMenu[numero,cont2+1]))));

       IF cont=qtd-1 THEN
          cont:=-1;
       END;
   END;

 UNTIL ((Key=CarriageReturn) OR (Key=LeftArrow) OR (Key=RightArrow));
 IF Key=LeftArrow THEN
    RETURN(1);
 ELSIF Key=RightArrow THEN
    RETURN(2);
 ELSIF Key=CarriageReturn THEN
    RETURN(cont2+3);
 END;
END SubMenu;

(*-----------------------------------------------------------------*)

(*
 Nome : ControlaMenus
 Descricao : procedimento que faz todo o controle de manuseio dos submenus.
 Parametros :
 tipo - indica qual o submenu selecionado do menu
 ultpos - indica a ultima posicao da opcao de submenu selecionada
 tf - indica se vai redesenhar a tela de fundo
*)
PROCEDURE ControlaMenus(tipo:String;ultpos:INTEGER;tf:BOOLEAN);
BEGIN

IF tf=TRUE THEN
  TeladeFundo("±",WhiteFG,BlueBG);
END;
IF Compare(tipo,"A")=equal THEN
    Menu(4,2,BlackFG,LightGrayBG,RedFG,LightGrayBG,1,YellowFG,LightGrayBG,1,vMenu);
    Rodape("Controle do Acervo da Biblioteca."," ",WhiteFG,BlueBG);
    Formulario("",3,3,4,20,BlackFG,LightGrayBG,"±",LightGrayFG,BlackBG);
    CASE SubMenu(1,3,16,4,5,ultpos,YellowFG,LightGrayBG,BlackFG,LightGrayBG) OF
    | 1: ControlaMenus("O",1,TRUE);
    | 2: ControlaMenus("U",1,TRUE);
    | 3: formLivros(1,"Cadastrar Livros",
         "Cadastro dos Livros do Acervo da Biblioteca.");
    | 4: formLivros(2,"Alterar Livros",
         "Altera os Livros do Acervo da Biblioteca."); 
    | 5: ControlaMenus("5",1,FALSE);
    END;
ELSIF Compare(tipo,"U")=equal THEN
    Menu(4,2,BlackFG,LightGrayBG,RedFG,LightGrayBG,10,YellowFG,LightGrayBG,2,vMenu);
    Rodape("Controle de Usuarios da Biblioteca."," ",WhiteFG,BlueBG);
    Formulario("",3,12,4,22,BlackFG,LightGrayBG,"±",LightGrayFG,BlackBG);
    CASE SubMenu(2,3,18,4,14,ultpos,YellowFG,LightGrayBG,BlackFG,LightGrayBG) OF
    | 1: ControlaMenus("A",1,TRUE);
    | 2: ControlaMenus("E",1,TRUE);
    | 3: formUsuarios(1,"Cadastrar Usuarios",
        "Cadastro dos Usuarios da Biblioteca.");
    | 4: formUsuarios(2,"Alterar Usuarios",
        "Altera os Usuarios da Biblioteca."); 
    | 5: ControlaMenus("6",1,FALSE);
    END;
ELSIF Compare(tipo,"E")=equal THEN
    Menu(4,2,BlackFG,LightGrayBG,RedFG,LightGrayBG,21,YellowFG,LightGrayBG,3,vMenu);
    Rodape("Controle de Emprestimos e Devolucoes da Biblioteca."," ",
    WhiteFG,BlueBG);
    Formulario("",3,23,4,37,BlackFG,LightGrayBG,"±",LightGrayFG,BlackBG);
    CASE SubMenu(3,3,16,4,25,ultpos,YellowFG,LightGrayBG,BlackFG,LightGrayBG) OF
    | 1: ControlaMenus("U",1,TRUE);
    | 2: ControlaMenus("O",1,TRUE);
    | 3: formEmprestimos(1,"Emprestar Livros",
         "Efetua os Emprestimos de Livros da Biblioteca.");
    | 4: formEmprestimos(2,"Devolver Livros",
         "Efetua a Devolucao dos Livros da Biblioteca.");
    | 5: formEmprestimos(3,"Consultar Emprestimos e Devolucoes",
         "Consulta os Emprestimos e Devolucoes dos Livros da Biblioteca.");  
    END;
ELSIF Compare(tipo,"O")=equal THEN
    Menu(4,2,BlackFG,LightGrayBG,RedFG,LightGrayBG,48,YellowFG,LightGrayBG,4,vMenu);
    Rodape("Opcoes do Sistema de Biblioteca."," ",WhiteFG,BlueBG);
    Formulario("",3,50,3,18,BlackFG,LightGrayBG,"±",LightGrayFG,BlackBG);
    CASE SubMenu(4,2,16,4,52,ultpos,YellowFG,LightGrayBG,BlackFG,LightGrayBG) OF
    | 1: ControlaMenus("E",1,TRUE);
    | 2: ControlaMenus("A",1,TRUE);
    | 3: formSobre;
    | 4: formSair; 
    END;
ELSIF Compare(tipo,"5")=equal THEN
    Formulario("",6,23,6,20,BlackFG,LightGrayBG,"±",LightGrayFG,BlackBG);
    CASE SubMenu(5,5,18,7,25,ultpos,YellowFG,LightGrayBG,BlackFG,LightGrayBG) OF
    | 1: ControlaMenus("A",3,TRUE);
    | 2: ControlaMenus("U",1,TRUE);
    | 4: formLivros(3,"Consultar Livros por Titulo",
          "Consulta os Livros por Titulo do Acervo da Biblioteca.");
    | 5: formLivros(4,"Consultar Livros por Autor",
         "Consulta os Livros por Autor do Acervo da Biblioteca.");
    | 6: formLivros(5,"Consultar Livros por Area",
         "Consulta os Livros por Area do Acervo da Biblioteca.");
    | 7: formLivros(6,"Consultar Livros por Palavra-chave",
         "Consulta os Livros por Palavra-chave do Acervo da Biblioteca.");
    | 3: formLivros(7,"Consultar Todos os Livros",
         "Consulta Todos os Livros do Acervo da Biblioteca."); 
    END;
ELSIF Compare(tipo,"6")=equal THEN
    Formulario("",6,34,5,26,BlackFG,LightGrayBG,"±",LightGrayFG,BlackBG);
    CASE SubMenu(6,4,24,7,36,ultpos,YellowFG,LightGrayBG,BlackFG,LightGrayBG) OF
    | 1: ControlaMenus("U",3,TRUE);
    | 2: ControlaMenus("E",1,TRUE);
    | 4: formUsuarios(3,"Consultar Usuarios por Numero de Inscricao",
         "Consulta os Usuarios por Numero de Inscricao.");
    | 5: formUsuarios(4,"Consultar Usuarios por Nome",
         "Consulta os Usuarios por Nome.");
    | 6: formUsuarios(5,"Consultar Usuarios por Identidade",
         "Consulta os Usuarios por Numero de Identidade.");
    | 3: formUsuarios(6,"Consultar Todos os Usuarios",
         "Consulta Todos os Usuarios da Biblioteca."); 
    END;
END;

END ControlaMenus;

(*-------------------------------------------------------------*)
        
(* Bloco principal do programa *)

BEGIN
  ClearScreen;
  TeladeFundo("±",WhiteFG,BlueBG);
  Cabecalho("Sistema de Automacao de Biblioteca"," ",WhiteFG,BlueBG);
  Rodape(""," ",WhiteFG,BlueBG);
  DatadoSistema(1,1,WhiteFG,BlueBG);
  HoradoSistema(1,73,WhiteFG,BlueBG);

  vMenu[1]:="Acervo";
  vMenu[2]:="Usuarios";
  vMenu[3]:="Emprestimos e Devolucoes";
  vMenu[4]:="Opcoes";

  vSubMenu[1,1]:="Cadastrar livros";
  vSubMenu[1,2]:="Alterar livros";
  vSubMenu[1,3]:="Consultar livros >";

  vSubMenu[2,1]:="Cadastrar usuarios";
  vSubMenu[2,2]:="Alterar usuarios";
  vSubMenu[2,3]:="Consultar usuarios >";

  vSubMenu[3,1]:="Emprestar livros";
  vSubMenu[3,2]:="Devolver livros";
  vSubMenu[3,3]:="Consultar Emprestimos e Devolucoes";

  vSubMenu[4,1]:="Sobre o sistema";
  vSubMenu[4,2]:="Sair do sistema";

  vSubMenu[5,1]:="Todos os livros";
  vSubMenu[5,2]:="Por Titulo";
  vSubMenu[5,3]:="Por Autor";
  vSubMenu[5,4]:="Por Area";
  vSubMenu[5,5]:="Por Palavra-chave";

  vSubMenu[6,1]:="Todos os Usuarios";
  vSubMenu[6,2]:="Por Numero de Inscricao";
  vSubMenu[6,3]:="Por Nome";
  vSubMenu[6,4]:="Por Identidade";

  Menu(4,2,BlackFG,LightGrayBG,RedFG,LightGrayBG,0,DarkGrayFG,BlackBG,0,vMenu); 
  formSplash; 
  TeladeFundo("±",WhiteFG,BlueBG); 

  REPEAT

   Inkey(Fk,Ch,"O","O",Key);

   IF Key=AltA THEN
      ControlaMenus("A",1,TRUE);
      TeladeFundo("±",WhiteFG,BlueBG); 
      Menu(4,2,BlackFG,LightGrayBG,RedFG,LightGrayBG,0,WhiteFG,BlackBG,0,vMenu); 
   ELSIF Key=AltU THEN
      ControlaMenus("U",1,TRUE);
      TeladeFundo("±",WhiteFG,BlueBG); 
      Menu(4,2,BlackFG,LightGrayBG,RedFG,LightGrayBG,0,WhiteFG,BlackBG,0,vMenu); 
   ELSIF Key=AltE THEN
      ControlaMenus("E",1,TRUE);
      TeladeFundo("±",WhiteFG,BlueBG); 
      Menu(4,2,BlackFG,LightGrayBG,RedFG,LightGrayBG,0,WhiteFG,BlackBG,0,vMenu); 
   ELSIF Key=AltO THEN
      ControlaMenus("O",1,TRUE);
      TeladeFundo("±",WhiteFG,BlueBG); 
      Menu(4,2,BlackFG,LightGrayBG,RedFG,LightGrayBG,0,WhiteFG,BlackBG,0,vMenu); 
   END;
 
  UNTIL Key = Esc;

END Biblio.
