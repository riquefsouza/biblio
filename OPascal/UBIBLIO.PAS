unit UBiblio;

interface

uses crt, dos, URotinas;

{ Declaracao de tipos }

type

 { Registro de Livros }

 LivrosRec = Record
     Ninsc : integer;        { Numero de Inscricao do Livro (5) }
     Titulo : string[30];    { Titulo do Livro (30) }
     Autor : string[30];     { Autor do Livro (30) }
     Area : string[30];      { Area de atuacao do Livro (30) }
     PChave : string[10];    { Palavra-Chave para pesquisar o Livro (10) }
     Edicao : integer;       { Edicao do Livro (4) }
     AnoPubli : integer;     { Ano de Publicacao do Livro (4) }
     Editora : String[30];   { Editora do Livro (30) }
     Volume : integer;       { Volume do Livro (4) }
     Estado : char;          { Estado Atual - (D)isponivel ou (E)mprestado (1) }
 end;

  { Registro de Enderecos }

 Enderecos = Record
     Logra : String[30];     { Logradouro (30) }
     Numero : integer;       { Numero do Endereco (5) }
     Compl : String[10];     { Complemento (10) }
     Bairro : String[20];    { Bairro do Endereco (20) }
     Cep : String[8];        { Cep do Endereco (8) }
 end;

 { Registro de Usuarios }

 UsuariosRec = Record
     Ninsc : integer;        { Numero de inscricao do Usuario (5) }
     Nome : String[30];      { Nome completo do Usuario (30) }
     Ident : String[10];     { Identidade do Usuario (10) }
     Endereco : Enderecos;   { Endereco completo do Usuario (73) }
     Telefone : String[11];  { Telefone do Usuario (11) }
     Categoria : char;       { Categoria - (A)luno,(P)rofessor,(F)uncionario (1) }
     Situacao : integer;     { Situacao - Numero de Livros em sua posse (1) }
 end;
 
  { Registro de Emprestimos }

  EmprestimosRec = Record
     NinscUsuario : integer;    { Numero de inscricao do Usuario (5) }
     NinscLivro : integer;      { Numero de inscricao do Livro (5) }
     DtEmprestimo : String[10]; { Data de Emprestimo do Livro (10) }
     DtDevolucao : String[10];  { Data de Devolucao do Livro (10) }
     Removido : boolean;        { Removido - Indica exclusao logica }
  end;

 TBiblio = object(TRotinas)

   { variaveis gerais }

   Fk:Boolean;
   Ch:char;
   S:String;
   Livros : LivrosRec;
   LivrosFile : File of LivrosRec;
   nTamLivros : integer;

   Usuarios : UsuariosRec;
   UsuariosFile : File of UsuariosRec;
   nTamUsuarios : integer;

   Emprestimos : EmprestimosRec;
   EmprestimosFile : File of EmprestimosRec;
   nTamEmprestimos : integer;

   SobreFile : Text;

   { variaveis de menu }

   vMenu : array[1..10] of String[30];
   vSubMenu : array[1..10,1..10] of String[35];

   { variaveis de lista }

   vLista : array[0..50] of String;
   {Listapos, Listacol:integer;}

   { Declaracao de funcoes }

   function SubMenu(numero,qtd,maxtam,topo,esquerda,ultpos,lfg,lbg,
               fg,bg:integer):integer;
   function Botao(topo,esquerda,fg,bg,sfg,sbg:integer;
                texto:string;foco:boolean):integer;

   function Lista(tipo,topo,esquerda,altura,largura,tlinhas,tcolunas,
               fg,bg:integer;
               var Listapos,Listacol:integer;foco:boolean): integer;
   function TiposLista(tipo,largura,pos,col:integer):string;

   { Declaracao de Procedimentos }

   procedure Digita( var St: string;JanelaTam,MaxTam,X,Y : Integer;
                  fg,bg : Integer;FT : Char; Fundo : integer);
   procedure formulario(titulo:string;topo,esquerda,
                     altura,largura,fg,bg:integer;
                     sombra:char;sfg,sbg:integer);
   procedure Menu(qtd,topo,fg,bg,lfg,lbg,pos2,mfg,mbg,cont2:integer);
   procedure DesenhaBotao(topo,esquerda,fg,bg,sfg,sbg:integer;
                       texto:string;foco:boolean);
   procedure formSplash;

   procedure DesenhaLista(tipo,topo,esquerda,altura,largura,
                       fg,bg,pos,col:integer;foco:boolean); 
   procedure AbrirArquivo(Tipo:integer); 

 end;

implementation

{
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
}
procedure TBiblio.Digita( var St: string;JanelaTam,MaxTam,X,Y : Integer;
                  fg,bg : Integer;FT : Char;Fundo : integer);
var
   xx, i, j, p : integer;
   InsertOn, ChaveEspecial : boolean;
   compensacao : integer;
   TempStr : String;

{-------------------------------------------}

procedure XY(x,y : integer);
var
  Xsmall : integer;
begin
  repeat
   Xsmall := x-80;
   if Xsmall > 0 then
     begin
       y:=y+1;
       x:=Xsmall;
     end;
  until Xsmall <= 0;
 gotoXY(x-1,y+1);
end;

{-------------------------------------------}

procedure SetString;
var
 i : integer;
begin
i:=length(St);
while s[i] = char(Fundo) do
  i:=i-1;
St[0]:=char(i);
setacursor(normal);
end;

{-------------------------------------------}

begin
j:=length(St)+1;
for i:=j to MaxTam do
   St[i]:=char(Fundo);
St[0]:=char(MaxTam);

tempstr:=copy(St,1,JanelaTam);
EscreveRapido(x,y,tempstr,fg,bg);
p:=1;
compensacao:=1;
InsertOn:=true;

   repeat
    xx:=X+(p-compensacao);
    if (p-compensacao) = JanelaTam then
       xx:=xx-1;

XY(XX,y);

if InsertOn then
   inkey(ChaveEspecial, ch, 'S', 'O')
else
   inkey(ChaveEspecial, ch, 'B', 'O');

if (FT='N') then
  begin
   if (key = TextKey) then
     begin
      beep(100,250);
      key:=nullkey;
     end
   else if (ch='-') and ((p>1) or (St[1]='-')) then
    begin
     beep(100,250);
     key:=nullkey;
    end
   else if (ch='.') then
    begin
     if not((pos('.',St)=0) or (pos('.',St)=p)) then
       begin
        beep(100,250);
        key:=nullkey;
       end
     else if (pos('.',St)=p) then
       delete(St,p,1);
     end;
    end;

 case key of

   NumberKey, TextKey, SpaceKey :
     begin
      if (length(St) = MaxTam) then
        begin
         if p = MaxTam then
          begin
           delete(St,MaxTam,1);
           St:=St+ch;
           if p = JanelaTam+compensacao then
             compensacao:=compensacao + 1;
           tempstr:=copy(St,compensacao,JanelaTam);
           EscreveRapido(x,y,tempstr,fg,bg);
          end
         else
          begin
           if InsertOn then
             begin
              delete(St,MaxTam,1);
              insert(ch,St,p);
              if p = JanelaTam+compensacao then
                 compensacao:=compensacao+1;
              if p < MaxTam then
                 p:=p+1;
              tempstr:=copy(St,compensacao,JanelaTam);
              EscreveRapido(x,y,tempstr,fg,bg);
             end
           else
             begin
              delete(St,p,1);
              insert(ch,St,p);
              if p = JanelaTam + compensacao then
                 compensacao:=compensacao+1;
              if p < MaxTam then
                 p:=p+1;
              tempstr:=copy(St,compensacao,JanelaTam);
              EscreveRapido(x,y,tempstr,fg,bg);
             end;
           end;
          end
        else
          begin
            if InsertOn then
              begin
               insert(ch,St,p);
              end
            else
              begin
               delete(St,p,1);
               insert(ch,St,p);
              end;
            if p = JanelaTam+compensacao then
               compensacao:=compensacao+1;
            if p < MaxTam then
               p:=p+1;
            tempstr:=copy(St,compensacao,JanelaTam);
            EscreveRapido(x,y,tempstr,fg,bg);
          end;
        end;

   Bksp:
     begin
      if p>1 then
        begin
         p:=p-1;
         delete(St,p,1);
         St:=St+char(Fundo);
         if compensacao > 1 then
           compensacao:=compensacao - 1;
         tempstr:=copy(St,compensacao,JanelaTam);
         EscreveRapido(x,y,tempstr,fg,bg);
         ch:=' ';
        end
      else
        begin
         beep(100,250);
         ch:=' ';
         p:=1;
        end;
      end;

   LeftArrow :
     begin
      if p > 1 then
        begin
         p:=p-1;
         if p < compensacao then
           begin
             compensacao:=compensacao - 1;
             tempstr:=copy(St,compensacao,JanelaTam);
             EscreveRapido(x,y,tempstr,fg,bg);
           end;
         end
      else
        begin
         SetString;
         { exit; }
        end;
      end;

   RightArrow :
     begin
      if (St[p] <> char(Fundo)) and (p < MaxTam) then
        begin
         p:=p+1;
         if p = (JanelaTam+compensacao) then
           begin
             compensacao:=compensacao + 1;
             tempstr:=copy(St,compensacao,JanelaTam);
             EscreveRapido(x,y,tempstr,fg,bg);
           end;
         end
      else
        begin
         SetString;
         { exit; }
        end;
      end;

   DeleteKey :
     begin
      delete(St,p,1);
      St:=St+char(Fundo);
      if ((Length(St)+1)-compensacao) >= JanelaTam then
        begin
          tempstr:=copy(St,compensacao,JanelaTam);
          EscreveRapido(x,y,tempstr,fg,bg);
        end
      else
        begin
          tempstr:=copy(St,compensacao,JanelaTam);
          EscreveRapido(x,y,tempstr,fg,bg);
        end;
      end;

   InsertKey :
      begin
        If InsertOn then
           InsertOn:=false
        else
           InsertOn:=true;
        end;

  else if not( key in [CarriageReturn, UpArrow, DownArrow,
               PgDn, PgUp, NullKey, Esc, Tab,
               F1, F2, F3, F4, F5, F6,
               F7, F8, F9, F10]) then
          beep(100,250);
  end;

until ( key in [CarriageReturn, Tab]);
SetString;

end;

{-------------------------------------------}

{
 Nome : formulario
 Descricao : procedimento que desenha um formulario na tela.
 Parametros :
 titulo - titulo do formulario
 topo - posicao da linha inicial na tela
 esquerda - posicao da coluna inicial na tela
 altura - a altura do formulario
 largura - a largura do formulario
 fg - cor do texto
 bg - cor de fundo
 sombra - o caracter que vai ser a sobra do formulario
 sfg - cor do texto da sombra
 sbg - cor de fundo da sombra
}
procedure TBiblio.formulario(titulo:string;topo,esquerda,
                     altura,largura,fg,bg:integer;
                     sombra:char;sfg,sbg:integer);
var
 cont,cont2:integer;
begin
  Etexto(esquerda,topo,fg,bg,'Ú');
  for cont:=1 to largura-1 do
   begin
     gotoxy(esquerda+cont,topo);
     write('Ä');
   end;
  gotoxy(esquerda+2,topo);
  write(titulo);
  gotoxy(esquerda+largura,topo);
  write('¿');
  for cont:=1 to altura-1 do
   begin
    gotoxy(esquerda,topo+cont);
    write('³');
    for cont2:=1 to largura-1 do
      begin
        gotoxy(esquerda+cont2,topo+cont);
        write(' ');
      end;
    gotoxy(esquerda+largura,topo+cont);
    write('³');
    Etexto(esquerda+largura+1,topo+cont,sfg,sbg,sombra);
    textcolor(fg);
    textbackground(bg);
   end;
  gotoxy(esquerda,topo+altura);
  write('À');
  for cont:=1 to largura-1 do
   begin
     Etexto(esquerda+cont,topo+altura,fg,bg,'Ä');
     Etexto(esquerda+cont+1,topo+altura+1,sfg,sbg,sombra);
   end;
  Etexto(esquerda+largura,topo+altura,fg,bg,'Ù');
  Etexto(esquerda+largura+1,topo+altura,sfg,sbg,sombra);
  gotoxy(esquerda+largura+1,topo+altura+1);
  write(sombra);
end;

{-------------------------------------------}

{
 Nome : SubMenu
 Descricao : funcao que permite criar um controle de submenu, retornando
 a opcao selecionada.
 Parametros :
 numero - indica qual e o submenu
 qtd - indica a quantidade de linhas do submenu
 maxtam - indica a largura maxima do submenu
 topo - posicao da linha inicial na tela
 esquerda - posicao da coluna inicial na tela
 ultpos - indica a ultima opcao referenciada pelo usuario
 lfg - cor do texto selecionado
 lbg - cor de fundo selecionado
 fg - cor do texto
 bg - cor de fundo
}
function TBiblio.SubMenu(numero,qtd,maxtam,topo,esquerda,ultpos,lfg,lbg,
               fg,bg:integer):integer;
var
 cont,cont2:integer;
begin
 textcolor(fg);
 textbackground(bg);
 for cont:=0 to qtd-1 do
  begin
    gotoxy(esquerda,topo+cont);
    write(vSubMenu[numero,cont+1]+Repete(' ',maxtam-length(vSubMenu[numero,cont+1])));
  end;
 Etexto(esquerda,topo+ultpos-1,lfg,lbg,vSubMenu[numero,ultpos]+
 Repete(' ',maxtam-length(vSubMenu[numero,ultpos])));

 cont:=ultpos-2;
 cont2:=ultpos-1;
 Repeat
   inkey(Fk,Ch,'O','O');

   if key=UpArrow then
     begin
       cont:=cont-1;
       cont2:=cont2-1;
       if cont2=-1 then
         begin
          cont:=-2;
          cont2:=qtd-1;
         end;

       Etexto(esquerda,topo+cont+2,fg,bg,vSubMenu[numero,cont+3]+
       Repete(' ',maxtam-length(vSubMenu[numero,cont+3])));
       Etexto(esquerda,topo+cont2,lfg,lbg,vSubMenu[numero,cont2+1]+
       Repete(' ',maxtam-length(vSubMenu[numero,cont2+1])));

       if cont=-2 then
          cont:=qtd-2;

     end;
   if key=DownArrow then
     begin
       cont:=cont+1;
       cont2:=cont2+1;
       if cont2=qtd then
          cont2:=0;

       Etexto(esquerda,topo+cont,fg,bg,vSubMenu[numero,cont+1]+
       Repete(' ',maxtam-length(vSubMenu[numero,cont+1])));
       Etexto(esquerda,topo+cont2,lfg,lbg,vSubMenu[numero,cont2+1]+
       Repete(' ',maxtam-length(vSubMenu[numero,cont2+1])));

       if cont=qtd-1 then
          cont:=-1;

     end;

 until (Key in [CarriageReturn,LeftArrow,RightArrow]);
 if key=LeftArrow then
   SubMenu:=1
 else if key=RightArrow then
   SubMenu:=2
 else if Key=CarriageReturn then
   SubMenu:=cont2+3;

end;

{-------------------------------------------}

{
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
}
procedure TBiblio.Menu(qtd,topo,fg,bg,lfg,lbg,pos2,mfg,mbg,cont2:integer);
var
 cont,pos,entre:integer;
begin
   for cont:=1 to 80 do
      Etexto(cont,topo,fg,bg,' ');
   pos:=0;
   entre:=0;
   for cont:=1 to qtd do
    begin
      Etexto(pos+4+entre,topo,lfg,lbg,copy(vMenu[cont],1,1));
      Etexto(pos+5+entre,topo,fg,bg,copy(vMenu[cont],2,length(vMenu[cont])));
      entre:=entre+3;
      pos:=pos+length(vMenu[cont]);
    end;
   if pos2 > 0 then
     begin
      Etexto(pos2+2,topo,lfg,mbg,' '+copy(vMenu[cont2],1,1));
      Etexto(pos2+4,topo,mfg,mbg,copy(vMenu[cont2],2,length(vMenu[cont2]))+' ');
     end;
end;

{-------------------------------------------}

{
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
}
procedure TBiblio.DesenhaBotao(topo,esquerda,fg,bg,sfg,sbg:integer;
                       texto:string;foco:boolean);
var
 tam,cont:integer;
begin
tam:=length(texto);
if foco=false then
   Etexto(esquerda,topo,fg,bg,' '+texto+' ');
if foco=true then
  Etexto(esquerda,topo,fg,bg,chr(16)+texto+chr(17));
Etexto(esquerda+tam+2,topo,sfg,sbg,chr(220));
for cont:=1 to tam+2 do
  Etexto(esquerda+cont,topo+1,sfg,sbg,chr(223));
end;

{-------------------------------------------}

{
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
}
function TBiblio.Botao(topo,esquerda,fg,bg,sfg,sbg:integer;
                texto:string;foco:boolean):integer;
var
 tam,cont:integer;
begin
tam:=length(texto);
DesenhaBotao(topo,esquerda,fg,bg,sfg,sbg,texto,foco);

Repeat

inkey(Fk,Ch,'O','O');

if foco=true then
 begin
  if key=CarriageReturn then
    begin
      Etexto(esquerda+1,topo,fg,bg,chr(16)+texto+chr(17));
      Etexto(esquerda,topo,sfg,sbg,' ');
      for cont:=1 to tam+2 do
        Etexto(esquerda+cont,topo+1,sfg,sbg,' ');
      delay(500);
      Botao:=2;
      exit;
    end;
 end;

until Key=Tab;
 if key=Tab then
    Botao:=1;

end;

{-----------------------------------------------------}

{
 Nome : formSplash
 Descricao : procedimento que desenha a tela inicial do sistema.
}
procedure TBiblio.formSplash;
begin
  setacursor(nenhum);
  formulario('',6,10,12,58,white,blue,'±',lightgray,black);
  Etexto(13, 8,yellow,blue,' ²²²²²²²     ²    ²²²²²²²     ²       ²    ²²²²²² ');
  Etexto(13, 9,yellow,blue,'²²²    ²²²   ²²  ²²²    ²²²   ²²      ²²  ²²²  ²²²');
  Etexto(13,10,yellow,blue,'²²²²²²²²²    ²²  ²²²²²²²²²    ²²      ²²  ²²    ²²');
  Etexto(13,11,yellow,blue,'²²²    ²²²   ²²  ²²²    ²²²   ²²²     ²²  ²²    ²²');
  Etexto(13,12,yellow,blue,'²²²²   ²²²   ²²  ²²²²   ²²²   ²²²²    ²²  ²²²  ²²²');
  Etexto(13,13,yellow,blue,' ²²²²²²²²²   ²²   ²²²²²²²²²   ²²²²²²  ²²   ²²²²²² ');
  Etexto(12,15,yellow,blue,'Programa Desenvolvido por Henrique Figueiredo de Souza');
  Etexto(12,16,yellow,blue,'Todos os Direitos Reservados - 1999   Versao 1.0');
  Etexto(12,17,yellow,blue,'Linguagem Usada Nesta Versao << PASCAL >>');
  delay(2000);
end;

{-------------------------------------------}

{
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
}
procedure TBiblio.DesenhaLista(tipo,topo,esquerda,altura,largura,
                       fg,bg,pos,col:integer;foco:boolean);
var
 cont:integer;
 posicao,coluna:string;
 sLista:string;
begin
if foco=true then
  begin
   Etexto(esquerda-1,topo-1,fg,bg,'Ú');
   Etexto(esquerda+largura+1,topo-1,fg,bg,'¿');
   Etexto(esquerda-1,topo+altura,fg,bg,'À');
   Etexto(esquerda+largura+1,topo+altura,fg,bg,'Ù');
 end
else
 begin
   Etexto(esquerda-1,topo-1,fg,bg,' ');
   Etexto(esquerda+largura+1,topo-1,fg,bg,' ');
   Etexto(esquerda-1,topo+altura,fg,bg,' ');
   Etexto(esquerda+largura+1,topo+altura,fg,bg,' ');
 end;

AbrirArquivo(tipo); 
sLista:=TiposLista(tipo,largura,pos+1,col+1);
Etexto(esquerda,topo,fg,bg,sLista+Repete(' ',largura-length(sLista)));
for cont:=1 to altura-2 do
 begin
  sLista:=TiposLista(tipo,largura,pos+cont+1,col+1);
  Etexto(esquerda,topo+cont,fg,bg,sLista+
  Repete(' ',largura-length(sLista)));
 end;
sLista:=TiposLista(tipo,largura,pos+altura,col+1);
Etexto(esquerda,topo+altura-1,fg,bg,sLista+
Repete(' ',largura-length(sLista)));

str(pos+1,posicao);
Etexto(esquerda,topo+altura+1,fg,bg,'Linha : '+
repete('0',4-length(posicao))+posicao);
str(col+1,coluna);
Etexto(esquerda+14,topo+altura+1,fg,bg,'Coluna : '+
repete('0',4-length(coluna))+coluna);

end;

{-------------------------------------------}

{
 Nome : TiposLista
 Descricao : funcao que indica quais arquivos serao usados com a lista,
 como tambem a formatacao do cabecalho desses arquivos na lista
 Parametros :
 tipo - indica o numero de qual arquivo a ser aberto
 largura - indica a largura do texto
 pos - indica a posicao do texto na lista
 col - indica a posicao da coluna do texto na lista
}
function TBiblio.TiposLista(tipo,largura,pos,col:integer):string;
var
 sAux:string;
begin
if tipo=1 then
  begin
    if pos=1 then
      begin
        sAux:='Numero de Inscricao ³ Titulo                         ³ ';
        sAux:=sAux+'Autor                          ³ ';
        sAux:=sAux+'Area                           ³ Palavra-Chave ³ ';
        sAux:=sAux+'Edicao ³ Ano de Publicacao ³ ';
        sAux:=sAux+'Editora                        ³ Volume ³ Estado Atual';
        TiposLista:=copy(sAux,col,largura);
      end;
    if pos=2 then
      TiposLista:=repete('-',largura);
    if pos > 2 then
     begin
      if nTamLivros > pos-3 then
       begin
        seek(LivrosFile,pos-3);
        read(LivrosFile,Livros);
        with Livros do
         begin
          str(Ninsc,S);
          sAux:=repete(' ',19-length(S))+S+' ³ ';
          sAux:=sAux+Titulo+repete(' ',31-length(Titulo))+'³ ';
          sAux:=sAux+Autor+repete(' ',31-length(Autor))+'³ ';
          sAux:=sAux+Area+repete(' ',31-length(Area))+'³ ';
          sAux:=sAux+Pchave+repete(' ',14-length(Pchave))+'³ ';
          Str(Edicao,S);
          sAux:=sAux+repete(' ',6-length(S))+S+' ³ ';
          Str(AnoPubli,S);
          sAux:=sAux+repete(' ',17-length(S))+S+' ³ ';
          sAux:=sAux+Editora+repete(' ',31-length(Editora))+'³ ';
          Str(Volume,S);
          sAux:=sAux+repete(' ',6-length(S))+S+' ³ ';
          if Estado='D' then
             sAux:=sAux+'Disponivel'
          else
             sAux:=sAux+'Emprestado';
         end;
         TiposLista:=copy(sAux,col,largura);
       end
      else
         TiposLista:='';
     end;
  end
else if tipo=2 then
  begin
    if pos=1 then
      begin
        sAux:='Numero de Inscricao ³ Nome                           ³ ';
        sAux:=sAux+'Identidade ³ Logradouro                     ³ ';
        sAux:=sAux+'Numero ³ Complemento ³ ';
        sAux:=sAux+'Bairro               ³ Cep      ³ ';
        sAux:=sAux+'Telefone    ³ Categoria   ³ Situacao';
        TiposLista:=copy(sAux,col,largura);
      end;
    if pos=2 then
      TiposLista:=repete('-',largura);
    if pos > 2 then
     begin
      if nTamUsuarios > pos-3 then
       begin
        seek(UsuariosFile,pos-3);
        read(UsuariosFile,Usuarios);
        with Usuarios do
         begin
          str(Ninsc,S);
          sAux:=repete(' ',19-length(S))+S+' ³ ';
          sAux:=sAux+Nome+repete(' ',31-length(Nome))+'³ ';
          sAux:=sAux+repete(' ',10-length(Ident))+Ident+' ³ ';
          sAux:=sAux+Endereco.logra+repete(' ',31-length(Endereco.logra))+'³ ';
          str(Endereco.numero,S);
          sAux:=sAux+repete(' ',6-length(S))+S+' ³ ';
          sAux:=sAux+Endereco.compl+repete(' ',12-length(Endereco.compl))+'³ ';
          sAux:=sAux+Endereco.Bairro+repete(' ',21-length(Endereco.Bairro))+'³ ';
          sAux:=sAux+repete(' ',8-length(Endereco.Cep))+Endereco.Cep+' ³';
          sAux:=sAux+repete(' ',12-length(Telefone))+Telefone+' ³ ';
          if Categoria='A' then
             sAux:=sAux+'Aluno'+repete(' ',12-length('Aluno'))+'³ '
          else if Categoria='P' then
             sAux:=sAux+'Professor'+repete(' ',12-length('Professor'))+'³ '
          else if Categoria='F' then
             sAux:=sAux+'Funcionario'+
             repete(' ',12-length('Funcionario'))+'³ ';
          str(Situacao,S);
          sAux:=sAux+repete(' ',8-length(S))+S;
         end;
         TiposLista:=copy(sAux,col,largura);
       end
      else
         TiposLista:='';
     end;
  end
else if tipo=3 then
  begin
    if pos=1 then
      begin
        sAux:='Numero de Inscricao do Usuario ³ ';
        sAux:=sAux+'Numero de Inscricao do Livro ³ ';
        sAux:=sAux+'Data do Emprestimo ³ Data da Devolucao ³ ';
        sAux:=sAux+'Removido';
        TiposLista:=copy(sAux,col,largura);
      end;
    if pos=2 then
      TiposLista:=repete('-',largura);
    if pos > 2 then
     begin
      if nTamEmprestimos > pos-3 then
       begin
        seek(EmprestimosFile,pos-3);
        read(EmprestimosFile,Emprestimos);
        with Emprestimos do
         begin
          S:='';
          str(NinscUsuario,S);
          sAux:=repete(' ',30-length(S))+S+' ³ ';
          str(NinscLivro,S);
          sAux:=sAux+repete(' ',28-length(S))+S+' ³ ';
          sAux:=sAux+DtEmprestimo+repete(' ',19-length(DtEmprestimo))+'³ ';
          sAux:=sAux+DtDevolucao+repete(' ',18-length(DtDevolucao))+'³ ';
          if Removido=true then
             sAux:=sAux+'Sim'
          else
             sAux:=sAux+'Nao';
         end;
         TiposLista:=copy(sAux,col,largura);
       end
      else
         TiposLista:='';
     end;
  end
else if tipo=4 then
    TiposLista:=copy(vLista[pos-1],col,length(vLista[pos-1]));

end;

{-------------------------------------------}

{
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
}
function TBiblio.Lista(tipo,topo,esquerda,altura,largura,tlinhas,tcolunas,
               fg,bg:integer;
               var Listapos,Listacol:integer;foco:boolean): integer;
var
 cont2:integer;
 posicao,coluna,sLista:string;
begin

DesenhaLista(tipo,topo,esquerda,altura,largura,fg,bg,
Listapos,listacol,foco);

Repeat

inkey(Fk,Ch,'O','O');

  if key=UpArrow then
    begin
     if Listapos > 0 then
       begin
         Listapos:=Listapos-1;
         for cont2:=0 to altura-1 do
            begin
              sLista:=TiposLista(tipo,largura,Listapos+cont2+1,listacol+1);
              Etexto(esquerda,topo+cont2,fg,bg,sLista+
              Repete(' ',largura-length(sLista)));
            end;
         str(listapos+1,posicao);
         Etexto(esquerda,topo+altura+1,fg,bg,'Linha : '+
         repete('0',4-length(posicao))+posicao);
       end;
    end;

  if key=DownArrow then
    begin
     if Listapos < (tlinhas-altura) then
       begin
         Listapos:=Listapos+1;
         for cont2:=0 to altura-1 do
            begin
              sLista:=TiposLista(tipo,largura,Listapos+cont2+1,listacol+1);
              Etexto(esquerda,topo+cont2,fg,bg,sLista+
              Repete(' ',largura-length(sLista)));
            end;
         str(listapos+1,posicao);
         Etexto(esquerda,topo+altura+1,fg,bg,'Linha : '+
         repete('0',4-length(posicao))+posicao);
       end;
    end;

  if key=RightArrow then
    begin
     if Listacol < (tcolunas-largura) then
       begin
         listacol:=listacol+1;
         for cont2:=0 to altura-1 do
            begin
              sLista:=TiposLista(tipo,largura,Listapos+cont2+1,Listacol+1);
              Etexto(esquerda,topo+cont2,fg,bg,sLista+
              Repete(' ',largura-length(sLista)));
            end;
         str(listacol+1,coluna);
         Etexto(esquerda+14,topo+altura+1,fg,bg,'Coluna : '+
         repete('0',4-length(coluna))+coluna);

       end;
    end;

  if key=LeftArrow then
    begin
     if Listacol > 0 then
       begin
         listacol:=listacol-1;
         for cont2:=0 to altura-1 do
            begin
              sLista:=TiposLista(tipo,largura,Listapos+cont2+1,Listacol+1);
              Etexto(esquerda,topo+cont2,fg,bg,sLista+
              Repete(' ',largura-length(sLista)));
            end;
         str(listacol+1,coluna);
         Etexto(esquerda+14,topo+altura+1,fg,bg,'Coluna : '+
         repete('0',4-length(coluna))+coluna);
       end;
    end;

until Key=Tab;
if Key=Tab then
  Lista:=1;
end;

{-----------------------------------------------------}

{
 Nome : AbrirArquivo
 Descricao : procedimento que Abri o tipo de arquivo selecionado.
 Parametros :
 tipo - indica o numero de qual arquivo a ser aberto
}
procedure TBiblio.AbrirArquivo(Tipo:integer);
begin
  if Tipo=1 then
   begin
     Assign(LivrosFile, 'Livros.dat');
     if fsearch('Livros.dat','')='' then
        rewrite(LivrosFile)
     else
        reset(LivrosFile);
     nTamLivros:=FileSize(LivrosFile);
   end;
  if tipo=2 then
   begin
     Assign(UsuariosFile, 'Usuarios.dat');
     if fsearch('Usuarios.dat','')='' then
        rewrite(UsuariosFile)
     else
        reset(UsuariosFile);
     nTamUsuarios:=FileSize(UsuariosFile);
   end;
  if Tipo=3 then
   begin
     Assign(EmprestimosFile, 'Empresti.dat');
     if fsearch('Empresti.dat','')='' then
        rewrite(EmprestimosFile)
     else
        reset(EmprestimosFile);
     nTamEmprestimos:=FileSize(EmprestimosFile);
   end;
  if Tipo=4 then
   begin
     Assign(SobreFile, 'Sobre.dat');
     reset(SobreFile);
   end;

end;

end.
