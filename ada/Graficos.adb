package body Graficos is

-------------------------------------------------

--
-- Nome : Digita
-- Descricao : Procedimento que permite ter um maior controle da digitacao
-- de um texto, tambem permitindo indicar um texto maior do que o permitido
-- pelo espaco limite definido.
-- Parametros :
-- S - e o resultado da digitacao
-- JanelaTam - indica o tamanho maximo de visualizacao do texto digitado
-- MaxTam - indica o tamanho maximo do texto a ser digitado
-- X - posicao da coluna na tela
-- Y - posicao da linha na tela
-- fg - cor do texto
-- bg - cor de fundo
-- FT - indica o tipo de caracter a ser digitado se (N)umero ou (T)exto
-- fundo - Indica o caracter de fundo, da janela de digitacao
--
procedure Digita( S: in out ustring;JanelaTam,MaxTam,X,Y: in Integer;
                  fg: in foreground_color;bg: in background_color;
                  FT: in Character;fundo : in integer) is
 xx, i, j, p, x1, y1 : integer := 0;
 ch : character;
 InsertOn, ChaveEspecial : boolean:=false;
 compensacao : integer := 0;
 TempStr : ustring;
 Xsmall : integer := 0;

-----------------------------------------------

procedure SetString is
 i : integer;
begin
i:=length(S);
while element(S,i) = character'val(fundo) loop
  i:=i-1;
  if i=0 then
    exit;
  end if;
end loop;
setcursortype(normal);
end setstring;

-----------------------------------------------

begin
if length(S)/=MaxTam then
   S:=S & repete(" ",MaxTam-length(S));
end if;

j:=length(S)+1;
for i in j..MaxTam loop
   replace_element(s,i,character'val(fundo));
end loop;

tempstr:=to_ustring(copy(s,1,JanelaTam));
EscreveRapido(x,y,tempstr,fg,bg);
p:=1;
compensacao:=1;
InsertOn:=true;

loop 
    xx:=X+(p-compensacao);
    if (p-compensacao) = JanelaTam then
       xx:=xx-1;
    end if;
--------------------------------------------
-- XY(XX,y);
  x1:=xx;
  y1:=y; 
  loop
   Xsmall := x1-80;
   if Xsmall > 0 then
       y1:=y1+1;
       x1:=Xsmall;
   end if;
   exit when Xsmall <= 0;
  end loop;
 gotoxy(x1-1,y1+1);
-------------------------------------------
if InsertOn then
   inkey(ChaveEspecial, ch, 'S', 'O');
else
   inkey(ChaveEspecial, ch, 'B', 'O');
end if;

if (FT='N') then
   if (key = TextKey) then
      beep;
      key:=nullkey;
   elsif (ch='-') and ((p>1) or (element(s,1)='-')) then
     beep;
     key:=nullkey;
   elsif (ch='.') then
     if not((posstr('.',s)=0) or (posstr('.',s)=p)) then
        beep;
        key:=nullkey;
     elsif (posstr('.',s)=p) then
       deletar(s,p,1);
     end if;
   end if;
end if;

 case key is

   when NumberKey | TextKey | SpaceKey =>
      if (length(s) = MaxTam) then
         if p = MaxTam then
           deletar(s,MaxTam,1);
           s:=s & ch;
           if p = JanelaTam+compensacao then
             compensacao:=compensacao + 1;
           end if;
           tempstr:=to_ustring(copy(s,compensacao,JanelaTam));
           EscreveRapido(x,y,tempstr,fg,bg);
         else
           if InsertOn then
              deletar(s,MaxTam,1);
              inserir(ch,s,p);
              if p = JanelaTam+compensacao then
                 compensacao:=compensacao+1;
              end if;
              if p < MaxTam then
                 p:=p+1;
              end if;
              tempstr:=to_ustring(copy(s,compensacao,JanelaTam));
              EscreveRapido(x,y,tempstr,fg,bg);
           else -- substituicao --
              deletar(s,p,1);
              inserir(ch,s,p);
              if p = JanelaTam + compensacao then
                 compensacao:=compensacao+1;
              end if;
              if p < MaxTam then
                 p:=p+1;
              end if;
              tempstr:=to_ustring(copy(s,compensacao,JanelaTam));
              EscreveRapido(x,y,tempstr,fg,bg);
           end if;
         end if;
      else
            if InsertOn then
               inserir(ch,s,p);
            else
               deletar(s,p,1);
               inserir(ch,s,p);
            end if;
            if p = JanelaTam+compensacao then
               compensacao:=compensacao+1;
            end if;
            if p < MaxTam then
               p:=p+1;
            end if;
            tempstr:=to_ustring(copy(s,compensacao,JanelaTam));
            EscreveRapido(x,y,tempstr,fg,bg);
      end if;
   when Bksp =>
      if p>1 then
         p:=p-1;
         deletar(s,p,1);
         s:=s & character'val(fundo);
         if compensacao > 1 then
           compensacao:=compensacao - 1;
         end if;
         tempstr:=to_ustring(copy(s,compensacao,JanelaTam));
         EscreveRapido(x,y,tempstr,fg,bg);
         ch:=' ';
       else
         beep;
         ch:=' ';
         p:=1;
      end if;

   when LeftArrow =>
      if p > 1 then
         p:=p-1;
         if p < compensacao then
             compensacao:=compensacao - 1;
             tempstr:=to_ustring(copy(s,compensacao,JanelaTam));
             EscreveRapido(x,y,tempstr,fg,bg);
         end if;
      else
         SetString;
         -- exit;
      end if;

   when RightArrow =>

      if (element(s,p) /= character'val(fundo)) and (p < MaxTam) then
         p:=p+1;
         if p = (JanelaTam+compensacao) then
             compensacao:=compensacao + 1;
             tempstr:=to_ustring(copy(s,compensacao,JanelaTam));
             EscreveRapido(x,y,tempstr,fg,bg);
         end if;
      else
         SetString;
         -- exit;
      end if;

   when DeleteKey =>
      deletar(s,p,1);
      s:=s & character'val(fundo);
      if ((length(s)+1)-compensacao) >= JanelaTam then
          tempstr:=to_ustring(copy(s,compensacao,JanelaTam));
          EscreveRapido(x,y,tempstr,fg,bg);
      else
          tempstr:=to_ustring(copy(s,compensacao,JanelaTam));
          EscreveRapido(x,y,tempstr,fg,bg);
      end if;

   when InsertKey =>
      If InsertOn then
         InsertOn:=false;
      else
         InsertOn:=true;
      end if;

   when others =>
       if key=UpArrow or key=DownArrow then
          beep;       
       elsif key=PgDn or key=PgUp or key=NullKey or key=Esc then
          beep;       
       elsif key=F1 or key=F2 or key=F3 or key=F4 or key=F5 or key=F6 then
          beep;       
       elsif key=F7 or key=F8 or key=F9 or key=F10 then
          beep;
       end if;
  end case;

  exit when key=CarriageReturn; 
  exit when key=Tab;
end loop;
SetString;
trim(S,both);
end digita;

---------------------------------------------------------------

--
-- Nome : formulario
-- Descricao : procedimento que desenha um formulario na tela.
-- Parametros :
-- titulo - titulo do formulario
-- topo - posicao da linha inicial na tela
-- esquerda - posicao da coluna inicial na tela
-- altura - a altura do formulario
-- largura - a largura do formulario
-- fg - cor do texto
-- bg - cor de fundo
-- sombra - o caracter que vai ser a sobra do formulario
-- sfg - cor do texto da sombra
-- sbg - cor de fundo da sombra
--
procedure formulario(titulo: in string;topo,esquerda,altura,largura: in integer;
                     fg: in foreground_color;bg: in background_color;
                     sombra: in string;
                     sfg: in foreground_color;sbg: in background_color) is
 cont,cont2:integer:=0;
begin
  Etexto(esquerda,topo,fg,bg,"Ú");
  for cont in 1..largura-1 loop
     gotoxy(esquerda+cont,topo);
     cputs("Ä");
  end loop;
  gotoxy(esquerda+2,topo);
  cputs(titulo);
  gotoxy(esquerda+largura,topo);
  cputs("¿");
  for cont in 1..altura-1 loop
    gotoxy(esquerda,topo+cont);
    cputs("³");
    for cont2 in 1..largura-1 loop
        gotoxy(esquerda+cont2,topo+cont);
        cputs(" ");
    end loop;
    gotoxy(esquerda+largura,topo+cont);
    cputs("³");
    Etexto(esquerda+largura+1,topo+cont,sfg,sbg,sombra);
    textcolor(fg);
    textbackground(bg);
  end loop;
  gotoxy(esquerda,topo+altura);
  cputs("À");
  for cont in 1..largura-1 loop
     Etexto(esquerda+cont,topo+altura,fg,bg,"Ä");
     Etexto(esquerda+cont+1,topo+altura+1,sfg,sbg,sombra);
  end loop;
  Etexto(esquerda+largura,topo+altura,fg,bg,"Ù");
  Etexto(esquerda+largura+1,topo+altura,sfg,sbg,sombra);
  gotoxy(esquerda+largura+1,topo+altura+1);
  cputs(sombra);
end formulario;

-----------------------------------------------------

--
-- Nome : SubMenu
-- Descricao : funcao que permite criar um controle de submenu, retornando
-- a opcao selecionada.
-- Parametros :
-- numero - indica qual e o submenu
-- qtd - indica a quantidade de linhas do submenu
-- maxtam - indica a largura maxima do submenu
-- topo - posicao da linha inicial na tela
-- esquerda - posicao da coluna inicial na tela
-- ultpos - indica a ultima opcao referenciada pelo usuario
-- lfg - cor do texto selecionado
-- lbg - cor de fundo selecionado
-- fg - cor do texto
-- bg - cor de fundo
--
function SubMenu(numero,qtd,maxtam,topo,esquerda,ultpos: in integer;
          lfg: in foreground_color;lbg: in background_color;
          fg: in foreground_color;bg: in background_color) return integer is
 cont,cont2,nRet:integer:=0;
begin
 textcolor(fg);
 textbackground(bg);
 for cont in 0..qtd-1 loop
    gotoxy(esquerda,topo+cont);
    cputs(to_string(vSubMenu(numero,cont+1)) & Repete(" ",maxtam-length(vSubMenu(numero,cont+1))));
 end loop;
 Etexto(esquerda,topo+ultpos-1,lfg,lbg,to_string(vSubMenu(numero,ultpos)) &
 Repete(" ",maxtam-length(vSubMenu(numero,ultpos))));

 cont:=ultpos-2;
 cont2:=ultpos-1;
 loop
   inkey(Fk,Ch,'O','O');

   if key=UpArrow then
       cont:=cont-1;
       cont2:=cont2-1;
       if cont2=-1 then
          cont:=-2;
          cont2:=qtd-1;
       end if;

       Etexto(esquerda,topo+cont+2,fg,bg,to_string(vSubMenu(numero,cont+3)) &
       Repete(" ",maxtam-length(vSubMenu(numero,cont+3))));
       Etexto(esquerda,topo+cont2,lfg,lbg,to_string(vSubMenu(numero,cont2+1)) &
       Repete(" ",maxtam-length(vSubMenu(numero,cont2+1))));

       if cont=-2 then
          cont:=qtd-2;
       end if;

   end if;
   if key=DownArrow then
       cont:=cont+1;
       cont2:=cont2+1;
       if cont2=qtd then
          cont2:=0;
       end if;

       Etexto(esquerda,topo+cont,fg,bg,to_string(vSubMenu(numero,cont+1)) &
       Repete(" ",maxtam-length(vSubMenu(numero,cont+1))));
       Etexto(esquerda,topo+cont2,lfg,lbg,to_string(vSubMenu(numero,cont2+1)) &
       Repete(" ",maxtam-length(vSubMenu(numero,cont2+1))));

       if cont=qtd-1 then
          cont:=-1;
       end if;
   end if;

   exit when Key=CarriageReturn;
   exit when key=LeftArrow;
   exit when key=RightArrow;
 end loop;
 if key=LeftArrow then
   nRet:=1;
 elsif key=RightArrow then
   nRet:=2;
 elsif Key=CarriageReturn then
   nRet:=cont2+3;
 end if;
 return nRet;
end Submenu;

-------------------------------------------------------------------

--
-- Nome : Menu
-- Descricao : procedimento que escreve a linha de opcoes do menu.
-- Parametros :
-- qtd - indica a quantidade de opcoes no menu
-- topo - posicao da linha inicial na tela
-- fg - cor do texto
-- bg - cor de fundo
-- lfg - cor do texto do primeiro caracter de cada opcao do menu
-- lbg - cor de fundo do primeiro caracter de cada opcao do menu
-- pos2 - indica a ultima opcao de menu referenciada pelo usuario
-- mfg - cor do texto do selecionado
-- mbg - cor de fundo do selecionado
-- cont2 - indica a ultima posicao da descricao da opcao de menu
-- referenciada pelo usuario
--
procedure Menu(qtd,topo: in integer;
               fg: in foreground_color;bg: in background_color;
               lfg: in foreground_color;lbg: in background_color;
               pos2: in integer;mfg: in foreground_color;
               mbg: in background_color;cont2: in integer) is
 cont,pos,entre:integer:=0;
begin
   for cont in 1..80 loop
      Etexto(cont,topo,fg,bg," ");
   end loop;
   pos:=0;
   entre:=0;
   for cont in 1..qtd loop
      Etexto(pos+4+entre,topo,lfg,lbg,copy(vMenu(cont),1,1));
      Etexto(pos+5+entre,topo,fg,bg,copy(vMenu(cont),2,length(vMenu(cont))));
      entre:=entre+3;
      pos:=pos+length(vMenu(cont));
   end loop;
   if pos2 > 0 then
      Etexto(pos2+2,topo,lfg,mbg," " & copy(vMenu(cont2),1,1));
      Etexto(pos2+4,topo,mfg,mbg,copy(vMenu(cont2),2,length(vMenu(cont2))) & " ");
   end if;
end menu;

----------------------------------------------------------------------

--
-- Nome : DesenhaBotao
-- Descricao : procedimento que desenha um botao na tela
-- Parametros :
-- topo - posicao da linha inicial na tela
-- esquerda - posicao da coluna inicial na tela
-- fg - cor do texto
-- bg - cor de fundo
-- sfg - cor do texto da sombra
-- sbg - cor de fundo da sombra
-- texto - o texto a ser escrito no botao
-- foco - indica se o botao esta focado ou nao
--
procedure DesenhaBotao(topo,esquerda: in integer;
                       fg: in foreground_color;bg: in background_color;
                       sfg: in foreground_color;sbg: in background_color;
                       texto: in string;foco: in boolean) is
 tam,cont:integer:=0;
begin
tam:=texto'length;
if foco=false then
   Etexto(esquerda,topo,fg,bg," " & texto & " ");
end if;
if foco=true then
  Etexto(esquerda,topo,fg,bg,character'val(16) & texto & character'val(17));
end if;
Etexto(esquerda+tam+2,topo,sfg,sbg,"Ü");
for cont in 1..tam+2 loop
  Etexto(esquerda+cont,topo+1,sfg,sbg,"ß");
end loop;
end DesenhaBotao;

----------------------------------------------------------------------

--
-- Nome : Botao
-- Descricao : funcao que realiza a acao de apertar o botao.
-- Parametros :
-- topo - posicao da linha inicial na tela
-- esquerda - posicao da coluna inicial na tela
-- fg - cor do texto
-- bg - cor de fundo
-- sfg - cor do texto da sombra
-- sbg - cor de fundo da sombra
-- texto - o texto a ser escrito no botao
-- foco - indica se o botao esta focado ou nao
--
function Botao(topo,esquerda: in integer;
               fg: in foreground_color;bg: in background_color;
               sfg: in foreground_color;sbg: in background_color;
               texto: in string;foco: in boolean) return integer is
 tam,cont,nRet:integer:=0;
begin
tam:=texto'length;
DesenhaBotao(topo,esquerda,fg,bg,sfg,sbg,texto,foco);

loop

inkey(Fk,Ch,'O','O');

if foco=true then
  if key=CarriageReturn then
      Etexto(esquerda+1,topo,fg,bg,character'val(16) & texto & character'val(17));
      Etexto(esquerda,topo,sfg,sbg," ");
      for cont in 1..tam+2 loop
        Etexto(esquerda+cont,topo+1,sfg,sbg," ");
      end loop;
      esperar(1);
      nRet:=2;
      exit;
  end if;
end if;

  exit when Key=Tab;
end loop;
 if key=Tab then
    nRet:=1;
 end if;
 return nRet;
end Botao;

----------------------------------------------------------------------

--
-- Nome : formSplash
-- Descricao : procedimento que desenha a tela inicial do sistema.
--
procedure formSplash is
begin
  setcursortype(none);
  formulario("",6,10,12,58,white,blue,"±",light_gray,black);
  Etexto(13, 8,yellow,blue," ²²²²²²²     ²    ²²²²²²²     ²       ²    ²²²²²² ");
  Etexto(13, 9,yellow,blue,"²²²    ²²²   ²²  ²²²    ²²²   ²²      ²²  ²²²  ²²²");
  Etexto(13,10,yellow,blue,"²²²²²²²²²    ²²  ²²²²²²²²²    ²²      ²²  ²²    ²²");
  Etexto(13,11,yellow,blue,"²²²    ²²²   ²²  ²²²    ²²²   ²²²     ²²  ²²    ²²");
  Etexto(13,12,yellow,blue,"²²²²   ²²²   ²²  ²²²²   ²²²   ²²²²    ²²  ²²²  ²²²");
  Etexto(13,13,yellow,blue," ²²²²²²²²²   ²²   ²²²²²²²²²   ²²²²²²  ²²   ²²²²²² ");
  Etexto(12,15,yellow,blue,"Programa Desenvolvido por Henrique Figueiredo de Souza");
  Etexto(12,16,yellow,blue,"Todos os Direito Reservados - 1999  Versao 1.0");
  Etexto(12,17,yellow,blue,"Linguagem Usada Nesta Versao << ADA >>");
  esperar(2);
end formSplash;

--------------------------------------------------------------------------

--
-- Nome : DesenhaLista
-- Descricao : procedimento que desenha uma Lista rolavel na tela
-- Parametros :
-- tipo - indica o numero de qual arquivo a ser aberto
-- topo - posicao da linha inicial na tela
-- esquerda - posicao da coluna inicial na tela
-- altura - indica a altura da lista
-- largura - indica a largura da lista
-- fg - cor do texto
-- bg - cor de fundo
-- pos - indica a ultima posicao da linha da lista na tela
-- col - indica a ultima posicao da coluna da lista na tela
-- foco - indica se a lista esta focada ou nao
--
procedure DesenhaLista(tipo,topo,esquerda,altura,largura: in integer;
                       fg: in foreground_color;bg: in background_color;
                       pos,col: in integer;foco: in boolean) is
 cont:integer:=0;
 posicao,coluna:ustring;
 sLista:ustring;
begin
if foco=true then
   Etexto(esquerda-1,topo-1,fg,bg,"Ú");
   Etexto(esquerda+largura+1,topo-1,fg,bg,"¿");
   Etexto(esquerda-1,topo+altura,fg,bg,"À");
   Etexto(esquerda+largura+1,topo+altura,fg,bg,"Ù");
else
   Etexto(esquerda-1,topo-1,fg,bg," ");
   Etexto(esquerda+largura+1,topo-1,fg,bg," ");
   Etexto(esquerda-1,topo+altura,fg,bg," ");
   Etexto(esquerda+largura+1,topo+altura,fg,bg," ");
end if;
AbrirArquivo(tipo);
sLista:=TiposLista(tipo,largura,pos+1,col+1);
Etexto(esquerda,topo,fg,bg,to_string(sLista) & Repete(" ",largura-length(sLista)));
for cont in 1..altura-2 loop
  sLista:=TiposLista(tipo,largura,pos+cont+1,col+1);
  Etexto(esquerda,topo+cont,fg,bg,to_string(sLista) &
  Repete(" ",largura-length(sLista)));
end loop;
sLista:=TiposLista(tipo,largura,pos+altura,col+1);
Etexto(esquerda,topo+altura-1,fg,bg,to_string(sLista) &
Repete(" ",largura-length(sLista)));

itostr(pos+1,posicao);
Etexto(esquerda,topo+altura+1,fg,bg,"Linha : " &
repete("0",4-itam(pos+1)) & to_string(posicao));
itostr(col+1,coluna);
Etexto(esquerda+14,topo+altura+1,fg,bg,"Coluna : " &
repete("0",4-itam(col+1)) & to_string(coluna));

end DesenhaLista;

----------------------------------------------------------------------

--
-- Nome : Lista
-- Descricao : funcao que executa a acao de rolamento da lista.
-- Parametros :
-- tipo - indica o numero de qual arquivo a ser aberto
-- topo - posicao da linha inicial na tela
-- esquerda - posicao da coluna inicial na tela
-- largura - indica a largura da lista
-- tlinhas - indica o numero total de linhas da lista
-- tcolunas - indica o numero total de colunas da lista
-- fg - cor do texto
-- bg - cor de fundo
-- listapos - indica a ultima posicao da linha da lista na tela
-- litacol - indica a ultima posicao da coluna da lista na tela
-- foco - indica se a lista esta focada ou nao
--
function Lista(tipo,topo,esquerda,altura,largura,tlinhas,tcolunas: in integer;
               fg: in foreground_color;bg: in background_color;           
               foco: in boolean) return integer is
 cont2,nRet:integer:=0;
 posicao,coluna: ustring;
 sLista:ustring;
begin

DesenhaLista(tipo,topo,esquerda,altura,largura,fg,bg,
Listapos,listacol,foco);

loop

inkey(Fk,Ch,'O','O');

  if key=UpArrow then
     if Listapos > 0 then
         Listapos:=Listapos-1;
         for cont2 in 0..altura-1 loop
           sLista:=TiposLista(tipo,largura,Listapos+cont2+1,listacol+1);
           Etexto(esquerda,topo+cont2,fg,bg,to_string(sLista) &
           Repete(" ",largura-length(sLista)));
         end loop;
         itostr(listapos+1,posicao);
         Etexto(esquerda,topo+altura+1,fg,bg,"Linha : " &
         repete("0",4-itam(listapos+1)) & to_string(posicao));
     end if;
  end if;

  if key=DownArrow then
     if Listapos < (tlinhas-altura) then
         Listapos:=Listapos+1;
         for cont2 in 0..altura-1 loop
           sLista:=TiposLista(tipo,largura,Listapos+cont2+1,listacol+1);
           Etexto(esquerda,topo+cont2,fg,bg,to_string(sLista) &
           Repete(" ",largura-length(sLista)));
         end loop;
         itostr(listapos+1,posicao);
         Etexto(esquerda,topo+altura+1,fg,bg,"Linha : " &
         repete("0",4-itam(listapos+1)) & to_string(posicao));
     end if;
  end if;

  if key=RightArrow then
     if Listacol < (tcolunas-largura) then
         listacol:=listacol+1;
         for cont2 in 0..altura-1 loop
           sLista:=TiposLista(tipo,largura,Listapos+cont2+1,Listacol+1);
           Etexto(esquerda,topo+cont2,fg,bg,to_string(sLista) &
           Repete(" ",largura-length(sLista)));
         end loop;
         itostr(listacol+1,coluna);
         Etexto(esquerda+14,topo+altura+1,fg,bg,"Coluna : " &
         repete("0",4-itam(listacol+1)) & to_string(coluna));
     end if;
  end if;

  if key=LeftArrow then
     if Listacol > 0 then
         listacol:=listacol-1;
         for cont2 in 0..altura-1 loop
           sLista:=TiposLista(tipo,largura,Listapos+cont2+1,Listacol+1);
           Etexto(esquerda,topo+cont2,fg,bg,to_string(sLista) &
           Repete(" ",largura-length(sLista)));
         end loop;
         itostr(listacol+1,coluna);
         Etexto(esquerda+14,topo+altura+1,fg,bg,"Coluna : " &
         repete("0",4-itam(listacol+1)) & to_string(coluna));
     end if;
  end if;

  exit when Key=Tab;
end loop;
if Key=Tab then
   nRet:=1;
end if;
return nRet;
end Lista;

------------------------------------------------------------------

--
-- Nome : TiposLista
-- Descricao : funcao que indica quais arquivos serao usados com a lista,
-- como tambem a formatacao do cabecalho desses arquivos na lista
-- Parametros :
-- tipo - indica o numero de qual arquivo a ser aberto
-- largura - indica a largura do texto
-- pos - indica a posicao do texto na lista
-- col - indica a posicao da coluna do texto na lista
--
function TiposLista(tipo,largura,pos,col:in integer) return ustring is
 sAux:ustring;
 sRet:ustring;
 sS:ustring;
begin
if tipo=1 then
    if pos=1 then
        sAux:=to_ustring("Numero de Inscricao ³ Titulo                         ³ ");
        sAux:=sAux & "Autor                          ³ ";
        sAux:=sAux & "Area                           ³ Palavra-Chave ³ ";
        sAux:=sAux & "Edicao ³ Ano de Publicacao ³ ";
        sAux:=sAux & "Editora                        ³ Volume ³ Estado Atual";
        sRet:=to_ustring(copy(sAux,col,largura));
    end if;
    if pos=2 then
       sRet:=to_ustring(repete("-",largura));
    end if;
    if pos > 2 then
      if nTamLivros > pos-3 then
        LivrosIO.set_index(LivrosFile,LivrosIO.count(pos-3+1));
        LivrosIO.read(LivrosFile,bLivros);
        fatribuir(1,true);

          itostr(Livros.Ninsc,sS);
          sAux:=to_ustring(repete(" ",19-itam(Livros.Ninsc)) &
          to_string(sS) & " ³ ");
          sAux:=sAux & Livros.Titulo & repete(" ",31-length(Livros.Titulo)) & "³ ";
          sAux:=sAux & Livros.Autor & repete(" ",31-length(Livros.Autor)) & "³ ";
          sAux:=sAux & Livros.Area & repete(" ",31-length(Livros.Area)) & "³ ";
          sAux:=sAux & Livros.Pchave & repete(" ",14-length(Livros.Pchave)) & "³ ";
          itostr(Livros.Edicao,sS);
          sAux:=sAux & repete(" ",6-itam(Livros.Edicao)) &
          to_string(sS) & " ³ ";
          itostr(Livros.AnoPubli,sS);
          sAux:=sAux & repete(" ",17-itam(Livros.AnoPubli)) &
          to_string(sS) & " ³ ";
          sAux:=sAux & Livros.Editora & repete(" ",31-length(Livros.Editora)) & "³ ";
          itostr(Livros.Volume,sS);
          sAux:=sAux & repete(" ",6-itam(Livros.Volume)) &
          to_string(sS) & " ³ ";
          if Livros.Estado='D' then
             sAux:=sAux & "Disponivel";
          else
             sAux:=sAux & "Emprestado";
          end if;

         sRet:=to_ustring(copy(sAux,col,largura));
      else
         sRet:=null_unbounded_string;
      end if;
    end if;
elsif tipo=2 then
    if pos=1 then
        sAux:=to_ustring("Numero de Inscricao ³ Nome                           ³ ");
        sAux:=sAux & "Identidade ³ Logradouro                     ³ ";
        sAux:=sAux & "Numero ³ Complemento ³ ";
        sAux:=sAux & "Bairro               ³ Cep      ³ ";
        sAux:=sAux & "Telefone    ³ Categoria   ³ Situacao";
        sRet:=to_ustring(copy(sAux,col,largura));
    end if;
    if pos=2 then
      sRet:=to_ustring(repete("-",largura));
    end if;
    if pos > 2 then
      if nTamUsuarios > pos-3 then
        UsuariosIO.set_index(UsuariosFile,UsuariosIO.count(pos-3+1));
        UsuariosIO.read(UsuariosFile,bUsuarios);
        fatribuir(2,true);
         
          itostr(Usuarios.Ninsc,sS);
          sAux:=to_ustring(repete(" ",19-itam(Usuarios.Ninsc)) &
          to_string(sS) & " ³ ");
          sAux:=sAux & Usuarios.Nome & repete(" ",31-length(Usuarios.Nome)) & "³ ";
          sAux:=sAux & repete(" ",10-length(Usuarios.Ident)) & Usuarios.Ident & " ³ ";
          sAux:=sAux & Usuarios.Endereco.logra &
          repete(" ",31-length(Usuarios.Endereco.logra)) & "³ ";
          itostr(Usuarios.Endereco.numero,sS);
          sAux:=sAux & repete(" ",6-itam(Usuarios.Endereco.numero)) &
          to_string(sS) & " ³ ";
          sAux:=sAux & Usuarios.Endereco.compl & repete(" ",12-length(Usuarios.Endereco.compl)) & "³ ";
          sAux:=sAux & Usuarios.Endereco.Bairro & repete(" ",21-length(Usuarios.Endereco.Bairro)) & "³ ";
          sAux:=sAux & repete(" ",8-length(Usuarios.Endereco.Cep)) & Usuarios.Endereco.Cep & " ³";
          sAux:=sAux & repete(" ",12-length(Usuarios.Telefone)) & Usuarios.Telefone & " ³ ";
          if Usuarios.Categoria='A' then
             sAux:=sAux & "Aluno" &
             repete(" ",12-length(to_ustring("Aluno"))) & "³ ";
          elsif Usuarios.Categoria='P' then
             sAux:=sAux & "Professor" &
             repete(" ",12-length(to_ustring("Professor"))) & "³ ";
          elsif Usuarios.Categoria='F' then
             sAux:=sAux & "Funcionario" & 
             repete(" ",12-length(to_ustring("Funcionario"))) & "³ ";
          end if;
          itostr(Usuarios.Situacao,sS);
          sAux:=sAux & repete(" ",8-itam(Usuarios.Situacao)) &
          to_string(sS);
         
         sRet:=to_ustring(copy(sAux,col,largura));

      else
         sRet:=null_unbounded_string;
      end if;
    end if;
elsif tipo=3 then
    if pos=1 then
        sAux:=to_ustring("Numero de Inscricao do Usuario ³ ");
        sAux:=sAux & "Numero de Inscricao do Livro ³ ";
        sAux:=sAux & "Data do Emprestimo ³ Data da Devolucao ³ ";
        sAux:=sAux & "Removido";
        sRet:=to_ustring(copy(sAux,col,largura));
    end if;
    if pos=2 then
       sRet:=to_ustring(repete("-",largura));
    end if;
    if pos > 2 then
      if nTamEmprestimos > pos-3 then
        EmprestimosIO.set_index(EmprestimosFile,EmprestimosIO.count(pos-3+1));
        EmprestimosIO.read(EmprestimosFile,bEmprestimos);
        fatribuir(3,true);

          S:=null_unbounded_string;
          itostr(Emprestimos.NinscUsuario,sS);
          sAux:=to_ustring(repete(" ",30-itam(Emprestimos.NinscUsuario)) &
          to_string(sS) & " ³ ");
          itostr(Emprestimos.NinscLivro,sS);
          sAux:=sAux & repete(" ",28-itam(Emprestimos.NinscLivro)) &
          to_string(sS) & " ³ ";
          sAux:=sAux & Emprestimos.DtEmprestimo & repete(" ",19-length(Emprestimos.DtEmprestimo)) & "³ ";
          sAux:=sAux & Emprestimos.DtDevolucao & repete(" ",18-length(Emprestimos.DtDevolucao)) & "³ ";
          if Emprestimos.Removido=true then
             sAux:=sAux & "Sim";
          else
             sAux:=sAux & "Nao";
          end if;
         sRet:=to_ustring(copy(sAux,col,largura));

      else
         sRet:=null_unbounded_string;
      end if;
    end if;
elsif tipo=4 then
    sRet:=to_ustring(copy(vLista(pos-1),col,length(vLista(pos-1))));
end if;
return sRet;
end TiposLista;

end Graficos;
