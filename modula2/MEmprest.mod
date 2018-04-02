IMPLEMENTATION MODULE MEmprest;

FROM IntStr IMPORT Alignment, Value, Give; 
(* FROM RealInOut IMPORT WriteReal; *) 
FROM Rotinas IMPORT LivrosRec, UsuariosRec, EmprestimosRec,
Ss, CHRS, TeladeFundo, Rodape, Cores, SetaCor, Etexto, Formulario,
Copy, Repete, SubtraiDatas, SomaDias, RetDataAtual,
ConverteData, AbrirArquivo, TamArquivo;
FROM Graficos IMPORT DesenhaBotao, Botao, DesenhaLista, Lista, Digita;
FROM MLivros IMPORT PesLivros;
FROM MUsuario IMPORT PesUsuarios;
FROM StdStrings IMPORT String, Compare, CompareResult, Assign;
FROM UxFiles IMPORT Close, EndFile, SetPos, WriteNBytes, ReadNBytes;
FROM SYSTEM IMPORT ADR, TSIZE, CAST;
FROM AsciiTime IMPORT StructTimeToAscii;
FROM SysClock IMPORT GetClock, DateTime;

(***************Modulo de Emprestimos e Devolucoes*******************)

(*
 Nome : PesEmprestimos
 Descricao : funcao que pesquisa as informacoes contidas no arquivo de
 Emprestimos.
 Parametros :
 nCodUsuario - codigo do campo de numero de inscricao do usuario
 sCodLivro - codigo do campo de numero de inscricao do livro
*)
PROCEDURE PesEmprestimos(nCodUsuario,nCodLivro:INTEGER):INTEGER;
VAR
 nPosicao,nRet:INTEGER;
 bFlag:BOOLEAN;
 nBytes:CARDINAL;
BEGIN
SetPos(EmprestimosFile,0);
nPosicao:=0;
bFlag:=FALSE;
LOOP
 IF NOT(EndFile(EmprestimosFile)) THEN
   ReadNBytes(EmprestimosFile,ADR(Emprestimos),TSIZE(EmprestimosRec),nBytes);
   IF (Emprestimos.NinscUsuario=nCodUsuario) AND
      (Emprestimos.NinscLivro=nCodLivro) THEN
      nRet:=nPosicao;
      SetPos(EmprestimosFile,TSIZE(EmprestimosRec)*nPosicao);
      bFlag:=TRUE;
   END;
   nPosicao:=nPosicao+1;
 ELSE
   EXIT;
 END;
END;
 IF (EndFile(EmprestimosFile)) AND (bFlag=FALSE) THEN
     Emprestimos.NinscUsuario:=nCodUsuario;
     Emprestimos.NinscLivro:=nCodLivro;
     RETURN(-1);
 END;
 RETURN(nRet);
END PesEmprestimos;

(*-----------------------------------------------------*)

(*
 Nome : formEmprestimos
 Descricao : procedimento que desenha o formulario de Emprestimos
 na tela, e tambem indica qual acao a tomar.
 Parametros :
 tipo - indica qual a acao do formulario
 titulo - o titulo do formulario
 rod - o texto do rodape sobre o formulario
*)
PROCEDURE formEmprestimos(tipo:INTEGER;titulo,rod:String);
BEGIN
  TeladeFundo("±",WhiteFG,BlueBG);
  Rodape(rod," ",WhiteFG,BlueBG);  
  Formulario(Ss(CHRS(180),Ss(titulo,CHRS(195))),4,2,18,76,WhiteFG,BlueBG,"±",LightGrayFG,BlackBG);

  Assign(Repete(" ",5),vEmprestimos[1]);
  Atribuir_vEmprestimos(TRUE);
  AbrirArquivo(1,LivrosFile);
  AbrirArquivo(2,UsuariosFile);
  AbrirArquivo(3,EmprestimosFile);
  IF tipo=1 THEN
     Rotulos_formEmprestimos(1,0);
     DesenhaBotao(20,45,BlackFG,LightGrayBG,BlackFG,BlueBG," Emprestar ",FALSE);
     DesenhaBotao(20,60,BlackFG,LightGrayBG,BlackFG,BlueBG," Fechar ",FALSE);
  END;
  IF tipo=2 THEN
     Rotulos_formEmprestimos(2,0);
     DesenhaBotao(20,45,BlackFG,LightGrayBG,BlackFG,BlueBG," Devolver ",FALSE);
     DesenhaBotao(20,60,BlackFG,LightGrayBG,BlackFG,BlueBG," Fechar ",FALSE);
  END;
  IF tipo=3 THEN
     DesenhaBotao(20,60,BlackFG,LightGrayBG,BlackFG,BlueBG," Fechar ",FALSE);
  END;
  Limpar_Emprestimos;
  IF tipo=1 THEN
     Controles_formEmprestimos("1",1,0,0,rod,FALSE);  (* Emprestar *)
  ELSIF tipo=2 THEN
     Controles_formEmprestimos("1",2,0,0,rod,FALSE);  (* Devolver *)
  ELSIF tipo=3 THEN
     Controles_formEmprestimos("2",3,0,0,rod,TRUE);  (* consultar todos *)
  END;
END formEmprestimos; 

(*-------------------------------------------*)

(*
 Nome : Limpar_Emprestimos
 Descricao : procedimento limpa as variaveis do registro de Emprestimos.
*)
PROCEDURE Limpar_Emprestimos;
BEGIN
   WITH Emprestimos DO
     NinscUsuario:=0;
     NinscLivro:=0;
     Assign(RetDataAtual(),DtEmprestimo);
     Removido:=FALSE;
   END;
END Limpar_Emprestimos;

(*-------------------------------------------*)

(*
 Nome : Rotulos_formEmprestimos
 Descricao : procedimento que escreve os rotulos do formulario de
 Emprestimos.
 Parametros :
 tipo - indica qual a acao do formulario
 l - indica um acrescimo na linha do rotulo
*)
PROCEDURE Rotulos_formEmprestimos(tipo,l:INTEGER);
BEGIN
IF (tipo=1) OR (tipo=2) THEN
  Etexto(5,6+l,WhiteFG,BlueBG,"Numero de Inscricao do Usuario : ");
  Etexto(38,6+l,BlackFG,LightGrayBG,vEmprestimos[1]);
  Etexto(5,8+l,WhiteFG,BlueBG,"Usuario : ");
  Etexto(16,8+l,BlackFG,LightGrayBG,Repete(" ",30));
  Etexto(49,8+l,WhiteFG,BlueBG,"Categoria : ");
  Etexto(5,10+l,WhiteFG,BlueBG,"Numero de Inscricao do Livro : ");
  Etexto(36,10+l,BlackFG,LightGrayBG,vEmprestimos[2]);
  Etexto(5,12+l,WhiteFG,BlueBG,"Livro : ");
  Etexto(13,12+l,BlackFG,LightGrayBG,Repete(" ",30));
  Etexto(46,12+l,WhiteFG,BlueBG,"Estado : ");
  Etexto(5,14+l,WhiteFG,BlueBG,"Data do Emprestimo : ");
  Etexto(27,14+l,BlackFG,LightGrayBG,vEmprestimos[3]);
  Etexto(40,14+l,WhiteFG,BlueBG,"Data de Devolucao : ");
  Etexto(61,14+l,BlackFG,LightGrayBG,vEmprestimos[4]);
END;
IF tipo=2 THEN
  Etexto(5,16+l,WhiteFG,BlueBG,"Dias em Atraso : ");
  Etexto(23,16+l,BlackFG,LightGrayBG,Repete(" ",4));
  Etexto(31,16+l,WhiteFG,BlueBG,"Multa por dias em atraso : ");
  Etexto(59,16+l,BlackFG,LightGrayBG,Repete(" ",7));
END;
END Rotulos_formEmprestimos;

(*-------------------------------------------*)

(*
 Nome : Controles_formEmprestimos
 Descricao : procedimento que realiza todo o controle de manuseio do
 formulario de Emprestimos.
 Parametros :
 tipo - indica qual a acao do formulario
 tipo2 - indica a acao original do formulario nao manipulado pela funcao
 pos - indica a ultima posicao da linha da Lista de emprestimos
 col - indica a ultima posicao da coluna da Lista de emprestimos
 rod - o texto do rodape sobre o formulario
 foco - se os objetos do formulario estao focados ou nao
*)
PROCEDURE Controles_formEmprestimos(tipo:String;tipo2,pos,col:INTEGER;
                                    rod:String;foco:BOOLEAN);
VAR
 sDiasAtraso,sMulta:String;
 nDiasAtraso,nPosicao:INTEGER;
 nMulta:REAL;
 bFora:BOOLEAN;
 nBytes:CARDINAL;
BEGIN
IF Compare(tipo,"1")=equal THEN
  S[0]:=00C;
  Rodape(""," ",WhiteFG,BlueBG);
  Etexto(61,8,WhiteFG,BlueBG,"");
  Etexto(55,12,WhiteFG,BlueBG,"");
  Etexto(23,16,BlackFG,LightGrayBG,"");
  Etexto(59,16,BlackFG,LightGrayBG,"");
  Digita(S,5,5,39,5,BlackFG,LightGrayBG,'N',32);
  I:=Value(S); 
  Usuarios.Ninsc:=I;
  Emprestimos.NinscUsuario:=I;
  IF (LENGTH(S) > 0) AND (Compare(S,Repete(" ",LENGTH(S)))<>equal) THEN
    nPosicao:=PesUsuarios(UsuariosFile,'N',"Ninsc",I,"",0);
    IF nPosicao<>-1 THEN
      SetPos(UsuariosFile,TSIZE(UsuariosRec)*nPosicao);
      ReadNBytes(UsuariosFile,ADR(Usuarios),TSIZE(UsuariosRec),nBytes);
      Assign(Usuarios.Nome,S);
      Etexto(16,8,BlackFG,LightGrayBG,S);
      IF Usuarios.Categoria='F' THEN
         Etexto(61,8,WhiteFG,BlueBG,"Funcionario");
      ELSIF Usuarios.Categoria='A' THEN
         Etexto(61,8,WhiteFG,BlueBG,"Aluno      ");
      ELSIF Usuarios.Categoria='P' THEN
         Etexto(61,8,WhiteFG,BlueBG,"Professor  ");
      END;
      S[0]:=00C;
      Digita(S,5,5,37,9,BlackFG,LightGrayBG,'N',32);
      I:=Value(S); 
      Livros.Ninsc:=I;
      Emprestimos.NinscLivro:=I;
      IF (LENGTH(S) > 0) AND (Compare(S,Repete(" ",LENGTH(S)))<>equal) THEN
        nPosicao:=PesLivros(LivrosFile,'N',"Ninsc",I,"",0);
        IF nPosicao<>-1 THEN
           SetPos(LivrosFile,TSIZE(LivrosRec)*nPosicao);
           ReadNBytes(LivrosFile,ADR(Livros),TSIZE(LivrosRec),nBytes);
           Assign(Livros.Titulo,S);
           Etexto(13,12,BlackFG,LightGrayBG,S);
           IF Livros.Estado='D' THEN
             Etexto(55,12,WhiteFG,BlueBG,"Disponivel");
           ELSE
             Etexto(55,12,WhiteFG,BlueBG,"Emprestado");
           END;
           (* Emprestimo *)

           IF tipo2=1 THEN
              IF Livros.Estado='D' THEN
                IF Usuarios.Situacao < 4 THEN
                   IF Usuarios.Categoria='F' THEN
                     Assign(SomaDias(RetDataAtual(),7),Emprestimos.DtDevolucao);
                   ELSIF Usuarios.Categoria='A' THEN
                     Assign(SomaDias(RetDataAtual(),14),Emprestimos.DtDevolucao);
                   ELSIF Usuarios.Categoria='P' THEN
                     Assign(SomaDias(RetDataAtual(),30),Emprestimos.DtDevolucao);
                   END;
                   Assign(RetDataAtual(),Emprestimos.DtEmprestimo);
                   Usuarios.Situacao:=Usuarios.Situacao + 1;
                   Livros.Estado:='E';
                   Assign(Emprestimos.DtEmprestimo,S);
                   Etexto(27,14,BlackFG,LightGrayBG,S);
                   Assign(Emprestimos.DtDevolucao,S);
                   Etexto(61,14,BlackFG,LightGrayBG,S);
                   S[0]:=00C;
                   Controles_formEmprestimos("Emprestar",tipo2,pos,col,rod,TRUE);
                ELSE
                   Rodape("Usuario com 4 livros em sua posse, Impossivel Efetuar Emprestimo !"," ",YellowFG,RedBG);
                   Controles_formEmprestimos("Fechar",tipo2,pos,col,rod,TRUE);
                END;
              ELSE
                Rodape("O livro ja esta emprestado, Impossivel Efetuar Emprestimo !"," ",YellowFG,RedBG);
                Controles_formEmprestimos("Fechar",tipo2,pos,col,rod,TRUE);
              END;
             (* Devolucao *)
           ELSIF tipo2=2 THEN
              IF PesEmprestimos(Usuarios.Ninsc,Livros.Ninsc)<>-1 THEN
                 IF Livros.Estado='E' THEN
                   IF ((Usuarios.Situacao >= 1) AND (Usuarios.Situacao <= 4)) THEN
                      Assign(Emprestimos.DtDevolucao,S);
                      IF ConverteData(S) <
                         ConverteData(RetDataAtual()) THEN
                         nDiasAtraso:=0;
                         nMulta:=0.0;
                         Assign(Emprestimos.DtDevolucao,S);
                         nDiasAtraso:=SubtraiDatas(S,RetDataAtual());
                         nMulta:=(0.5 * CAST(REAL,nDiasAtraso));
                      ELSE
                         nDiasAtraso:=0;
                         nMulta:=0.0;
                      END;
                      Give(sDiasAtraso,nDiasAtraso,1,left); 
                      (* GiveFloat(sMulta,nMulta,2,1,left);  *)
                      Assign(Emprestimos.DtEmprestimo,S);
                      Etexto(27,14,BlackFG,LightGrayBG,S);
                      Assign(Emprestimos.DtDevolucao,S);
                      Etexto(61,14,BlackFG,LightGrayBG,S);
                      Etexto(23,16,BlackFG,LightGrayBG,sDiasAtraso);
                      Etexto(59,16,BlackFG,LightGrayBG,sMulta); 
                      (* WriteReal(nMulta,6); *)
                      Usuarios.Situacao:=Usuarios.Situacao - 1;
                      Livros.Estado:='D';
                      Controles_formEmprestimos("Devolver",tipo2,pos,col,
                      rod,TRUE);
                   ELSE
                      Rodape("Usuario com 0 livros em sua posse, Impossivel Efetuar Devolucao !"," ",YellowFG,RedBG);
                      Controles_formEmprestimos("Fechar",tipo2,pos,col,rod,TRUE);
                   END;
                 ELSE
                   Rodape("O livro ja esta disponivel, Impossivel Efetuar Devolucao !"," ",YellowFG,RedBG);
                   Controles_formEmprestimos("Fechar",tipo2,pos,col,rod,TRUE);
                 END;
               ELSE
                 Rodape("Emprestimo inexistente, Impossivel Efetuar Devolucao !"," ",YellowFG,RedBG);
                 Controles_formEmprestimos("Fechar",tipo2,pos,col,rod,TRUE);
               END;
           END;
             (* --- *)
        ELSE
          Give(S,I,1,left); 
          Atribuir_vEmprestimos(TRUE);
          Rotulos_formEmprestimos(tipo2,0);
          Rodape("Numero de Inscricao do Livro, nao encontrado !",
          " ",YellowFG,RedBG);
          Controles_formEmprestimos("Fechar",tipo2,pos,col,rod,TRUE);
        END;
      ELSE
        Controles_formEmprestimos("Fechar",tipo2,pos,col,rod,TRUE);
      END;
    ELSE
      Give(S,I,1,left); 
      Atribuir_vEmprestimos(TRUE);
      Rotulos_formEmprestimos(tipo2,0);
      Rodape("Numero de Inscricao do Usuario, nao encontrado !",
      " ",YellowFG,RedBG);
      Controles_formEmprestimos("Fechar",tipo2,pos,col,rod,TRUE);
    END;
  ELSE
    Controles_formEmprestimos("Fechar",tipo2,pos,col,rod,TRUE);
  END;
ELSIF Compare(tipo,"2")=equal THEN
nTamEmprestimos:=TamArquivo(EmprestimosFile,ADR(Emprestimos),TSIZE(EmprestimosRec)); 
   IF Lista(3,6,5,13,70,nTamEmprestimos+2,113,nTamEmprestimos,WhiteFG,
      BlueBG,pos,col,foco,vLista,EmprestimosFile)=1 THEN
      DesenhaLista(3,6,5,13,70,WhiteFG,BlueBG,pos,col,nTamEmprestimos,FALSE,
      vLista,EmprestimosFile);
      Controles_formEmprestimos("Fechar",tipo2,pos,col,rod,TRUE);
   END;
ELSIF Compare(tipo,"Emprestar")=equal THEN
    CASE Botao(20,45,BlackFG,LightGrayBG,BlackFG,BlueBG," Emprestar ",foco) OF
    | 1:  DesenhaBotao(20,45,BlackFG,LightGrayBG,BlackFG,BlueBG," Emprestar ",FALSE);
          Controles_formEmprestimos("Fechar",tipo2,pos,col,rod,TRUE);
    | 2: IF PesEmprestimos(Usuarios.Ninsc,Livros.Ninsc)<>-1 THEN
            Emprestimos.Removido:=FALSE;
            SalvarEmprestimos(2);
         ELSE
            Emprestimos.Removido:=FALSE;
            nTamEmprestimos:=TamArquivo(EmprestimosFile,ADR(Emprestimos),
            TSIZE(EmprestimosRec));
            SalvarEmprestimos(1);
         END;
          DesenhaBotao(20,45,BlackFG,LightGrayBG,BlackFG,BlueBG," Emprestar ",FALSE);
          Controles_formEmprestimos("Fechar",tipo2,pos,col,rod,TRUE);
    END;
ELSIF Compare(tipo,"Devolver")=equal THEN
    CASE Botao(20,45,BlackFG,LightGrayBG,BlackFG,BlueBG," Devolver ",foco) OF
    | 1:  DesenhaBotao(20,45,BlackFG,LightGrayBG,BlackFG,BlueBG," Devolver ",FALSE);
          Controles_formEmprestimos("Fechar",tipo2,pos,col,rod,TRUE);
    | 2:  Emprestimos.Removido:=TRUE;
          SalvarEmprestimos(2);
          DesenhaBotao(20,45,BlackFG,LightGrayBG,BlackFG,BlueBG," Devolver ",FALSE);
          Controles_formEmprestimos("Fechar",tipo2,pos,col,rod,TRUE);
    END;
ELSIF Compare(tipo,"Fechar")=equal THEN
    CASE Botao(20,60,BlackFG,LightGrayBG,BlackFG,BlueBG," Fechar ",foco) OF
    |  1: DesenhaBotao(20,60,BlackFG,LightGrayBG,BlackFG,BlueBG," Fechar ",FALSE);
          IF (tipo2=1) OR (tipo2=2) THEN
            Controles_formEmprestimos("1",tipo2,pos,col,rod,TRUE);
          ELSIF tipo2=3 THEN
            Controles_formEmprestimos("2",tipo2,pos,col,rod,TRUE);
          END;
    | 2: Rodape(""," ",WhiteFG,BlueBG);
         Close(LivrosFile,bFora);
         Close(UsuariosFile,bFora);
         Close(EmprestimosFile,bFora);
    END;
END;

END Controles_formEmprestimos;
 
(*-------------------------------------------------------*)

(*
 Nome : Atribuir_vEmprestimos
 Descricao : procedimento que atribui ou limpa o vetor de Emprestimos.
 Parametros :
 limpar - indica se vai limpar ou atribuir os vetores
*)
PROCEDURE Atribuir_vEmprestimos(limpar:BOOLEAN);
BEGIN
IF limpar=FALSE THEN
  WITH Emprestimos DO
    Assign(DtEmprestimo,vEmprestimos[3]);
    Assign(DtDevolucao,vEmprestimos[4]);
  END;
ELSE
  vEmprestimos[2]:=Repete(" ",5);
  vEmprestimos[3]:=Repete(" ",10);
  vEmprestimos[4]:=Repete(" ",10);
END;
END Atribuir_vEmprestimos;

(*-------------------------------------------------------*)

(*
 Nome : SalvarEmprestimos
 Descricao : procedimento que salva os dados digitados no
 formulario de emprestimos.
 Parametros :
 tipo - indica qual acao a salvar
*)
PROCEDURE SalvarEmprestimos(tipo:INTEGER);
VAR
 nBytes:CARDINAL;
BEGIN
    WriteNBytes(LivrosFile,ADR(Livros),TSIZE(LivrosRec),nBytes);
    WriteNBytes(UsuariosFile,ADR(Usuarios),TSIZE(UsuariosRec),nBytes);
    IF tipo=1 THEN
      nTamEmprestimos:=TamArquivo(EmprestimosFile,ADR(Emprestimos),TSIZE(EmprestimosRec));
      SetPos(EmprestimosFile,ABS(TSIZE(EmprestimosRec)*nTamEmprestimos)); 
      WriteNBytes(EmprestimosFile,ADR(Emprestimos),TSIZE(EmprestimosRec),nBytes);
      Atribuir_vEmprestimos(TRUE);
      Rotulos_formEmprestimos(1,0);
    ELSIF tipo=2 THEN
      WriteNBytes(EmprestimosFile,ADR(Emprestimos),TSIZE(EmprestimosRec),nBytes);
      Atribuir_vEmprestimos(TRUE);
      Rotulos_formEmprestimos(1,0);
    END;
END SalvarEmprestimos;

END MEmprest.
