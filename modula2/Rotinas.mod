IMPLEMENTATION MODULE Rotinas;

FROM IntStr IMPORT Value, Alignment, Give;
(* FROM RealStr IMPORT Alignment, GiveFloat; *)
FROM ANSISYS IMPORT Attribute, SetAttribute, GotoRowCol;
FROM Cursor IMPORT SetShape;
FROM AsciiTime IMPORT StructTimeToAscii; 
FROM Ascii IMPORT bel;
FROM StdStrings IMPORT String, Length, Delete, Assign,
Append, Extract, Compare, CompareResult;
FROM SYSTEM IMPORT CAST;
FROM Terminal IMPORT WriteString, Write, GetKeyStroke;
FROM SysClock IMPORT GetClock, DateTime;
FROM SYSTEM IMPORT ADDRESS;
FROM UxFiles IMPORT File, Open, OpenMode, Create, SetPos, EndFile,
ReadNBytes;

(*-----------------------------------------------------------------*)

(* Rotinas Fundamentais *)

PROCEDURE SetaCor(Cor:Cores);
BEGIN
 CASE Cor OF
 (* Foreground *)
 | BlackFG : SetAttribute(blackFG); 
 | BlueFG  : SetAttribute(blueFG); 
 | GreenFG : SetAttribute(greenFG);
 | CyanFG  : SetAttribute(cyanFG); 
 | RedFG   : SetAttribute(redFG); 
 | MagentaFG : SetAttribute(magentaFG);
 | BrownFG   : SetAttribute(yellowFG); 
 | LightGrayFG : SetAttribute(whiteFG);
 (* Background *)
 | BlackBG : SetAttribute(blackBG); 
 | BlueBG  : SetAttribute(blueBG); 
 | GreenBG : SetAttribute(greenBG);
 | CyanBG  : SetAttribute(cyanBG); 
 | RedBG   : SetAttribute(redBG); 
 | MagentaBG : SetAttribute(magentaBG);
 | BrownBG   : SetAttribute(yellowBG); 
 | LightGrayBG : SetAttribute(whiteBG);
 (* Foreground bold *)
 | DarkGrayFG : SetAttribute(bold); SetAttribute(blackFG);
 | LightBlueFG : SetAttribute(bold); SetAttribute(blueFG);
 | LightGreenFG : SetAttribute(bold); SetAttribute(greenFG);
 | LightCyanFG : SetAttribute(bold); SetAttribute(cyanFG); 
 | LightRedFG : SetAttribute(bold); SetAttribute(redFG); 
 | LightMagentaFG : SetAttribute(bold); SetAttribute(magentaFG);
 | YellowFG : SetAttribute(bold); SetAttribute(yellowFG);
 | WhiteFG : SetAttribute(bold); SetAttribute(whiteFG); 
 END;
END SetaCor;

(*-------------------------------------------------------------------*)

(*
 Nome : EscreveRapido
 Descricao : Procedimento que permite ter um controle do posicionamento
 do cursor, sem piscadas ou erros de repeticao de visualizacao.
 Parametros :
 x - posicao de coluna na tela
 y - posicao de linha na tela
 S - o resultado do que foi digitado
 fg - cor do texto
 bg - cor de fundo
*)
PROCEDURE EscreveRapido(x,y:INTEGER;VAR S:String;fg,bg:Cores);
BEGIN
 SetaCor(fg);
 SetaCor(bg);
 GotoRowCol(y+1,x-1);
 WriteString(S);
END EscreveRapido;

(*--------------------------------------------------------------------*)

(*
 Nome : SetaCursor
 Descricao : Procedimento que muda o modo do cursor na tela.
 Parametros :
 tipo - indica o tipo de cursor
*)
PROCEDURE SetaCursor(tipo:ModoCursor);
BEGIN
IF tipo=nenhum THEN
   SetShape(20,0);
ELSIF tipo=normal THEN
   SetShape(19,20); 
ELSIF tipo=solido THEN
   SetShape(0,20); 
END;

END SetaCursor;

(*--------------------------------------------------------------------*)

(*
 Nome : Esperar
 Descricao : Procedimento que gera um espera de tanto tempo
 Parametros :
 freq - frequencia do tempo
*)
PROCEDURE Esperar(freq:INTEGER);
VAR
 cont:INTEGER;
BEGIN
cont:=0;
REPEAT
 cont:=cont+1;
UNTIL (freq*320)=cont;

END Esperar;

(*--------------------------------------------------------------------*)

(*
 Nome : LENGTH
 Descricao : Funcao que retorna o tamanho em inteiro
 Parametros :
 freq - frequencia do tempo
*)
PROCEDURE LENGTH(str1:ARRAY OF CHAR):INTEGER;
BEGIN
 RETURN(CAST(INTEGER,Length(str1)));
END LENGTH;

(*--------------------------------------------------------------------*)

(*
 Nome : CHRS
 Descricao : Funcao que retorna o CHR em String
 Parametros :
 freq - frequencia do tempo
*)
PROCEDURE CHRS(i1:INTEGER):String;
VAR
 c2 : String;
BEGIN
 c2[0]:=CHR(i1);
 c2[1]:=00C;
 RETURN(c2);
END CHRS;

(*--------------------------------------------------------------------*)

(*
 Nome : Center
 Descricao : Procedimento que centraliza um texto na tela.
 Parametros :
 y - posicao de linha na tela
 s - texto a ser centralizado
 fg - cor do texto
 bg - cod de fundo
*)
PROCEDURE Center(y:INTEGER;s:String;fg,bg:Cores);
VAR
 x:INTEGER;
BEGIN
 x:=40-(LENGTH(s) DIV 2);
 Etexto(x,y,fg,bg,s);
END Center;

(*------------------------------------------*)

(*
 Nome : Beep
 Descricao : Procedimento que gera um beep.
 Parametros :
 time - duracao do beep.
*)
PROCEDURE Beep;
BEGIN
 Write(bel);
END Beep;

(*-------------------------------------------*)

(*
 Nome : Ss
 Descricao : funcao que concatena strings e retorna o resultado
 Parametros :
 str1 - indica a string1
 str2 - indica a string2
*)
PROCEDURE Ss(str1,str2:ARRAY OF CHAR):String;
VAR
  str3:String;
BEGIN
 str3[0]:=00C;
 Append(str1,str3);
 Append(str2,str3);
 RETURN(str3);
END Ss;

(*-------------------------------------------*)

(*
 Nome : Copy
 Descricao : funcao que retorna um pedaco de uma string
 Parametros :
 str - indica a string
 ini - indica a posicao inicial do pedaco
 tam - indica o tamanho do pedaco
*)
PROCEDURE Copy(str:String;ini,tam:INTEGER):String;
VAR
str1 : String;
BEGIN
ini:=ini-1;
Extract(str,CAST(CARDINAL,ini),CAST(CARDINAL,tam),str1);
RETURN (str1);
END Copy;

(*-------------------------------------------*)

(*
 Nome : Inserir
 Descricao : funcao que inclui um caracter numa string
 Parametros :
 origem - o caracter a ser incluido
 alvo - a string que vai receber o caracter
 ini - a posicao na string a inserir o caracter
*)
PROCEDURE Inserir(origem:CHAR;VAR alvo:String;ini:INTEGER);
VAR
 ig,j:INTEGER;
 s1:String;
BEGIN
 IF (ini>0) AND (ini<=LENGTH(alvo)+1) THEN
   j:=0;
   FOR ig:=0 TO LENGTH(alvo) DO
    IF ig=ini-1 THEN
       s1[j]:=origem;
       j:=j+1;
    END;  
    s1[j]:=alvo[ig];
    j:=j+1;
   END;
   s1[j]:=00C;
   alvo:=s1;
 END;
END Inserir;

(*--------------------------------------------------*)

(*
 Nome : Pos
 Descricao : funcao que retorna a posicao de um caracter numa string
 Parametros :
 origem - indica o caracter a ser encontrado na string
 alvo - indica a string que vai ser pesquisada
*)
PROCEDURE Pos(origem:CHAR; alvo:String):INTEGER;
VAR
  j,nRet:INTEGER;
BEGIN
nRet:=0;
FOR j:=LENGTH(alvo)-1 TO 0 BY -1 DO
  IF (origem=alvo[j]) THEN
     nRet:=j+1;
  END;
END;
RETURN (nRet); 
END Pos;

(*-------------------------------------------*)

(*
 Nome : Rtrimstr
 Descricao : funcao que retorna a string sem espacos a direita
 Parametros :
 str - indica a string
*)
PROCEDURE Rtrimstr(str:String):String;
VAR
j,i:INTEGER;
str1:String;
BEGIN
j:=LENGTH(str)-1;
str1:=str;
FOR i:=j TO 0 BY -1 DO 
  IF str1[i] <> ' ' THEN
    str1[i+1]:=00C;
    RETURN(str1);
  END;
END;
str1[0]:=00C;
RETURN(str1);
END Rtrimstr;

(*-------------------------------------------*)

(*
 Nome : Inkey
 Descricao : Procedimento que identifica uma tecla do teclado.
 Parametros :
 chavefuncional - variavel que indica se e uma tecla funcional
 ch - indica o caracter pressionado
 cursorinicio - indica o estado do cursor inicial
 cursorfim - indica o estado do cursor final
 sKey - indica a tecla de retorno
*)
PROCEDURE Inkey(VAR chavefuncional:BOOLEAN;
                VAR ch:CHAR;cursorinicio,cursorfim:CHAR;VAR sKey:Keys);
BEGIN

 CASE cursorinicio OF
 | 'B':SetaCursor(solido);
 | 'S':SetaCursor(normal);
 | 'O':SetaCursor(nenhum);
 END;

chavefuncional:=FALSE;
GetKeyStroke(ch);
IF (ch=00C) THEN
  chavefuncional:=TRUE;
  GetKeyStroke(ch);
END;

IF chavefuncional THEN
   CASE ORD(ch) OF
   | 15: sKey := ShiftTab;
   | 18: sKey := AltE;
   | 22: sKey := AltU;
   | 24: sKey := AltO;
   | 30: sKey := AltA;
   | 31: sKey := AltS;
   | 72: sKey := UpArrow;
   | 80: sKey := DownArrow;
   | 75: sKey := LeftArrow;
   | 77: sKey := RightArrow;
   | 73: sKey := PgUp;
   | 81: sKey := PgDn;
   | 71: sKey := HomeKey;
   | 79: sKey := EndKey;
   | 83: sKey := DeleteKey;
   | 82: sKey := InsertKey;
   | 59: sKey := F1;
   | 60: sKey := F2;
   | 61: sKey := F3;
   | 62: sKey := F4;
   | 63: sKey := F5;
   | 64: sKey := F6;
   | 65: sKey := F7;
   | 66: sKey := F8;
   | 67: sKey := F9;
   | 68: sKey := F10;
   END;
ELSE
   CASE ORD(ch) OF
   |  1: sKey := CtrlA;
   |  8: sKey := Bksp;
   |  9: sKey := Tab;
   | 10: sKey := CarriageReturn;
   | 27: sKey := Esc;
   | 32: sKey := SpaceKey;
   | 33..44, 47, 58..254: sKey := TextKey;
   | 45..46, 48..57: sKey := NumberKey;
   END;
END;

 CASE cursorfim OF
 | 'B':SetaCursor(solido);
 | 'S':SetaCursor(normal);
 | 'O':SetaCursor(nenhum);
 END;

END Inkey;

(*-----------------------------------------------------------*)

(*
 Nome : Repete
 Descricao : funcao que retorna um texto repetido n vezes.
 Parametros :
 St - indica o texto a ser repetido
 Tam - quantas vezes o texto se repetira
*)
PROCEDURE Repete(St:String;Tam:INTEGER) : String;
VAR
 cont:INTEGER;
 Esp:String;
BEGIN
 cont:=1;
 Esp:="";
 WHILE (cont <= Tam) DO
    Append(St,Esp);
    cont:=cont+1;
 END;
 RETURN Esp;
END Repete;

(*-------------------------------------------*)

(*
 Nome : Etexto
 Descricao : procedimento que escreve o texto na tela com determinada cor.
 Parametros :
 c - posicao de coluna do texto
 l - posicao de linha do texto
 fg - cor do texto
 bg - cor de fundo
 texto - o texto a ser escrito
*)
PROCEDURE Etexto(c,l:INTEGER;fg,bg:Cores;texto:String);
BEGIN
 SetAttribute(allOff);
 SetaCor(fg);
 SetaCor(bg);
 GotoRowCol(l,c);
 WriteString(texto);
END Etexto;

(*-------------------------------------------*)

(*
 Nome : Teladefundo
 Descricao : procedimento que desenha os caracteres do fundo da tela.
 Parametros :
 tipo - o caracter a ser escrito no fundo
 fg - cor do texto
 bg - cor de fundo
*)
PROCEDURE TeladeFundo(tipo:String;fg,bg:Cores);
VAR
 l,c:INTEGER;
 t:String;
BEGIN
t:=Repete(tipo,80);
FOR l:=3 TO 24 DO
    Etexto(1,l,fg,bg,t); 
END;
END TeladeFundo;

(*-------------------------------------------*)

(*
 Nome : cabecalho
 Descricao : procedimento que escreve o texto de cabecalho do sistema.
 Parametros :
 texto - o texto a ser escrito
 tipo - o caracter de fundo.
 fg - cor do texto
 bg - cor de fundo
*)
PROCEDURE Cabecalho(texto:String;tipo:String;fg,bg:Cores);
VAR
 c:INTEGER;
BEGIN
FOR c:=1 TO 80 DO
  Etexto(c,1,fg,bg,tipo);
END;
Center(1,texto,fg,bg);
END Cabecalho;

(*-------------------------------------------*)

(*
 Nome : rodape
 Descricao : procedimento que escreve o texto no rodape da tela.
 Parametros :
 texto - o texto a ser escrito
 tipo - o caracter de fundo.
 fg - cor do texto
 bg - cor de fundo
*)
PROCEDURE Rodape(texto:String;tipo:String;fg,bg:Cores);
VAR
 c:INTEGER;
BEGIN
FOR c:=1 TO 79 DO
  Etexto(c,25,fg,bg,tipo);
END;
Center(25,texto,fg,bg);
END Rodape;

(*-------------------------------------------*)

(*
 Nome : SubtraiDatas
 Descricao : funcao que subtrai duas datas e retorna o numero de dias
 Parametros :
 dt1 - data inicial
 dt2 - data final
*)
PROCEDURE SubtraiDatas(dt1:String;dt2:String):INTEGER;
VAR
 dia,mes,ano,dia1,mes1,ano1,dia2,mes2,ano2:INTEGER;
 i,c,dias:INTEGER;
 udiames: ARRAY[1..12] OF INTEGER;
BEGIN
 dias:=0;
 udiames[1]:=31;
 udiames[2]:=28;
 udiames[3]:=31;
 udiames[4]:=30;
 udiames[5]:=31;
 udiames[6]:=30;
 udiames[7]:=31;
 udiames[8]:=31;
 udiames[9]:=30;
 udiames[10]:=31;
 udiames[11]:=30;
 udiames[12]:=31;

 i:=Value(Copy(dt1,1,2));
 dia1:=i;
 i:=Value(Copy(dt1,4,2));
 mes1:=i;
 i:=Value(Copy(dt1,7,4));
 ano1:=i;

 i:=Value(Copy(dt2,1,2));
 dia2:=i;
 i:=Value(Copy(dt2,4,2));
 mes2:=i;
 i:=Value(Copy(dt2,7,4));
 ano2:=i;

 FOR ano:=ano1 TO ano2 DO
    FOR mes:=mes1 TO 12 DO
       (* ano bissexto *)
       IF (ano MOD 4)=0 THEN
         udiames[2]:=29;
       END;
       (* data final *)
       IF (ano=ano2) AND (mes=mes2) THEN
         udiames[mes2]:=dia2;
       END;
       FOR dia:=dia1 TO udiames[mes] DO
          dias:=dias+1;
       END;
       IF (ano=ano2) AND (mes=mes2) THEN
           RETURN(dias-1);
       END;
       dia1:=1;
    END;
    mes1:=1;
 END;

END SubtraiDatas;

(*--------------------------------------------------------*)

(*
 Nome : DiadaSemana
 Descricao : funcao que retorna o dia da semana de uma data em relacao
 a uma data base.
 Parametros :
 dt - indica a data para a qual deseja saber o dia da semana.
*)
PROCEDURE DiadaSemana(dt:String):String;
VAR
  sRet:String;
  ds:ARRAY[1..7] OF String;
  ndias,ix,jx,antdiv:INTEGER;
  bFlag:BOOLEAN;
BEGIN
 ix:=0;
 ndias:=0;
 bFlag:=FALSE;
 ds[1]:="Domingo";
 ds[2]:="Segunda";
 ds[3]:="Terca";
 ds[4]:="Quarta";
 ds[5]:="Quinta";
 ds[6]:="Sexta";
 ds[7]:="Sabado";
 ndias:=SubtraiDatas("01/01/1995",dt);
 IF (ndias >= 1) AND (ndias <= 6) THEN
    ix:=ndias;
 ELSE
    WHILE bFlag=FALSE DO
       jx:=(ndias DIV 7);
       ix:=(ndias MOD 7);
       IF (jx < 7) AND (ix < 7) THEN
          bFlag:=TRUE;
          ix:=ix+1;
       END;
       IF (jx < 7) AND (ix = 0) THEN
          bFlag:=TRUE;
          ix:=0;
       END;
       ndias:=jx;
    END;
 END;
 sRet:=ds[ix];
 RETURN(sRet);
END DiadaSemana;

(*-------------------------------------------*)

(*
 Nome : DatadoSistema
 Descricao : procedimento que escreve a data do sistema na tela.
 Parametros :
 l - posicao da linha na tela
 c - posicao da coluna na tela
 fg - cor do texto
 bg - cor de fundo
*)
PROCEDURE DatadoSistema(l,c:INTEGER;fg,bg:Cores);
VAR
  datahora :  DateTime;
  strdh,dia,mes,ano,ds,dt : String;
BEGIN
 GetClock(datahora);
 StructTimeToAscii(strdh,datahora);
 dia:=Copy(strdh,10,2);
 mes:=Copy(strdh,6,3);
 ano:=Copy(strdh,1,4);

 IF Compare(mes,"Jan")=equal THEN mes:="01";
 ELSIF Compare(mes,"Feb")=equal THEN mes:="02";
 ELSIF Compare(mes,"Mar")=equal THEN mes:="03";
 ELSIF Compare(mes,"Apr")=equal THEN mes:="04";
 ELSIF Compare(mes,"May")=equal THEN mes:="05";
 ELSIF Compare(mes,"Jun")=equal THEN mes:="06";
 ELSIF Compare(mes,"Jul")=equal THEN mes:="07";
 ELSIF Compare(mes,"Aug")=equal THEN mes:="08";
 ELSIF Compare(mes,"Sep")=equal THEN mes:="09";
 ELSIF Compare(mes,"Oct")=equal THEN mes:="10";
 ELSIF Compare(mes,"Nov")=equal THEN mes:="11";
 ELSIF Compare(mes,"Dez")=equal THEN mes:="12";
 END;
 dia:=Ss(Repete("0",2-LENGTH(dia)),dia);
 dt:=Ss(dia,Ss("/",Ss(mes,Ss("/",ano))));
 ds:=DiadaSemana(dt);
 Etexto(c,l,fg,bg,Ss(ds,Ss(", ",dt)));
END DatadoSistema;

(*-------------------------------------------*)

(*
 Nome : HoradoSistema
 Descricao : procedimento que escreve a Hora do sistema na tela.
 Parametros :
 l - posicao da linha na tela
 c - posicao da coluna na tela
 fg - cor do texto
 bg - cor de fundo
*)
PROCEDURE HoradoSistema(l,c:INTEGER;fg,bg:Cores);
VAR
  datahora :  DateTime;
  strdh : String;
BEGIN
 GetClock(datahora);
 StructTimeToAscii(strdh,datahora); 
 Etexto(c,l,fg,bg,Copy(strdh,13,8));
END HoradoSistema; 

(*-------------------------------------------*)

(*
 Nome : Zeros
 Descricao : funcao que escreve zeros na frente de uma String.
 Parametros :
 s - a String a receber zeros a frente
 tam - o tamanho da String
*)
PROCEDURE Zeros(s:String;tam:INTEGER) : String;
VAR
 cont : INTEGER;
 aux : String;
BEGIN
  aux:="";
  IF tam <> LENGTH(s) THEN
      FOR cont:=1 TO tam-LENGTH(s) DO
        Append("0",aux);
      END;
  END;
  RETURN (Ss(s,aux));
END Zeros;

(*-------------------------------------------*)

(*
 Nome : Formulario
 Descricao : procedimento que desenha um formulario na tela.
 Parametros :
 titulo - titulo do formulario
 topo - posicao da linha inicial na tela
 esquerda - posicao da coluna inicial na tela
 altura - a altura do formulario
 largura - a largura do formulario
 fg - cor do texto
 bg - cor de fundo
 sombra - o caracter que vai ser a sobra do formulario
 sfg - cor do texto da sombra
 sbg - cor de fundo da sombra
*)
PROCEDURE Formulario(titulo:String;topo,esquerda,
                     altura,largura:INTEGER;fg,bg:Cores;
                     sombra:String;sfg,sbg:Cores);
VAR
 cont,cont2:INTEGER;
 sEsp:String;
BEGIN
  Etexto(esquerda,topo,fg,bg,"Ú");
  FOR cont:=1 TO largura-1 DO
     GotoRowCol(topo,esquerda+cont);
     WriteString("Ä");
  END;
  GotoRowCol(topo,esquerda+2);
  WriteString(titulo);
  GotoRowCol(topo,esquerda+largura);
  WriteString("¿");
  sEsp:=Repete(" ",largura-1);
  FOR cont:=1 TO altura-1 DO
    GotoRowCol(topo+cont,esquerda);
    WriteString("³");
    GotoRowCol(topo+cont,esquerda+1);
    WriteString(sEsp);
    GotoRowCol(topo+cont,esquerda+largura);
    WriteString("³");
    Etexto(esquerda+largura+1,topo+cont,sfg,sbg,sombra);
    SetaCor(fg);
    SetaCor(bg);
  END;
  GotoRowCol(topo+altura,esquerda);
  WriteString("À");
  FOR cont:=1 TO largura-1 DO
     Etexto(esquerda+cont,topo+altura,fg,bg,"Ä");
     Etexto(esquerda+cont+1,topo+altura+1,sfg,sbg,sombra);
  END;
  Etexto(esquerda+largura,topo+altura,fg,bg,"Ù");
  Etexto(esquerda+largura+1,topo+altura,sfg,sbg,sombra);
  GotoRowCol(topo+altura+1,esquerda+largura+1);
  WriteString(sombra);
END Formulario;

(*-----------------------------------------------------*)

(*
 Nome : TamArquivo
 Descricao : funcao que retorna o tamanho de um arquivo
 Parametros :
 Arq - o nome do arquivo
 Endereco - Endereco do Registro
 TamTipo - Tamanho do Registro
*)
PROCEDURE TamArquivo(Arq:File;Endereco:ADDRESS;TamTipo:CARDINAL):INTEGER;
VAR 
  cont:INTEGER;
  nBytes:CARDINAL;
BEGIN
    cont:=0;
    SetPos(Arq,0);
    WHILE NOT(EndFile(Arq)) DO
      ReadNBytes(Arq,Endereco,TamTipo,nBytes);
      cont:=cont+1;
    END;
    cont:=cont-1;
    SetPos(Arq,0);
    RETURN(cont);
END TamArquivo;  

(*-----------------------------------------------------*)

(*
 Nome : AbrirArquivo
 Descricao : procedimento que Abri o tipo de arquivo selecionado.
 Parametros :
 tipo - indica o numero de qual arquivo a ser aberto
*)
PROCEDURE AbrirArquivo(Tipo:INTEGER;VAR Arq:File);
VAR
  bFora:BOOLEAN;
BEGIN
  IF Tipo=1 THEN
    Open(Arq,"Livros.dat",ReadWrite,bFora);
    IF bFora=FALSE THEN
       Create(Arq,"Livros.dat",bFora);
       IF bFora=TRUE THEN
          Open(Arq,"Livros.dat",ReadWrite,bFora);
          IF bFora=FALSE THEN
            Rodape("Erro ao abrir o arquivo Livros.dat !"," ",WhiteFG,RedBG);
          END;
       ELSE
         Rodape("Erro ao Criar o arquivo Livros.dat !"," ",WhiteFG,RedBG);
       END;
    END;
    (* nTamLivros:=TamArquivo(LivrosFile,ADR(Livros),TSIZE(LivrosRec)); *)
  END;
  IF Tipo=2 THEN
    Open(Arq,"Usuarios.dat",ReadWrite,bFora);
    IF bFora=FALSE THEN
       Create(Arq,"Usuarios.dat",bFora);
       IF bFora=TRUE THEN
          Open(Arq,"Usuarios.dat",ReadWrite,bFora);
          IF bFora=FALSE THEN
            Rodape("Erro ao abrir o arquivo Usuarios.dat !"," ",WhiteFG,RedBG);
          END;
       ELSE
         Rodape("Erro ao Criar o arquivo Usuarios.dat !"," ",WhiteFG,RedBG);
       END;
    END;
    (* nTamUsuarios:=TamArquivo(UsuariosFile,ADR(Usuarios),TSIZE(UsuariosRec)); *)
  END;
  IF Tipo=3 THEN
    Open(Arq,"Empresti.dat",ReadWrite,bFora);
    IF bFora=FALSE THEN
       Create(Arq,"Empresti.dat",bFora);
       IF bFora=TRUE THEN
          Open(Arq,"Empresti.dat",ReadWrite,bFora);
          IF bFora=FALSE THEN
            Rodape("Erro ao abrir o arquivo Empresti.dat !"," ",WhiteFG,RedBG);
          END;
       ELSE
         Rodape("Erro ao Criar o arquivo Empresti.dat !"," ",WhiteFG,RedBG);
       END;
    END;
    (* nTamEmprestimos:=TamArquivo(EmprestimosFile,ADR(Emprestimos),TSIZE(EmprestimosRec)); *)
  END;
  IF Tipo=4 THEN
    Open(Arq,"Sobre.dat",ReadOnly,bFora);
    IF bFora=FALSE THEN
       Rodape("Erro ao abrir o arquivo Sobre.dat !"," ",WhiteFG,RedBG);
    END;
  END;

END AbrirArquivo;

(*-----------------------------------------------------*)

(*
 Nome : RetDataAtual
 Descricao : funcao que retorna a data atual do sistema
*)
PROCEDURE RetDataAtual():String;
VAR
  datahora :  DateTime;
  strdh,dia,mes,ano,sRet : String;
BEGIN
 GetClock(datahora);
 StructTimeToAscii(strdh,datahora);
 dia:=Copy(strdh,10,2);
 mes:=Copy(strdh,6,3);
 ano:=Copy(strdh,1,4);

 IF Compare(mes,"Jan")=equal THEN mes:="01";
 ELSIF Compare(mes,"Feb")=equal THEN mes:="02";
 ELSIF Compare(mes,"Mar")=equal THEN mes:="03";
 ELSIF Compare(mes,"Apr")=equal THEN mes:="04";
 ELSIF Compare(mes,"May")=equal THEN mes:="05";
 ELSIF Compare(mes,"Jun")=equal THEN mes:="06";
 ELSIF Compare(mes,"Jul")=equal THEN mes:="07";
 ELSIF Compare(mes,"Aug")=equal THEN mes:="08";
 ELSIF Compare(mes,"Sep")=equal THEN mes:="09";
 ELSIF Compare(mes,"Oct")=equal THEN mes:="10";
 ELSIF Compare(mes,"Nov")=equal THEN mes:="11";
 ELSIF Compare(mes,"Dez")=equal THEN mes:="12";
 END;
 dia:=Ss(Repete("0",2-LENGTH(dia)),dia);
 sRet:=Ss(dia,Ss("/",Ss(mes,Ss("/",ano))));
 RETURN(sRet);

END RetDataAtual;

(*--------------------------------------------------------*)

(*
 Nome : ConverteData
 Descricao : funcao que converte a data em String para numero.
 Parametros :
 dt - data a ser convertida
*)
PROCEDURE ConverteData(dt:String):INTEGER;
VAR
  sAux:String;
  nAux:INTEGER;
BEGIN
 sAux:=Ss(Copy(dt,7,4),Ss(Copy(dt,4,2),Copy(dt,1,2)));
 nAux:=Value(sAux); 
 RETURN(nAux);
END ConverteData;

(*--------------------------------------------------------*)

(*
 Nome : SomaDias
 Descricao : funcao que soma um determinado numero de dias a uma data.
 Parametros :
 dt1 - a data a ser somada
 qtddias - numero de dias a serem somados
*)
PROCEDURE SomaDias(dt1:String;qtddias:INTEGER):String;
VAR
 dia,mes,ano,dia1,mes1,ano1,dia2,mes2,ano2:INTEGER;
 i,c,dias:INTEGER;
 sAux,sAux2:String;
 udiames: ARRAY[1..12] OF INTEGER;
BEGIN
 dias:=0;
 udiames[1]:=31;
 udiames[2]:=28;
 udiames[3]:=31;
 udiames[4]:=30;
 udiames[5]:=31;
 udiames[6]:=30;
 udiames[7]:=31;
 udiames[8]:=31;
 udiames[9]:=30;
 udiames[10]:=31;
 udiames[11]:=30;
 udiames[12]:=31;

 i:=Value(Copy(dt1,1,2)); 
 dia1:=i;
 i:=Value(Copy(dt1,4,2)); 
 mes1:=i;
 i:=Value(Copy(dt1,7,4)); 
 ano1:=i;

 ano2:=ano1 + (qtddias DIV 365);

 FOR ano:=ano1 TO ano2 DO
    FOR mes:=mes1 TO 12 DO
       (* ano bissexto *)
       IF (ano MOD 4)=0 THEN
         udiames[2]:=29;
       END;
       FOR dia:=dia1 TO udiames[mes] DO
            dias:=dias+1;
            IF dias=qtddias+1 THEN
                Give(sAux,dia,1,left); 
                sAux2:=Ss(Repete("0",2-LENGTH(sAux)),Ss(sAux, "/"));
                Give(sAux,mes,1,left); 
                sAux2:=Ss(sAux2,Ss(Repete("0",2-LENGTH(sAux)),Ss(sAux, "/")));
                Give(sAux,ano,1,left); 
                sAux2:=Ss(sAux2,sAux);
                RETURN(sAux2);
            END;
       END;
       dia1:=1;
    END;
    mes1:=1;
 END;

END SomaDias;

END Rotinas.
