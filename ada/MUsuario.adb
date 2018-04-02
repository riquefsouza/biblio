package body MUsuario is

--******************Modulo de Usuarios**********************--

--
-- Nome : PesUsuarios
-- Descricao : funcao que pesquisa as informacoes contidas no arquivo de
-- usuarios.
-- Parametros :
-- tipo - indica se e o valor e (N)umerico ou (S)tring
-- campo - qual o campo a ser pesquisado
-- nCod2 - codigo do campo se numerico
-- sCod2 - codigo do campo se string
-- nTamsCod - tamanho caracteres do campo de string
--
function PesUsuarios(tipo: in character;campo: in string;nCod2: in integer;
                     sCod2: in string;nTamsCod: in integer) return integer is
 nPosicao,nCod,nRet:integer:=0;
 sCod:ustring;
 bFlag:boolean:=false;
begin
UsuariosIO.set_index(UsuariosFile,1);
nPosicao:=1;
bFlag:=false;
nCod:=1;
sCod:=null_unbounded_string;
while Not(UsuariosIO.End_of_file(UsuariosFile)) loop
   UsuariosIO.read(UsuariosFile,bUsuarios);
   fatribuir(2,true);

   if tipo='N' then
       if campo="Ninsc" then
          nCod:=Usuarios.Ninsc;
       end if;
       if (nCod=nCod2) then
          nRet:=nPosicao;
          UsuariosIO.set_index(UsuariosFile,UsuariosIO.count(nPosicao));
          bFlag:=true;
          exit;
       end if;
   elsif tipo='S' then
       if campo="Nome" then
          sCod:=Usuarios.Nome;
       elsif campo="Ident" then
          sCod:=Usuarios.Ident;
       end if;
       if (copy(sCod,1,nTamsCod)=sCod2) then
          nRet:=nPosicao;
          UsuariosIO.set_index(UsuariosFile,UsuariosIO.count(nPosicao));
          bFlag:=true;
          exit;
       end if;
   end if;
   nPosicao:=nPosicao+1;
end loop;
 if (UsuariosIO.End_of_file(UsuariosFile)) and (bFlag=false) then
    nRet:=-1;
 end if;
 return nRet;
end PesUsuarios;

---------------------------------------------------------

--
-- Nome : PesBinaria
-- Descricao : funcao que realiza uma pesquisa binaria
-- por numero de inscricao do usuario.
-- Parametros :
-- Chave - numero de inscricao do usuario a pesquisar
--
function PesBinaria(Chave: in integer) return integer is
 inicio,fim,meio,nRet:integer:=0;
 achou:boolean:=false;
begin
 inicio:=1;
 fim:=nTamUsuarios+1;
 achou:=false;
 while ((not achou) and (inicio <= fim)) loop
   meio:=((inicio+fim) / 2);
   UsuariosIO.set_index(UsuariosFile,UsuariosIO.count(meio)); -- (meio-1)
   UsuariosIO.read(UsuariosFile,bUsuarios);
   fAtribuir(2,true);
   if (chave=Usuarios.Ninsc) then
      achou:=true;
   else
      if (chave > Usuarios.Ninsc) then
        inicio:=meio+1;
      else
        fim:=meio-1;
      end if;
   end if;
 end loop;
 if achou=true then
    nRet:=meio-1;
 else
    nRet:=-1;
 end if;
 return nRet;
end PesBinaria;

---------------------------------------------------------

--
-- Nome : formUsuarios
-- Descricao : procedimento que desenha o formulario de Usuarios na tela, e
-- tambem indica qual acao a tomar.
-- Parametros :
-- tipo - indica qual a acao do formulario
-- titulo - o titulo do formulario
-- rod - o texto do rodape sobre o formulario
--
procedure formUsuarios(tipo: in integer;titulo,rod: in string) is
begin
  teladefundo("±",white,blue);
  rodape(rod," ",white,blue);
  formulario(character'val(180) & titulo &
  character'val(195),4,2,18,76,white,blue,"±",light_gray,black);

  vUsuarios(1):=to_ustring(Repete(" ",5));
  Atribuir_vUsuarios(true);
  AbrirArquivo(2);
  if (tipo=1) or (tipo=2) then
     Rotulos_formUsuarios(0);
     DesenhaBotao(20,48,black,light_gray,black,blue," Salvar ",false);
     DesenhaBotao(20,63,black,light_gray,black,blue," Fechar ",false);
  end if;
  if (tipo=3) or (tipo=4) or (tipo=5) then
     DesenhaBotao(20,63,black,light_gray,black,blue," Fechar ",false);
     Rotulos_formUsuarios(2);
     Etexto(2,7,white,blue,character'val(195) &
     Repete("Ä",75) & character'val(180));
  end if;
  if tipo=6 then
     DesenhaBotao(20,63,black,light_gray,black,blue," Fechar ",false);
  end if;
  if tipo=3 then
     Etexto(5,6,white,blue,"Numero de Inscricao : ");
     Etexto(27,6,black,light_gray,Repete(" ",5));
  end if;
  if tipo=4 then
     Etexto(5,6,white,blue,"Nome : ");
     Etexto(12,6,black,light_gray,Repete(" ",30));
  end if;
  if tipo=5 then
     Etexto(5,6,white,blue,"Identidade : ");
     Etexto(18,6,black,light_gray,Repete(" ",10));
  end if;

  Limpar_Usuarios;
  if tipo=1 then
     Controles_formUsuarios("2",1,0,0,rod,false);  -- cadastrar --
  elsif tipo=2 then
     Controles_formUsuarios("1",2,0,0,rod,false);  -- alterar --
  elsif tipo=3 then
     Controles_formUsuarios("3",3,0,0,rod,false); -- consultar por NInsc --
  elsif tipo=4 then
     Controles_formUsuarios("4",4,0,0,rod,false); -- consultar por Nome --
  elsif tipo=5 then
     Controles_formUsuarios("5",5,0,0,rod,false); -- consultar por Identidade --
  elsif tipo=6 then
     Controles_formUsuarios("6",6,0,0,rod,true); -- consultar todos --
  end if;
end formUsuarios;

-----------------------------------------------

--
-- Nome : Limpar_Usuarios
-- Descricao : procedimento limpa as variaveis do registro de usuarios.
--
procedure Limpar_Usuarios is
begin
     Usuarios.Ninsc:=0;
     Usuarios.Nome:=null_unbounded_string;
     Usuarios.Ident:=to_ustring("0");
     Usuarios.Endereco.Logra:=null_unbounded_string;
     Usuarios.Endereco.Numero:=0;
     Usuarios.Endereco.Compl:=null_unbounded_string;
     Usuarios.Endereco.Bairro:=null_unbounded_string;
     Usuarios.Endereco.Cep:=to_ustring("0");
     Usuarios.Telefone:=to_ustring("0");
     Usuarios.Categoria:=' ';
     Usuarios.Situacao:=0;
end Limpar_Usuarios;

-----------------------------------------------

--
-- Nome : Rotulos_formUsuarios
-- Descricao : procedimento que escreve os rotulos do formulario de Usuarios.
-- Parametros :
-- l - indica um acrescimo na linha do rotulo
--
procedure Rotulos_formUsuarios(l: in integer) is
begin
  Etexto(5,6+l,white,blue,"Numero de Inscricao : ");
  Etexto(27,6+l,black,light_gray,to_string(vUsuarios(1)));
  Etexto(35,6+l,white,blue,"Nome : ");
  Etexto(42,6+l,black,light_gray,to_string(vUsuarios(2)));
  Etexto(5,8+l,white,blue,"Identidade : ");
  Etexto(18,8+l,black,light_gray,to_string(vUsuarios(3)));
  Etexto(2,10+l,white,blue,character'val(195) &
  Repete("Ä",75) & character'val(180));
  Etexto(5,10+l,white,blue,"Endereco");
  Etexto(5,12+l,white,blue,"Logradouro : ");
  Etexto(18,12+l,black,light_gray,to_string(vUsuarios(4)));
  Etexto(51,12+l,white,blue,"Numero : ");
  Etexto(60,12+l,black,light_gray,to_string(vUsuarios(5)));
  Etexto(5,14+l,white,blue,"Complemento : ");
  Etexto(19,14+l,black,light_gray,to_string(vUsuarios(6)));
  Etexto(32,14+l,white,blue,"Bairro : ");
  Etexto(41,14+l,black,light_gray,to_string(vUsuarios(7)));
  Etexto(63,14+l,white,blue,"Cep : ");
  Etexto(69,14+l,black,light_gray,to_string(vUsuarios(8)));
  Etexto(2,16+l,white,blue,character'val(195) &
  repete("Ä",75) & character'val(180));
  Etexto(31,8+l,white,blue,"Telefone : ");
  Etexto(42,8+l,black,light_gray,to_string(vUsuarios(9)));
  Etexto(5,17+l,white,blue,"Categoria : ");
  Etexto(17,17+l,black,light_gray,to_string(vUsuarios(10)));
  Etexto(20,17+l,white,blue,"(A)luno ou (P)rofessor ou (F)uncionario");
  Etexto(5,19+l,white,blue,"Situacao : ");
  Etexto(16,19+l,black,light_gray,to_string(vUsuarios(11)));

end Rotulos_formUsuarios;
-----------------------------------------------

--
-- Nome : Controles_formUsuarios
-- Descricao : procedimento que realiza todo o controle de manuseio do
-- formulario de Usuarios.
-- Parametros :
-- tipo - indica qual a acao do formulario
-- tipo2 - indica a acao original do formulario nao manipulado pela funcao
-- pos - indica a ultima posicao da linha da lista de usuarios
-- col - indica a ultima posicao da coluna da lista de usuarios
-- rod - o texto do rodape sobre o formulario
-- foco - se os objetos do formulario estao focados ou nao
--
procedure Controles_formUsuarios(tipo: in string;tipo2,pos,col: in integer;
                                 rod: in string;foco: in boolean) is
begin
if tipo="1" then
      Digita(S,5,5,28,5,black,light_gray,'N',0); -- Ninsc --
      I:=atoi(to_string(S));
      Usuarios.Ninsc:=I;
      if (length(S) > 0) and (S/=to_ustring(Repete(" ",length(S)))) then
         DesenhaBotao(20,48,black,light_gray,black,blue," Salvar ",false);
         if PesUsuarios('N',"Ninsc",I,"",0)/=-1 then
            Atribuir_vUsuarios(false);
            Rotulos_formUsuarios(0);
            rodape(rod," ",white,blue);
            Controles_formUsuarios("2",tipo2,pos,col,rod,false);
         else
            itostr(I,S);
            Atribuir_vUsuarios(true);
            Rotulos_formUsuarios(0);
            rodape("Numero de Inscricao, nao encontrado !"," ",yellow,red);
            Controles_formUsuarios("Fechar",tipo2,pos,col,rod,true);
         end if;
      else
        Controles_formUsuarios("Fechar",tipo2,pos,col,rod,true);
      end if;
elsif tipo="2" then
        if tipo2=1 then
            nTamUsuarios:=integer(UsuariosIO.Size(UsuariosFile));
            if nTamUsuarios = 0 then
               Usuarios.Ninsc:=1;
            else
                Usuarios.Ninsc:=nTamUsuarios + 1;
            end if;
            I:=Usuarios.Ninsc;
            itostr(Usuarios.Ninsc,S);
            Etexto(27,6,black,light_gray,to_string(S));
            S:=null_unbounded_string;
        elsif tipo2=2 then
            AbrirArquivo(2);
            if PesUsuarios('N',"Ninsc",I,"",0)=-1 then
              rodape("Numero de Inscricao, nao encontrado !"," ",yellow,red);
            end if;
        end if;
        Digita_formUsuarios;

      Controles_formUsuarios("Salvar",tipo2,pos,col,rod,true);

elsif tipo="3" then
      S:=null_unbounded_string;
      Digita(S,5,5,28,5,black,light_gray,'N',0); -- N insc --
      I:=atoi(to_string(S));
      Usuarios.Ninsc:=I;
      if (length(S) > 0) and (S/=to_ustring(Repete(" ",length(S)))) then
         if PesBinaria(I)/=-1 then
            Atribuir_vUsuarios(false);
            Rotulos_formUsuarios(2);
            rodape(rod," ",white,blue);
         else
            Atribuir_vUsuarios(true);
            Rotulos_formUsuarios(2);
            rodape("Numero de Inscricao, nao encontrado !"," ",yellow,red);
         end if;
      end if;
        Controles_formUsuarios("Fechar",tipo2,pos,col,rod,true);
elsif tipo="4" then
      S:=null_unbounded_string;
      Digita(S,30,30,13,5,black,light_gray,'T',0);
      Usuarios.Nome:=S;
      if (length(S) > 0) and (S/=to_ustring(Repete(" ",length(S)))) then
         if PesUsuarios('S',"Nome",0,to_string(S),length(S))/=-1 then
            Atribuir_vUsuarios(false);
            Rotulos_formUsuarios(2);
            rodape(rod," ",white,blue);
         else
            Atribuir_vUsuarios(true);
            Rotulos_formUsuarios(2);
            rodape("Nome do Usuario, nao encontrado !"," ",yellow,red);
         end if;
      end if;
        Controles_formUsuarios("Fechar",tipo2,pos,col,rod,true);

elsif tipo="5" then
      S:=null_unbounded_string;
      Digita(S,10,10,19,5,black,light_gray,'N',0);
      Usuarios.Ident:=S;
      if (length(S) > 0) and (S/=to_ustring(Repete(" ",length(S)))) then
         if PesUsuarios('N',"Ident",0,to_string(S),length(S))/=-1 then
            Atribuir_vUsuarios(false);
            Rotulos_formUsuarios(2);
            rodape(rod," ",white,blue);
         else
            Atribuir_vUsuarios(true);
            Rotulos_formUsuarios(2);
            rodape("Identidade do Usuario, nao encontrada !"," ",yellow,red);
         end if;
      end if;
        Controles_formUsuarios("Fechar",tipo2,pos,col,rod,true);

elsif tipo="6" then
    Listapos:=pos;
    Listacol:=col;
    if lista(2,6,5,13,70,nTamUsuarios+2,194,white,blue,foco)=1 then
       desenhalista(2,6,5,13,70,white,blue,pos,col,false);
       Controles_formUsuarios("Fechar",tipo2,pos,col,rod,true);
    end if;
elsif tipo="Salvar" then
    case Botao(20,48,black,light_gray,black,blue," Salvar ",foco) is
      when 1 =>
          DesenhaBotao(20,48,black,light_gray,black,blue," Salvar ",false);
          Controles_formUsuarios("Fechar",tipo2,pos,col,rod,true);
      when 2 =>
          SalvarUsuarios(tipo2);
          DesenhaBotao(20,48,black,light_gray,black,blue," Salvar ",false);
          Controles_formUsuarios("Fechar",tipo2,pos,col,rod,true);
      when others => null;
    end case;
elsif tipo = "Fechar" then
    case Botao(20,63,black,light_gray,black,blue," Fechar ",foco) is
      when 1 =>
          DesenhaBotao(20,63,black,light_gray,black,blue," Fechar ",false);
          if tipo2=1 then
            Controles_formUsuarios("2",tipo2,pos,col,rod,true);
          elsif tipo2=2 then
            Controles_formUsuarios("1",tipo2,pos,col,rod,false);
          elsif tipo2=3 then
            Controles_formUsuarios("3",tipo2,pos,col,rod,false);
          elsif tipo2=4 then
            Controles_formUsuarios("4",tipo2,pos,col,rod,false);
          elsif tipo2=5 then
            Controles_formUsuarios("5",tipo2,pos,col,rod,false);
          elsif tipo2=6 then
            Controles_formUsuarios("6",tipo2,pos,col,rod,true);
          end if;
      when 2 =>
         rodape(""," ",white,blue);
         UsuariosIO.close(UsuariosFile);
      when others => null;
    end case; 
end if;

end Controles_formUsuarios;

-----------------------------------------------------------

--
-- Nome : Atribuir_vUsuarios
-- Descricao : procedimento que atribui ou limpa o vetor de Usuarios.
-- Parametros :
-- limpar - indica se vai limpar ou atribuir os vetores
--
procedure Atribuir_vUsuarios(limpar: in boolean) is
begin
if limpar=false then
   itostr(Usuarios.Ninsc,S);
   vUsuarios(1):=S;
   vUsuarios(2):=Usuarios.Nome;
   vUsuarios(3):=Usuarios.Ident;
   vUsuarios(4):=Usuarios.Endereco.Logra;
   itostr(Usuarios.Endereco.numero,S);
   vUsuarios(5):=S;
   vUsuarios(6):=Usuarios.Endereco.Compl;
   vUsuarios(7):=Usuarios.Endereco.Bairro;
   vUsuarios(8):=Usuarios.Endereco.Cep;
   vUsuarios(9):=Usuarios.Telefone;
   replace_element(vUsuarios(10),1,Usuarios.Categoria);
   itostr(Usuarios.Situacao,S);
   vUsuarios(11):=S;
else
  vUsuarios(2):=to_ustring(Repete(" ",30));
  vUsuarios(3):=to_ustring(Repete(" ",10));
  vUsuarios(4):=to_ustring(Repete(" ",30));
  vUsuarios(5):=to_ustring(Repete(" ",5));
  vUsuarios(6):=to_ustring(Repete(" ",10));
  vUsuarios(7):=to_ustring(Repete(" ",20));
  vUsuarios(8):=to_ustring(Repete(" ",8));
  vUsuarios(9):=to_ustring(Repete(" ",11));
  vUsuarios(10):=to_ustring(Repete(" ",1));
  vUsuarios(11):=to_ustring(Repete(" ",1));
end if;

end Atribuir_vUsuarios;

-----------------------------------------------------------

--
-- Nome : Digita_formUsuarios
-- Descricao : procedimento que realiza o cotrole de digitacao dos dados no
-- formulario de usuarios.
--
procedure Digita_formUsuarios is
begin
   S:=Usuarios.Nome;
   Digita(S,30,30,43,5,black,light_gray,'T',0);
   Usuarios.Nome:=S;
   S:=Usuarios.Ident;
   Digita(S,10,10,19,7,black,light_gray,'N',0);
   Usuarios.Ident:=S;
   S:=Usuarios.Telefone;
   Digita(S,11,11,43,7,black,light_gray,'N',0);
   Usuarios.Telefone:=S;
   S:=Usuarios.Endereco.Logra;
   Digita(S,30,30,19,11,black,light_gray,'T',0);
   Usuarios.Endereco.Logra:=S;
   itostr(Usuarios.Endereco.numero,S);
   Digita(S,5,5,61,11,black,light_gray,'N',0);
   I:=atoi(to_string(S));
   Usuarios.Endereco.numero:=I;
   S:=Usuarios.Endereco.compl;
   Digita(S,10,10,20,13,black,light_gray,'T',0);
   Usuarios.Endereco.compl:=S;
   S:=Usuarios.Endereco.Bairro;
   Digita(S,20,20,42,13,black,light_gray,'T',0);
   Usuarios.Endereco.Bairro:=S;
   S:=Usuarios.Endereco.Cep;
   Digita(S,8,8,70,13,black,light_gray,'N',0);
   Usuarios.Endereco.Cep:=S;
   replace_element(S,1,Usuarios.Categoria);
   Digita(S,1,1,18,16,black,light_gray,'T',0);
   Usuarios.Categoria:=element(S,1);
   itostr(Usuarios.Situacao,S);
   Digita(S,1,1,17,18,black,light_gray,'N',0);
   I:=atoi(to_string(S));
   Usuarios.Situacao:=I;
   S:=null_unbounded_string;

end Digita_formUsuarios;

-----------------------------------------------------------

--
-- Nome : VerificaUsuarios
-- Descricao : funcao que verifica se os dados no formulario de usuarios
-- foram digitados.
--
function VerificaUsuarios return boolean is
 bRet:boolean:=true;
begin
  itostr(Usuarios.Ninsc,S);
  if (length(S) = 0) and (S=to_ustring(repete(" ",length(S)))) then
      rodape("Numero de Inscricao, nao cadastrado !"," ",yellow,red);
      bRet:=false;
  end if;
  if (length(Usuarios.Nome) = 0) and
     (Usuarios.Nome=to_ustring(repete(" ",length(Usuarios.Nome)))) then
      rodape("Nome do Usuario, nao cadastrado !"," ",yellow,red);
      bRet:=false;
  end if;
  if (length(Usuarios.Ident) = 0) and
     (Usuarios.Ident=to_ustring(repete(" ",length(Usuarios.Ident)))) then
      rodape("Identidade, nao cadastrada !"," ",yellow,red);
      bRet:=false;
  end if;
  if (length(Usuarios.Endereco.logra) = 0) and
     (Usuarios.Endereco.logra=to_ustring(repete(" ",length(Usuarios.Endereco.logra)))) then
      rodape("Logradouro, nao cadastrado !"," ",yellow,red);
      bRet:=false;
  end if;
  itostr(Usuarios.Endereco.numero,S);
  if (length(S) = 0) and (S=to_ustring(repete(" ",length(S)))) then
      rodape("Numero do Endereco, nao cadastrado !"," ",yellow,red);
      bRet:=false;
  end if;
  if (length(Usuarios.Endereco.compl) = 0) and
     (Usuarios.Endereco.compl=to_ustring(repete(" ",length(Usuarios.Endereco.compl)))) then
      rodape("Complemento do Endereco, nao cadastrado !"," ",yellow,red);
      bRet:=false;
  end if;
  if (length(Usuarios.Endereco.Bairro) = 0) and
     (Usuarios.Endereco.Bairro=to_ustring(repete(" ",length(Usuarios.Endereco.Bairro)))) then
      rodape("Bairro, nao cadastrado !"," ",yellow,red);
      bRet:=false;
  end if;
  if (length(Usuarios.Endereco.Cep) = 0) and
     (Usuarios.Endereco.Cep=to_ustring(repete(" ",length(Usuarios.Endereco.Cep)))) then
      rodape("Cep, nao cadastrado !"," ",yellow,red);
      bRet:=false;
  end if;
  if (length(Usuarios.Telefone) = 0) and (Usuarios.Telefone=to_ustring(repete(" ",length(Usuarios.Telefone)))) then
      rodape("Telefone, nao cadastrado !"," ",yellow,red);
      bRet:=false;
  end if;
  if (Usuarios.Categoria = ' ') then
      rodape("Categoria, nao cadastrada !"," ",yellow,red);
      bRet:=false;
  end if;

 return bRet;

end VerificaUsuarios;

-------------------------------------------------------------------

--
-- Nome : SalvarUsuarios
-- Descricao : procedimento que salva os dados digitados no
-- formulario de usuarios.
-- Parametros :
-- tipo - indica qual acao a salvar
--
procedure SalvarUsuarios(tipo: in integer) is
begin
if VerificaUsuarios=true then
 if (Usuarios.Categoria='A') or (Usuarios.Categoria='P')
   or (Usuarios.Categoria='F') then
    if tipo=1 then
       UsuariosIO.set_index(UsuariosFile,UsuariosIO.count(nTamUsuarios+1));
       fAtribuir(2,false);
       UsuariosIO.write(UsuariosFile,bUsuarios);
       Atribuir_vUsuarios(true);
       Rotulos_formUsuarios(0);
       Limpar_Usuarios;
    elsif tipo=2 then
       fAtribuir(2,false);
       UsuariosIO.write(UsuariosFile,bUsuarios);
    end if;
 else
  rodape("Categoria, Cadastrada Incorretamente !"," ",yellow,red);
 end if;
end if;

end SalvarUsuarios;

end MUsuario;
