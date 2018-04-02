IMPLEMENTATION MODULE MLivros;

FROM Rotinas IMPORT LivrosRec, Ss, CHRS, TeladeFundo, Rodape,
Cores, SetaCor, Etexto, Formulario, Copy, Repete, 
AbrirArquivo, TamArquivo;
FROM Graficos IMPORT DesenhaBotao, Botao, DesenhaLista, Lista, Digita;
FROM StdStrings IMPORT String, Compare, CompareResult, Assign;
FROM UxFiles IMPORT File, Close, EndFile, SetPos, WriteNBytes, ReadNBytes;
FROM SYSTEM IMPORT ADR, TSIZE;
FROM IntStr IMPORT Alignment, Value, Give; 

(*******************Modulo de Acervos***********************)

(*
 Nome : PesLivros
 Descricao : funcao que pesquisa as informacoes contidas no arquivo de
 livros
 Parametros :
 tipo - indica se e o valor e (N)umerico ou (S)tring
 campo - qual o campo a ser pesquisado
 nCod2 - codigo do campo se numerico
 sCod2 - codigo do campo se String
 nTamsCod - tamanho caracteres do campo de String
*)
PROCEDURE PesLivros(Arq:File;tipo:CHAR;campo:String;nCod2:INTEGER;
                    sCod2:String;nTamsCod:INTEGER):INTEGER;
VAR
 nPosicao,nCod,nRet:INTEGER;
 sCod:String;
 bFlag:BOOLEAN;
 nBytes:CARDINAL;
BEGIN
SetPos(Arq,0);
nPosicao:=0;    
bFlag:=FALSE;
nCod:=0;
sCod:="";
LOOP
 IF NOT(EndFile(Arq)) THEN
   ReadNBytes(Arq,ADR(Livros),TSIZE(LivrosRec),nBytes);
   IF tipo='N' THEN
       IF Compare(campo,"Ninsc")=equal THEN
          nCod:=Livros.Ninsc;
       END;
       IF (nCod=nCod2) THEN
          nRet:=nPosicao;
          SetPos(Arq,TSIZE(LivrosRec)*nPosicao);
          bFlag:=TRUE;
          EXIT;
       END;
   ELSIF tipo='S' THEN
       IF Compare(campo,"Titulo")=equal THEN
          Assign(Livros.Titulo,sCod);
       ELSIF Compare(campo,"Area")=equal THEN
          Assign(Livros.Area,sCod);
       ELSIF Compare(campo,"Autor")=equal THEN
          Assign(Livros.Autor,sCod);
       ELSIF Compare(campo,"Pchave")=equal THEN
          Assign(Livros.PChave,sCod);
       END;
       IF Compare(Copy(sCod,1,nTamsCod),sCod2)=equal THEN
          nRet:=nPosicao;
          SetPos(Arq,TSIZE(LivrosRec)*nPosicao);
          bFlag:=TRUE;
          EXIT;
       END;
   END;
   nPosicao:=nPosicao+1;
 ELSE
   EXIT;
 END;
END;
 IF (EndFile(Arq)) AND (bFlag=FALSE) THEN
    RETURN(-1);
 END;
 RETURN(nRet);
END PesLivros;

(*-----------------------------------------------------*)

(*
 Nome : formLivros
 Descricao : procedimento que desenha o formulario de livros na tela, e
 tambem indica qual acao a tomar.
 Parametros :
 tipo - indica qual a acao do formulario
 titulo - o titulo do formulario
 rod - o texto do rodape sobre o formulario
*)
PROCEDURE formLivros(tipo:INTEGER;titulo,rod:String);
BEGIN
  TeladeFundo("±",WhiteFG,BlueBG);
  Rodape(rod," ",WhiteFG,BlueBG);  
  Formulario(Ss(CHRS(180),Ss(titulo,CHRS(195))),4,2,18,76,WhiteFG,BlueBG,"±",LightGrayFG,BlackBG);

  vLivros[1]:=Repete(" ",5);
  Atribuir_vLivros(TRUE);
  AbrirArquivo(1,LivrosFile);
  IF (tipo=1) OR (tipo=2) THEN
     Rotulos_formLivros(0);
     DesenhaBotao(20,45,BlackFG,LightGrayBG,BlackFG,BlueBG," Salvar ",FALSE);
     DesenhaBotao(20,60,BlackFG,LightGrayBG,BlackFG,BlueBG," Fechar ",FALSE);
  END;
  IF (tipo=3) OR (tipo=4) OR (tipo=5) OR (tipo=6) THEN
     DesenhaBotao(20,60,BlackFG,LightGrayBG,BlackFG,BlueBG," Fechar ",FALSE);
     Rotulos_formLivros(2);
     Etexto(2,7,WhiteFG,BlueBG,Ss("Ã",Ss(Repete(CHRS(196),75),"´")));
  END;
  IF tipo=7 THEN
     DesenhaBotao(20,60,BlackFG,LightGrayBG,BlackFG,BlueBG," Fechar ",FALSE);
  END;
  IF tipo=3 THEN
     Etexto(5,6,WhiteFG,BlueBG,"Titulo : ");
     Etexto(14,6,BlackFG,LightGrayBG,Repete(" ",30));
  END;
  IF tipo=4 THEN
     Etexto(5,6,WhiteFG,BlueBG,"Autor : ");
     Etexto(13,6,BlackFG,LightGrayBG,Repete(" ",30));
  END;
  IF tipo=5 THEN
     Etexto(5,6,WhiteFG,BlueBG,"Area : ");
     Etexto(12,6,BlackFG,LightGrayBG,Repete(" ",30));
  END;
  IF tipo=6 THEN
     Etexto(5,6,WhiteFG,BlueBG,"Palavra-Chave : ");
     Etexto(21,6,BlackFG,LightGrayBG,Repete(" ",10));
  END;

  Limpar_Livros;
  IF tipo=1 THEN
     Controles_formLivros("2",1,0,0,rod,FALSE);  (* cadastrar *)
  ELSIF tipo=2 THEN
     Controles_formLivros("1",2,0,0,rod,FALSE);  (* alterar *)
  ELSIF tipo=3 THEN
     Controles_formLivros("3",3,0,0,rod,FALSE); (* consultar por titulo *)
  ELSIF tipo=4 THEN
     Controles_formLivros("4",4,0,0,rod,FALSE); (* consultar por Autor *)
  ELSIF tipo=5 THEN
     Controles_formLivros("5",5,0,0,rod,FALSE); (* consultar por Area *)
  ELSIF tipo=6 THEN
     Controles_formLivros("6",6,0,0,rod,FALSE); (* consultar por Palavra-chave *)
  ELSIF tipo=7 THEN
     Controles_formLivros("7",7,0,0,rod,TRUE); (* consultar todos *)
  END;
END formLivros;

(*-------------------------------------------*)

(*
 Nome : Limpar_Livros
 Descricao : procedimento limpa as variaveis do registro de livros.
*)
PROCEDURE Limpar_Livros;
BEGIN
   WITH Livros DO
     Ninsc:=0;
     Titulo[0]:=00C;
     Autor[0]:=00C;
     Area[0]:=00C;
     PChave[0]:=00C;
     Edicao:=0;
     AnoPubli:=0;
     Editora[0]:=00C;
     Volume:=0;
     Estado:=' ';
   END;
END Limpar_Livros;

(*-------------------------------------------*)

(*
 Nome : Rotulos_formLivros
 Descricao : procedimento que escreve os rotulos do formulario de livros.
 Parametros :
 l - indica um acrescimo na linha do rotulo
*)
PROCEDURE Rotulos_formLivros(l:INTEGER);
BEGIN
  Etexto(5,6+l,WhiteFG,BlueBG,"Numero de Inscricao : ");
  Etexto(27,6+l,BlackFG,LightGrayBG,vLivros[1]);
  Etexto(35,6+l,WhiteFG,BlueBG,"Titulo : ");
  Etexto(44,6+l,BlackFG,LightGrayBG,vLivros[2]);
  Etexto(5,8+l,WhiteFG,BlueBG,"Autor : ");
  Etexto(13,8+l,BlackFG,LightGrayBG,vLivros[3]);
  Etexto(5,10+l,WhiteFG,BlueBG,"Area : ");
  Etexto(12,10+l,BlackFG,LightGrayBG,vLivros[4]);
  Etexto(5,12+l,WhiteFG,BlueBG,"Palavra-Chave : ");
  Etexto(21,12+l,BlackFG,LightGrayBG,vLivros[5]);
  Etexto(35,12+l,WhiteFG,BlueBG,"Edicao : ");
  Etexto(44,12+l,BlackFG,LightGrayBG,vLivros[6]);
  Etexto(5,14+l,WhiteFG,BlueBG,"Ano de Publicacao : ");
  Etexto(25,14+l,BlackFG,LightGrayBG,vLivros[7]);
  Etexto(35,14+l,WhiteFG,BlueBG,"Editora : ");
  Etexto(45,14+l,BlackFG,LightGrayBG,vLivros[8]);
  Etexto(5,16+l,WhiteFG,BlueBG,"Volume : ");
  Etexto(14,16+l,BlackFG,LightGrayBG,vLivros[9]);
  Etexto(22,16+l,WhiteFG,BlueBG,"Estado Atual : ");
  Etexto(37,16+l,BlackFG,LightGrayBG,vLivros[10]);
  Etexto(40,16+l,WhiteFG,BlueBG,"(D)isponivel ou (E)mprestado");

END Rotulos_formLivros;
(*-------------------------------------------*)

(*
 Nome : Controles_formLivros
 Descricao : procedimento que realiza todo o controle de manuseio do
 formulario de livros.
 Parametros :
 tipo - indica qual a acao do formulario
 tipo2 - indica a acao original do formulario nao manipulado pela funcao
 pos - indica a ultima posicao da linha da lista de livros
 col - indica a ultima posicao da coluna da lista de livros
 rod - o texto do rodape sobre o formulario
 foco - se os objetos do formulario estao focados ou nao
*)
PROCEDURE Controles_formLivros(tipo:String;tipo2,pos,col:INTEGER;rod:String;
                               foco:BOOLEAN);
VAR
 bFora:BOOLEAN;
BEGIN
IF Compare(tipo,"1")=equal THEN
      S[0]:=00C;
      Digita(S,5,5,28,5,BlackFG,LightGrayBG,'N',32); (* Ninsc *)
      I:=Value(S); 
      Livros.Ninsc:=I;
      IF (LENGTH(S) > 0) AND (Compare(S,Repete(" ",LENGTH(S)))<>equal) THEN
         DesenhaBotao(20,45,BlackFG,LightGrayBG,BlackFG,BlueBG," Salvar ",FALSE); 
         IF PesLivros(LivrosFile,'N',"Ninsc",I,"",0)<>-1 THEN
            Atribuir_vLivros(FALSE);
            Rotulos_formLivros(0);
            Rodape(rod," ",WhiteFG,BlueBG);
            Controles_formLivros("2",tipo2,pos,col,rod,FALSE);
         ELSE
            Give(S,I,1,left); 
            Atribuir_vLivros(TRUE);
            Rotulos_formLivros(0);
            Rodape("Numero de Inscricao, nao encontrado !"," ",YellowFG,RedBG);
            Controles_formLivros("Fechar",tipo2,pos,col,rod,TRUE);
         END;
      ELSE
        Controles_formLivros("Fechar",tipo2,pos,col,rod,TRUE);
      END;
ELSIF Compare(tipo,"2")=equal THEN
     WITH Livros DO
        IF tipo2=1 THEN
            nTamLivros:=TamArquivo(LivrosFile,ADR(Livros),TSIZE(LivrosRec)); 
            IF nTamLivros = 0 THEN
               Ninsc:=1
            ELSE               
               Ninsc:=nTamLivros + 1;
            END;
            I:=Ninsc;
            Give(S,Ninsc,1,left); 
            Etexto(27,6,BlackFG,LightGrayBG,S);
            S:="";
        ELSIF tipo2=2 THEN
            AbrirArquivo(1,LivrosFile);
            IF PesLivros(LivrosFile,'N',"Ninsc",I,"",0)=-1 THEN
              Rodape("Numero de Inscricao, nao encontrado !"," ",YellowFG,RedBG);
            END;
        END;
          Digita_formLivros;
     END;
      Controles_formLivros("Salvar",tipo2,pos,col,rod,TRUE);
ELSIF Compare(tipo,"3")=equal THEN
      S[0]:=00C;
      Digita(S,30,30,15,5,BlackFG,LightGrayBG,'T',32);
      Assign(S,Livros.Titulo);
      IF (LENGTH(S) > 0) AND (Compare(S,Repete(" ",LENGTH(S)))<>equal) THEN
         IF PesLivros(LivrosFile,'S',"Titulo",0,S,LENGTH(S))<>-1 THEN
            Atribuir_vLivros(FALSE);
            Rotulos_formLivros(2);
            Rodape(rod," ",WhiteFG,BlueBG);
         ELSE
            Atribuir_vLivros(TRUE);
            Rotulos_formLivros(2);
            Rodape("Titulo do Livro, nao encontrado !"," ",YellowFG,RedBG);
         END;
      END;
        Controles_formLivros("Fechar",tipo2,pos,col,rod,TRUE);
ELSIF Compare(tipo,"4")=equal THEN
      S[0]:=00C;
      Digita(S,30,30,14,5,BlackFG,LightGrayBG,'T',32);
      Assign(S,Livros.Autor);
      IF (LENGTH(S) > 0) AND (Compare(S,Repete(" ",LENGTH(S)))<>equal) THEN
         IF PesLivros(LivrosFile,'S',"Autor",0,S,LENGTH(S))<>-1 THEN
            Atribuir_vLivros(FALSE);
            Rotulos_formLivros(2);
            Rodape(rod," ",WhiteFG,BlueBG);
         ELSE
            Atribuir_vLivros(TRUE);
            Rotulos_formLivros(2);
            Rodape("Autor do Livro, nao encontrado !"," ",YellowFG,RedBG);
         END;
      END;
        Controles_formLivros("Fechar",tipo2,pos,col,rod,TRUE);
ELSIF Compare(tipo,"5")=equal THEN
      S[0]:=00C;
      Digita(S,4,4,13,5,BlackFG,LightGrayBG,'T',32);
      Assign(S,Livros.Area);
      IF (LENGTH(S) > 0) AND (Compare(S,Repete(" ",LENGTH(S)))<>equal) THEN
         IF PesLivros(LivrosFile,'S',"Area",0,S,LENGTH(S))<>-1 THEN
            Atribuir_vLivros(FALSE);
            Rotulos_formLivros(2);
            Rodape(rod," ",WhiteFG,BlueBG);
         ELSE
            Atribuir_vLivros(TRUE);
            Rotulos_formLivros(2);
            Rodape("Area do Livro, nao encontrada !"," ",YellowFG,RedBG);
         END;
      END;
        Controles_formLivros("Fechar",tipo2,pos,col,rod,TRUE);
ELSIF Compare(tipo,"6")=equal THEN
      S[0]:=00C;
      Digita(S,10,10,22,5,BlackFG,LightGrayBG,'T',32);
      Assign(S,Livros.PChave);
      IF (LENGTH(S) > 0) AND (Compare(S,Repete(" ",LENGTH(S)))<>equal) THEN
         IF PesLivros(LivrosFile,'S',"PChave",0,S,LENGTH(S))<>-1 THEN
            Atribuir_vLivros(FALSE);
            Rotulos_formLivros(2);
            Rodape(rod," ",WhiteFG,BlueBG);
         ELSE
            Atribuir_vLivros(TRUE);
            Rotulos_formLivros(2);
            Rodape("Palavra-Chave do Livro, nao encontrado !"," ",YellowFG,RedBG);
         END;
      END;
        Controles_formLivros("Fechar",tipo2,pos,col,rod,TRUE);
ELSIF Compare(tipo,"7")=equal THEN
    nTamLivros:=TamArquivo(LivrosFile,ADR(Livros),TSIZE(LivrosRec)); 
    IF Lista(1,6,5,13,70,nTamLivros+2,220,nTamLivros,WhiteFG,BlueBG,pos,col,foco,
             vLista,LivrosFile)=1 THEN
       DesenhaLista(1,6,5,13,70,WhiteFG,BlueBG,pos,col,nTamLivros,FALSE,
       vLista,LivrosFile);
       Controles_formLivros("Fechar",tipo2,pos,col,rod,TRUE);
    END;
ELSIF Compare(tipo,"Salvar")=equal THEN
    CASE Botao(20,45,BlackFG,LightGrayBG,BlackFG,BlueBG," Salvar ",foco) OF
    | 1: DesenhaBotao(20,45,BlackFG,LightGrayBG,BlackFG,BlueBG," Salvar ",FALSE);
         Controles_formLivros("Fechar",tipo2,pos,col,rod,TRUE);
    | 2: SalvarLivros(tipo2);
         DesenhaBotao(20,45,BlackFG,LightGrayBG,BlackFG,BlueBG," Salvar ",FALSE);
         Controles_formLivros("Fechar",tipo2,pos,col,rod,TRUE);
    END;
ELSIF Compare(tipo,"Fechar")=equal THEN
    CASE Botao(20,60,BlackFG,LightGrayBG,BlackFG,BlueBG," Fechar ",foco) OF
    | 1:  DesenhaBotao(20,60,BlackFG,LightGrayBG,BlackFG,BlueBG," Fechar ",FALSE);
          IF tipo2=1 THEN
            Controles_formLivros("2",tipo2,pos,col,rod,TRUE);
          ELSIF tipo2=2 THEN
            Controles_formLivros("1",tipo2,pos,col,rod,FALSE);
          ELSIF tipo2=3 THEN
            Controles_formLivros("3",tipo2,pos,col,rod,FALSE);
          ELSIF tipo2=4 THEN
            Controles_formLivros("4",tipo2,pos,col,rod,FALSE);
          ELSIF tipo2=5 THEN
            Controles_formLivros("5",tipo2,pos,col,rod,FALSE);
          ELSIF tipo2=6 THEN
            Controles_formLivros("6",tipo2,pos,col,rod,FALSE);
          ELSIF tipo2=7 THEN
            Controles_formLivros("7",tipo2,pos,col,rod,TRUE);
          END;
    | 2: Rodape(""," ",WhiteFG,BlueBG);
         Close(LivrosFile,bFora);
    END;
END;

END Controles_formLivros;

(*-------------------------------------------------------*)

(*
 Nome : Atribuir_vLivros
 Descricao : procedimento que atribui ou limpa o vetor de livros.
 Parametros :
 limpar - indica se vai limpar ou atribuir os vetores
*)
PROCEDURE Atribuir_vLivros(limpar:BOOLEAN);
BEGIN
IF limpar=FALSE THEN
  WITH Livros DO
      Give(S,Ninsc,1,left); 
      vLivros[1]:=S;
      Assign(Titulo,vLivros[2]);
      Assign(Autor,vLivros[3]);
      Assign(Area,vLivros[4]);
      Assign(PChave,vLivros[5]);
      Give(S,Edicao,1,left); 
      vLivros[6]:=S;
      Give(S,AnoPubli,1,left); 
      vLivros[7]:=S;
      Assign(Editora,vLivros[8]);
      Give(S,Volume,1,left); 
      vLivros[9]:=S;
      vLivros[10][0]:=Estado;
  END;
ELSE
  vLivros[2]:=Repete(" ",30);
  vLivros[3]:=Repete(" ",30);
  vLivros[4]:=Repete(" ",30);
  vLivros[5]:=Repete(" ",10);
  vLivros[6]:=Repete(" ",4);
  vLivros[7]:=Repete(" ",4);
  vLivros[8]:=Repete(" ",30);
  vLivros[9]:=Repete(" ",4);
  vLivros[10]:=Repete(" ",1);
END;

END Atribuir_vLivros;

(*-------------------------------------------------------*)

(*
 Nome : Digita_formLivros
 Descricao : procedimento que realiza o cotrole de digitacao dos dados no
 formulario de livros.
*)
PROCEDURE Digita_formLivros;
BEGIN
     WITH Livros DO
        Assign(Titulo,S);
        Digita(S,30,30,45,5,BlackFG,LightGrayBG,'T',32);
        Assign(S,Titulo);
        Assign(Autor,S);
        Digita(S,30,30,14,7,BlackFG,LightGrayBG,'T',32);
        Assign(S,Autor);
        Assign(Area,S);
        Digita(S,30,30,13,9,BlackFG,LightGrayBG,'T',32);
        Assign(S,Area);
        Assign(PChave,S);
        Digita(S,10,10,22,11,BlackFG,LightGrayBG,'T',32);
        Assign(S,PChave);
        Give(S,Edicao,1,left); 
        Digita(S,4,4,45,11,BlackFG,LightGrayBG,'N',32);
        I:=Value(S); 
        Edicao:=I;
        Give(S,AnoPubli,1,left); 
        Digita(S,4,4,26,13,BlackFG,LightGrayBG,'N',32);
        I:=Value(S); 
        AnoPubli:=I;
        Assign(Editora,S);
        Digita(S,30,30,46,13,BlackFG,LightGrayBG,'T',32);
        Assign(S,Editora);
        Give(S,Volume,1,left); 
        Digita(S,4,4,15,15,BlackFG,LightGrayBG,'N',32);
        I:=Value(S); 
        Volume:=I;
        S[0]:=Estado;
        Digita(S,1,1,38,15,BlackFG,LightGrayBG,'T',32);
        Estado:=S[0];
        S[0]:=00C;
     END;
END Digita_formLivros;

(*-------------------------------------------------------*)

(*
 Nome : VerificaLivros
 Descricao : funcao que verifica se os dados no formulario de livros
 foram digitados.
*)
PROCEDURE VerificaLivros():BOOLEAN;
BEGIN
WITH Livros DO
  Give(S,Ninsc,1,left); 
  IF (LENGTH(S) = 0) AND (Compare(S,Repete(" ",LENGTH(S)))=equal) THEN
     Rodape("Numero de Inscricao, nao cadastrado !"," ",YellowFG,RedBG);
     RETURN(FALSE);
  END;
  IF (LENGTH(Titulo) = 0) AND (Compare(Titulo,Repete(" ",LENGTH(Titulo)))=equal) THEN
      Rodape("Titulo, nao cadastrado !"," ",YellowFG,RedBG);
      RETURN(FALSE);
  END;
  IF (LENGTH(Autor) = 0) AND (Compare(Autor,Repete(" ",LENGTH(Autor)))=equal) THEN
      Rodape("Autor, nao cadastrado !"," ",YellowFG,RedBG);
      RETURN(FALSE);
  END;
  IF (LENGTH(Area) = 0) AND (Compare(Area,Repete(" ",LENGTH(Area)))=equal) THEN
      Rodape("Area, nao cadastrada !"," ",YellowFG,RedBG);
      RETURN(FALSE);
  END;
  IF (LENGTH(PChave) = 0) AND (Compare(PChave,Repete(" ",LENGTH(PChave)))=equal) THEN
      Rodape("Palavra-Chave, nao cadastrada !"," ",YellowFG,RedBG);
      RETURN(FALSE);
  END;
  Give(S,Edicao,1,left); 
  IF (LENGTH(S) = 0) AND (Compare(S,Repete(" ",LENGTH(S)))=equal) THEN
      Rodape("Edicao, nao cadastrada !"," ",YellowFG,RedBG);
      RETURN(FALSE);
  END;
  Give(S,AnoPubli,1,left); 
  IF (LENGTH(S) = 0) AND (Compare(S,Repete(" ",LENGTH(S)))=equal) THEN
      Rodape("Ano de Publicacao, nao cadastrado !"," ",YellowFG,RedBG);
      RETURN(FALSE);
  END;
  IF (LENGTH(Editora) = 0) AND (Compare(Editora,Repete(" ",LENGTH(Editora)))=equal) THEN
      Rodape("Editora, nao cadastrada !"," ",YellowFG,RedBG);
      RETURN(FALSE);
  END;
  Give(S,Volume,1,left); 
  IF (LENGTH(S) = 0) AND (Compare(S,Repete(" ",LENGTH(S)))=equal) THEN
      Rodape("Volume, nao cadastrado !"," ",YellowFG,RedBG);
      RETURN(FALSE);
  END;
  IF Estado = ' ' THEN
      Rodape("Estado, nao cadastrado !"," ",YellowFG,RedBG);
      RETURN(FALSE);
  END;
END;
 RETURN(TRUE);
END VerificaLivros;

(*---------------------------------------------------------------*)

(*
 Nome : SalvarLivros
 Descricao : procedimento que salva os dados digitados no
 formulario de livros.
 Parametros :
 tipo - indica qual acao a Salvar
*)
PROCEDURE SalvarLivros(tipo:INTEGER);
VAR
  nBytes:CARDINAL;
BEGIN
IF VerificaLivros()=TRUE THEN
 IF (Livros.Estado='D') OR (Livros.Estado='E') THEN
    IF tipo=1 THEN
        nTamLivros:=TamArquivo(LivrosFile,ADR(Livros),TSIZE(LivrosRec));
        SetPos(LivrosFile,ABS(TSIZE(LivrosRec)*nTamLivros)); 
        WriteNBytes(LivrosFile,ADR(Livros),TSIZE(LivrosRec),nBytes);
        Atribuir_vLivros(TRUE);
        Rotulos_formLivros(0);
        Limpar_Livros;
    ELSIF tipo=2 THEN
        WriteNBytes(LivrosFile,ADR(Livros),TSIZE(LivrosRec),nBytes);
    END;
 ELSE
    Rodape("Estado Atual, Cadastrado Incorretamente !"," ",YellowFG,RedBG);
 END;
END;

END SalvarLivros;

END MLivros.
