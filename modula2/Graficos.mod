IMPLEMENTATION MODULE Graficos;

FROM Rotinas IMPORT Keys, LivrosRec, UsuariosRec, EmprestimosRec,
Ss, LENGTH, Repete, Copy, CHRS, Esperar, ModoCursor, SetaCursor, Inkey,
Etexto, Cores, Formulario, Rodape, AbrirArquivo, EscreveRapido,
Pos, Inserir, Beep, Rtrimstr;
FROM ANSISYS IMPORT GotoRowCol;
FROM StdStrings IMPORT String, Delete;
FROM IntStr IMPORT Alignment, Give;  
FROM SYSTEM IMPORT ADDRESS, ADR, TSIZE, CAST;
FROM UxFiles IMPORT File, SetPos, ReadNBytes;

(*-----------------------------------------------------------------*)

(*
 Nome : Digita
 Descricao : Procedimento que permite ter um maior controle da digitacao
 de um texto, tambem permitindo indicar um texto maior do que o permitido
 pelo espaco limite definido.
 Parametros :
 S - e o resultado da digitacao
 JanelaTam - indica o tamanho maximo de visualizacao do texto digitado
 MaxTam - indica o tamanho maximo do texto a ser digitado
 X - posicao da coluna na tela
 Y - posicao da linha na tela
 fg - cor do texto
 bg - cor de fundo
 FT - indica o tipo de caracter a ser digitado se (N)umero ou (T)exto
 Fundo - Indica o caracter de fundo, da janela de digitacao
*)
PROCEDURE Digita( VAR S: String;JanelaTam,MaxTam, x, y : INTEGER;
                  fg,bg : Cores;FT : CHAR;Fundo : INTEGER);
VAR
   xx, i, j, p : INTEGER;
   ch : CHAR;
   InsertOn, ChaveEspecial : BOOLEAN;
   compensacao : INTEGER;
   TempStr : String;
   sKey : Keys;

(*-------------------------------------------*)

PROCEDURE XY(x,y : INTEGER);
VAR
  Xsmall : INTEGER;
BEGIN
  REPEAT
   Xsmall:=x-80;
   IF Xsmall > 0 THEN
       y:=y+1;
       x:=Xsmall;
   END;
  UNTIL Xsmall <= 0;
 GotoRowCol(y+1,x-1);
END XY;

(*-------------------------------------------*)

PROCEDURE SetString;
VAR
 i : INTEGER;
BEGIN
i:=LENGTH(S)-1;
LOOP
 i:=i-1;
 IF i=-1 THEN
    EXIT;
 END;
 IF S[i] <> CAST(CHAR,Fundo) THEN
    EXIT;
 END;
END;
SetaCursor(normal);
END SetString;

(*-------------------------------------------*)

BEGIN
j:=LENGTH(S);
FOR i:=j TO MaxTam-1 DO
   S[i]:=CAST(CHAR,Fundo);
END;
S[MaxTam]:=00C;

TempStr:=Copy(S,1,JanelaTam);
EscreveRapido(x,y,TempStr,fg,bg);
p:=0;
compensacao:=1;
InsertOn:=TRUE;

REPEAT 
 xx:=x+((p+1)-compensacao);
 IF ((p+1)-compensacao) = JanelaTam THEN
    xx:=xx-1;
 END;
    
XY(xx,y);

IF InsertOn THEN
   Inkey(ChaveEspecial, ch, 'S', 'O', sKey);
ELSE
   Inkey(ChaveEspecial, ch, 'B', 'O', sKey);
END;

IF (FT='N') THEN
   IF (sKey = TextKey) THEN
      Beep;
      sKey:=NullKey;
   ELSIF (ch='-') AND ((p>1) OR (S[1]='-')) THEN
     Beep;
     sKey:=NullKey;
   ELSIF (ch='.') THEN
     IF NOT((Pos('.',S)=0) OR (Pos('.',S)=p)) THEN
        Beep;
        sKey:=NullKey;
     ELSIF (Pos('.',S)=p) THEN
       Delete(S,p,1);
     END;
   END;
END;

 IF (sKey=NumberKey) OR (sKey=TextKey) OR (sKey=SpaceKey) THEN
      IF (LENGTH(S) = MaxTam) THEN
         IF p = MaxTam THEN
           Delete(S,MaxTam,1);
           S[MaxTam-1]:=ch; 
           S[MaxTam]:=00C;
           IF p = JanelaTam+compensacao THEN
             compensacao:=compensacao + 1;
           END;
           TempStr:=Copy(S,compensacao,JanelaTam);
           EscreveRapido(x,y,TempStr,fg,bg); 
         ELSE
           IF InsertOn THEN
              Delete(S,MaxTam,1);
              Inserir(ch,S,p+1);
              IF p = JanelaTam+compensacao THEN
                 compensacao:=compensacao+1;
              END;
              IF p < MaxTam THEN
                 p:=p+1;
              END;
              TempStr:=Copy(S,compensacao,JanelaTam);
              EscreveRapido(x,y,TempStr,fg,bg); 
           ELSE
              Delete(S,p,1);             
              Inserir(ch,S,p+1);
              IF p = JanelaTam + compensacao THEN
                 compensacao:=compensacao+1;
              END;
              IF p < MaxTam THEN
                 p:=p+1;
              END;
              TempStr:=Copy(S,compensacao,JanelaTam);
              EscreveRapido(x,y,TempStr,fg,bg);  
           END;
         END;
      ELSE
            IF InsertOn THEN               
               Inserir(ch,S,p+1);
            ELSE
               Delete(S,p,1);               
               Inserir(ch,S,p+1);
            END;
            IF p = JanelaTam+compensacao THEN
               compensacao:=compensacao+1;
            END;
            IF p < MaxTam THEN
               p:=p+1;
            END;
            TempStr:=Copy(S,compensacao,JanelaTam);
            EscreveRapido(x,y,TempStr,fg,bg); 
      END;
 ELSIF (sKey=Bksp) THEN
      IF p > 0 THEN
         p:=p-1;
         Delete(S,p,1);
         S[MaxTam-1]:=CAST(CHAR,Fundo); 
         S[MaxTam]:=00C;
         IF compensacao > 1 THEN
           compensacao:=compensacao - 1;
         END;
         TempStr:=Copy(S,compensacao,JanelaTam);
         EscreveRapido(x,y,TempStr,fg,bg);
         ch:=' ';
      ELSE
         Beep;
         ch:=' ';
         p:=0;
      END;
 ELSIF (sKey=LeftArrow) THEN
      IF p > 0 THEN
         p:=p-1;
         IF (p+1) < compensacao THEN
             compensacao:=compensacao - 1;
             TempStr:=Copy(S,compensacao,JanelaTam);
             EscreveRapido(x,y,TempStr,fg,bg);
         END;
      ELSE
         SetString; 
         (* exit; *)
      END;
 ELSIF (sKey=RightArrow) THEN
      IF (S[p] <> CAST(CHAR,Fundo)) AND (p < MaxTam) THEN
         p:=p+1;
         IF p = (JanelaTam+compensacao) THEN
             compensacao:=compensacao + 1;
             TempStr:=Copy(S,compensacao,JanelaTam);
             EscreveRapido(x,y,TempStr,fg,bg); 
         END;
      ELSE
         SetString; 
         (* exit; *)
      END;
 ELSIF (sKey=DeleteKey) THEN
      Delete(S,p,1);
      S[MaxTam-1]:=CAST(CHAR,Fundo); 
      S[MaxTam]:=00C;
      IF ((LENGTH(S)+1)-compensacao) >= JanelaTam THEN
          TempStr:=Copy(S,compensacao,JanelaTam);
          EscreveRapido(x,y,TempStr,fg,bg);
      ELSE
          TempStr:=Copy(S,compensacao,JanelaTam);
          EscreveRapido(x,y,TempStr,fg,bg);
      END;
 ELSIF (sKey=InsertKey) THEN
      IF InsertOn THEN
         InsertOn:=FALSE;
      ELSE
         InsertOn:=TRUE;
      END;
 ELSE
    IF (sKey=UpArrow) OR (sKey=DownArrow) OR (sKey=PgDn) OR (sKey=PgUp) THEN
      Beep;
    ELSIF (sKey=NullKey) OR (sKey=Esc) OR (sKey=F1) OR (sKey=F2) OR (sKey=F3) OR (sKey=F4) THEN
      Beep;
    ELSIF (sKey=F5) OR (sKey=F6) OR (sKey=F7) OR (sKey=F8) OR (sKey=F9) OR (sKey=F10) THEN
      Beep;
    END;
 END;

UNTIL ((sKey=CarriageReturn) OR (sKey=Tab));  
SetString;  
S:=Rtrimstr(S);
END Digita;

(*-----------------------------------------------------------------*)

(*
 Nome : Menu
 Descricao : procedimento que escreve a linha de opcoes do menu.
 Parametros :
 qtd - indica a quantidade de opcoes no menu
 topo - posicao da linha inicial na tela
 fg - cor do texto
 bg - cor de fundo
 lfg - cor do texto do primeiro caracter de cada opcao do menu
 lbg - cor de fundo do primeiro caracter de cada opcao do menu
 pos2 - indica a ultima opcao de menu referenciada pelo usuario
 mfg - cor do texto do selecionado
 mbg - cor de fundo do selecionado
 cont2 - indica a ultima posicao da descricao da opcao de menu
 referenciada pelo usuario
*)
PROCEDURE Menu(qtd,topo:INTEGER;fg,bg,lfg,lbg:Cores;pos2:INTEGER;
               mfg,mbg:Cores;cont2:INTEGER;VAR vMenu:ARRAY OF String);
VAR
 cont,pos,entre:INTEGER;
BEGIN
   FOR cont:=1 TO 80 DO
      Etexto(cont,topo,fg,bg," ");
   END;
   pos:=0;
   entre:=0;
   FOR cont:=1 TO qtd DO
      Etexto(pos+4+entre,topo,lfg,lbg,Copy(vMenu[cont-1],1,1));
      Etexto(pos+5+entre,topo,fg,bg,Copy(vMenu[cont-1],2,LENGTH(vMenu[cont-1])));
      entre:=entre+3;
      pos:=pos+LENGTH(vMenu[cont-1]);
   END;
   IF pos2 > 0 THEN
      Etexto(pos2+2,topo,lfg,mbg,Ss(" ",Copy(vMenu[cont2-1],1,1)));
      Etexto(pos2+4,topo,mfg,mbg,Ss(Copy(vMenu[cont2-1],2,LENGTH(vMenu[cont2-1]))," "));
   END;
END Menu;

(*------------------------------------------------------------*)

(*
 Nome : DesenhaBotao
 Descricao : procedimento que desenha um botao na tela
 Parametros :
 topo - posicao da linha inicial na tela
 esquerda - posicao da coluna inicial na tela
 fg - cor do texto
 bg - cor de fundo
 sfg - cor do texto da sombra
 sbg - cor de fundo da sombra
 texto - o texto a ser escrito no botao
 foco - indica se o botao esta focado ou nao
*)
PROCEDURE DesenhaBotao(topo,esquerda:INTEGER;fg,bg,sfg,sbg:Cores;
                       texto:String;foco:BOOLEAN);
VAR
 tam,cont:INTEGER;
BEGIN
tam:=LENGTH(texto);
IF foco=FALSE THEN
   Etexto(esquerda,topo,fg,bg,Ss(" ",Ss(texto," ")));
END;
IF foco=TRUE THEN
  Etexto(esquerda,topo,fg,bg,Ss(CHRS(16),Ss(texto,CHRS(17))));
END;
Etexto(esquerda+tam+2,topo,sfg,sbg,CHRS(220));
FOR cont:=1 TO tam+2 DO
  Etexto(esquerda+cont,topo+1,sfg,sbg,CHRS(223));
END;
END DesenhaBotao;

(*------------------------------------------------------------*)

(*
 Nome : Botao
 Descricao : funcao que realiza a acao de apertar o botao.
 Parametros :
 topo - posicao da linha inicial na tela
 esquerda - posicao da coluna inicial na tela
 fg - cor do texto
 bg - cor de fundo
 sfg - cor do texto da sombra
 sbg - cor de fundo da sombra
 texto - o texto a ser escrito no botao
 foco - indica se o botao esta focado ou nao
*)
PROCEDURE Botao(topo,esquerda:INTEGER;fg,bg,sfg,sbg:Cores;
                texto:String;foco:BOOLEAN):INTEGER;
VAR
 tam,cont:INTEGER;
 Fk:BOOLEAN;
 Ch:CHAR;
 sKey:Keys;
BEGIN
tam:=LENGTH(texto);
DesenhaBotao(topo,esquerda,fg,bg,sfg,sbg,texto,foco);

REPEAT

Inkey(Fk,Ch,'O','O',sKey);

IF foco=TRUE THEN
  IF sKey=CarriageReturn THEN
      Etexto(esquerda+1,topo,fg,bg,Ss(CHRS(16),Ss(texto,CHRS(17))));
      Etexto(esquerda,topo,sfg,sbg," ");
      FOR cont:=1 TO tam+2 DO
        Etexto(esquerda+cont,topo+1,sfg,sbg," ");
      END;
      Esperar(500);
      RETURN(2);
  END;
END;

UNTIL sKey=Tab;
 IF sKey=Tab THEN
    RETURN(1);
 END;
END Botao;

(*------------------------------------------------------------*)

(*
 Nome : formSplash
 Descricao : procedimento que desenha a tela inicial do sistema.
*)
PROCEDURE formSplash;
BEGIN
  SetaCursor(nenhum);
  Formulario("",6,10,12,58,WhiteFG,BlueBG,"±",LightGrayFG,BlackBG);
  Etexto(13, 8,YellowFG,BlueBG," ²²²²²²²     ²    ²²²²²²²     ²       ²    ²²²²²² ");
  Etexto(13, 9,YellowFG,BlueBG,"²²²    ²²²   ²²  ²²²    ²²²   ²²      ²²  ²²²  ²²²");
  Etexto(13,10,YellowFG,BlueBG,"²²²²²²²²²    ²²  ²²²²²²²²²    ²²      ²²  ²²    ²²");
  Etexto(13,11,YellowFG,BlueBG,"²²²    ²²²   ²²  ²²²    ²²²   ²²²     ²²  ²²    ²²");
  Etexto(13,12,YellowFG,BlueBG,"²²²²   ²²²   ²²  ²²²²   ²²²   ²²²²    ²²  ²²²  ²²²");
  Etexto(13,13,YellowFG,BlueBG," ²²²²²²²²²   ²²   ²²²²²²²²²   ²²²²²²  ²²   ²²²²²² ");
  Etexto(12,15,YellowFG,BlueBG,"Programa Desenvolvido por Henrique Figueiredo de Souza");
  Etexto(12,16,YellowFG,BlueBG,"Todos os Direitos Reservados - 1999   Versao 1.0");
  Etexto(12,17,YellowFG,BlueBG,"Linguagem Usada Nesta Versao << MODULA2 >>");
  Esperar(2000);
END formSplash;

(*------------------------------------------------------------*)

(*
 Nome : DesenhaLista
 Descricao : procedimento que desenha uma Lista rolavel na tela
 Parametros :
 tipo - indica o numero de qual arquivo a ser aberto
 topo - posicao da linha inicial na tela
 esquerda - posicao da coluna inicial na tela
 altura - indica a altura da lista
 largura - indica a largura da lista
 fg - cor do texto
 bg - cor de fundo
 pos - indica a ultima posicao da linha da lista na tela
 col - indica a ultima posicao da coluna da lista na tela
 foco - indica se a lista esta focada ou nao
*)
PROCEDURE DesenhaLista(tipo,topo,esquerda,altura,largura:INTEGER;
fg,bg:Cores;pos,col,rtam:INTEGER;foco:BOOLEAN;
VAR vLista:ARRAY OF String;Arq:File);
VAR
 cont:INTEGER;
 posicao,coluna:String;
 sLista:String;
BEGIN
IF foco=TRUE THEN
   Etexto(esquerda-1,topo-1,fg,bg,"Ú");
   Etexto(esquerda+largura+1,topo-1,fg,bg,"¿");
   Etexto(esquerda-1,topo+altura,fg,bg,"À");
   Etexto(esquerda+largura+1,topo+altura,fg,bg,"Ù");
ELSE
   Etexto(esquerda-1,topo-1,fg,bg," ");
   Etexto(esquerda+largura+1,topo-1,fg,bg," ");
   Etexto(esquerda-1,topo+altura,fg,bg," ");
   Etexto(esquerda+largura+1,topo+altura,fg,bg," ");
END;
AbrirArquivo(tipo,Arq);
sLista:=TiposLista(tipo,largura,pos+1,col+1,rtam,vLista,Arq);
Etexto(esquerda,topo,fg,bg,Ss(sLista,Repete(" ",largura-LENGTH(sLista))));
FOR cont:=1 TO altura-3 DO
  sLista:=TiposLista(tipo,largura,pos+cont+1,col+1,rtam,vLista,Arq);
  Etexto(esquerda,topo+cont,fg,bg,Ss(sLista,
  Repete(" ",largura-LENGTH(sLista))));
END;
sLista:=TiposLista(tipo,largura,pos+altura,col+1,rtam,vLista,Arq);
Etexto(esquerda,topo+altura-1,fg,bg,Ss(sLista,
Repete(" ",largura-LENGTH(sLista)))); 

Give(posicao,pos+1,1,left); 
Etexto(esquerda,topo+altura+1,fg,bg,Ss("Linha : ",
Ss(Repete("0",4-LENGTH(posicao)),posicao)));
Give(coluna,col+1,1,left); 
Etexto(esquerda+14,topo+altura+1,fg,bg,Ss("Coluna : ",
Ss(Repete("0",4-LENGTH(coluna)),coluna)));

END DesenhaLista;

(*----------------------------------------------------*)

(*
 Nome : TiposLista
 Descricao : funcao que indica quais arquivos serao usados com a lista,
 como tambem a formatacao do cabecalho desses arquivos na lista
 Parametros :
 tipo - indica o numero de qual arquivo a ser aberto
 largura - indica a largura do texto
 pos - indica a posicao do texto na lista
 col - indica a posicao da coluna do texto na lista
*)
PROCEDURE TiposLista(tipo,largura,pos,col,rtam:INTEGER;
          VAR vLista:ARRAY OF String;Arq:File):String;
VAR
 sAux,S:String;
 nBytes: CARDINAL;
BEGIN
IF tipo=1 THEN
    IF pos=1 THEN
       sAux:="Numero de Inscricao ³ Titulo                         ³ ";
       sAux:=Ss(sAux,"Autor                          ³ ");
       sAux:=Ss(sAux,"Area                           ³ Palavra-Chave ³ ");
       sAux:=Ss(sAux,"Edicao ³ Ano de Publicacao ³ ");
       sAux:=Ss(sAux,"Editora                        ³ Volume ³ Estado Atual");
       RETURN(Copy(sAux,col,largura));
    END;
    IF pos=2 THEN
      RETURN(Repete("-",largura));
    END;
    IF pos > 2 THEN
      IF rtam > pos-3 THEN
        SetPos(Arq,(pos-3)*TSIZE(LivrosRec)); 
        ReadNBytes(Arq,ADR(Livros),TSIZE(LivrosRec),nBytes);

        WITH Livros DO
          S[0]:=00C;
          Give(S,Ninsc,1,left); 
          sAux:=Ss(Repete(" ",19-LENGTH(S)),Ss(S," ³ "));
          sAux:=Ss(sAux,Ss(Titulo,Ss(Repete(" ",31-LENGTH(Titulo)),"³ ")));
          sAux:=Ss(sAux,Ss(Autor,Ss(Repete(" ",31-LENGTH(Autor)),"³ ")));
          sAux:=Ss(sAux,Ss(Area,Ss(Repete(" ",31-LENGTH(Area)),"³ ")));
          sAux:=Ss(sAux,Ss(PChave,Ss(Repete(" ",14-LENGTH(PChave)),"³ ")));
          Give(S,Edicao,1,left); 
          sAux:=Ss(sAux,Ss(Repete(" ",6-LENGTH(S)),Ss(S," ³ ")));
          Give(S,AnoPubli,1,left); 
          sAux:=Ss(sAux,Ss(Repete(" ",17-LENGTH(S)),Ss(S," ³ ")));
          sAux:=Ss(sAux,Ss(Editora,Ss(Repete(" ",31-LENGTH(Editora)),"³ ")));
          Give(S,Volume,1,left); 
          sAux:=Ss(sAux,Ss(Repete(" ",6-LENGTH(S)),Ss(S," ³ ")));
          IF Estado="D" THEN
             sAux:=Ss(sAux,"Disponivel");
          ELSE
             sAux:=Ss(sAux,"Emprestado");
          END;
        END;
         RETURN(Copy(sAux,col,largura));
      ELSE
         RETURN(Repete(" ",largura));
      END;
     END;
ELSIF tipo=2 THEN
    IF pos=1 THEN
        sAux:="Numero de Inscricao ³ Nome                           ³ ";
        sAux:=Ss(sAux,"Identidade ³ Logradouro                     ³ ");
        sAux:=Ss(sAux,"Numero ³ Complemento ³ ");
        sAux:=Ss(sAux,"Bairro               ³ Cep      ³ ");
        sAux:=Ss(sAux,"Telefone    ³ Categoria   ³ Situacao");
        RETURN(Copy(sAux,col,largura));
    END;
    IF pos=2 THEN
      RETURN(Repete("-",largura));
    END;
    IF pos > 2 THEN
      IF rtam > pos-3 THEN
        SetPos(Arq,(pos-3)*TSIZE(UsuariosRec));
        ReadNBytes(Arq,ADR(Usuarios),TSIZE(UsuariosRec),nBytes);

        WITH Usuarios DO
          S[0]:=00C;
          Give(S,Ninsc,1,left); 
          sAux:=Ss(Repete(" ",19-LENGTH(S)),Ss(S," ³ "));
          sAux:=Ss(sAux,Ss(Nome,Ss(Repete(" ",31-LENGTH(Nome)),"³ ")));
          sAux:=Ss(sAux,Ss(Repete(" ",10-LENGTH(Ident)),Ss(Ident," ³ ")));
          sAux:=Ss(sAux,Ss(Endereco.Logra,Ss(Repete(" ",31-LENGTH(Endereco.Logra)),"³ ")));
          Give(S,Endereco.Numero,1,left); 
          sAux:=Ss(sAux,Ss(Repete(" ",6-LENGTH(S)),Ss(S," ³ ")));
          sAux:=Ss(sAux,Ss(Endereco.Compl,Ss(Repete(" ",12-LENGTH(Endereco.Compl)),"³ ")));
          sAux:=Ss(sAux,Ss(Endereco.Bairro,Ss(Repete(" ",21-LENGTH(Endereco.Bairro)),"³ ")));
          sAux:=Ss(sAux,Ss(Repete(" ",8-LENGTH(Endereco.Cep)),Ss(Endereco.Cep," ³")));
          sAux:=Ss(sAux,Ss(Repete(" ",12-LENGTH(Telefone)),Ss(Telefone," ³ ")));
          IF Categoria='A' THEN
             sAux:=Ss(sAux,Ss("Aluno",Ss(Repete(" ",12-LENGTH("Aluno")),"³ ")));
          ELSIF Categoria='P' THEN
             sAux:=Ss(sAux,Ss("Professor",Ss(Repete(" ",12-LENGTH("Professor")),"³ ")));
          ELSIF Categoria='F' THEN
             sAux:=Ss(sAux,Ss("Funcionario",
             Ss(Repete(" ",12-LENGTH("Funcionario")),"³ ")));
          END;
          Give(S,Situacao,1,left); 
          sAux:=Ss(sAux,Ss(Repete(" ",8-LENGTH(S)),S));
        END;
         RETURN(Copy(sAux,col,largura));
      ELSE
         RETURN(Repete(" ",largura));
      END;
    END;
ELSIF tipo=3 THEN
    IF pos=1 THEN
        sAux:="Numero de Inscricao do Usuario ³ ";
        sAux:=Ss(sAux,"Numero de Inscricao do Livro ³ ");
        sAux:=Ss(sAux,"Data do Emprestimo ³ Data da Devolucao ³ ");
        sAux:=Ss(sAux,"Removido");
        RETURN(Copy(sAux,col,largura));
    END;
    IF pos=2 THEN
      RETURN(Repete("-",largura));
    END;
    IF pos > 2 THEN
      IF rtam > pos-3 THEN
        SetPos(Arq,(pos-3)*TSIZE(EmprestimosRec));
        ReadNBytes(Arq,ADR(Emprestimos),TSIZE(EmprestimosRec),nBytes);

        WITH Emprestimos DO
          S[0]:=00C;
          Give(S,NinscUsuario,1,left); 
          sAux:=Ss(Repete(" ",30-LENGTH(S)),Ss(S," ³ "));
          Give(S,NinscLivro,1,left); 
          sAux:=Ss(sAux,Ss(Repete(" ",28-LENGTH(S)),Ss(S," ³ ")));
          sAux:=Ss(sAux,Ss(DtEmprestimo,Ss(Repete(" ",19-LENGTH(DtEmprestimo)),"³ ")));
          sAux:=Ss(sAux,Ss(DtDevolucao,Ss(Repete(" ",18-LENGTH(DtDevolucao)),"³ ")));
          IF Removido=TRUE THEN
             sAux:=Ss(sAux,"Sim");
          ELSE
             sAux:=Ss(sAux,"Nao");
          END;
        END;
         RETURN(Copy(sAux,col,largura));
      ELSE
         RETURN(Repete(" ",largura));
      END;
    END;
ELSIF tipo=4 THEN
    RETURN(Copy(vLista[pos-1],col,LENGTH(vLista[pos-1])));
END;

END TiposLista;

(*-----------------------------------------------------------------*)

(*
 Nome : Lista
 Descricao : funcao que executa a acao de rolamento da lista.
 Parametros :
 tipo - indica o numero de qual arquivo a ser aberto
 topo - posicao da linha inicial na tela
 esquerda - posicao da coluna inicial na tela
 largura - indica a largura da lista
 tlinhas - indica o numero total de linhas da lista
 tcolunas - indica o numero total de colunas da lista
 fg - cor do texto
 bg - cor de fundo
 listapos - indica a ultima posicao da linha da lista na tela
 litacol - indica a ultima posicao da coluna da lista na tela
 foco - indica se a lista esta focada ou nao
*)
PROCEDURE Lista(tipo,topo,esquerda,altura,largura,tlinhas,tcolunas,rtam:INTEGER;
                fg,bg:Cores;
                VAR Listapos,Listacol:INTEGER;foco:BOOLEAN;
                VAR vLista:ARRAY OF String;Arq:File): INTEGER;
VAR
 cont2:INTEGER;
 posicao,coluna,sLista:String;
 sKey:Keys;
 Fk:BOOLEAN;
 Ch:CHAR;
BEGIN

DesenhaLista(tipo,topo,esquerda,altura,largura,fg,bg,
Listapos,Listacol,rtam,foco,vLista,Arq); 

REPEAT

Inkey(Fk,Ch,'O','O',sKey);

  IF sKey=UpArrow THEN
     IF Listapos > 0 THEN
         Listapos:=Listapos-1;
         FOR cont2:=0 TO altura-1 DO
           sLista:=TiposLista(tipo,largura,Listapos+cont2+1,Listacol+1,rtam,
           vLista,Arq);
           Etexto(esquerda,topo+cont2,fg,bg,Ss(sLista,
           Repete(" ",largura-LENGTH(sLista))));
         END;
         Give(posicao,Listapos+1,1,left); 
         Etexto(esquerda,topo+altura+1,fg,bg,Ss("Linha : ",
         Ss(Repete("0",4-LENGTH(posicao)),posicao)));
     END;
  END;

  IF sKey=DownArrow THEN
     IF Listapos < (tlinhas-altura) THEN
         Listapos:=Listapos+1;
         FOR cont2:=0 TO altura-1 DO
           sLista:=TiposLista(tipo,largura,Listapos+cont2+1,Listacol+1,rtam,
           vLista,Arq);
           Etexto(esquerda,topo+cont2,fg,bg,Ss(sLista,
           Repete(" ",largura-LENGTH(sLista))));
         END;
         Give(posicao,Listapos+1,1,left); 
         Etexto(esquerda,topo+altura+1,fg,bg,Ss("Linha : ",
         Ss(Repete("0",4-LENGTH(posicao)),posicao)));
     END;
  END;

  IF sKey=RightArrow THEN
     IF Listacol < (tcolunas-largura) THEN
         Listacol:=Listacol+1;
         FOR cont2:=0 TO altura-1 DO
          sLista:=TiposLista(tipo,largura,Listapos+cont2+1,Listacol+1,rtam,
          vLista,Arq);
          Etexto(esquerda,topo+cont2,fg,bg,Ss(sLista,
          Repete(" ",largura-LENGTH(sLista))));
         END;
         Give(coluna,Listacol+1,1,left); 
         Etexto(esquerda+14,topo+altura+1,fg,bg,Ss("Coluna : ",
         Ss(Repete("0",4-LENGTH(coluna)),coluna)));
     END;
  END;

  IF sKey=LeftArrow THEN
     IF Listacol > 0 THEN
         Listacol:=Listacol-1;
         FOR cont2:=0 TO altura-1 DO
           sLista:=TiposLista(tipo,largura,Listapos+cont2+1,Listacol+1,rtam,
           vLista,Arq);
           Etexto(esquerda,topo+cont2,fg,bg,Ss(sLista,
           Repete(" ",largura-LENGTH(sLista))));
         END;
         Give(coluna,Listacol+1,1,left); 
         Etexto(esquerda+14,topo+altura+1,fg,bg,Ss("Coluna : ",
         Ss(Repete("0",4-LENGTH(coluna)),coluna)));
     END;
  END;

UNTIL sKey=Tab;
IF sKey=Tab THEN
  RETURN(1);
END;

END Lista;

END Graficos.
