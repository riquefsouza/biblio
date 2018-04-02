IMPLEMENTATION MODULE MUsuario;

FROM Rotinas IMPORT UsuariosRec, Ss, CHRS, TeladeFundo, Rodape,
Cores, SetaCor, Etexto, Formulario, Copy, Repete, 
AbrirArquivo, TamArquivo;
FROM Graficos IMPORT DesenhaBotao, Botao, DesenhaLista, Lista, Digita;
FROM StdStrings IMPORT String, Compare, CompareResult, Assign;
FROM UxFiles IMPORT File, Close, EndFile, SetPos, WriteNBytes, ReadNBytes;
FROM SYSTEM IMPORT ADR, TSIZE;
FROM IntStr IMPORT Alignment, Value, Give; 

(*******************Modulo de Usuarios***********************)

(*
 Nome : PesUsuarios
 Descricao : funcao que pesquisa as informacoes contidas no arquivo de
 usuarios.
 Parametros :
 tipo - indica se e o valor e (N)umerico ou (S)tring
 campo - qual o campo a ser pesquisado
 nCod2 - codigo do campo se numerico
 sCod2 - codigo do campo se String
 nTamsCod - tamanho caracteres do campo de String
*)
PROCEDURE PesUsuarios(Arq:File;tipo:CHAR;campo:String;nCod2:INTEGER;sCod2:String;
                     nTamsCod:INTEGER):INTEGER;
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
   ReadNBytes(Arq,ADR(Usuarios),TSIZE(UsuariosRec),nBytes);
   IF tipo='N' THEN
       IF Compare(campo,"Ninsc")=equal THEN
          nCod:=Usuarios.Ninsc;
       END;
       IF (nCod=nCod2) THEN
          nRet:=nPosicao;
          SetPos(Arq,TSIZE(UsuariosRec)*nPosicao);
          bFlag:=TRUE;
          EXIT;
       END
   ELSIF tipo='S' THEN
       IF Compare(campo,"Nome")=equal THEN
          Assign(Usuarios.Nome,sCod);
       ELSIF Compare(campo,"Ident")=equal THEN
          Assign(Usuarios.Ident,sCod);
       END;
       IF Compare(Copy(sCod,1,nTamsCod),sCod2)=equal THEN
          nRet:=nPosicao;
          SetPos(Arq,TSIZE(UsuariosRec)*nPosicao);
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
END PesUsuarios;

(*-----------------------------------------------------*)

(*
 Nome : PesBinaria
 Descricao : funcao que realiza uma pesquisa binaria
 por numero de inscricao do usuario.
 Parametros :
 Chave - numero de inscricao do usuario a pesquisar
*)
PROCEDURE PesBinaria(Chave:INTEGER):INTEGER;
VAR
 inicio,fim,meio:INTEGER;
 achou:BOOLEAN;
 nBytes:CARDINAL;
BEGIN
 inicio:=1;
 fim:=nTamUsuarios+1;
 achou:=FALSE;
 WHILE (NOT(achou) AND (inicio <= fim)) DO
   meio:=ABS((inicio+fim) DIV 2);
   SetPos(UsuariosFile,TSIZE(UsuariosRec)*(meio-1));
   ReadNBytes(UsuariosFile,ADR(Usuarios),TSIZE(UsuariosRec),nBytes);
   IF (Chave=Usuarios.Ninsc) THEN
      achou:=TRUE
   ELSE
      IF (Chave > Usuarios.Ninsc) THEN
        inicio:=meio+1
      ELSE
        fim:=meio-1;
      END;
   END;
 END;
 IF achou=TRUE THEN
    RETURN(meio-1);
 ELSE
    RETURN(-1);
 END;
END PesBinaria;

(*-----------------------------------------------------*)

(*
 Nome : formUsuarios
 Descricao : procedimento que desenha o formulario de Usuarios na tela, e
 tambem indica qual acao a tomar.
 Parametros :
 tipo - indica qual a acao do formulario
 titulo - o titulo do formulario
 rod - o texto do rodape sobre o formulario
*)
PROCEDURE formUsuarios(tipo:INTEGER;titulo,rod:String);
BEGIN
  TeladeFundo("±",WhiteFG,BlueBG);
  Rodape(rod," ",WhiteFG,BlueBG);
  Formulario(Ss(CHRS(180),Ss(titulo,CHRS(195))),4,2,18,76,WhiteFG,BlueBG,"±",LightGrayFG,BlackBG);

  Assign(Repete(" ",5),vUsuarios[1]);
  Atribuir_vUsuarios(TRUE);
  AbrirArquivo(2,UsuariosFile);
  IF (tipo=1) OR (tipo=2) THEN
     Rotulos_formUsuarios(0);
     DesenhaBotao(20,48,BlackFG,LightGrayBG,BlackFG,BlueBG," Salvar ",FALSE);
     DesenhaBotao(20,63,BlackFG,LightGrayBG,BlackFG,BlueBG," Fechar ",FALSE);
  END;
  IF (tipo=3) OR (tipo=4) OR (tipo=5) THEN
     DesenhaBotao(20,63,BlackFG,LightGrayBG,BlackFG,BlueBG," Fechar ",FALSE);
     Rotulos_formUsuarios(2);
     Etexto(2,7,WhiteFG,BlueBG,Ss("Ã",Ss(Repete(CHRS(196),75),"´")));
  END;
  IF tipo=6 THEN
     DesenhaBotao(20,63,BlackFG,LightGrayBG,BlackFG,BlueBG," Fechar ",FALSE);
  END;
  IF tipo=3 THEN
     Etexto(5,6,WhiteFG,BlueBG,"Numero de Inscricao : ");
     Etexto(27,6,BlackFG,LightGrayBG,Repete(" ",5));
  END;
  IF tipo=4 THEN
     Etexto(5,6,WhiteFG,BlueBG,"Nome : ");
     Etexto(12,6,BlackFG,LightGrayBG,Repete(" ",30));
  END;
  IF tipo=5 THEN
     Etexto(5,6,WhiteFG,BlueBG,"Identidade : ");
     Etexto(18,6,BlackFG,LightGrayBG,Repete(" ",10));
  END;

  Limpar_Usuarios;
  IF tipo=1 THEN
     Controles_formUsuarios("2",1,0,0,rod,FALSE);  (* cadastrar *)
  ELSIF tipo=2 THEN
     Controles_formUsuarios("1",2,0,0,rod,FALSE);  (* alterar *)
  ELSIF tipo=3 THEN
     Controles_formUsuarios("3",3,0,0,rod,FALSE); (* consultar por NInsc *)
  ELSIF tipo=4 THEN
     Controles_formUsuarios("4",4,0,0,rod,FALSE); (* consultar por Nome *)
  ELSIF tipo=5 THEN
     Controles_formUsuarios("5",5,0,0,rod,FALSE); (* consultar por Identidade *)
  ELSIF tipo=6 THEN
     Controles_formUsuarios("6",6,0,0,rod,TRUE); (* consultar todos *)
  END;
END formUsuarios;

(*-------------------------------------------*)

(*
 Nome : Limpar_Usuarios
 Descricao : procedimento limpa as variaveis do registro de usuarios.
*)
PROCEDURE Limpar_Usuarios;
BEGIN
   WITH Usuarios DO
     Ninsc:=0;
     Nome[0]:=00C;
     Ident:="0";
     Endereco.Logra[0]:=00C;
     Endereco.Numero:=0;
     Endereco.Compl[0]:=00C;
     Endereco.Bairro[0]:=00C;
     Endereco.Cep:="0";
     Telefone:="0";
     Categoria:=' ';
     Situacao:=0;
   END;
END Limpar_Usuarios;

(*-------------------------------------------*)

(*
 Nome : Rotulos_formUsuarios
 Descricao : procedimento que escreve os rotulos do Formulario de Usuarios.
 Parametros :
 l - indica um acrescimo na linha do rotulo
*)
PROCEDURE Rotulos_formUsuarios(l:INTEGER);
BEGIN
  Etexto(5,6+l,WhiteFG,BlueBG,"Numero de Inscricao : ");
  Etexto(27,6+l,BlackFG,LightGrayBG,vUsuarios[1]);
  Etexto(35,6+l,WhiteFG,BlueBG,"Nome : ");
  Etexto(42,6+l,BlackFG,LightGrayBG,vUsuarios[2]);
  Etexto(5,8+l,WhiteFG,BlueBG,"Identidade : ");
  Etexto(18,8+l,BlackFG,LightGrayBG,vUsuarios[3]);
  Etexto(2,10+l,WhiteFG,BlueBG,Ss(CHRS(195),Ss(Repete("Ä",75),CHRS(180))));
  Etexto(5,10+l,WhiteFG,BlueBG,"Endereco");
  Etexto(5,12+l,WhiteFG,BlueBG,"Logradouro : ");
  Etexto(18,12+l,BlackFG,LightGrayBG,vUsuarios[4]);
  Etexto(51,12+l,WhiteFG,BlueBG,"Numero : ");
  Etexto(60,12+l,BlackFG,LightGrayBG,vUsuarios[5]);
  Etexto(5,14+l,WhiteFG,BlueBG,"Complemento : ");
  Etexto(19,14+l,BlackFG,LightGrayBG,vUsuarios[6]);
  Etexto(32,14+l,WhiteFG,BlueBG,"Bairro : ");
  Etexto(41,14+l,BlackFG,LightGrayBG,vUsuarios[7]);
  Etexto(63,14+l,WhiteFG,BlueBG,"Cep : ");
  Etexto(69,14+l,BlackFG,LightGrayBG,vUsuarios[8]);
  Etexto(2,16+l,WhiteFG,BlueBG,Ss(CHRS(195),Ss(Repete("Ä",75),CHRS(180))));
  Etexto(31,8+l,WhiteFG,BlueBG,"Telefone : ");
  Etexto(42,8+l,BlackFG,LightGrayBG,vUsuarios[9]);
  Etexto(5,17+l,WhiteFG,BlueBG,"Categoria : ");
  Etexto(17,17+l,BlackFG,LightGrayBG,vUsuarios[10]);
  Etexto(20,17+l,WhiteFG,BlueBG,"(A)luno ou (P)rofessor ou (F)uncionario");
  Etexto(5,19+l,WhiteFG,BlueBG,"Situacao : ");
  Etexto(16,19+l,BlackFG,LightGrayBG,vUsuarios[11]);

END Rotulos_formUsuarios;

(*-------------------------------------------*)

(*
 Nome : Controles_formUsuarios
 Descricao : procedimento que realiza todo o controle de manuseio do
 Formulario de Usuarios.
 Parametros :
 tipo - indica qual a acao do Formulario
 tipo2 - indica a acao original do Formulario nao manipulado pela funcao
 pos - indica a ultima posicao da linha da lista de usuarios
 col - indica a ultima posicao da coluna da lista de usuarios
 rod - o texto do Rodape sobre o Formulario
 foco - se os objetos do Formulario estao focados ou nao
*)
PROCEDURE Controles_formUsuarios(tipo:String;tipo2,pos,col:INTEGER;
                                 rod:String;foco:BOOLEAN);
VAR
 bFora:BOOLEAN;
BEGIN
IF Compare(tipo,"1")=equal THEN
      S[0]:=00C;
      Digita(S,5,5,28,5,BlackFG,LightGrayBG,'N',32); (* N insc *)
      I:=Value(S); 
      Usuarios.Ninsc:=I;
      IF (LENGTH(S) > 0) AND (Compare(S,Repete(" ",LENGTH(S)))<>equal) THEN
         DesenhaBotao(20,48,BlackFG,LightGrayBG,BlackFG,BlueBG," Salvar ",FALSE);
         IF PesUsuarios(UsuariosFile,'N',"Ninsc",I,"",0)<>-1 THEN
            Atribuir_vUsuarios(FALSE);
            Rotulos_formUsuarios(0);
            Rodape(rod," ",WhiteFG,BlueBG);
            Controles_formUsuarios("2",tipo2,pos,col,rod,FALSE);
         ELSE
            Give(S,I,1,left); 
            Atribuir_vUsuarios(TRUE);
            Rotulos_formUsuarios(0);
            Rodape("Numero de Inscricao, nao encontrado !"," ",YellowFG,RedBG);
            Controles_formUsuarios("Fechar",tipo2,pos,col,rod,TRUE);
         END;
      ELSE
        Controles_formUsuarios("Fechar",tipo2,pos,col,rod,TRUE);
      END;
ELSIF Compare(tipo,"2")=equal THEN
     WITH Usuarios DO
        IF tipo2=1 THEN
            nTamUsuarios:=TamArquivo(UsuariosFile,ADR(Usuarios),TSIZE(UsuariosRec)); 
            IF nTamUsuarios = 0 THEN
               Ninsc:=1;
            ELSE
               Ninsc:=nTamUsuarios + 1;
            END;
            I:=Ninsc;
            Give(S,Ninsc,1,left); 
            Etexto(27,6,BlackFG,LightGrayBG,S);
            S[0]:=00C;
        ELSIF tipo2=2 THEN
            AbrirArquivo(2,UsuariosFile);
            IF PesUsuarios(UsuariosFile,'N',"Ninsc",I,"",0)=-1 THEN
              Rodape("Numero de Inscricao, nao encontrado !"," ",YellowFG,RedBG);
            END;
        END;
          Digita_formUsuarios;
     END;
      Controles_formUsuarios("Salvar",tipo2,pos,col,rod,TRUE);

ELSIF Compare(tipo,"3")=equal THEN
      S[0]:=00C;
      Digita(S,5,5,28,5,BlackFG,LightGrayBG,'N',32); (* N insc *)
      I:=Value(S); 
      Usuarios.Ninsc:=I;
      IF (LENGTH(S) > 0) AND (Compare(S,Repete(" ",LENGTH(S)))<>equal) THEN
         IF PesBinaria(I)<>-1 THEN
            Atribuir_vUsuarios(FALSE);
            Rotulos_formUsuarios(2);
            Rodape(rod," ",WhiteFG,BlueBG);
         ELSE
            Atribuir_vUsuarios(TRUE);
            Rotulos_formUsuarios(2);
            Rodape("Numero de Inscricao, nao encontrado !"," ",YellowFG,RedBG);
         END;
      END;
      Controles_formUsuarios("Fechar",tipo2,pos,col,rod,TRUE);
ELSIF Compare(tipo,"4")=equal THEN
      S[0]:=00C;
      Digita(S,30,30,13,5,BlackFG,LightGrayBG,'T',32);
      Assign(S,Usuarios.Nome);
      IF (LENGTH(S) > 0) AND (Compare(S,Repete(" ",LENGTH(S)))<>equal) THEN
         IF PesUsuarios(UsuariosFile,'S',"Nome",0,S,LENGTH(S))<>-1 THEN
            Atribuir_vUsuarios(FALSE);
            Rotulos_formUsuarios(2);
            Rodape(rod," ",WhiteFG,BlueBG);
         ELSE
            Atribuir_vUsuarios(TRUE);
            Rotulos_formUsuarios(2);
            Rodape("Nome do Usuario, nao encontrado !"," ",YellowFG,RedBG);
         END;
      END;
      Controles_formUsuarios("Fechar",tipo2,pos,col,rod,TRUE);
ELSIF Compare(tipo,"5")=equal THEN
      S[0]:=00C;
      Digita(S,10,10,19,5,BlackFG,LightGrayBG,'N',32);
      Assign(S,Usuarios.Ident);
      IF (LENGTH(S) > 0) AND (Compare(S,Repete(" ",LENGTH(S)))<>equal) THEN
         IF PesUsuarios(UsuariosFile,'N',"Ident",0,S,LENGTH(S))<>-1 THEN
            Atribuir_vUsuarios(FALSE);
            Rotulos_formUsuarios(2);
            Rodape(rod," ",WhiteFG,BlueBG);
         ELSE
            Atribuir_vUsuarios(TRUE);
            Rotulos_formUsuarios(2);
            Rodape("Identidade do Usuario, nao encontrada !"," ",YellowFG,RedBG);
         END;
      END;
      Controles_formUsuarios("Fechar",tipo2,pos,col,rod,TRUE);
ELSIF Compare(tipo,"6")=equal THEN
 nTamUsuarios:=TamArquivo(UsuariosFile,ADR(Usuarios),TSIZE(UsuariosRec)); 
 IF Lista(2,6,5,13,70,nTamUsuarios+2,194,nTamUsuarios,WhiteFG,BlueBG,pos,col,foco,
    vLista,UsuariosFile)=1 THEN
    DesenhaLista(2,6,5,13,70,WhiteFG,BlueBG,pos,col,nTamUsuarios,FALSE,
    vLista,UsuariosFile);
    Controles_formUsuarios("Fechar",tipo2,pos,col,rod,TRUE);
 END;
ELSIF Compare(tipo,"Salvar")=equal THEN
    CASE Botao(20,48,BlackFG,LightGrayBG,BlackFG,BlueBG," Salvar ",foco) OF
    | 1: DesenhaBotao(20,48,BlackFG,LightGrayBG,BlackFG,BlueBG," Salvar ",FALSE);
         Controles_formUsuarios("Fechar",tipo2,pos,col,rod,TRUE);
    | 2: SalvarUsuarios(tipo2);
         DesenhaBotao(20,48,BlackFG,LightGrayBG,BlackFG,BlueBG," Salvar ",FALSE);
         Controles_formUsuarios("Fechar",tipo2,pos,col,rod,TRUE);
    END;
ELSIF Compare(tipo,"Fechar")=equal THEN
    CASE Botao(20,63,BlackFG,LightGrayBG,BlackFG,BlueBG," Fechar ",foco) OF
    | 1:  DesenhaBotao(20,63,BlackFG,LightGrayBG,BlackFG,BlueBG," Fechar ",FALSE);
          IF tipo2=1 THEN
            Controles_formUsuarios("2",tipo2,pos,col,rod,TRUE);
          ELSIF tipo2=2 THEN
            Controles_formUsuarios("1",tipo2,pos,col,rod,FALSE);
          ELSIF tipo2=3 THEN
            Controles_formUsuarios("3",tipo2,pos,col,rod,FALSE);
          ELSIF tipo2=4 THEN
            Controles_formUsuarios("4",tipo2,pos,col,rod,FALSE);
          ELSIF tipo2=5 THEN
            Controles_formUsuarios("5",tipo2,pos,col,rod,FALSE);
          ELSIF tipo2=6 THEN
            Controles_formUsuarios("6",tipo2,pos,col,rod,TRUE);
          END;
    | 2: Rodape(""," ",WhiteFG,BlueBG);
         Close(UsuariosFile,bFora);
    END;
END;

END Controles_formUsuarios;

(*-------------------------------------------------------*)

(*
 Nome : Atribuir_vUsuarios
 Descricao : procedimento que atribui ou limpa o vetor de Usuarios.
 Parametros :
 limpar - indica se vai limpar ou atribuir os vetores
*)
PROCEDURE Atribuir_vUsuarios(limpar:BOOLEAN);
BEGIN
IF limpar=FALSE THEN
  WITH Usuarios DO
      Give(S,Ninsc,1,left); 
      vUsuarios[1]:=S;
      Assign(Nome,vUsuarios[2]);
      Assign(Ident,vUsuarios[3]);
      Assign(Endereco.Logra,vUsuarios[4]);
      Give(S,Endereco.Numero,1,left); 
      vUsuarios[5]:=S;
      Assign(Endereco.Compl,vUsuarios[6]);
      Assign(Endereco.Bairro,vUsuarios[7]);
      Assign(Endereco.Cep,vUsuarios[8]);
      Assign(Telefone,vUsuarios[9]);
      vUsuarios[10][0]:=Categoria;
      Give(S,Situacao,1,left); 
      vUsuarios[11][0]:=S[0];
  END;
ELSE
  vUsuarios[2]:=Repete(" ",30);
  vUsuarios[3]:=Repete(" ",10);
  vUsuarios[4]:=Repete(" ",30);
  vUsuarios[5]:=Repete(" ",5);
  vUsuarios[6]:=Repete(" ",10);
  vUsuarios[7]:=Repete(" ",20);
  vUsuarios[8]:=Repete(" ",8);
  vUsuarios[9]:=Repete(" ",11);
  vUsuarios[10]:=Repete(" ",1);
  vUsuarios[11]:=Repete(" ",1);
END;
END Atribuir_vUsuarios;

(*-------------------------------------------------------*)

(*
 Nome : Digita_formUsuarios
 Descricao : procedimento que realiza o cotrole de digitacao dos dados no
 Formulario de usuarios.
*)
PROCEDURE Digita_formUsuarios;
BEGIN
     WITH Usuarios DO
        Assign(Nome,S);
        Digita(S,30,30,43,5,BlackFG,LightGrayBG,'T',32);
        Assign(S,Nome);
        Assign(Ident,S);
        Digita(S,10,10,19,7,BlackFG,LightGrayBG,'N',32);
        Assign(S,Ident);
        Assign(Telefone,S);
        Digita(S,11,11,43,7,BlackFG,LightGrayBG,'N',32);
        Assign(S,Telefone);
        Assign(Endereco.Logra,S);
        Digita(S,30,30,19,11,BlackFG,LightGrayBG,'T',32);
        Assign(S,Endereco.Logra);
        Give(S,Endereco.Numero,1,left); 
        Digita(S,5,5,61,11,BlackFG,LightGrayBG,'N',32);
        I:=Value(S); 
        Endereco.Numero:=I;
        Assign(Endereco.Compl,S);
        Digita(S,10,10,20,13,BlackFG,LightGrayBG,'T',32);
        Assign(S,Endereco.Compl);
        Assign(Endereco.Bairro,S);
        Digita(S,20,20,42,13,BlackFG,LightGrayBG,'T',32);
        Assign(S,Endereco.Bairro);
        Assign(Endereco.Cep,S);
        Digita(S,8,8,70,13,BlackFG,LightGrayBG,'N',32);
        Assign(S,Endereco.Cep);
        S[0]:=Categoria;
        Digita(S,1,1,18,16,BlackFG,LightGrayBG,'T',32);
        Categoria:=S[0];
        Give(S,Situacao,1,left); 
        Digita(S,1,1,17,18,BlackFG,LightGrayBG,'N',32);
        I:=Value(S); 
        Situacao:=I;
        S[0]:=00C;
     END;
END Digita_formUsuarios;

(*-------------------------------------------------------*)

(*
 Nome : VerificaUsuarios
 Descricao : funcao que verifica se os dados no Formulario de usuarios
 foram digitados.
*)
PROCEDURE VerificaUsuarios():BOOLEAN;
BEGIN
WITH Usuarios DO
  Give(S,Ninsc,1,left); 
  IF (LENGTH(S) = 0) AND (Compare(S,Repete(" ",LENGTH(S)))=equal) THEN
     Rodape("Numero de Inscricao, nao cadastrado !"," ",YellowFG,RedBG);
     RETURN(FALSE);
  END;
  IF (LENGTH(Nome) = 0) AND (Compare(Nome,Repete(" ",LENGTH(Nome)))=equal) THEN
      Rodape("Nome do Usuario, nao cadastrado !"," ",YellowFG,RedBG);
      RETURN(FALSE);
  END;
  IF (LENGTH(Ident) = 0) AND (Compare(Ident,Repete(" ",LENGTH(Ident)))=equal) THEN
      Rodape("Identidade, nao cadastrada !"," ",YellowFG,RedBG);
      RETURN(FALSE);
  END;
  IF (LENGTH(Endereco.Logra) = 0) AND
     (Compare(Endereco.Logra,Repete(" ",LENGTH(Endereco.Logra)))=equal) THEN
      Rodape("Logradouro, nao cadastrado !"," ",YellowFG,RedBG);
      RETURN(FALSE);
  END;
  Give(S,Endereco.Numero,1,left); 
  IF (LENGTH(S) = 0) AND (Compare(S,Repete(" ",LENGTH(S)))=equal) THEN
      Rodape("Numero do Endereco, nao cadastrado !"," ",YellowFG,RedBG);
      RETURN(FALSE);
  END;
  IF (LENGTH(Endereco.Compl) = 0)
     AND (Compare(Endereco.Compl,Repete(" ",LENGTH(Endereco.Compl)))=equal) THEN
      Rodape("Complemento do Endereco, nao cadastrado !"," ",YellowFG,RedBG);
      RETURN(FALSE);
  END;
  IF (LENGTH(Endereco.Bairro) = 0)
     AND (Compare(Endereco.Bairro,Repete(" ",LENGTH(Endereco.Bairro)))=equal) THEN
      Rodape("Bairro, nao cadastrado !"," ",YellowFG,RedBG);
      RETURN(FALSE);
  END;
  IF (LENGTH(Endereco.Cep) = 0) AND
     (Compare(Endereco.Cep,Repete(" ",LENGTH(Endereco.Cep)))=equal) THEN
      Rodape("Cep, nao cadastrado !"," ",YellowFG,RedBG);
      RETURN(FALSE);
  END;
  IF (LENGTH(Telefone) = 0) AND (Compare(Telefone,Repete(" ",LENGTH(Telefone)))=equal) THEN
      Rodape("Telefone, nao cadastrado !"," ",YellowFG,RedBG);
      RETURN(FALSE);
  END;
  IF  Categoria = ' ' THEN
      Rodape("Categoria, nao cadastrada !"," ",YellowFG,RedBG);
      RETURN(FALSE);
  END;
END;
 RETURN(TRUE);
END VerificaUsuarios;

(*---------------------------------------------------------------*)

(*
 Nome : SalvarUsuarios
 Descricao : procedimento que salva os dados digitados no
 Formulario de usuarios.
 Parametros :
 tipo - indica qual acao a salvar
*)
PROCEDURE SalvarUsuarios(tipo:INTEGER);
VAR
  nBytes:CARDINAL;
BEGIN
IF VerificaUsuarios()=TRUE THEN
 IF (Usuarios.Categoria='A') OR (Usuarios.Categoria='P')
   OR (Usuarios.Categoria='F') THEN
    IF tipo=1 THEN
       (* nTamUsuarios:=TamArquivo(UsuariosFile,ADR(Usuarios),TSIZE(UsuariosRec)); *)
        SetPos(UsuariosFile,ABS(TSIZE(UsuariosRec)*0)); 
        WriteNBytes(UsuariosFile,ADR(Usuarios),TSIZE(UsuariosRec),nBytes);
        Atribuir_vUsuarios(TRUE);
        Rotulos_formUsuarios(0);
        Limpar_Usuarios;
    ELSIF tipo=2 THEN
        WriteNBytes(UsuariosFile,ADR(Usuarios),TSIZE(UsuariosRec),nBytes);
    END;
 ELSE
   Rodape("Categoria, Cadastrada Incorretamente !"," ",YellowFG,RedBG);
 END;
END;

END SalvarUsuarios;

END MUsuario.
