{******************Modulo de Livros**********************}

{
 Nome : PesLivros
 Descricao : funcao que pesquisa as informacoes contidas no arquivo de
 livros
 Parametros :
 tipo - indica se e o valor e (N)umerico ou (S)tring
 campo - qual o campo a ser pesquisado
 nCod2 - codigo do campo se numerico
 sCod2 - codigo do campo se string
 nTamsCod - tamanho caracteres do campo de string
}
function PesLivros(tipo:char;campo:string;nCod2:integer;sCod2:string;
                   nTamsCod:integer):integer;
var
 nPosicao,nCod:integer;
 sCod:string;
 bFlag:boolean;
begin
seek(LivrosFile,0);
nPosicao:=0;
bFlag:=false;
nCod:=0;
sCod:='';
while Not Eof(LivrosFile) do
 begin
   read(LivrosFile,Livros);
   if tipo='N' then
     begin
       if campo='Ninsc' then
          nCod:=Livros.Ninsc;

       if (nCod=nCod2) then
         begin
          PesLivros:=nPosicao;
          seek(LivrosFile,nPosicao);
          bFlag:=true;
          exit;
         end
     end
   else if tipo='S' then
     begin
       if campo='Titulo' then
          sCod:=Livros.titulo
       else if campo='Area' then
          sCod:=Livros.Area
       else if campo='Autor' then
          sCod:=Livros.Autor
       else if campo='Pchave' then
          sCod:=Livros.Pchave;

       if (copy(sCod,1,nTamsCod)=sCod2) then
         begin
          PesLivros:=nPosicao;
          seek(LivrosFile,nPosicao);
          bFlag:=true;
          exit;
         end;
     end;
   nPosicao:=nPosicao+1;
 end;
 if (Eof(LivrosFile)) and (bFlag=false) then
    PesLivros:=-1;
end;

{-----------------------------------------------------}

{
 Nome : formLivros
 Descricao : procedimento que desenha o formulario de livros na tela, e
 tambem indica qual acao a tomar.
 Parametros :
 tipo - indica qual a acao do formulario
 titulo - o titulo do formulario
 rod - o texto do rodape sobre o formulario
}
procedure formLivros(tipo:integer;titulo,rod:string);
begin
  teladefundo('±',white,lightblue);
  rodape(rod,' ',white,blue);  
  formulario(chr(180)+titulo+chr(195),4,2,18,76,white,blue,'±',lightgray,black);

  vLivros[1]:=Repete(' ',5);
  Atribuir_vLivros(true);
  AbrirArquivo(1);
  if (tipo=1) or (tipo=2) then
    begin
     Rotulos_formLivros(0);
     DesenhaBotao(20,45,black,white,black,blue,' Salvar ',false);
     DesenhaBotao(20,60,black,white,black,blue,' Fechar ',false);
    end;
  if (tipo=3) or (tipo=4) or (tipo=5) or (tipo=6) then
    begin
     DesenhaBotao(20,60,black,white,black,blue,' Fechar ',false);
     Rotulos_formLivros(2);
     Etexto(2,7,white,blue,chr(195)+Repete(chr(196),75)+chr(180));
    end;
  if tipo=7 then
     DesenhaBotao(20,60,black,white,black,blue,' Fechar ',false);

  if tipo=3 then
    begin
     Etexto(5,6,white,blue,'Titulo : ');
     Etexto(14,6,black,lightgray,Repete(' ',30));
    end;
  if tipo=4 then
    begin
     Etexto(5,6,white,blue,'Autor : ');
     Etexto(13,6,black,lightgray,Repete(' ',30));
    end;
  if tipo=5 then
    begin
     Etexto(5,6,white,blue,'Area : ');
     Etexto(12,6,black,lightgray,Repete(' ',30));
    end;
  if tipo=6 then
    begin
     Etexto(5,6,white,blue,'Palavra-Chave : ');
     Etexto(21,6,black,lightgray,Repete(' ',10));
    end;

  Limpar_Livros;
  if tipo=1 then
     Controles_formLivros('2',1,0,0,rod,false)  { cadastrar }
  else if tipo=2 then
     Controles_formLivros('1',2,0,0,rod,false)  { alterar }
  else if tipo=3 then
     Controles_formLivros('3',3,0,0,rod,false) { consultar por titulo }
  else if tipo=4 then
     Controles_formLivros('4',4,0,0,rod,false) { consultar por Autor }
  else if tipo=5 then
     Controles_formLivros('5',5,0,0,rod,false) { consultar por Area }
  else if tipo=6 then
     Controles_formLivros('6',6,0,0,rod,false) { consultar por Palavra-chave }
  else if tipo=7 then
     Controles_formLivros('7',7,0,0,rod,true); { consultar todos }
end;

{-------------------------------------------}

{
 Nome : Limpar_Livros
 Descricao : procedimento limpa as variaveis do registro de livros.
}
procedure Limpar_Livros;
begin
   with Livros do
    begin
     Ninsc:=0;
     Titulo:='';
     Autor:='';
     Area:='';
     Pchave:='';
     Edicao:=0;
     AnoPubli:=0;
     Editora:='';
     Volume:=0;
     Estado:=' ';
    end;
end;

{-------------------------------------------}

{
 Nome : Rotulos_formLivros
 Descricao : procedimento que escreve os rotulos do formulario de livros.
 Parametros :
 l - indica um acrescimo na linha do rotulo
}
procedure Rotulos_formLivros(l:integer);
begin
  Etexto(5,6+l,white,blue,'Numero de Inscricao : ');
  Etexto(27,6+l,black,lightgray,vlivros[1]);
  Etexto(35,6+l,white,blue,'Titulo : ');
  Etexto(44,6+l,black,lightgray,vlivros[2]);
  Etexto(5,8+l,white,blue,'Autor : ');
  Etexto(13,8+l,black,lightgray,vlivros[3]);
  Etexto(5,10+l,white,blue,'Area : ');
  Etexto(12,10+l,black,lightgray,vlivros[4]);
  Etexto(5,12+l,white,blue,'Palavra-Chave : ');
  Etexto(21,12+l,black,lightgray,vlivros[5]);
  Etexto(35,12+l,white,blue,'Edicao : ');
  Etexto(44,12+l,black,lightgray,vlivros[6]);
  Etexto(5,14+l,white,blue,'Ano de Publicacao : ');
  Etexto(25,14+l,black,lightgray,vlivros[7]);
  Etexto(35,14+l,white,blue,'Editora : ');
  Etexto(45,14+l,black,lightgray,vlivros[8]);
  Etexto(5,16+l,white,blue,'Volume : ');
  Etexto(14,16+l,black,lightgray,vlivros[9]);
  Etexto(22,16+l,white,blue,'Estado Atual : ');
  Etexto(37,16+l,black,lightgray,vlivros[10]);
  Etexto(40,16+l,white,blue,'(D)isponivel ou (E)mprestado');

end;
{-------------------------------------------}

{
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
}
procedure Controles_formLivros(tipo:string;tipo2,pos,col:integer;rod:string;
                               foco:boolean);
begin
if tipo='1' then
   begin
      Digita(S,5,5,28,5,black,lightgray,'N',0); { Ninsc }
      Val(S,I,C);
      Livros.Ninsc:=I;
      if (length(S) > 0) and (S<>Repete(' ',length(S))) then
        begin
         DesenhaBotao(20,45,black,white,black,blue,' Salvar ',false);
         if PesLivros('N','Ninsc',I,'',0)<>-1 then
           begin
                Atribuir_vLivros(false);
                Rotulos_formLivros(0);
                rodape(rod,' ',white,blue);
                Controles_formLivros('2',tipo2,pos,col,rod,false);
           end
         else
           begin
            str(I,S);
            Atribuir_vLivros(true);
            Rotulos_formLivros(0);
            rodape('Numero de Inscricao, nao encontrado !',' ',yellow,red);
            Controles_formLivros('Fechar',tipo2,pos,col,rod,true);
           end;
        end
      else
        Controles_formLivros('Fechar',tipo2,pos,col,rod,true);
   end
else if tipo='2' then
   begin
     with Livros do
      begin
        if tipo2=1 then
          begin
            nTamLivros:=FileSize(LivrosFile);
            if nTamLivros = 0 then
               Ninsc:=1
            else
               Ninsc:=nTamLivros + 1;
            I:=Ninsc;
            str(Ninsc,S);
            Etexto(27,6,black,lightgray,S);
            S:='';
          end
        else if tipo2=2 then
          begin
            AbrirArquivo(1);
            if PesLivros('N','Ninsc',I,'',0)=-1 then
              rodape('Numero de Inscricao, nao encontrado !',' ',yellow,red);
          end;
          Digita_formLivros;
      end;
      Controles_formLivros('Salvar',tipo2,pos,col,rod,true);
   end
else if tipo='3' then
    begin
      S:='';
      Digita(S,30,30,15,5,black,lightgray,'T',0);
      Livros.Titulo:=S;
      if (length(S) > 0) and (S<>Repete(' ',length(S))) then
        begin
         if PesLivros('S','Titulo',0,S,length(S))<>-1 then
           begin
              Atribuir_vLivros(false);
              Rotulos_formLivros(2);
              rodape(rod,' ',white,blue);
           end
         else
           begin
            Atribuir_vLivros(true);
            Rotulos_formLivros(2);
            rodape('Titulo do Livro, nao encontrado !',' ',yellow,red);
           end;
        end;
        Controles_formLivros('Fechar',tipo2,pos,col,rod,true);
    end
else if tipo='4' then
    begin
      S:='';
      Digita(S,30,30,14,5,black,lightgray,'T',0);
      Livros.Autor:=S;
      if (length(S) > 0) and (S<>Repete(' ',length(S))) then
        begin
         if PesLivros('S','Autor',0,S,length(S))<>-1 then
           begin
              Atribuir_vLivros(false);
              Rotulos_formLivros(2);
              rodape(rod,' ',white,blue);
           end
         else
           begin
            Atribuir_vLivros(true);
            Rotulos_formLivros(2);
            rodape('Autor do Livro, nao encontrado !',' ',yellow,red);
           end;
        end;
        Controles_formLivros('Fechar',tipo2,pos,col,rod,true);
    end
else if tipo='5' then
    begin
      S:='';
      Digita(S,4,4,13,5,black,lightgray,'T',0);
      Livros.Area:=S;
      if (length(S) > 0) and (S<>Repete(' ',length(S))) then
        begin
         if PesLivros('S','Area',0,S,length(S))<>-1 then
           begin
              Atribuir_vLivros(false);
              Rotulos_formLivros(2);
              rodape(rod,' ',white,blue);
           end
         else
           begin
            Atribuir_vLivros(true);
            Rotulos_formLivros(2);
            rodape('Area do Livro, nao encontrada !',' ',yellow,red);
           end;
        end;
        Controles_formLivros('Fechar',tipo2,pos,col,rod,true);
    end
else if tipo='6' then
    begin
      S:='';
      Digita(S,10,10,22,5,black,lightgray,'T',0);
      Livros.PChave:=S;
      if (length(S) > 0) and (S<>Repete(' ',length(S))) then
        begin
         if PesLivros('S','Pchave',0,S,length(S))<>-1 then
           begin
              Atribuir_vLivros(false);
              Rotulos_formLivros(2);
              rodape(rod,' ',white,blue);
           end
         else
           begin
            Atribuir_vLivros(true);
            Rotulos_formLivros(2);
            rodape('Palavra-Chave do Livro, nao encontrado !',' ',yellow,red);
           end;
        end;
        Controles_formLivros('Fechar',tipo2,pos,col,rod,true);
    end
else if tipo='7' then
  begin
    if lista(1,6,5,13,70,nTamLivros+2,220,white,blue,pos,col,foco)=1 then
      begin
        desenhalista(1,6,5,13,70,white,blue,pos,col,false);
        Controles_formLivros('Fechar',tipo2,pos,col,rod,true);
      end;
  end
else if tipo='Salvar' then
  begin
    case Botao(20,45,black,white,black,blue,' Salvar ',foco) of
      1:begin
          DesenhaBotao(20,45,black,white,black,blue,' Salvar ',false);
          Controles_formLivros('Fechar',tipo2,pos,col,rod,true);
        end;
      2:begin
          SalvarLivros(tipo2);
          DesenhaBotao(20,45,black,white,black,blue,' Salvar ',false);
          Controles_formLivros('Fechar',tipo2,pos,col,rod,true);
        end;
    end;
  end
else if tipo = 'Fechar' then
  begin
    case Botao(20,60,black,white,black,blue,' Fechar ',foco) of
      1:begin
          DesenhaBotao(20,60,black,white,black,blue,' Fechar ',false);
          if tipo2=1 then
            Controles_formLivros('2',tipo2,pos,col,rod,true)
          else if tipo2=2 then
            Controles_formLivros('1',tipo2,pos,col,rod,false)
          else if tipo2=3 then
            Controles_formLivros('3',tipo2,pos,col,rod,false)
          else if tipo2=4 then
            Controles_formLivros('4',tipo2,pos,col,rod,false)
          else if tipo2=5 then
            Controles_formLivros('5',tipo2,pos,col,rod,false)
          else if tipo2=6 then
            Controles_formLivros('6',tipo2,pos,col,rod,false)
          else if tipo2=7 then
            Controles_formLivros('7',tipo2,pos,col,rod,true);

        end;
      2:begin
         rodape('',' ',white,blue);
         close(LivrosFile);
        end;
    end;
  end;

end;

{-------------------------------------------------------}

{
 Nome : Atribuir_vLivros
 Descricao : procedimento que atribui ou limpa o vetor de livros.
 Parametros :
 limpar - indica se vai limpar ou atribuir os vetores
}
procedure Atribuir_vLivros(limpar:boolean);
begin
if limpar=false then
 begin
  with Livros do
    begin
      str(Ninsc,S);
      vLivros[1]:=S;
      vLivros[2]:=Titulo;
      vLivros[3]:=Autor;
      vLivros[4]:=Area;
      vLivros[5]:=Pchave;
      Str(Edicao,S);
      vLivros[6]:=S;
      Str(AnoPubli,S);
      vLivros[7]:=S;
      vLivros[8]:=Editora;
      Str(Volume,S);
      vLivros[9]:=S;
      vLivros[10]:=Estado;
    end;
 end
else
 begin
  vLivros[2]:=Repete(' ',30);
  vLivros[3]:=Repete(' ',30);
  vLivros[4]:=Repete(' ',30);
  vLivros[5]:=Repete(' ',10);
  vLivros[6]:=Repete(' ',4);
  vLivros[7]:=Repete(' ',4);
  vLivros[8]:=Repete(' ',30);
  vLivros[9]:=Repete(' ',4);
  vLivros[10]:=Repete(' ',1);
 end;
end;

{-------------------------------------------------------}

{
 Nome : Digita_formLivros
 Descricao : procedimento que realiza o cotrole de digitacao dos dados no
 formulario de livros.
}
procedure Digita_formLivros;
begin
     with Livros do
      begin
        S:=Titulo;
        Digita(S,30,30,45,5,black,lightgray,'T',0);
        Titulo:=S;
        S:=Autor;
        Digita(S,30,30,14,7,black,lightgray,'T',0);
        Autor:=S;
        S:=Area;
        Digita(S,30,30,13,9,black,lightgray,'T',0);
        Area:=S;
        S:=PChave;
        Digita(S,10,10,22,11,black,lightgray,'T',0);
        Pchave:=S;
        Str(Edicao,S);
        Digita(S,4,4,45,11,black,lightgray,'N',0);
        Val(S,I,C);
        Edicao:=I;
        Str(AnoPubli,S);
        Digita(S,4,4,26,13,black,lightgray,'N',0);
        Val(S,I,C);
        AnoPubli:=I;
        S:=Editora;
        Digita(S,30,30,46,13,black,lightgray,'T',0);
        Editora:=S;
        str(Volume,S);
        Digita(S,4,4,15,15,black,lightgray,'N',0);
        Val(S,I,C);
        Volume:=I;
        S:=Estado;
        Digita(S,1,1,38,15,black,lightgray,'T',0);
        Estado:=S[1];
        S:='';
      end;
end;

{-------------------------------------------------------}

{
 Nome : VerificaLivros
 Descricao : funcao que verifica se os dados no formulario de livros
 foram digitados.
}
function VerificaLivros:boolean;
begin
with Livros do
 begin
  str(Ninsc,S);
  if (length(S) = 0) and (S=Repete(' ',length(S))) then
    begin
      rodape('Numero de Inscricao, nao cadastrado !',' ',yellow,red);
      VerificaLivros:=false;
      exit
    end;
  if (length(Titulo) = 0) and (Titulo=Repete(' ',length(Titulo))) then
    begin
      rodape('Titulo, nao cadastrado !',' ',yellow,red);
      VerificaLivros:=false;
      exit
    end;
  if (length(Autor) = 0) and (Autor=Repete(' ',length(Autor))) then
    begin
      rodape('Autor, nao cadastrado !',' ',yellow,red);
      VerificaLivros:=false;
      exit
    end;
  if (length(Area) = 0) and (Area=Repete(' ',length(Area))) then
    begin
      rodape('Area, nao cadastrada !',' ',yellow,red);
      VerificaLivros:=false;
      exit
    end;
  if (length(Pchave) = 0) and (Pchave=Repete(' ',length(Pchave))) then
    begin
      rodape('Palavra-Chave, nao cadastrada !',' ',yellow,red);
      VerificaLivros:=false;
      exit
    end;
  str(Edicao,S);
  if (length(S) = 0) and (S=Repete(' ',length(S))) then
    begin
      rodape('Edicao, nao cadastrada !',' ',yellow,red);
      VerificaLivros:=false;
      exit
    end;
  str(AnoPubli,S);
  if (length(S) = 0) and (S=Repete(' ',length(S))) then
    begin
      rodape('Ano de Publicacao, nao cadastrado !',' ',yellow,red);
      VerificaLivros:=false;
      exit
    end;
  if (length(Editora) = 0) and (Editora=Repete(' ',length(Editora))) then
    begin
      rodape('Editora, nao cadastrada !',' ',yellow,red);
      VerificaLivros:=false;
      exit
    end;
  str(Volume,S);
  if (length(S) = 0) and (S=Repete(' ',length(S))) then
    begin
      rodape('Volume, nao cadastrado !',' ',yellow,red);
      VerificaLivros:=false;
      exit
    end;
  if (length(Estado) = 0) and (Estado=Repete(' ',length(Estado))) then
    begin
      rodape('Estado, nao cadastrado !',' ',yellow,red);
      VerificaLivros:=false;
      exit
    end;

 end;
 VerificaLivros:=true;
end;

{---------------------------------------------------------------}

{
 Nome : SalvarLivros
 Descricao : procedimento que salva os dados digitados no
 formulario de livros.
 Parametros :
 tipo - indica qual acao a salvar
}
procedure SalvarLivros(tipo:integer);
begin
if VerificaLivros=true then
begin
if (Livros.Estado='D') or (Livros.Estado='E') then
  begin
    if tipo=1 then
      begin
        seek(LivrosFile,nTamLivros);
        write(LivrosFile,Livros);
        Atribuir_vLivros(true);
        Rotulos_formLivros(0);
        Limpar_Livros;
      end
    else if tipo=2 then
       write(LivrosFile,Livros);
  end
else
  rodape('Estado Atual, Cadastrado Incorretamente !',' ',yellow,red);
end;

end;

