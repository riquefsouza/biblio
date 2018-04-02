{ Modulo de Emprestimos e Devolucoes }
unit memprest;

interface

uses crt, rotinas1, grafico1, rotinas2, grafico2, mlivros, musuario;

var
 { variaveis do modulo de Emprestimos }

 vsEmprestimos : array[1..5] of String[10];

{ Declaracao de funcoes de memprest }

function fnPesEmprestimos(ncodusuario,ncodlivro:integer):integer;

{ Declaracao de Procedimentos de memprest }

procedure pFrmEmprestimos(ntip:integer;stit,srod:string); 
procedure pLprEmprestimos; 
procedure pRotFrmEmprestimos(ntip,nl:integer);
procedure pConFrmEmprestimos(stip:string;ntip2,npos,
          ncol:integer;srod:string;bfco:boolean);
procedure pAtrEmprestimos(blimpar:boolean);
procedure pSlvEmprestimos(ntip:integer); 

implementation

{
 Nome : fnPesEmprestimos
 Descricao : funcao que pesquisa as informacoes contidas no arquivo de
 Emprestimos.
 Parametros :
 nCodUsuario - codigo do campo de numero de inscricao do usuario
 sCodLivro - codigo do campo de numero de inscricao do livro
}
function fnPesEmprestimos(ncodusuario,ncodlivro:integer):integer;
var
 nposicao:integer;
 bflag:boolean;
begin
seek(fEmprestimos,0);
nposicao:=0;
bflag:=false;
while Not Eof(fEmprestimos) do
 begin
   read(fEmprestimos,Emprestimos);
   if (Emprestimos.nNinscUsuario=ncodusuario) and
      (Emprestimos.nNinscLivro=ncodlivro) then
     begin
      fnPesEmprestimos:=nposicao;
      seek(fEmprestimos,nposicao);
      bflag:=true;
      exit;
     end;
   nposicao:=nposicao+1;
 end;
 if (Eof(fEmprestimos)) and (bflag=false) then
   begin
     Emprestimos.nNinscUsuario:=ncodUsuario;
     Emprestimos.nNinscLivro:=ncodLivro;
     fnPesEmprestimos:=-1;
   end;
end;

{-----------------------------------------------------}

{
 Nome : pFrmEmprestimos
 Descricao : procedimento que desenha o formulario de Emprestimos
 na tela, e tambem indica qual acao a tomar.
 Parametros :
 ntip - indica qual a acao do formulario
 stit - o titulo do formulario
 srod - o texto do rodape sobre o formulario
}
procedure pFrmEmprestimos(ntip:integer;stit,srod:string);
begin
  pTelaFundo(sCFundo,mnCor[5,1],mnCor[5,2]);
  pRodape(srod,' ',mnCor[6,1],mnCor[6,2]);  
  pFrm(chr(180)+stit+chr(195),4,2,18,76,chr(177),mnCor[8,1],mnCor[8,2],
  lightgray,black);

  vsEmprestimos[1]:=fsRepete(' ',5);
  pAtrEmprestimos(true);
  pAbrirArquivo(1);
  pAbrirArquivo(2);
  pAbrirArquivo(3);
  if ntip=1 then
    begin
     pRotFrmEmprestimos(1,0);
     pDesBotao(20,45,' Emprestar ',mnCor[9,1],mnCor[9,2],black,
     mnCor[8,2],false);
     pDesBotao(20,60,' Fechar ',mnCor[9,1],mnCor[9,2],black,mnCor[8,2],false);
    end;
  if ntip=2 then
    begin
     pRotFrmEmprestimos(2,0);
     pDesBotao(20,45,' Devolver ',mnCor[9,1],mnCor[9,2],black,
     mnCor[8,2],false);
     pDesBotao(20,60,' Fechar ',mnCor[9,1],mnCor[9,2],black,mnCor[8,2],false);
    end;
  if ntip=3 then
     pDesBotao(20,60,' Fechar ',mnCor[9,1],mnCor[9,2],black,mnCor[8,2],false);

  pLprEmprestimos;
  if ntip=1 then
     pConFrmEmprestimos('1',1,0,0,srod,false)  { Emprestar }
  else if ntip=2 then
     pConFrmEmprestimos('1',2,0,0,srod,false)  { Devolver }
  else if ntip=3 then
     pConFrmEmprestimos('2',3,0,0,srod,true);  { consultar todos }
end;

{-------------------------------------------}

{
 Nome : pLprEmprestimos
 Descricao : procedimento limpa as variaveis do registro de Emprestimos.
}
procedure pLprEmprestimos;
begin
   with Emprestimos do
    begin
     nNinscUsuario:=0;
     nNinscLivro:=0;
     sDtEmprestimo:=fsDataAtual;
     { sDtDevolucao:=fsDataAtual; }
     bRemovido:=false;
    end;
end;

{-------------------------------------------}

{
 Nome : pRotFrmEmprestimos
 Descricao : procedimento que escreve os rotulos do formulario de
 Emprestimos.
 Parametros :
 ntip - indica qual a acao do formulario
 nl - indica um acrescimo na linha do rotulo
}
procedure pRotFrmEmprestimos(ntip,nl:integer);
begin
if (ntip=1) or (ntip=2) then
 begin
  pETexto(6+nl,5,'Numero de Inscricao do Usuario : ',mnCor[8,1],mnCor[8,2]);
  pETexto(6+nl,38,vsEmprestimos[1],mnCor[11,1],mnCor[11,2]);
  pETexto(8+nl,5,'Usuario : ',mnCor[8,1],mnCor[8,2]);
  pETexto(8+nl,16,fsRepete(' ',30),mnCor[11,1],mnCor[11,2]);
  pETexto(8+nl,49,'Categoria : ',mnCor[8,1],mnCor[8,2]);
  pETexto(10+nl,5,'Numero de Inscricao do Livro : ',mnCor[8,1],mnCor[8,2]);
  pETexto(10+nl,36,vsEmprestimos[2],mnCor[11,1],mnCor[11,2]);
  pETexto(12+nl,5,'Livro : ',mnCor[8,1],mnCor[8,2]);
  pETexto(12+nl,13,fsRepete(' ',30),mnCor[11,1],mnCor[11,2]);
  pETexto(12+nl,46,'Estado : ',mnCor[8,1],mnCor[8,2]);
  pETexto(14+nl,5,'Data do Emprestimo : ',mnCor[8,1],mnCor[8,2]);
  pETexto(14+nl,27,vsEmprestimos[3],mnCor[11,1],mnCor[11,2]);
  pETexto(14+nl,40,'Data de Devolucao : ',mnCor[8,1],mnCor[8,2]);
  pETexto(14+nl,61,vsEmprestimos[4],mnCor[11,1],mnCor[11,2]);
 end;
if ntip=2 then
 begin
  pETexto(16+nl,5,'Dias em Atraso : ',mnCor[8,1],mnCor[8,2]);
  pETexto(16+nl,23,fsRepete(' ',4),mnCor[11,1],mnCor[11,2]);
  pETexto(16+nl,31,'Multa por dias em atraso : ',mnCor[8,1],mnCor[8,2]);
  pETexto(16+nl,59,fsRepete(' ',7),mnCor[11,1],mnCor[11,2]);
 end;
end;

{-------------------------------------------}

{
 Nome : pConFrmEmprestimos
 Descricao : procedimento que realiza todo o controle de manuseio do
 formulario de Emprestimos.
 Parametros :
 stip - indica qual a acao do formulario
 ntip2 - indica a acao original do formulario nao manipulado pela funcao
 npos - indica a ultima posicao da linha da lista de emprestimos
 ncol - indica a ultima posicao da coluna da lista de emprestimos
 srod - o texto do rodape sobre o formulario
 bfco - se os objetos do formulario estao focados ou nao
}
procedure pConFrmEmprestimos(stip:string;ntip2,npos,ncol:integer;
                             srod:string;bfco:boolean);
var
 sdiasatraso,smulta:string;
 ndiasatraso, ni, ncode:integer;
 pmulta: real;
begin
if stip='1' then
 begin
  sS:='';
  pRodape('',' ',mnCor[6,1],mnCor[6,2]);
  pETexto(8,61,'',mnCor[8,1],mnCor[8,2]);
  pETexto(12,55,'',mnCor[8,1],mnCor[8,2]);
  pETexto(16,23,'',mnCor[11,1],mnCor[11,2]);
  pETexto(16,59,'',mnCor[11,1],mnCor[11,2]);
  sS:=fsDigita(5,39,sS,5,5,'N',0,mnCor[11,1],mnCor[11,2]);
  val(sS,ni,ncode);
  Usuarios.nNinsc:=ni;
  Emprestimos.nNinscUsuario:=ni;
  if (length(sS) > 0) and (sS<>fsRepete(' ',length(sS))) then
   begin
    if fnPesUsuarios('N','Ninsc',ni,'',0)<>-1 then
     begin
      pETexto(8,16,Usuarios.sNome,mnCor[11,1],mnCor[11,2]);
      if Usuarios.cCategoria='F' then
         pETexto(8,61,'Funcionario',mnCor[8,1],mnCor[8,2])
      else if Usuarios.cCategoria='A' then
         pETexto(8,61,'Aluno      ',mnCor[8,1],mnCor[8,2])
      else if Usuarios.cCategoria='P' then
         pETexto(8,61,'Professor  ',mnCor[8,1],mnCor[8,2]);

      sS:='';
      sS:=fsDigita(9,37,sS,5,5,'N',0,mnCor[11,1],mnCor[11,2]);
      val(sS,ni,ncode);
      Livros.nNinsc:=ni;
      Emprestimos.nNinscLivro:=ni;
      if (length(sS) > 0) and (sS<>fsRepete(' ',length(sS))) then
       begin
        if fnPesLivros('N','Ninsc',ni,'',0)<>-1 then
         begin
           pETexto(12,13,Livros.sTitulo,mnCor[11,1],mnCor[11,2]);
           if Livros.cEstado='D' then
             pETexto(12,55,'Disponivel',mnCor[8,1],mnCor[8,2])
           else
             pETexto(12,55,'Emprestado',mnCor[8,1],mnCor[8,2]);

           { Emprestimo }

           if ntip2=1 then
             begin
              if Livros.cEstado='D' then
               begin
                if Usuarios.nSituacao < 4 then
                  begin
                   if Usuarios.cCategoria='F' then
                     Emprestimos.sDtDevolucao:=fsSomaDias(fsDataAtual,7)
                   else if Usuarios.cCategoria='A' then
                     Emprestimos.sDtDevolucao:=fsSomaDias(fsDataAtual,14)
                   else if Usuarios.cCategoria='P' then
                     Emprestimos.sDtDevolucao:=fsSomaDias(fsDataAtual,30);
                   Emprestimos.sDtEmprestimo:=fsDataAtual;
                   Usuarios.nSituacao:=Usuarios.nSituacao + 1;
                   Livros.cEstado:='E';
                   pETexto(14,27,Emprestimos.sDtEmprestimo,mnCor[11,1],mnCor[11,2]);
                   pETexto(14,61,Emprestimos.sDtDevolucao,mnCor[11,1],mnCor[11,2]);
                   pConFrmEmprestimos('Emprestar',ntip2,npos,ncol,srod,true);
                  end    
                else
                  begin
                   pRodape('Usuario com 4 livros em sua posse, Impossivel '+
                   'Efetuar Emprestimo !',' ',mnCor[7,1],mnCor[7,2]);
                   pConFrmEmprestimos('Fechar',ntip2,npos,ncol,srod,true);
                  end;
               end
              else
               begin
                pRodape('O livro ja esta emprestado, Impossivel '+
                'Efetuar Emprestimo !',' ',mnCor[7,1],mnCor[7,2]);
                pConFrmEmprestimos('Fechar',ntip2,npos,ncol,srod,true);
               end;
             end
             { Devolucao }
           else if ntip2=2 then
             begin
              if fnPesEmprestimos(Usuarios.nNinsc,Livros.nNinsc)<>-1 then
                begin
                 if Livros.cEstado='E' then
                  begin
                   if ((Usuarios.nSituacao >= 1) and (Usuarios.nSituacao <= 4)) then
                     begin
                      if fnConverteData(Emprestimos.sDtDevolucao) <
                         fnConverteData(fsDataAtual) then
                        begin
                         ndiasatraso:=0;
                         pmulta:=0.0;
                         ndiasatraso:=fnSubDatas(Emprestimos.sDtDevolucao,
                         fsDataAtual);
                         pmulta:=(0.5 * ndiasatraso);
                        end
                      else
                        begin
                         ndiasatraso:=0;
                         pmulta:=0.0;
                        end;
                      str(ndiasatraso,sdiasatraso);
                      str(pmulta:3:2,smulta);
                      pETexto(14,27,Emprestimos.sDtEmprestimo,mnCor[11,1],mnCor[11,2]);
                      pETexto(14,61,Emprestimos.sDtDevolucao,mnCor[11,1],mnCor[11,2]);
                      pETexto(16,23,sdiasatraso,mnCor[11,1],mnCor[11,2]);
                      pETexto(16,59,smulta,mnCor[11,1],mnCor[11,2]);
                      Usuarios.nSituacao:=Usuarios.nSituacao - 1;
                      Livros.cEstado:='D';
                      pConFrmEmprestimos('Devolver',ntip2,npos,ncol,
                      srod,true);
                     end
                   else
                     begin
                      pRodape('Usuario com 0 livros em sua posse, Impossivel '+
                      'Efetuar Devolucao !',' ',mnCor[7,1],mnCor[7,2]);
                      pConFrmEmprestimos('Fechar',ntip2,npos,ncol,srod,true);
                     end;
                  end
                 else
                  begin
                   pRodape('O livro ja esta disponivel, Impossivel '+
                   'Efetuar Devolucao !',' ',mnCor[7,1],mnCor[7,2]);
                   pConFrmEmprestimos('Fechar',ntip2,npos,ncol,srod,true);
                  end;
                end
               else
                begin
                 pRodape('Emprestimo inexistente, Impossivel '+
                 'Efetuar Devolucao !',' ',mnCor[7,1],mnCor[7,2]);
                 pConFrmEmprestimos('Fechar',ntip2,npos,ncol,srod,true);
                end;
             end;
             { --- }
         end
        else
         begin
          str(ni,sS);
          pAtrEmprestimos(true);
          pRotFrmEmprestimos(ntip2,0);
          pRodape('Numero de Inscricao do Livro, nao encontrado !',
          ' ',mnCor[7,1],mnCor[7,2]);
          pConFrmEmprestimos('Fechar',ntip2,npos,ncol,srod,true);
         end;
       end
      else
        pConFrmEmprestimos('Fechar',ntip2,npos,ncol,srod,true);
     end
    else
     begin
      str(ni,sS);
      pAtrEmprestimos(true);
      pRotFrmEmprestimos(ntip2,0);
      pRodape('Numero de Inscricao do Usuario, nao encontrado !',
      ' ',mnCor[7,1],mnCor[7,2]);
      pConFrmEmprestimos('Fechar',ntip2,npos,ncol,srod,true);
     end;
   end
  else
    pConFrmEmprestimos('Fechar',ntip2,npos,ncol,srod,true);
 end
else if stip='2' then
  begin
   nListapos:=npos;
   nListacol:=ncol;
   if fnLista(3,6,5,13,70,nTamEmprestimos+2,113,mnCor[8,1],mnCor[8,2],
      mnCor[10,1],mnCor[10,2],bfco)=1 then
      begin
        pDesLista(3,6,5,13,70,nTamEmprestimos+2,113,mnCor[8,1],mnCor[8,2],      
        mnCor[10,1],mnCor[10,2],nListapos,nListacol,false);
        pConFrmEmprestimos('Fechar',ntip2,npos,ncol,srod,true);
      end;
  end
else if stip='Emprestar' then
  begin
    case fnBotao(20,45,' Emprestar ',mnCor[9,1],mnCor[9,2],black,
         mnCor[8,2],bfco) of
      1:begin
          pDesBotao(20,45,' Emprestar ',mnCor[9,1],mnCor[9,2],black,
          mnCor[8,2],false);
          pConFrmEmprestimos('Fechar',ntip2,npos,ncol,srod,true);
        end;
      2:begin
         if fnPesEmprestimos(Usuarios.nNinsc,Livros.nNinsc)<>-1 then
           begin
            Emprestimos.bRemovido:=false;
            pSlvEmprestimos(2);
           end
         else
           begin
            Emprestimos.bRemovido:=false;
            nTamEmprestimos:=FileSize(fEmprestimos);
            pSlvEmprestimos(1);
           end;
          pDesBotao(20,45,' Emprestar ',mnCor[9,1],mnCor[9,2],black,
          mnCor[8,2],false);
          pConFrmEmprestimos('Fechar',ntip2,npos,ncol,srod,true);
        end;
    end;
  end
else if stip='Devolver' then
  begin
    case fnBotao(20,45,' Devolver ',mnCor[9,1],mnCor[9,2],black,
         mnCor[8,2],bfco) of
      1:begin
          pDesBotao(20,45,' Devolver ',mnCor[9,1],mnCor[9,2],black,
          mnCor[8,2],false);
          pConFrmEmprestimos('Fechar',ntip2,npos,ncol,srod,true);
        end;
      2:begin
          Emprestimos.bRemovido:=true;
          pSlvEmprestimos(2);
          pDesBotao(20,45,' Devolver ',mnCor[9,1],mnCor[9,2],black,
          mnCor[8,2],false);
          pConFrmEmprestimos('Fechar',ntip2,npos,ncol,srod,true);
        end;
    end;
  end
else if stip = 'Fechar' then
  begin
    case fnBotao(20,60,' Fechar ',mnCor[9,1],mnCor[9,2],black,
         mnCor[8,2],bfco) of
      1:begin
          pDesBotao(20,60,' Fechar ',mnCor[9,1],mnCor[9,2],black,
          mnCor[8,2],false);
          if (ntip2=1) or (ntip2=2) then
            pConFrmEmprestimos('1',ntip2,npos,ncol,srod,true)
          else if ntip2=3 then
            pConFrmEmprestimos('2',ntip2,npos,ncol,srod,true);
        end;
      2:begin
         pRodape('',' ',mnCor[6,1],mnCor[6,2]);
         close(fLivros);
         close(fUsuarios);
         close(fEmprestimos);
        end;
    end;
  end;

end;
 
{-------------------------------------------------------}

{
 Nome : pAtrEmprestimos
 Descricao : procedimento que atribui ou limpa o vetor de Emprestimos.
 Parametros :
 limpar - indica se vai limpar ou atribuir os vetores
}
procedure pAtrEmprestimos(blimpar:boolean);
begin
if blimpar=false then
 begin
  with Emprestimos do
    begin
      vsEmprestimos[3]:=sDtEmprestimo;
      vsEmprestimos[4]:=sDtDEvolucao;
    end;
 end
else
 begin
  vsEmprestimos[2]:=fsRepete(' ',5);
  vsEmprestimos[3]:=fsRepete(' ',10);
  vsEmprestimos[4]:=fsRepete(' ',10);
 end;
end;

{-------------------------------------------------------}

{
 Nome : pSlvEmprestimos
 Descricao : procedimento que salva os dados digitados no
 formulario de emprestimos.
 Parametros :
 ntip - indica qual acao a salvar
}
procedure pSlvEmprestimos(ntip:integer);
begin
    write(fLivros,Livros);
    write(fUsuarios,Usuarios);
    if ntip=1 then
      begin
        seek(fEmprestimos,nTamEmprestimos);
        write(fEmprestimos,Emprestimos);
        pAtrEmprestimos(true);
        pRotFrmEmprestimos(1,0);
      end
    else if ntip=2 then
      begin
        write(fEmprestimos,Emprestimos);
        pAtrEmprestimos(true);
        pRotFrmEmprestimos(1,0);
      end;
end;

end.
                
