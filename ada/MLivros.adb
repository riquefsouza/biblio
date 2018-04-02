package body MLivros is

--******************Modulo de Livros**********************--

--
-- Nome : PesLivros
-- Descricao : funcao que pesquisa as informacoes contidas no arquivo de
-- livros
-- Parametros :
-- tipo - indica se e o valor e (N)umerico ou (S)tring
-- campo - qual o campo a ser pesquisado
-- nCod2 - codigo do campo se numerico
-- sCod2 - codigo do campo se string
-- nTamsCod - tamanho caracteres do campo de string
--
function PesLivros(tipo: in character;campo: in string;nCod2: in integer;
                   sCod2: in string;nTamsCod: in integer) return integer is
 nPosicao,nCod,nRet:integer:=0;
 sCod:ustring;
 bFlag:boolean:=false;
begin
LivrosIO.set_index(LivrosFile,1);
nPosicao:=1;
bFlag:=false;
nCod:=1;
sCod:=null_unbounded_string;
while Not(LivrosIO.End_of_file(LivrosFile)) loop
   LivrosIO.read(LivrosFile,bLivros);
   fatribuir(1,true);

   if tipo='N' then
       if campo="Ninsc" then
          nCod:=Livros.Ninsc;
       end if;
       if (nCod=nCod2) then
          nRet:=nPosicao;
          LivrosIO.set_index(LivrosFile,LivrosIO.count(nPosicao));
          bFlag:=true;
          exit;
       end if;
   elsif tipo='S' then
       if campo="Titulo" then
          sCod:=Livros.titulo;
       elsif campo="Area" then
          sCod:=Livros.Area;
       elsif campo="Autor" then
          sCod:=Livros.Autor;
       elsif campo="Pchave" then
          sCod:=Livros.Pchave;
       end if;
       if (copy(sCod,1,nTamsCod)=sCod2) then
          nRet:=nPosicao;
          LivrosIO.set_index(LivrosFile,LivrosIO.count(nPosicao));
          bFlag:=true;
          exit;
       end if;
   end if;
   nPosicao:=nPosicao+1;
end loop;
 if (LivrosIO.End_of_file(LivrosFile)) and (bFlag=false) then
    nRet:=-1;
 end if;
 return nRet;
end PesLivros;

---------------------------------------------------------

--
-- Nome : formLivros
-- Descricao : procedimento que desenha o formulario de livros na tela, e
-- tambem indica qual acao a tomar.
-- Parametros :
-- tipo - indica qual a acao do formulario
-- titulo - o titulo do formulario
-- rod - o texto do rodape sobre o formulario
--
procedure formLivros(tipo: in integer;titulo,rod: in string) is
begin
  teladefundo("±",white,blue);
  rodape(rod," ",white,blue);  
  formulario(character'val(180) & titulo &
  character'val(195),4,2,18,76,white,blue,"±",light_gray,black);

  vLivros(1):=to_ustring(Repete(" ",5));
  Atribuir_vLivros(true);
  AbrirArquivo(1);
  if (tipo=1) or (tipo=2) then
     Rotulos_formLivros(0);
     DesenhaBotao(20,45,black,light_gray,black,blue," Salvar ",false);
     DesenhaBotao(20,60,black,light_gray,black,blue," Fechar ",false);
  end if;
  if (tipo=3) or (tipo=4) or (tipo=5) or (tipo=6) then
     DesenhaBotao(20,60,black,light_gray,black,blue," Fechar ",false);
     Rotulos_formLivros(2);
     Etexto(2,7,white,blue,character'val(195) &
     Repete("Ä",75) & character'val(180));
  end if;
  if tipo=7 then
     DesenhaBotao(20,60,black,light_gray,black,blue," Fechar ",false);
  end if;
  if tipo=3 then
     Etexto(5,6,white,blue,"Titulo : ");
     Etexto(14,6,black,light_gray,Repete(" ",30));
  end if;
  if tipo=4 then
     Etexto(5,6,white,blue,"Autor : ");
     Etexto(13,6,black,light_gray,Repete(" ",30));
  end if;
  if tipo=5 then
     Etexto(5,6,white,blue,"Area : ");
     Etexto(12,6,black,light_gray,Repete(" ",30));
  end if;
  if tipo=6 then
     Etexto(5,6,white,blue,"Palavra-Chave : ");
     Etexto(21,6,black,light_gray,Repete(" ",10));
  end if;

  Limpar_Livros;
  if tipo=1 then
     Controles_formLivros("2",1,0,0,rod,false);  -- cadastrar --
  elsif tipo=2 then
     Controles_formLivros("1",2,0,0,rod,false);  -- alterar --
  elsif tipo=3 then
     Controles_formLivros("3",3,0,0,rod,false); -- consultar por titulo --
  elsif tipo=4 then
     Controles_formLivros("4",4,0,0,rod,false); -- consultar por Autor --
  elsif tipo=5 then
     Controles_formLivros("5",5,0,0,rod,false); -- consultar por Area --
  elsif tipo=6 then
     Controles_formLivros("6",6,0,0,rod,false); -- consultar por Palavra-chave --
  elsif tipo=7 then
     Controles_formLivros("7",7,0,0,rod,true); -- consultar todos --
  end if;
end formLivros;

-----------------------------------------------

--
-- Nome : Limpar_Livros
-- Descricao : procedimento limpa as variaveis do registro de livros.
--
procedure Limpar_Livros is
begin
     Livros.Ninsc:=0;
     Livros.Titulo:=null_unbounded_string;
     Livros.Autor:=null_unbounded_string;
     Livros.Area:=null_unbounded_string;
     Livros.Pchave:=null_unbounded_string;
     Livros.Edicao:=0;
     Livros.AnoPubli:=0;
     Livros.Editora:=null_unbounded_string;
     Livros.Volume:=0;
     Livros.Estado:=' ';
end Limpar_Livros;

-----------------------------------------------

--
-- Nome : Rotulos_formLivros
-- Descricao : procedimento que escreve os rotulos do formulario de livros.
-- Parametros :
-- l - indica um acrescimo na linha do rotulo
--
procedure Rotulos_formLivros(l: in integer) is
begin
  Etexto(5,6+l,white,blue,"Numero de Inscricao : ");
  Etexto(27,6+l,black,light_gray,to_string(vlivros(1)));
  Etexto(35,6+l,white,blue,"Titulo : ");
  Etexto(44,6+l,black,light_gray,to_string(vlivros(2)));
  Etexto(5,8+l,white,blue,"Autor : ");
  Etexto(13,8+l,black,light_gray,to_string(vlivros(3)));
  Etexto(5,10+l,white,blue,"Area : ");
  Etexto(12,10+l,black,light_gray,to_string(vlivros(4)));
  Etexto(5,12+l,white,blue,"Palavra-Chave : ");
  Etexto(21,12+l,black,light_gray,to_string(vlivros(5)));
  Etexto(35,12+l,white,blue,"Edicao : ");
  Etexto(44,12+l,black,light_gray,to_string(vlivros(6)));
  Etexto(5,14+l,white,blue,"Ano de Publicacao : ");
  Etexto(25,14+l,black,light_gray,to_string(vlivros(7)));
  Etexto(35,14+l,white,blue,"Editora : ");
  Etexto(45,14+l,black,light_gray,to_string(vlivros(8)));
  Etexto(5,16+l,white,blue,"Volume : ");
  Etexto(14,16+l,black,light_gray,to_string(vlivros(9)));
  Etexto(22,16+l,white,blue,"Estado Atual : ");
  Etexto(37,16+l,black,light_gray,to_string(vlivros(10)));
  Etexto(40,16+l,white,blue,"(D)isponivel ou (E)mprestado");

end Rotulos_formLivros;

-----------------------------------------------

--
-- Nome : Controles_formLivros
-- Descricao : procedimento que realiza todo o controle de manuseio do
-- formulario de livros.
-- Parametros :
-- tipo - indica qual a acao do formulario
-- tipo2 - indica a acao original do formulario nao manipulado pela funcao
-- pos - indica a ultima posicao da linha da lista de livros
-- col - indica a ultima posicao da coluna da lista de livros
-- rod - o texto do rodape sobre o formulario
-- foco - se os objetos do formulario estao focados ou nao
--
procedure Controles_formLivros(tipo: in string;tipo2,pos,col: in integer;
                               rod: in string;foco: in boolean) is
begin
if tipo="1" then
      Digita(S,5,5,28,5,black,light_gray,'N',0); -- Ninsc --
      I:=atoi(to_string(S));
      Livros.Ninsc:=I;
      if (length(S) > 0) and (S/=to_ustring(Repete(" ",length(S)))) then
         DesenhaBotao(20,45,black,light_gray,black,blue," Salvar ",false);
         if PesLivros('N',"Ninsc",I,"",0)/=-1 then
            Atribuir_vLivros(false);
            Rotulos_formLivros(0);
            rodape(rod," ",white,blue);
            Controles_formLivros("2",tipo2,pos,col,rod,false);
         else
            itostr(I,S);
            Atribuir_vLivros(true);
            Rotulos_formLivros(0);
            rodape("Numero de Inscricao, nao encontrado !"," ",yellow,red);
            Controles_formLivros("Fechar",tipo2,pos,col,rod,true);
         end if;
      else
        Controles_formLivros("Fechar",tipo2,pos,col,rod,true);
      end if;
elsif tipo="2" then
        if tipo2=1 then
            nTamLivros:=integer(LivrosIO.size(LivrosFile));
            if nTamLivros = 0 then
               Livros.Ninsc:=1;
            else              
               Livros.Ninsc:=nTamLivros + 1;
            end if;
            I:=Livros.Ninsc;
            itostr(Livros.Ninsc,S);
            Etexto(27,6,black,light_gray,to_string(S));
            S:=null_unbounded_string;
        elsif tipo2=2 then
            AbrirArquivo(1);
            if PesLivros('N',"Ninsc",I,"",0)=-1 then
              rodape("Numero de Inscricao, nao encontrado !"," ",yellow,red);
            end if;
        end if;
        Digita_formLivros;
      
      Controles_formLivros("Salvar",tipo2,pos,col,rod,true);

elsif tipo="3" then
      S:=null_unbounded_string;
      Digita(S,30,30,15,5,black,light_gray,'T',0);
      Livros.Titulo:=S;
      if (length(S) > 0) and (S/=to_ustring(Repete(" ",length(S)))) then
         if PesLivros('S',"Titulo",0,to_string(S),length(S))/=-1 then
            Atribuir_vLivros(false);
            Rotulos_formLivros(2);
            rodape(rod," ",white,blue);
         else
            Atribuir_vLivros(true);
            Rotulos_formLivros(2);
            rodape("Titulo do Livro, nao encontrado !"," ",yellow,red);
         end if;
      end if;
        Controles_formLivros("Fechar",tipo2,pos,col,rod,true);

elsif tipo="4" then
      S:=null_unbounded_string;
      Digita(S,30,30,14,5,black,light_gray,'T',0);
      Livros.Autor:=S;
      if (length(S) > 0) and (S/=to_ustring(Repete(" ",length(S)))) then
         if PesLivros('S',"Autor",0,to_string(S),length(S))/=-1 then
            Atribuir_vLivros(false);
            Rotulos_formLivros(2);
            rodape(rod," ",white,blue);
         else
            Atribuir_vLivros(true);
            Rotulos_formLivros(2);
            rodape("Autor do Livro, nao encontrado !"," ",yellow,red);
         end if;
      end if;
        Controles_formLivros("Fechar",tipo2,pos,col,rod,true);

elsif tipo="5" then
      S:=null_unbounded_string;
      Digita(S,4,4,13,5,black,light_gray,'T',0);
      Livros.Area:=S;
      if (length(S) > 0) and (S/=to_ustring(Repete(" ",length(S)))) then
         if PesLivros('S',"Area",0,to_string(S),length(S))/=-1 then
            Atribuir_vLivros(false);
            Rotulos_formLivros(2);
            rodape(rod," ",white,blue);
         else
            Atribuir_vLivros(true);
            Rotulos_formLivros(2);
            rodape("Area do Livro, nao encontrada !"," ",yellow,red);
         end if;
      end if;
        Controles_formLivros("Fechar",tipo2,pos,col,rod,true);

elsif tipo="6" then
      S:=null_unbounded_string;
      Digita(S,10,10,22,5,black,light_gray,'T',0);
      Livros.PChave:=S;
      if (length(S) > 0) and (S/=to_ustring(Repete(" ",length(S)))) then
         if PesLivros('S',"Pchave",0,to_string(S),length(S))/=-1 then
            Atribuir_vLivros(false);
            Rotulos_formLivros(2);
            rodape(rod," ",white,blue);
         else
            Atribuir_vLivros(true);
            Rotulos_formLivros(2);
            rodape("Palavra-Chave do Livro, nao encontrado !"," ",yellow,red);
         end if;
      end if;
      Controles_formLivros("Fechar",tipo2,pos,col,rod,true);

elsif tipo="7" then
    Listapos:=pos;
    Listacol:=col;
    if lista(1,6,5,13,70,nTamLivros+2,220,white,blue,foco)=1 then
       desenhalista(1,6,5,13,70,white,blue,pos,col,false);
       Controles_formLivros("Fechar",tipo2,pos,col,rod,true);
    end if;
elsif tipo="Salvar" then
    case Botao(20,45,black,light_gray,black,blue," Salvar ",foco) is
      when 1 =>
          DesenhaBotao(20,45,black,light_gray,black,blue," Salvar ",false);
          Controles_formLivros("Fechar",tipo2,pos,col,rod,true);
      when 2 =>
          SalvarLivros(tipo2);
          DesenhaBotao(20,45,black,light_gray,black,blue," Salvar ",false);
          Controles_formLivros("Fechar",tipo2,pos,col,rod,true);
      when others => null;
    end case;
elsif tipo = "Fechar" then
    case Botao(20,60,black,light_gray,black,blue," Fechar ",foco) is
      when 1 =>
          DesenhaBotao(20,60,black,light_gray,black,blue," Fechar ",false);
          if tipo2=1 then
            Controles_formLivros("2",tipo2,pos,col,rod,true);
          elsif tipo2=2 then
            Controles_formLivros("1",tipo2,pos,col,rod,false);
          elsif tipo2=3 then
            Controles_formLivros("3",tipo2,pos,col,rod,false);
          elsif tipo2=4 then
            Controles_formLivros("4",tipo2,pos,col,rod,false);
          elsif tipo2=5 then
            Controles_formLivros("5",tipo2,pos,col,rod,false);
          elsif tipo2=6 then
            Controles_formLivros("6",tipo2,pos,col,rod,false);
          elsif tipo2=7 then
            Controles_formLivros("7",tipo2,pos,col,rod,true);
          end if;
      when 2 =>
         rodape(""," ",white,blue);
         LivrosIO.close(LivrosFile);
      when others => null;
    end case;
end if;

end Controles_formLivros;

-----------------------------------------------------------

--
-- Nome : Atribuir_vLivros
-- Descricao : procedimento que atribui ou limpa o vetor de livros.
-- Parametros :
-- limpar - indica se vai limpar ou atribuir os vetores
--
procedure Atribuir_vLivros(limpar: in boolean) is
begin
if limpar=false then
   itostr(Livros.Ninsc,S);
   vLivros(1):=S;
   vLivros(2):=Livros.Titulo;
   vLivros(3):=Livros.Autor;
   vLivros(4):=Livros.Area;
   vLivros(5):=Livros.Pchave;
   itostr(Livros.Edicao,S);
   vLivros(6):=S;
   itostr(Livros.AnoPubli,S);
   vLivros(7):=S;
   vLivros(8):=Livros.Editora;
   itostr(Livros.Volume,S);
   vLivros(9):=S;
   replace_element(vLivros(10),1,Livros.Estado);
else
  vLivros(2):=to_ustring(Repete(" ",30));
  vLivros(3):=to_ustring(Repete(" ",30));
  vLivros(4):=to_ustring(Repete(" ",30));
  vLivros(5):=to_ustring(Repete(" ",10));
  vLivros(6):=to_ustring(Repete(" ",4));
  vLivros(7):=to_ustring(Repete(" ",4));
  vLivros(8):=to_ustring(Repete(" ",30));
  vLivros(9):=to_ustring(Repete(" ",4));
  vLivros(10):=to_ustring(Repete(" ",1));
end if;
end Atribuir_vLivros;

-----------------------------------------------------------

--
-- Nome : Digita_formLivros
-- Descricao : procedimento que realiza o cotrole de digitacao dos dados no
-- formulario de livros.
--
procedure Digita_formLivros is
begin
        S:=Livros.Titulo;
        Digita(S,30,30,45,5,black,light_gray,'T',0);
        Livros.Titulo:=S;
        S:=Livros.Autor;
        Digita(S,30,30,14,7,black,light_gray,'T',0);
        Livros.Autor:=S;
        S:=Livros.Area;
        Digita(S,30,30,13,9,black,light_gray,'T',0);
        Livros.Area:=S;
        S:=Livros.PChave;
        Digita(S,10,10,22,11,black,light_gray,'T',0);
        Livros.Pchave:=S;
        itostr(Livros.Edicao,S);
        Digita(S,4,4,45,11,black,light_gray,'N',0);
        I:=atoi(to_string(S));
        Livros.Edicao:=I;
        itostr(Livros.AnoPubli,S);
        Digita(S,4,4,26,13,black,light_gray,'N',0);
        I:=atoi(to_string(S));
        Livros.AnoPubli:=I;
        S:=Livros.Editora;
        Digita(S,30,30,46,13,black,light_gray,'T',0);
        Livros.Editora:=S;
        itostr(Livros.Volume,S);
        Digita(S,4,4,15,15,black,light_gray,'N',0);
        I:=atoi(to_string(S));
        Livros.Volume:=I;
        replace_element(S,1,Livros.Estado);
        Digita(S,1,1,38,15,black,light_gray,'T',0);
        if length(S) > 0 then
           Livros.Estado:=element(S,1);
        end if;   
        S:=null_unbounded_string;
end Digita_formLivros; 

-----------------------------------------------------------

--
-- Nome : VerificaLivros
-- Descricao : funcao que verifica se os dados no formulario de livros
-- foram digitados.
--
function VerificaLivros return boolean is
 bRet:boolean:=true;
begin
  itostr(Livros.Ninsc,S);
  if (length(S) = 0) and (S=to_ustring(Repete(" ",length(S)))) then
     rodape("Numero de Inscricao, nao cadastrado !"," ",yellow,red);
     bRet:=false;
  end if;
  if (length(Livros.Titulo) = 0) and
     (Livros.Titulo=to_ustring(Repete(" ",length(Livros.Titulo)))) then
      rodape("Titulo, nao cadastrado !"," ",yellow,red);
      bRet:=false;
  end if;
  if (length(Livros.Autor) = 0) and
     (Livros.Autor=to_ustring(Repete(" ",length(Livros.Autor)))) then
      rodape("Autor, nao cadastrado !"," ",yellow,red);
      bRet:=false;
  end if;
  if (length(Livros.Area) = 0) and
     (Livros.Area=to_ustring(Repete(" ",length(Livros.Area)))) then
      rodape("Area, nao cadastrada !"," ",yellow,red);
      bRet:=false;
  end if;
  if (length(Livros.Pchave) = 0) and
     (Livros.Pchave=to_ustring(Repete(" ",length(Livros.Pchave)))) then
      rodape("Palavra-Chave, nao cadastrada !"," ",yellow,red);
      bRet:=false;
  end if;
  itostr(Livros.Edicao,S);
  if (length(S) = 0) and (S=to_ustring(Repete(" ",length(S)))) then
      rodape("Edicao, nao cadastrada !"," ",yellow,red);
      bRet:=false;
  end if;
  itostr(Livros.AnoPubli,S);
  if (length(S) = 0) and (S=to_ustring(Repete(" ",length(S)))) then
      rodape("Ano de Publicacao, nao cadastrado !"," ",yellow,red);
      bRet:=false;
  end if;
  if (length(Livros.Editora) = 0) and
     (Livros.Editora=to_ustring(Repete(" ",length(Livros.Editora)))) then
      rodape("Editora, nao cadastrada !"," ",yellow,red);
      bRet:=false;
  end if;
  itostr(Livros.Volume,S);
  if (length(S) = 0) and (S=to_ustring(Repete(" ",length(S)))) then
      rodape("Volume, nao cadastrado !"," ",yellow,red);
      bRet:=false;
  end if;
  if (Livros.Estado = ' ') then
     rodape("Estado, nao cadastrado !"," ",yellow,red);
     bRet:=false;
  end if;

 return bRet;
end VerificaLivros;

-------------------------------------------------------------------

--
-- Nome : SalvarLivros
-- Descricao : procedimento que salva os dados digitados no
-- formulario de livros.
-- Parametros :
-- tipo - indica qual acao a salvar
--
procedure SalvarLivros(tipo: in integer) is
begin
if VerificaLivros=true then
 if (Livros.Estado='D') or (Livros.Estado='E') then
    if tipo=1 then
        LivrosIO.set_index(LivrosFile,LivrosIO.count(nTamLivros+1));
        fAtribuir(1,false);
        LivrosIO.write(LivrosFile,bLivros);        
        Atribuir_vLivros(true);
        Rotulos_formLivros(0);
        Limpar_Livros;
    elsif tipo=2 then
       fAtribuir(1,false);
       LivrosIo.write(LivrosFile,bLivros);
    end if;
 else
  rodape("Estado Atual, Cadastrado Incorretamente !"," ",yellow,red);
 end if;
end if;

end SalvarLivros;

end MLivros;
