IMPLEMENTATION MODULE MOpcoes;

FROM TextInOut IMPORT Read; 
FROM Rotinas IMPORT ModoCursor, Ss, CHRS, SetaCursor, TeladeFundo,
Rodape, Cores, SetaCor, Etexto, Formulario, AbrirArquivo;
FROM Graficos IMPORT DesenhaBotao, Botao, DesenhaLista, Lista, formSplash;
FROM ANSISYS IMPORT Mode, SetMode, ClearScreen;
FROM StdStrings IMPORT String, Compare, CompareResult;
FROM UxFiles IMPORT Close, EndFile;


(********************Modulo de Opcoes***********************)

(*
 Nome : formSair
 Descricao : procedimento que desenha o formulario de sair.
*)
PROCEDURE formSair;
BEGIN
  TeladeFundo("±",WhiteFG,BlueBG);
  Rodape("Alterta !, Aviso de Saida do Sistema."," ",YellowFG,RedBG);
  Formulario(Ss(CHRS(180),Ss("Sair do Sistema",CHRS(195))),10,25,6,27,WhiteFG,BlueBG,"±",LightGrayFG,BlackBG);
  Etexto(27,12,WhiteFG,BlueBG,"Deseja Sair do Sistema ?");
  DesenhaBotao(14,40,BlackFG,LightGrayBG,BlackFG,BlueBG," Nao ",FALSE);
  Controles_formSair(" Sim ",TRUE);
END formSair;

(*-------------------------------------------*)

(*
 Nome : Controles_formSair
 Descricao : procedimento que realiza todo o controle de manuseio do
 formulario de Saida.
 Parametros :
 tipo - indica qual acao a executar
 foco - indica quais objeto terao foco
*)
PROCEDURE Controles_formSair(tipo:String;foco:BOOLEAN);
BEGIN

IF Compare(tipo," Sim ")=equal THEN
    CASE Botao(14,30,BlackFG,LightGrayBG,BlackFG,BlueBG," Sim ",foco) OF
    | 1: DesenhaBotao(14,30,BlackFG,LightGrayBG,BlackFG,BlueBG," Sim ",FALSE);
         Controles_formSair(" Nao ",TRUE);
    | 2: SetMode(textColour80x25);
         SetMode(cursorWrap);
         SetaCor(LightGrayFG);
         SetaCor(BlackBG);
         SetaCursor(normal);
         ClearScreen;
         formSplash;
         SetaCor(LightGrayFG);
         SetaCor(BlackBG);
         SetaCursor(normal);
         ClearScreen;
         HALT;
    END;
ELSIF Compare(tipo," Nao ")=equal THEN
    CASE Botao(14,40,BlackFG,LightGrayBG,BlackFG,BlueBG," Nao ",foco) OF
    | 1: DesenhaBotao(14,40,BlackFG,LightGrayBG,BlackFG,BlueBG," Nao ",FALSE);
         Controles_formSair(" Sim ",TRUE);
    | 2: Rodape(""," ",WhiteFG,BlueBG);
    END;
END;

END Controles_formSair;

(*-------------------------------------------*)

(*
 Nome : formSobre
 Descricao : procedimento que desenha o formulario de Sobre.
*)
PROCEDURE formSobre;
BEGIN
  TeladeFundo("±",WhiteFG,BlueBG);
  Rodape("Informacoes sobre o sistema."," ",WhiteFG,BlueBG);
  Formulario(Ss(CHRS(180),Ss("Sobre o Sistema",CHRS(195))),4,2,18,76,WhiteFG,BlueBG,"±",LightGrayFG,BlackBG);
  LerArquivoSobre;
  DesenhaBotao(20,63,BlackFG,LightGrayBG,BlackFG,BlueBG," Fechar ",FALSE);
  Controles_formSobre("Lista",0,0,TRUE);
END formSobre;

(*-----------------------------------------------------*)

(*
 Nome : LerArquivoSobre
 Descricao : procedimento que le o arquivo de sobre a atribui ao vetor
 de lista.
*)
PROCEDURE LerArquivoSobre;
VAR
 cont,cont2:INTEGER;
 linha:CHAR;
BEGIN
 AbrirArquivo(4,SobreFile); 
 cont:=0;
 cont2:=0;
 WHILE NOT(EndFile(SobreFile)) DO
   Read(SobreFile,linha); 
   IF linha=CHR(10) THEN
      vLista[cont][cont2]:=00C;
      cont:=cont+1;
      cont2:=0;
      Read(SobreFile,linha);
   END;
   vLista[cont][cont2]:=linha;
   cont2:=cont2+1;
 END;
END LerArquivoSobre;

(*-----------------------------------------------------*)

(*
 Nome : Controles_formSobre
 Descricao : procedimento que realiza todo o controle de manuseio do
 formulario de Sobre.
 Parametros :
 tipo - indica qual acao a executar
 pos - indica a ultima posicao da linha da lista de sobre
 col - indica a ultima posicao da coluna da lista de sobre
 foco - indica quais objeto terao foco
*)
PROCEDURE Controles_formSobre(tipo:String;pos,col:INTEGER;foco:BOOLEAN);
VAR
  bFora:BOOLEAN;
BEGIN
IF Compare(tipo,"Fechar")=equal THEN
    CASE Botao(20,63,BlackFG,LightGrayBG,BlackFG,BlueBG," Fechar ",foco) OF
    | 1: DesenhaBotao(20,63,BlackFG,LightGrayBG,BlackFG,BlueBG," Fechar ",FALSE);
         Controles_formSobre("Lista",pos,col,TRUE);
    | 2: Close(SobreFile,bFora);
         Rodape(""," ",WhiteFG,BlueBG);
         TeladeFundo("±",WhiteFG,BlueBG);
    END;
ELSIF Compare(tipo,"Lista")=equal THEN
    IF Lista(4,6,5,13,70,43,70,0,WhiteFG,BlueBG,pos,col,foco,
       vLista,SobreFile)=1 THEN
       DesenhaLista(4,6,5,13,70,WhiteFG,BlueBG,pos,col,0,FALSE,
       vLista,SobreFile);
       Controles_formSobre("Fechar",pos,col,TRUE);
    END;
END;

END Controles_formSobre;

END MOpcoes.
