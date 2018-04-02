unit UEmprest;

interface

uses crt, dos, UBiblio, ULivros, UUsuario;

{ Declaracao de tipos }

type

  TEmprest = object(TBiblio)

   { variaveis do modulo de Emprestimos }

   vEmprestimos : array[1..5] of String[10];
   I,C: integer;

   { Declaracao de funcoes }

   function PesEmprestimos(nCodUsuario,nCodLivro:integer):integer;

   { Declaracao de Procedimentos }

   procedure formEmprestimos(tipo:integer;titulo,rod:string);
   procedure Limpar_Emprestimos;
   procedure Rotulos_formEmprestimos(tipo,l:integer);
   procedure Controles_formEmprestimos(tipo:string;tipo2,pos,
          col:integer;rod:string;foco:boolean);
   procedure Atribuir_vEmprestimos(limpar:boolean);
   procedure SalvarEmprestimos(tipo:integer);

  end;

implementation

var
  PUsuario : TUsuario;
  PLivros : TLivros;

{**************Unidade de Emprestimos e Devolucoes******************}

{
 Nome : PesEmprestimos
 Descricao : funcao que pesquisa as informacoes contidas no arquivo de
 Emprestimos.
 Parametros :
 nCodUsuario - codigo do campo de numero de inscricao do usuario
 sCodLivro - codigo do campo de numero de inscricao do livro
}
function TEmprest.PesEmprestimos(nCodUsuario,nCodLivro:integer):integer;
var
 nPosicao:integer;
 bFlag:boolean;
begin
seek(EmprestimosFile,0);
nPosicao:=0;
bFlag:=false;
while Not Eof(EmprestimosFile) do
 begin
   read(EmprestimosFile,Emprestimos);
   if (Emprestimos.NinscUsuario=nCodUsuario) and
      (Emprestimos.NinscLivro=nCodLivro) then
     begin
      PesEmprestimos:=nPosicao;
      seek(EmprestimosFile,nPosicao);
      bFlag:=true;
      exit;
     end;
   nPosicao:=nPosicao+1;
 end;
 if (Eof(EmprestimosFile)) and (bFlag=false) then
   begin
     Emprestimos.NinscUsuario:=nCodUsuario;
     Emprestimos.NinscLivro:=nCodLivro;
     PesEmprestimos:=-1;
   end;
end;

{-----------------------------------------------------}

{
 Nome : formEmprestimos
 Descricao : procedimento que desenha o formulario de Emprestimos
 na tela, e tambem indica qual acao a tomar.
 Parametros :
 tipo - indica qual a acao do formulario
 titulo - o titulo do formulario
 rod - o texto do rodape sobre o formulario
}
procedure TEmprest.formEmprestimos(tipo:integer;titulo,rod:string);
begin
  teladefundo('±',white,lightblue);
  rodape(rod,' ',white,blue);
  formulario(chr(180)+titulo+chr(195),4,2,18,76,white,blue,'±',lightgray,black);

  vEmprestimos[1]:=Repete(' ',5);
  Atribuir_vEmprestimos(true);
  AbrirArquivo(1);
  AbrirArquivo(2);
  AbrirArquivo(3);
  if tipo=1 then
    begin
     Rotulos_formEmprestimos(1,0);
     DesenhaBotao(20,45,black,white,black,blue,' Emprestar ',false);
     DesenhaBotao(20,60,black,white,black,blue,' Fechar ',false);
    end;
  if tipo=2 then
    begin
     Rotulos_formEmprestimos(2,0);
     DesenhaBotao(20,45,black,white,black,blue,' Devolver ',false);
     DesenhaBotao(20,60,black,white,black,blue,' Fechar ',false);
    end;
  if tipo=3 then
     DesenhaBotao(20,60,black,white,black,blue,' Fechar ',false);

  Limpar_Emprestimos;
  if tipo=1 then
     Controles_formEmprestimos('1',1,0,0,rod,false)  { Emprestar }
  else if tipo=2 then
     Controles_formEmprestimos('1',2,0,0,rod,false)  { Devolver }
  else if tipo=3 then
     Controles_formEmprestimos('2',3,0,0,rod,true);  { consultar todos }
end;

{-------------------------------------------}

{
 Nome : Limpar_Emprestimos
 Descricao : procedimento limpa as variaveis do registro de Emprestimos.
}
procedure TEmprest.Limpar_Emprestimos;
begin
   with Emprestimos do
    begin
     NinscUsuario:=0;
     NinscLivro:=0;
     DtEmprestimo:=RetDataAtual;
     { DtDevolucao:=RetDataAtual; }
     Removido:=false;
    end;
end;

{-------------------------------------------}

{
 Nome : Rotulos_formEmprestimos
 Descricao : procedimento que escreve os rotulos do formulario de
 Emprestimos.
 Parametros :
 tipo - indica qual a acao do formulario
 l - indica um acrescimo na linha do rotulo
}
procedure TEmprest.Rotulos_formEmprestimos(tipo,l:integer);
begin
if (tipo=1) or (tipo=2) then
 begin
  Etexto(5,6+l,white,blue,'Numero de Inscricao do Usuario : ');
  Etexto(38,6+l,black,lightgray,vEmprestimos[1]);
  Etexto(5,8+l,white,blue,'Usuario : ');
  Etexto(16,8+l,black,lightgray,Repete(' ',30));
  Etexto(49,8+l,white,blue,'Categoria : ');
  Etexto(5,10+l,white,blue,'Numero de Inscricao do Livro : ');
  Etexto(36,10+l,black,lightgray,vEmprestimos[2]);
  Etexto(5,12+l,white,blue,'Livro : ');
  Etexto(13,12+l,black,lightgray,Repete(' ',30));
  Etexto(46,12+l,white,blue,'Estado : ');
  Etexto(5,14+l,white,blue,'Data do Emprestimo : ');
  Etexto(27,14+l,black,lightgray,vEmprestimos[3]);
  Etexto(40,14+l,white,blue,'Data de Devolucao : ');
  Etexto(61,14+l,black,lightgray,vEmprestimos[4]);
 end;
if tipo=2 then
 begin
  Etexto(5,16+l,white,blue,'Dias em Atraso : ');
  Etexto(23,16+l,black,lightgray,repete(' ',4));
  Etexto(31,16+l,white,blue,'Multa por dias em atraso : ');
  Etexto(59,16+l,black,lightgray,repete(' ',7));
 end;
end;

{-------------------------------------------}

{
 Nome : Controles_formEmprestimos
 Descricao : procedimento que realiza todo o controle de manuseio do
 formulario de Emprestimos.
 Parametros :
 tipo - indica qual a acao do formulario
 tipo2 - indica a acao original do formulario nao manipulado pela funcao
 pos - indica a ultima posicao da linha da lista de emprestimos
 col - indica a ultima posicao da coluna da lista de emprestimos
 rod - o texto do rodape sobre o formulario
 foco - se os objetos do formulario estao focados ou nao
}
procedure TEmprest.Controles_formEmprestimos(tipo:string;tipo2,pos,col:integer;
                                    rod:string;foco:boolean);
var
 sDiasAtraso,sMulta:string;
 nDiasAtraso:integer;
 nMulta: real;
begin
if tipo='1' then
 begin
  S:='';
  rodape('',' ',white,blue);
  Etexto(61,8,white,blue,'');
  Etexto(55,12,white,blue,'');
  Etexto(23,16,black,lightgray,'');
  Etexto(59,16,black,lightgray,'');
  Digita(S,5,5,39,5,black,lightgray,'N',0);
  Val(S,I,C);
  Usuarios.Ninsc:=I;
  Emprestimos.NinscUsuario:=I;
  if (length(S) > 0) and (S<>Repete(' ',length(S))) then
   begin
    if PUsuario.PesUsuarios('N','Ninsc',I,'',0)<>-1 then
     begin
      Etexto(16,8,black,lightgray,Usuarios.Nome);
      if Usuarios.Categoria='F' then
         Etexto(61,8,white,blue,'Funcionario')
      else if Usuarios.Categoria='A' then
         Etexto(61,8,white,blue,'Aluno      ')
      else if Usuarios.Categoria='P' then
         Etexto(61,8,white,blue,'Professor  ');

      S:='';
      Digita(S,5,5,37,9,black,lightgray,'N',0);
      Val(S,I,C);
      Livros.Ninsc:=I;
      Emprestimos.NinscLivro:=I;
      if (length(S) > 0) and (S<>Repete(' ',length(S))) then
       begin
        if PLivros.PesLivros('N','Ninsc',I,'',0)<>-1 then
         begin
           Etexto(13,12,black,lightgray,Livros.Titulo);
           if Livros.Estado='D' then
             Etexto(55,12,white,blue,'Disponivel')
           else
             Etexto(55,12,white,blue,'Emprestado');

           { Emprestimo }

           if tipo2=1 then
             begin
              if Livros.Estado='D' then
               begin
                if Usuarios.Situacao < 4 then
                  begin
                   if Usuarios.Categoria='F' then
                     Emprestimos.DtDevolucao:=SomaDias(RetDataAtual,7)
                   else if Usuarios.Categoria='A' then
                     Emprestimos.DtDevolucao:=SomaDias(RetDataAtual,14)
                   else if Usuarios.Categoria='P' then
                     Emprestimos.DtDevolucao:=SomaDias(RetDataAtual,30);
                   Emprestimos.DtEmprestimo:=RetDataAtual;
                   Usuarios.Situacao:=Usuarios.Situacao + 1;
                   Livros.Estado:='E';
                   Etexto(27,14,black,lightgray,Emprestimos.DtEmprestimo);
                   Etexto(61,14,black,lightgray,Emprestimos.DtDevolucao);
                   Controles_formEmprestimos('Emprestar',tipo2,pos,col,rod,true);
                  end    
                else
                  begin
                   rodape('Usuario com 4 livros em sua posse, Impossivel '+
                   'Efetuar Emprestimo !',' ',yellow,red);
                   Controles_formEmprestimos('Fechar',tipo2,pos,col,rod,true);
                  end;
               end
              else
               begin
                rodape('O livro ja esta emprestado, Impossivel '+
                'Efetuar Emprestimo !',' ',yellow,red);
                Controles_formEmprestimos('Fechar',tipo2,pos,col,rod,true);
               end;
             end
             { Devolucao }
           else if tipo2=2 then
             begin
              if PesEmprestimos(Usuarios.Ninsc,Livros.Ninsc)<>-1 then
                begin
                 if Livros.Estado='E' then
                  begin
                   if ((Usuarios.Situacao >= 1) and (Usuarios.Situacao <= 4)) then
                     begin
                      if ConverteData(Emprestimos.DtDevolucao) <
                         ConverteData(RetDataAtual) then
                        begin
                         nDiasAtraso:=0;
                         nMulta:=0.0;
                         nDiasAtraso:=SubtraiDatas(Emprestimos.DtDevolucao,
                         RetDataAtual);
                         nMulta:=(0.5 * nDiasAtraso);
                        end
                      else
                        begin
                         nDiasAtraso:=0;
                         nMulta:=0.0;
                        end;
                      str(nDiasAtraso,sDiasAtraso);
                      str(nMulta:3:2,sMulta);
                      Etexto(27,14,black,lightgray,Emprestimos.DtEmprestimo);
                      Etexto(61,14,black,lightgray,Emprestimos.DtDevolucao);
                      Etexto(23,16,black,lightgray,sDiasAtraso);
                      Etexto(59,16,black,lightgray,sMulta);
                      Usuarios.Situacao:=Usuarios.Situacao - 1;
                      Livros.Estado:='D';
                      Controles_formEmprestimos('Devolver',tipo2,pos,col,
                      rod,true);
                     end
                   else
                     begin
                      rodape('Usuario com 0 livros em sua posse, Impossivel '+
                      'Efetuar Devolucao !',' ',yellow,red);
                      Controles_formEmprestimos('Fechar',tipo2,pos,col,rod,true);
                     end;
                  end
                 else
                  begin
                   rodape('O livro ja esta disponivel, Impossivel '+
                   'Efetuar Devolucao !',' ',yellow,red);
                   Controles_formEmprestimos('Fechar',tipo2,pos,col,rod,true);
                  end;
                end
               else
                begin
                 rodape('Emprestimo inexistente, Impossivel '+
                 'Efetuar Devolucao !',' ',yellow,red);
                 Controles_formEmprestimos('Fechar',tipo2,pos,col,rod,true);
                end;
             end;
             { --- }
         end
        else
         begin
          str(I,S);
          Atribuir_vEmprestimos(true);
          Rotulos_formEmprestimos(tipo2,0);
          rodape('Numero de Inscricao do Livro, nao encontrado !',
          ' ',yellow,red);
          Controles_formEmprestimos('Fechar',tipo2,pos,col,rod,true);
         end;
       end
      else
        Controles_formEmprestimos('Fechar',tipo2,pos,col,rod,true);
     end
    else
     begin
      str(I,S);
      Atribuir_vEmprestimos(true);
      Rotulos_formEmprestimos(tipo2,0);
      rodape('Numero de Inscricao do Usuario, nao encontrado !',
      ' ',yellow,red);
      Controles_formEmprestimos('Fechar',tipo2,pos,col,rod,true);
     end;
   end
  else
    Controles_formEmprestimos('Fechar',tipo2,pos,col,rod,true);
 end
else if tipo='2' then
  begin
   if lista(3,6,5,13,70,nTamEmprestimos+2,113,white,blue,pos,col,foco)=1 then
      begin
        desenhalista(3,6,5,13,70,white,blue,pos,col,false);
        Controles_formEmprestimos('Fechar',tipo2,pos,col,rod,true);
      end;
  end
else if tipo='Emprestar' then
  begin
    case Botao(20,45,black,white,black,blue,' Emprestar ',foco) of
      1:begin
          DesenhaBotao(20,45,black,white,black,blue,' Emprestar ',false);
          Controles_formEmprestimos('Fechar',tipo2,pos,col,rod,true);
        end;
      2:begin
         if PesEmprestimos(Usuarios.Ninsc,Livros.Ninsc)<>-1 then
           begin
            Emprestimos.Removido:=false;
            SalvarEmprestimos(2);
           end
         else
           begin
            Emprestimos.Removido:=false;
            nTamEmprestimos:=FileSize(EmprestimosFile);
            SalvarEmprestimos(1);
           end;
          DesenhaBotao(20,45,black,white,black,blue,' Emprestar ',false);
          Controles_formEmprestimos('Fechar',tipo2,pos,col,rod,true);
        end;
    end;
  end
else if tipo='Devolver' then
  begin
    case Botao(20,45,black,white,black,blue,' Devolver ',foco) of
      1:begin
          DesenhaBotao(20,45,black,white,black,blue,' Devolver ',false);
          Controles_formEmprestimos('Fechar',tipo2,pos,col,rod,true);
        end;
      2:begin
          Emprestimos.Removido:=true;
          SalvarEmprestimos(2);
          DesenhaBotao(20,45,black,white,black,blue,' Devolver ',false);
          Controles_formEmprestimos('Fechar',tipo2,pos,col,rod,true);
        end;
    end;
  end
else if tipo = 'Fechar' then
  begin
    case Botao(20,60,black,white,black,blue,' Fechar ',foco) of
      1:begin
          DesenhaBotao(20,60,black,white,black,blue,' Fechar ',false);
          if (tipo2=1) or (tipo2=2) then
            Controles_formEmprestimos('1',tipo2,pos,col,rod,true)
          else if tipo2=3 then
            Controles_formEmprestimos('2',tipo2,pos,col,rod,true);
        end;
      2:begin
         rodape('',' ',white,blue);
         close(LivrosFile);
         close(UsuariosFile);
         close(EmprestimosFile);
        end;
    end;
  end;

end;
 
{-------------------------------------------------------}

{
 Nome : Atribuir_vEmprestimos
 Descricao : procedimento que atribui ou limpa o vetor de Emprestimos.
 Parametros :
 limpar - indica se vai limpar ou atribuir os vetores
}
procedure TEmprest.Atribuir_vEmprestimos(limpar:boolean);
begin
if limpar=false then
 begin
  with Emprestimos do
    begin
      vEmprestimos[3]:=DtEmprestimo;
      vEmprestimos[4]:=DtDEvolucao;
    end;
 end
else
 begin
  vEmprestimos[2]:=Repete(' ',5);
  vEmprestimos[3]:=Repete(' ',10);
  vEmprestimos[4]:=Repete(' ',10);
 end;
end;

{-------------------------------------------------------}

{
 Nome : SalvarEmprestimos
 Descricao : procedimento que salva os dados digitados no
 formulario de emprestimos.
 Parametros :
 tipo - indica qual acao a salvar
}
procedure TEmprest.SalvarEmprestimos(tipo:integer);
begin
    write(LivrosFile,Livros);
    write(UsuariosFile,Usuarios);
    if tipo=1 then
      begin
        seek(EmprestimosFile,nTamEmprestimos);
        write(EmprestimosFile,Emprestimos);
        Atribuir_vEmprestimos(true);
        Rotulos_formEmprestimos(1,0);
      end
    else if tipo=2 then
      begin
        write(EmprestimosFile,Emprestimos);
        Atribuir_vEmprestimos(true);
        Rotulos_formEmprestimos(1,0);
      end;
end;

end.
