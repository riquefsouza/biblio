unit UUsuario;

interface

uses crt, dos, UBiblio;

{ Declaracao de tipos }

type
 
 TUsuario = object(TBiblio)

   { variaveis do modulo de Usuarios }

   vUsuarios : array[1..11] of String[30];
   I,C : integer;

   { Declaracao de funcoes }

   function PesUsuarios(tipo:char;campo:string;nCod2:integer;sCod2:string;
                        nTamsCod:integer):integer; 
   function PesBinaria(Chave:integer):integer;
   function VerificaUsuarios:boolean;

   { Declaracao de Procedimentos }

   procedure formUsuarios(tipo:integer;titulo,rod:string); 
   procedure Limpar_Usuarios; 
   procedure Rotulos_formUsuarios(l:integer); 
   procedure Controles_formUsuarios(tipo:string;tipo2,pos,
          col:integer;rod:string;foco:boolean); 
   procedure Atribuir_vUsuarios(limpar:boolean); 
   procedure Digita_formUsuarios; 
   procedure SalvarUsuarios(tipo:integer); 

 end;

implementation

{******************Unidade de Usuarios**********************}

{
 Nome : PesUsuarios
 Descricao : funcao que pesquisa as informacoes contidas no arquivo de
 usuarios.
 Parametros :
 tipo - indica se e o valor e (N)umerico ou (S)tring
 campo - qual o campo a ser pesquisado
 nCod2 - codigo do campo se numerico
 sCod2 - codigo do campo se string
 nTamsCod - tamanho caracteres do campo de string
}
function TUsuario.PesUsuarios(tipo:char;campo:string;nCod2:integer;
                              sCod2:string;nTamsCod:integer):integer;
var
 nPosicao,nCod:integer;
 sCod:string;
 bFlag:boolean;
begin
seek(UsuariosFile,0);
nPosicao:=0;
bFlag:=false;
nCod:=0;
sCod:='';
while Not Eof(UsuariosFile) do
 begin
   read(UsuariosFile,Usuarios);
   if tipo='N' then
     begin
       if campo='Ninsc' then
          nCod:=Usuarios.Ninsc;

       if (nCod=nCod2) then
         begin
          PesUsuarios:=nPosicao;
          seek(UsuariosFile,nPosicao);
          bFlag:=true;
          exit;
         end
     end
   else if tipo='S' then
     begin
       if campo='Nome' then
          sCod:=Usuarios.Nome
       else if campo='Ident' then
          sCod:=Usuarios.Ident;

       if (copy(sCod,1,nTamsCod)=sCod2) then
         begin
          PesUsuarios:=nPosicao;
          seek(UsuariosFile,nPosicao);
          bFlag:=true;
          exit;
         end;
     end;
   nPosicao:=nPosicao+1;
 end;
 if (Eof(UsuariosFile)) and (bFlag=false) then
    PesUsuarios:=-1;
end;

{-----------------------------------------------------}

{
 Nome : PesBinaria
 Descricao : funcao que realiza uma pesquisa binaria
 por numero de inscricao do usuario.
 Parametros :
 Chave - numero de inscricao do usuario a pesquisar
}
function TUsuario.PesBinaria(Chave:integer):integer;
var
 inicio,fim,meio:integer;
 achou:boolean;
begin
 inicio:=1;
 fim:=nTamUsuarios+1;
 achou:=false;
 while ((not achou) and (inicio <= fim)) do
  begin
   meio:=((inicio+fim) div 2);
   seek(UsuariosFile,meio-1);
   read(UsuariosFile,Usuarios);
   if (chave=Usuarios.Ninsc) then
      achou:=true
   else
    begin
      if (chave > Usuarios.Ninsc) then
        inicio:=meio+1
      else
        fim:=meio-1;
    end;
  end;
 if achou=true then
    PesBinaria:=meio-1
 else
    PesBinaria:=-1;
end;

{-----------------------------------------------------}

{
 Nome : formUsuarios
 Descricao : procedimento que desenha o formulario de Usuarios na tela, e
 tambem indica qual acao a tomar.
 Parametros :
 tipo - indica qual a acao do formulario
 titulo - o titulo do formulario
 rod - o texto do rodape sobre o formulario
}
procedure TUsuario.formUsuarios(tipo:integer;titulo,rod:string);
begin
  teladefundo('±',white,lightblue);
  rodape(rod,' ',white,blue);
  formulario(chr(180)+titulo+chr(195),4,2,18,76,white,blue,'±',lightgray,black);

  vUsuarios[1]:=Repete(' ',5);
  Atribuir_vUsuarios(true);
  AbrirArquivo(2);
  if (tipo=1) or (tipo=2) then
    begin
     Rotulos_formUsuarios(0);
     DesenhaBotao(20,48,black,white,black,blue,' Salvar ',false);
     DesenhaBotao(20,63,black,white,black,blue,' Fechar ',false);
    end;
  if (tipo=3) or (tipo=4) or (tipo=5) then
    begin
     DesenhaBotao(20,63,black,white,black,blue,' Fechar ',false);
     Rotulos_formUsuarios(2);
     Etexto(2,7,white,blue,chr(195)+Repete(chr(196),75)+chr(180));
    end;
  if tipo=6 then
     DesenhaBotao(20,63,black,white,black,blue,' Fechar ',false);

  if tipo=3 then
    begin
     Etexto(5,6,white,blue,'Numero de Inscricao : ');
     Etexto(27,6,black,lightgray,Repete(' ',5));
    end;
  if tipo=4 then
    begin
     Etexto(5,6,white,blue,'Nome : ');
     Etexto(12,6,black,lightgray,Repete(' ',30));
    end;
  if tipo=5 then
    begin
     Etexto(5,6,white,blue,'Identidade : ');
     Etexto(18,6,black,lightgray,Repete(' ',10));
    end;

  Limpar_Usuarios;
  if tipo=1 then
     Controles_formUsuarios('2',1,0,0,rod,false)  { cadastrar }
  else if tipo=2 then
     Controles_formUsuarios('1',2,0,0,rod,false)  { alterar }
  else if tipo=3 then
     Controles_formUsuarios('3',3,0,0,rod,false) { consultar por NInsc }
  else if tipo=4 then
     Controles_formUsuarios('4',4,0,0,rod,false) { consultar por Nome }
  else if tipo=5 then
     Controles_formUsuarios('5',5,0,0,rod,false) { consultar por Identidade }
  else if tipo=6 then
     Controles_formUsuarios('6',6,0,0,rod,true); { consultar todos }
end;

{-------------------------------------------}

{
 Nome : Limpar_Usuarios
 Descricao : procedimento limpa as variaveis do registro de usuarios.
}
procedure TUsuario.Limpar_Usuarios;
begin
   with Usuarios do
    begin
     Ninsc:=0;
     Nome:='';
     Ident:='0';
     Endereco.Logra:='';
     Endereco.Numero:=0;
     Endereco.Compl:='';
     Endereco.Bairro:='';
     Endereco.Cep:='0';
     Telefone:='0';
     Categoria:=' ';
     Situacao:=0;
    end;
end;

{-------------------------------------------}

{
 Nome : Rotulos_formUsuarios
 Descricao : procedimento que escreve os rotulos do formulario de Usuarios.
 Parametros :
 l - indica um acrescimo na linha do rotulo
}
procedure TUsuario.Rotulos_formUsuarios(l:integer);
begin
  Etexto(5,6+l,white,blue,'Numero de Inscricao : ');
  Etexto(27,6+l,black,lightgray,vUsuarios[1]);
  Etexto(35,6+l,white,blue,'Nome : ');
  Etexto(42,6+l,black,lightgray,vUsuarios[2]);
  Etexto(5,8+l,white,blue,'Identidade : ');
  Etexto(18,8+l,black,lightgray,vUsuarios[3]);
  Etexto(2,10+l,white,blue,chr(195)+Repete('Ä',75)+chr(180));
  Etexto(5,10+l,white,blue,'Endereco');
  Etexto(5,12+l,white,blue,'Logradouro : ');
  Etexto(18,12+l,black,lightgray,vUsuarios[4]);
  Etexto(51,12+l,white,blue,'Numero : ');
  Etexto(60,12+l,black,lightgray,vUsuarios[5]);
  Etexto(5,14+l,white,blue,'Complemento : ');
  Etexto(19,14+l,black,lightgray,vUsuarios[6]);
  Etexto(32,14+l,white,blue,'Bairro : ');
  Etexto(41,14+l,black,lightgray,vUsuarios[7]);
  Etexto(63,14+l,white,blue,'Cep : ');
  Etexto(69,14+l,black,lightgray,vUsuarios[8]);
  Etexto(2,16+l,white,blue,chr(195)+repete('Ä',75)+chr(180));
  Etexto(31,8+l,white,blue,'Telefone : ');
  Etexto(42,8+l,black,lightgray,vUsuarios[9]);
  Etexto(5,17+l,white,blue,'Categoria : ');
  Etexto(17,17+l,black,lightgray,vUsuarios[10]);
  Etexto(20,17+l,white,blue,'(A)luno ou (P)rofessor ou (F)uncionario');
  Etexto(5,19+l,white,blue,'Situacao : ');
  Etexto(16,19+l,black,lightgray,vUsuarios[11]);

end;
{-------------------------------------------}

{
 Nome : Controles_formUsuarios
 Descricao : procedimento que realiza todo o controle de manuseio do
 formulario de Usuarios.
 Parametros :
 tipo - indica qual a acao do formulario
 tipo2 - indica a acao original do formulario nao manipulado pela funcao
 pos - indica a ultima posicao da linha da lista de usuarios
 col - indica a ultima posicao da coluna da lista de usuarios
 rod - o texto do rodape sobre o formulario
 foco - se os objetos do formulario estao focados ou nao
}
procedure TUsuario.Controles_formUsuarios(tipo:string;tipo2,pos,col:integer;
                                 rod:string;foco:boolean);
begin
if tipo='1' then
   begin
      Digita(S,5,5,28,5,black,lightgray,'N',0); { N insc }
      Val(S,I,C);
      Usuarios.Ninsc:=I;
      if (length(S) > 0) and (S<>Repete(' ',length(S))) then
        begin
         DesenhaBotao(20,48,black,white,black,blue,' Salvar ',false);
         if PesUsuarios('N','Ninsc',I,'',0)<>-1 then
           begin
                Atribuir_vUsuarios(false);
                Rotulos_formUsuarios(0);
                rodape(rod,' ',white,blue);
                Controles_formUsuarios('2',tipo2,pos,col,rod,false);
           end
         else
           begin
            str(I,S);
            Atribuir_vUsuarios(true);
            Rotulos_formUsuarios(0);
            rodape('Numero de Inscricao, nao encontrado !',' ',yellow,red);
            Controles_formUsuarios('Fechar',tipo2,pos,col,rod,true);
           end;
        end
      else
        Controles_formUsuarios('Fechar',tipo2,pos,col,rod,true);
   end
else if tipo='2' then
   begin
     with Usuarios do
      begin
        if tipo2=1 then
          begin
            nTamUsuarios:=FileSize(UsuariosFile);
            if nTamUsuarios = 0 then
               Ninsc:=1
            else            
               Ninsc:=nTamUsuarios + 1;
            I:=Ninsc;
            str(Ninsc,S);
            Etexto(27,6,black,lightgray,S);
            S:='';
          end
        else if tipo2=2 then
          begin
            AbrirArquivo(2);
            if PesUsuarios('N','Ninsc',I,'',0)=-1 then
              rodape('Numero de Inscricao, nao encontrado !',' ',yellow,red);
          end;
          Digita_formUsuarios;
      end;
      Controles_formUsuarios('Salvar',tipo2,pos,col,rod,true);
   end
else if tipo='3' then
    begin
      S:='';
      Digita(S,5,5,28,5,black,lightgray,'N',0); { N insc }
      Val(S,I,C);
      Usuarios.Ninsc:=I;
      if (length(S) > 0) and (S<>Repete(' ',length(S))) then
        begin
         if PesBinaria(I)<>-1 then
           begin
              Atribuir_vUsuarios(false);
              Rotulos_formUsuarios(2);
              rodape(rod,' ',white,blue);
           end
         else
           begin
            Atribuir_vUsuarios(true);
            Rotulos_formUsuarios(2);
            rodape('Numero de Inscricao, nao encontrado !',' ',yellow,red);
           end;
        end;
        Controles_formUsuarios('Fechar',tipo2,pos,col,rod,true);
    end
else if tipo='4' then
    begin
      S:='';
      Digita(S,30,30,13,5,black,lightgray,'T',0);
      Usuarios.Nome:=S;
      if (length(S) > 0) and (S<>Repete(' ',length(S))) then
        begin
         if PesUsuarios('S','Nome',0,S,length(S))<>-1 then
           begin
              Atribuir_vUsuarios(false);
              Rotulos_formUsuarios(2);
              rodape(rod,' ',white,blue);
           end
         else
           begin
            Atribuir_vUsuarios(true);
            Rotulos_formUsuarios(2);
            rodape('Nome do Usuario, nao encontrado !',' ',yellow,red);
           end;
        end;
        Controles_formUsuarios('Fechar',tipo2,pos,col,rod,true);
    end
else if tipo='5' then
    begin
      S:='';
      Digita(S,10,10,19,5,black,lightgray,'N',0);
      Usuarios.Ident:=S;
      if (length(S) > 0) and (S<>Repete(' ',length(S))) then
        begin
         if PesUsuarios('N','Ident',0,S,length(S))<>-1 then
           begin
              Atribuir_vUsuarios(false);
              Rotulos_formUsuarios(2);
              rodape(rod,' ',white,blue);
           end
         else
           begin
            Atribuir_vUsuarios(true);
            Rotulos_formUsuarios(2);
            rodape('Identidade do Usuario, nao encontrada !',' ',yellow,red);
           end;
        end;
        Controles_formUsuarios('Fechar',tipo2,pos,col,rod,true);
    end
else if tipo='6' then
  begin
    if lista(2,6,5,13,70,nTamUsuarios+2,194,white,blue,pos,col,foco)=1 then
      begin
        desenhalista(2,6,5,13,70,white,blue,pos,col,false);
        Controles_formUsuarios('Fechar',tipo2,pos,col,rod,true);
      end;
  end
else if tipo='Salvar' then
  begin
    case Botao(20,48,black,white,black,blue,' Salvar ',foco) of
      1:begin
          DesenhaBotao(20,48,black,white,black,blue,' Salvar ',false);
          Controles_formUsuarios('Fechar',tipo2,pos,col,rod,true);
        end;
      2:begin
          SalvarUsuarios(tipo2);
          DesenhaBotao(20,48,black,white,black,blue,' Salvar ',false);
          Controles_formUsuarios('Fechar',tipo2,pos,col,rod,true);
        end;
    end;
  end
else if tipo = 'Fechar' then
  begin
    case Botao(20,63,black,white,black,blue,' Fechar ',foco) of
      1:begin
          DesenhaBotao(20,63,black,white,black,blue,' Fechar ',false);
          if tipo2=1 then
            Controles_formUsuarios('2',tipo2,pos,col,rod,true)
          else if tipo2=2 then
            Controles_formUsuarios('1',tipo2,pos,col,rod,false)
          else if tipo2=3 then
            Controles_formUsuarios('3',tipo2,pos,col,rod,false)
          else if tipo2=4 then
            Controles_formUsuarios('4',tipo2,pos,col,rod,false)
          else if tipo2=5 then
            Controles_formUsuarios('5',tipo2,pos,col,rod,false)
          else if tipo2=6 then
            Controles_formUsuarios('6',tipo2,pos,col,rod,true);
        end;
      2:begin
         rodape('',' ',white,blue);
         close(UsuariosFile);
        end;
    end;
  end;

end;

{-------------------------------------------------------}

{
 Nome : Atribuir_vUsuarios
 Descricao : procedimento que atribui ou limpa o vetor de Usuarios.
 Parametros :
 limpar - indica se vai limpar ou atribuir os vetores
}
procedure TUsuario.Atribuir_vUsuarios(limpar:boolean);
begin
if limpar=false then
 begin
  with Usuarios do
    begin
      str(Ninsc,S);
      vUsuarios[1]:=S;
      vUsuarios[2]:=Nome;
      vUsuarios[3]:=Ident;
      vUsuarios[4]:=Endereco.Logra;
      str(Endereco.numero,S);
      vUsuarios[5]:=S;
      vUsuarios[6]:=Endereco.Compl;
      vUsuarios[7]:=Endereco.Bairro;
      vUsuarios[8]:=Endereco.Cep;
      vUsuarios[9]:=Telefone;
      vUsuarios[10]:=Categoria;
      str(Situacao,S);
      vUsuarios[11]:=S;
    end;
 end
else
 begin
  vUsuarios[2]:=Repete(' ',30);
  vUsuarios[3]:=Repete(' ',10);
  vUsuarios[4]:=Repete(' ',30);
  vUsuarios[5]:=Repete(' ',5);
  vUsuarios[6]:=Repete(' ',10);
  vUsuarios[7]:=Repete(' ',20);
  vUsuarios[8]:=Repete(' ',8);
  vUsuarios[9]:=Repete(' ',11);
  vUsuarios[10]:=Repete(' ',1);
  vUsuarios[11]:=Repete(' ',1);
 end;
end;

{-------------------------------------------------------}

{
 Nome : Digita_formUsuarios
 Descricao : procedimento que realiza o cotrole de digitacao dos dados no
 formulario de usuarios.
}
procedure TUsuario.Digita_formUsuarios;
begin
     with Usuarios do
      begin
        S:=Nome;
        Digita(S,30,30,43,5,black,lightgray,'T',0);
        Nome:=S;
        S:=Ident;
        Digita(S,10,10,19,7,black,lightgray,'N',0);
        Ident:=S;
        S:=Telefone;
        Digita(S,11,11,43,7,black,lightgray,'N',0);
        Telefone:=S;
        S:=Endereco.Logra;
        Digita(S,30,30,19,11,black,lightgray,'T',0);
        Endereco.Logra:=S;
        Str(Endereco.numero,S);
        Digita(S,5,5,61,11,black,lightgray,'N',0);
        Val(S,I,C);
        Endereco.numero:=I;
        S:=Endereco.compl;
        Digita(S,10,10,20,13,black,lightgray,'T',0);
        Endereco.compl:=S;
        S:=Endereco.Bairro;
        Digita(S,20,20,42,13,black,lightgray,'T',0);
        Endereco.Bairro:=S;
        S:=Endereco.Cep;
        Digita(S,8,8,70,13,black,lightgray,'N',0);
        Endereco.Cep:=S;
        S:=Categoria;
        Digita(S,1,1,18,16,black,lightgray,'T',0);
        Categoria:=S[1];
        str(Situacao,S);
        Digita(S,1,1,17,18,black,lightgray,'N',0);
        Val(S,I,C);
        Situacao:=I;
        S:='';
      end;
end;

{-------------------------------------------------------}

{
 Nome : VerificaUsuarios
 Descricao : funcao que verifica se os dados no formulario de usuarios
 foram digitados.
}
function TUsuario.VerificaUsuarios:boolean;
begin
with Usuarios do
 begin
  str(Ninsc,S);
  if (length(S) = 0) and (S=Repete(' ',length(S))) then
    begin
      rodape('Numero de Inscricao, nao cadastrado !',' ',yellow,red);
      VerificaUsuarios:=false;
      exit
    end;
  if (length(Nome) = 0) and (Nome=Repete(' ',length(Nome))) then
    begin
      rodape('Nome do Usuario, nao cadastrado !',' ',yellow,red);
      VerificaUsuarios:=false;
      exit
    end;
  if (length(Ident) = 0) and (Ident=Repete(' ',length(Ident))) then
    begin
      rodape('Identidade, nao cadastrada !',' ',yellow,red);
      VerificaUsuarios:=false;
      exit
    end;
  if (length(Endereco.logra) = 0) and
     (Endereco.logra=Repete(' ',length(Endereco.logra))) then
    begin
      rodape('Logradouro, nao cadastrado !',' ',yellow,red);
      VerificaUsuarios:=false;
      exit
    end;
  str(Endereco.numero,S);
  if (length(S) = 0) and (S=Repete(' ',length(S))) then
    begin
      rodape('Numero do Endereco, nao cadastrado !',' ',yellow,red);
      VerificaUsuarios:=false;
      exit
    end;
  if (length(Endereco.compl) = 0)
     and (Endereco.compl=Repete(' ',length(Endereco.compl))) then
    begin
      rodape('Complemento do Endereco, nao cadastrado !',' ',yellow,red);
      VerificaUsuarios:=false;
      exit
    end;
  if (length(Endereco.Bairro) = 0)
     and (Endereco.Bairro=Repete(' ',length(Endereco.Bairro))) then
    begin
      rodape('Bairro, nao cadastrado !',' ',yellow,red);
      VerificaUsuarios:=false;
      exit
    end;
  if (length(Endereco.Cep) = 0) and
     (Endereco.Cep=Repete(' ',length(Endereco.Cep))) then
    begin
      rodape('Cep, nao cadastrado !',' ',yellow,red);
      VerificaUsuarios:=false;
      exit
    end;
  if (length(Telefone) = 0) and (Telefone=Repete(' ',length(Telefone))) then
    begin
      rodape('Telefone, nao cadastrado !',' ',yellow,red);
      VerificaUsuarios:=false;
      exit
    end;
  if (length(Categoria) = 0) and
     (Categoria=Repete(' ',length(Categoria))) then
    begin
      rodape('Categoria, nao cadastrada !',' ',yellow,red);
      VerificaUsuarios:=false;
      exit
    end;

 end;
 VerificaUsuarios:=true;
end;

{---------------------------------------------------------------}

{
 Nome : SalvarUsuarios
 Descricao : procedimento que salva os dados digitados no
 formulario de usuarios.
 Parametros :
 tipo - indica qual acao a salvar
}
procedure TUsuario.SalvarUsuarios(tipo:integer);
begin
if VerificaUsuarios=true then
begin
if (Usuarios.Categoria='A') or (Usuarios.Categoria='P')
   or (Usuarios.Categoria='F') then
  begin
    if tipo=1 then
      begin
        seek(UsuariosFile,nTamUsuarios);
        write(UsuariosFile,Usuarios);
        Atribuir_vUsuarios(true);
        Rotulos_formUsuarios(0);
        Limpar_Usuarios;
      end
    else if tipo=2 then
       write(UsuariosFile,Usuarios);
  end
else
  rodape('Categoria, Cadastrada Incorretamente !',' ',yellow,red);
end;

end;

end.
