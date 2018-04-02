package body MEmprest is

--**************Modulo de Emprestimos e Devolucoes******************--

--
-- Nome : RetDataAtual
-- Descricao : funcao que retorna a data atual do sistema
--
function RetDataAtual return ustring is
 y : year_number;
 m : month_number;
 d : day_number;
 dia,mes,ano: ustring;
begin
  d:=integer(day(clock));
  m:=integer(month(clock));
  y:=integer(year(clock));
  itostr(d,dia);
  itostr(m,mes);
  itostr(y,ano);
  return (to_ustring(repete("0",2-itam(d))) & dia & "/" &
  to_ustring(repete("0",2-itam(m))) & mes & "/" & ano);

end RetDataAtual;

------------------------------------------------------------

--
-- Nome : ConverteData
-- Descricao : funcao que converte a data em string para numero.
-- Parametros :
-- dt - data a ser convertida
--
function ConverteData(dt: in ustring) return integer is
  sAux:string(1..8);
  nAux:integer:=0;
begin
 sAux:=copy(dt,7,4) & copy(dt,4,2) & copy(dt,1,2);
 nAux:=atoi(sAux);
 return nAux;
end ConverteData;

------------------------------------------------------------

--
-- Nome : SubtraiDatas
-- Descricao : funcao que subtrai duas datas e retorna o numero de dias
-- Parametros :
-- dt1 - data inicial
-- dt2 - data final
--
function SubtraiDatas(dt1: in ustring;dt2: in ustring) return integer is
 dia,mes,ano,dia1,mes1,ano1,dia2,mes2,ano2:integer:=0;
 i,c,dias,nRet:integer:=0;
 udiames:array(1..12) of integer;
begin
 dias:=0;
 udiames(1):=31;
 udiames(2):=28;
 udiames(3):=31;
 udiames(4):=30;
 udiames(5):=31;
 udiames(6):=30;
 udiames(7):=31;
 udiames(8):=31;
 udiames(9):=30;
 udiames(10):=31;
 udiames(11):=30;
 udiames(12):=31;

 i:=atoi(copy(dt1,1,2));
 dia1:=i;
 i:=atoi(copy(dt1,4,2));
 mes1:=i;
 i:=atoi(copy(dt1,7,4));
 ano1:=i;

 i:=atoi(copy(dt2,1,2));
 dia2:=i;
 i:=atoi(copy(dt2,4,2));
 mes2:=i;
 i:=atoi(copy(dt2,7,4));
 ano2:=i;

 for ano in ano1..ano2 loop
    for mes in mes1..12 loop
       -- ano bissexto --
       if (ano mod 4)=0 then
         udiames(2):=29;
       end if;
       -- data final --
       if (ano=ano2) and (mes=mes2) then
         udiames(mes2):=dia2;
       end if;
       for dia in dia1..udiames(mes) loop
          dias:=dias+1;
       end loop;
       if (ano=ano2) and (mes=mes2) then
           nRet:=dias-1;
           exit;
       end if;
       dia1:=1;
    end loop;
    mes1:=1;
 end loop;

 return nRet;
end SubtraiDatas;

------------------------------------------------------------

--
-- Nome : SomaDias
-- Descricao : funcao que soma um determinado numero de dias a uma data.
-- Parametros :
-- dt1 - a data a ser somada
-- qtddias - numero de dias a serem somados
--
function SomaDias(dt1: in ustring;qtddias: in integer) return ustring is
 dia,mes,ano,dia1,mes1,ano1,dia2,mes2,ano2:integer:=0;
 i,c,dias:integer:=0;
 sAux,sAux2,sRet:ustring;
 udiames:array(1..12) of integer;
begin
 dias:=0;
 udiames(1):=31;
 udiames(2):=28;
 udiames(3):=31;
 udiames(4):=30;
 udiames(5):=31;
 udiames(6):=30;
 udiames(7):=31;
 udiames(8):=31;
 udiames(9):=30;
 udiames(10):=31;
 udiames(11):=30;
 udiames(12):=31;

 i:=atoi(copy(dt1,1,2));
 dia1:=i;
 i:=atoi(copy(dt1,4,2));
 mes1:=i;
 i:=atoi(copy(dt1,7,4));
 ano1:=i;

 ano2:=ano1 + (qtddias / 365);

 for ano in ano1..ano2 loop
    for mes in mes1..12 loop
       -- ano bissexto --
       if (ano mod 4)=0 then
         udiames(2):=29;
       end if;
       for dia in dia1..udiames(mes) loop
            dias:=dias+1;
            if dias=qtddias+1 then
              itostr(dia,sAux);
              sAux2:=repete("0",2-length(sAux)) & sAux & to_ustring("/");
              itostr(mes,sAux);
              sAux2:=sAux2 & repete("0",2-length(sAux)) & sAux & to_ustring("/");
              itostr(ano,sAux);
              sAux2:=sAux2 & repete("0",4-length(sAux)) & sAux;
              sRet:=sAux2;
              exit;
            end if;
       end loop;
       dia1:=1;
    end loop;
    mes1:=1;
 end loop;
 return sRet;
end SomaDias;

------------------------------------------------------------

--
-- Nome : PesEmprestimos
-- Descricao : funcao que pesquisa as informacoes contidas no arquivo de
-- Emprestimos.
-- Parametros :
-- nCodUsuario - codigo do campo de numero de inscricao do usuario
-- sCodLivro - codigo do campo de numero de inscricao do livro
--
function PesEmprestimos(nCodUsuario,nCodLivro: in integer) return integer is
 nPosicao,nRet:integer:=0;
 bFlag:boolean:=false;
begin
EmprestimosIO.set_index(EmprestimosFile,1);
nPosicao:=1;
bFlag:=false;
while Not(EmprestimosIO.End_of_file(EmprestimosFile)) loop
   EmprestimosIO.read(EmprestimosFile,bEmprestimos);
   fAtribuir(3,true);
   if (Emprestimos.NinscUsuario=nCodUsuario) and
      (Emprestimos.NinscLivro=nCodLivro) then
      nRet:=nPosicao;
      EmprestimosIO.set_index(EmprestimosFile,EmprestimosIO.count(nPosicao));
      bFlag:=true;
      exit;
   end if;
   nPosicao:=nPosicao+1;
end loop;
 if (EmprestimosIO.End_of_file(EmprestimosFile)) and (bFlag=false) then
    Emprestimos.NinscUsuario:=nCodUsuario;
    Emprestimos.NinscLivro:=nCodLivro;
    nRet:=-1;
 end if;
 return nRet;

end PesEmprestimos;

---------------------------------------------------------

--
-- Nome : formEmprestimos
-- Descricao : procedimento que desenha o formulario de Emprestimos
-- na tela, e tambem indica qual acao a tomar.
-- Parametros :
-- tipo - indica qual a acao do formulario
-- titulo - o titulo do formulario
-- rod - o texto do rodape sobre o formulario
--
procedure formEmprestimos(tipo: in integer;titulo,rod: in string) is
begin
  teladefundo("±",white,blue);
  rodape(rod," ",white,blue);  
  formulario(character'val(180) & titulo &
  character'val(195),4,2,18,76,white,blue,"±",light_gray,black);

  vEmprestimos(1):=to_ustring(Repete(" ",5));
  Atribuir_vEmprestimos(true);
  AbrirArquivo(1);
  AbrirArquivo(2);
  AbrirArquivo(3);
  if tipo=1 then
     Rotulos_formEmprestimos(1,0);
     DesenhaBotao(20,45,black,light_gray,black,blue," Emprestar ",false);
     DesenhaBotao(20,60,black,light_gray,black,blue," Fechar ",false);
  end if;
  if tipo=2 then
     Rotulos_formEmprestimos(2,0);
     DesenhaBotao(20,45,black,light_gray,black,blue," Devolver ",false);
     DesenhaBotao(20,60,black,light_gray,black,blue," Fechar ",false);
  end if;
  if tipo=3 then
     DesenhaBotao(20,60,black,light_gray,black,blue," Fechar ",false);
  end if;
  Limpar_Emprestimos;
  if tipo=1 then
     Controles_formEmprestimos("1",1,0,0,rod,false);  -- Emprestar --
  elsif tipo=2 then
     Controles_formEmprestimos("1",2,0,0,rod,false);  -- Devolver --
  elsif tipo=3 then
     Controles_formEmprestimos("2",3,0,0,rod,true);  -- consultar todos --
  end if;
end formEmprestimos;

-----------------------------------------------

--
-- Nome : Limpar_Emprestimos
-- Descricao : procedimento limpa as variaveis do registro de Emprestimos.
--
procedure Limpar_Emprestimos is
begin
     Emprestimos.NinscUsuario:=0;
     Emprestimos.NinscLivro:=0;
     Emprestimos.DtEmprestimo:=RetDataAtual;
     Emprestimos.Removido:=false;
end Limpar_Emprestimos;

-----------------------------------------------

--
-- Nome : Rotulos_formEmprestimos
-- Descricao : procedimento que escreve os rotulos do formulario de
-- Emprestimos.
-- Parametros :
-- tipo - indica qual a acao do formulario
-- l - indica um acrescimo na linha do rotulo
--
procedure Rotulos_formEmprestimos(tipo,l: in integer) is
begin
if (tipo=1) or (tipo=2) then
  Etexto(5,6+l,white,blue,"Numero de Inscricao do Usuario : ");
  Etexto(38,6+l,black,light_gray,to_string(vEmprestimos(1)));
  Etexto(5,8+l,white,blue,"Usuario : ");
  Etexto(16,8+l,black,light_gray,Repete(" ",30));
  Etexto(49,8+l,white,blue,"Categoria : ");
  Etexto(5,10+l,white,blue,"Numero de Inscricao do Livro : ");
  Etexto(36,10+l,black,light_gray,to_string(vEmprestimos(2)));
  Etexto(5,12+l,white,blue,"Livro : ");
  Etexto(13,12+l,black,light_gray,Repete(" ",30));
  Etexto(46,12+l,white,blue,"Estado : ");
  Etexto(5,14+l,white,blue,"Data do Emprestimo : ");
  Etexto(27,14+l,black,light_gray,to_string(vEmprestimos(3)));
  Etexto(40,14+l,white,blue,"Data de Devolucao : ");
  Etexto(61,14+l,black,light_gray,to_string(vEmprestimos(4)));
end if;
if tipo=2 then
  Etexto(5,16+l,white,blue,"Dias em Atraso : ");
  Etexto(23,16+l,black,light_gray,repete(" ",4));
  Etexto(31,16+l,white,blue,"Multa por dias em atraso : ");
  Etexto(59,16+l,black,light_gray,repete(" ",7));
end if;
end Rotulos_formEmprestimos;

-----------------------------------------------

--
-- Nome : Controles_formEmprestimos
-- Descricao : procedimento que realiza todo o controle de manuseio do
-- formulario de Emprestimos.
-- Parametros :
-- tipo - indica qual a acao do formulario
-- tipo2 - indica a acao original do formulario nao manipulado pela funcao
-- pos - indica a ultima posicao da linha da lista de emprestimos
-- col - indica a ultima posicao da coluna da lista de emprestimos
-- rod - o texto do rodape sobre o formulario
-- foco - se os objetos do formulario estao focados ou nao
--
procedure Controles_formEmprestimos(tipo: in string;tipo2,pos,col: in integer;
                                    rod: in string;foco: in boolean) is
 sDiasAtraso:ustring;
 nDiasAtraso:integer:=0;
 nMulta: float:=0.0;
begin
if tipo="1" then
  S:=null_unbounded_string;
  rodape(""," ",white,blue);
  Etexto(61,8,white,blue,"");
  Etexto(55,12,white,blue,"");
  Etexto(23,16,black,light_gray,"");
  Etexto(59,16,black,light_gray,"");
  Digita(S,5,5,39,5,black,light_gray,'N',0);
  I:=atoi(to_string(S));
  Usuarios.Ninsc:=I;
  Emprestimos.NinscUsuario:=I;
  if (length(S) > 0) and (S/=to_ustring(Repete(" ",length(S)))) then
    if PesUsuarios('N',"Ninsc",I,"",0)/=-1 then
      Etexto(16,8,black,light_gray,to_string(Usuarios.Nome));
      if Usuarios.Categoria='F' then
         Etexto(61,8,white,blue,"Funcionario");
      elsif Usuarios.Categoria='A' then
         Etexto(61,8,white,blue,"Aluno      ");
      elsif Usuarios.Categoria='P' then
         Etexto(61,8,white,blue,"Professor  ");
      end if;
      S:=null_unbounded_string;
      Digita(S,5,5,37,9,black,light_gray,'N',0);
      I:=atoi(to_string(S));
      Livros.Ninsc:=I;
      Emprestimos.NinscLivro:=I;
      if (length(S) > 0) and (S/=to_ustring(Repete(" ",length(S)))) then
        if PesLivros('N',"Ninsc",I,"",0)/=-1 then
           Etexto(13,12,black,light_gray,to_string(Livros.Titulo));
           if Livros.Estado='D' then
             Etexto(55,12,white,blue,"Disponivel");
           else
             Etexto(55,12,white,blue,"Emprestado");
           end if;

           -- Emprestimo --

           if tipo2=1 then
              if Livros.Estado='D' then
                if Usuarios.Situacao < 4 then
                   if Usuarios.Categoria='F' then
                     Emprestimos.DtDevolucao:=SomaDias(RetDataAtual,7);
                   elsif Usuarios.Categoria='A' then
                     Emprestimos.DtDevolucao:=SomaDias(RetDataAtual,14);
                   elsif Usuarios.Categoria='P' then
                     Emprestimos.DtDevolucao:=SomaDias(RetDataAtual,30);
                   end if;
                   Emprestimos.DtEmprestimo:=RetDataAtual;
                   Usuarios.Situacao:=Usuarios.Situacao + 1;
                   Livros.Estado:='E';
                   Etexto(27,14,black,light_gray,to_string(Emprestimos.DtEmprestimo));
                   Etexto(61,14,black,light_gray,to_string(Emprestimos.DtDevolucao));
                   Controles_formEmprestimos("Emprestar",tipo2,pos,col,rod,true);
                else
                   rodape("Usuario com 4 livros em sua posse, Impossivel Efetuar Emprestimo !"," ",yellow,red);
                   Controles_formEmprestimos("Fechar",tipo2,pos,col,rod,true);
                end if;
              else
                rodape("O livro ja esta emprestado, Impossivel Efetuar Emprestimo !"," ",yellow,red);
                Controles_formEmprestimos("Fechar",tipo2,pos,col,rod,true);
              end if;
             -- Devolucao --
           elsif tipo2=2 then
              if PesEmprestimos(Usuarios.Ninsc,Livros.Ninsc)/=-1 then
                 if Livros.Estado='E' then
                   if ((Usuarios.Situacao >= 1) and (Usuarios.Situacao <= 4)) then
                      if ConverteData(Emprestimos.DtDevolucao) <
                         ConverteData(RetDataAtual) then
                         nDiasAtraso:=0;
                         nMulta:=0.0;
                         nDiasAtraso:=SubtraiDatas(Emprestimos.DtDevolucao,
                         RetDataAtual);
                         nMulta:=(0.5 * float(nDiasAtraso));
                      else
                         nDiasAtraso:=0;
                         nMulta:=0.0;
                      end if;
                      itostr(nDiasAtraso,sDiasAtraso);
                      Etexto(27,14,black,light_gray,to_string(Emprestimos.DtEmprestimo));
                      Etexto(61,14,black,light_gray,to_string(Emprestimos.DtDevolucao));
                      Etexto(23,16,black,light_gray,to_string(sDiasAtraso));
                      -- Etexto(59,16,black,light_gray,to_string(sMulta)); --
                      textcolor(black);
                      textbackground(light_gray);
                      gotoxy(59,16);
                      Put(nMulta,3,2,0);
                      Usuarios.Situacao:=Usuarios.Situacao - 1;
                      Livros.Estado:='D';
                      Controles_formEmprestimos("Devolver",tipo2,pos,col,
                      rod,true);
                   else
                      rodape("Usuario com 0 livros em sua posse, Impossivel Efetuar Devolucao !"," ",yellow,red);
                      Controles_formEmprestimos("Fechar",tipo2,pos,col,rod,true);
                   end if;
                 else
                   rodape("O livro ja esta disponivel, Impossivel Efetuar Devolucao !"," ",yellow,red);
                   Controles_formEmprestimos("Fechar",tipo2,pos,col,rod,true);
                 end if; 
              else
                 rodape("Emprestimo inexistente, Impossivel Efetuar Devolucao !"," ",yellow,red);
                 Controles_formEmprestimos("Fechar",tipo2,pos,col,rod,true);
              end if;
           end if;
             ----- 
        else
          itostr(I,S);
          Atribuir_vEmprestimos(true);
          Rotulos_formEmprestimos(tipo2,0);
          rodape("Numero de Inscricao do Livro, nao encontrado !",
          " ",yellow,red);
          Controles_formEmprestimos("Fechar",tipo2,pos,col,rod,true);
        end if;
      else
        Controles_formEmprestimos("Fechar",tipo2,pos,col,rod,true);
      end if;
    else
      itostr(I,S);
      Atribuir_vEmprestimos(true);
      Rotulos_formEmprestimos(tipo2,0);
      rodape("Numero de Inscricao do Usuario, nao encontrado !",
      " ",yellow,red);
      Controles_formEmprestimos("Fechar",tipo2,pos,col,rod,true);
    end if;
  else
    Controles_formEmprestimos("Fechar",tipo2,pos,col,rod,true);
  end if;
elsif tipo="2" then
   Listapos:=pos;
   Listacol:=col;
   if lista(3,6,5,13,70,nTamEmprestimos+2,113,white,blue,foco)=1 then
      desenhalista(3,6,5,13,70,white,blue,pos,col,false);
      Controles_formEmprestimos("Fechar",tipo2,pos,col,rod,true);
   end if;
elsif tipo="Emprestar" then
    case Botao(20,45,black,light_gray,black,blue," Emprestar ",foco) is
      when 1 =>
          DesenhaBotao(20,45,black,light_gray,black,blue," Emprestar ",false);
          Controles_formEmprestimos("Fechar",tipo2,pos,col,rod,true);
      when 2 =>
          if PesEmprestimos(Usuarios.Ninsc,Livros.Ninsc)/=-1 then
            Emprestimos.Removido:=false;
            SalvarEmprestimos(2);
          else
            Emprestimos.Removido:=false;
            nTamEmprestimos:=integer(EmprestimosIO.size(EmprestimosFile));
            SalvarEmprestimos(1);
          end if;
          DesenhaBotao(20,45,black,light_gray,black,blue," Emprestar ",false);
          Controles_formEmprestimos("Fechar",tipo2,pos,col,rod,true);
      when others => null;
    end case;
elsif tipo="Devolver" then
    case Botao(20,45,black,light_gray,black,blue," Devolver ",foco) is
      when 1 =>
          DesenhaBotao(20,45,black,light_gray,black,blue," Devolver ",false);
          Controles_formEmprestimos("Fechar",tipo2,pos,col,rod,true);
      when 2 =>
          Emprestimos.Removido:=true;
          SalvarEmprestimos(2);
          DesenhaBotao(20,45,black,light_gray,black,blue," Devolver ",false);
          Controles_formEmprestimos("Fechar",tipo2,pos,col,rod,true);
      when others => null;
    end case;
elsif tipo = "Fechar" then
    case Botao(20,60,black,light_gray,black,blue," Fechar ",foco) is
      when 1 =>
          DesenhaBotao(20,60,black,light_gray,black,blue," Fechar ",false);
          if (tipo2=1) or (tipo2=2) then
            Controles_formEmprestimos("1",tipo2,pos,col,rod,true);
          elsif tipo2=3 then
            Controles_formEmprestimos("2",tipo2,pos,col,rod,true);
          end if;
      when 2 =>
         rodape(""," ",white,blue);
         LivrosIO.close(LivrosFile);
         UsuariosIO.close(UsuariosFile);
         EmprestimosIO.close(EmprestimosFile);
      when others => null;
    end case;
end if;

end Controles_formEmprestimos;

-----------------------------------------------------------

--
-- Nome : Atribuir_vEmprestimos
-- Descricao : procedimento que atribui ou limpa o vetor de Emprestimos.
-- Parametros :
-- limpar - indica se vai limpar ou atribuir os vetores
--
procedure Atribuir_vEmprestimos(limpar: in boolean) is
begin
if limpar=false then
   vEmprestimos(3):=Emprestimos.DtEmprestimo;
   vEmprestimos(4):=Emprestimos.DtDEvolucao;
else
  vEmprestimos(2):=to_ustring(Repete(" ",5));
  vEmprestimos(3):=to_ustring(Repete(" ",10));
  vEmprestimos(4):=to_ustring(Repete(" ",10));
end if;
end Atribuir_vEmprestimos;  

-----------------------------------------------------------

--
-- Nome : SalvarEmprestimos
-- Descricao : procedimento que salva os dados digitados no
-- formulario de emprestimos.
-- Parametros :
-- tipo - indica qual acao a salvar
--
procedure SalvarEmprestimos(tipo: in integer) is
begin
    fAtribuir(1,false);
    LivrosIO.write(LivrosFile,bLivros);
    fAtribuir(2,false);
    UsuariosIO.write(UsuariosFile,bUsuarios);
    if tipo=1 then
        EmprestimosIO.set_index(EmprestimosFile,EmprestimosIO.count(nTamEmprestimos+1));
        fAtribuir(3,false);
        EmprestimosIO.write(EmprestimosFile,bEmprestimos);
        Atribuir_vEmprestimos(true);
        Rotulos_formEmprestimos(1,0);
    elsif tipo=2 then
        fAtribuir(3,false);
        EmprestimosIO.write(EmprestimosFile,bEmprestimos);
        Atribuir_vEmprestimos(true);
        Rotulos_formEmprestimos(1,0);
    end if;
end SalvarEmprestimos;

end MEmprest;
