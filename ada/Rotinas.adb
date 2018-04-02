package body Rotinas is

-- Rotinas Fundamentais --

--
-- Nome : EscreveRapido
-- Descricao : Procedimento que permite ter um controle do posicionamento
-- do cursor, sem piscadas ou erros de repeticao de visualizacao.
-- Parametros :
-- x - posicao de coluna na tela
-- y - posicao de linha na tela
-- S - o resultado do que foi digitado
-- fg - cor do texto
-- bg - cod de fundo
-- stype - cor do monitor 'C'olorido ou 'M'onocromatico
--
procedure EscreveRapido(x,y: in integer;S: in out ustring;fg: in foreground_color;
                    bg: in background_color) is
begin
 textcolor(fg);
 textbackground(bg);
 gotoxy(x-1,y+1);
 cputs(to_string(S));
end EscreveRapido;

----------------------------------------------

--
-- Nome : Center
-- Descricao : Procedimento que centraliza um texto na tela.
-- Parametros :
-- y - posicao de linha na tela
-- s - texto a ser centralizado
-- fg - cor do texto
-- bg - cod de fundo
-- stype - cor do monitor 'C'olorido ou 'M'onocromatico
--
procedure center(y: in integer;S: in string;fg: in foreground_color;
                 bg: in background_color) is
 x : integer;
begin
 x:=40-(s'length / 2);
 etexto(x,y,fg,bg,s);
end center;

----------------------------------------------

--
-- Nome : Beep
-- Descricao : Procedimento que gera um beep.
-- Parametros :
-- freq - frequencia do beep.
-- time - duracao do beep.
--
procedure beep is
begin
 put(character'val(7));
end beep;

-----------------------------------------------

--
-- Nome : esperar
-- Descricao : Procedimento que gera um espera de tanto tempo
-- Parametros :
-- freq - frequencia do tempo
--
procedure esperar(freq: in integer) is
 cont:integer:=0;
begin
loop
 cont:=cont+1;
 exit when (freq*2200000)=cont;
end loop;
end esperar;

-----------------------------------------------

--
-- Nome : copy
-- Descricao : funcao que retorna um pedaco de uma string
-- Parametros :
-- str - indica a string
-- ini - indica a posicao inicial do pedaco
-- tam - indica o tamanho do pedaco
--
function copy(stg: in ustring;ini,tam: in integer) return string is
 ts:integer:=0;
begin
if tam > (length(stg)-ini)+1 then
   ts:=(length(stg)-ini)+1;
else
   ts:=tam;
end if;
return slice(stg,ini,ini+ts-1);
end copy;

-----------------------------------------------

--
-- Nome : itam
-- Descricao : funcao que retorna o tamanho de um inteiro
-- Parametros :
-- it - indica o inteiro
--
function itam(it: in integer) return integer is
 nRet:integer:=0;
begin
if it <= 9 then
  nRet:=1;
end if;
if it <= 99 and it > 9  then
  nRet:=2;
end if;
if it <= 999 and it > 99 then
  nRet:=3;
end if;
if it <= 9999 and it > 999 then
  nRet:=4;
end if;
if it <= 99999 and it > 9999 then
  nRet:=5;
end if;
if it <= 999999 and it > 99999 then
  nRet:=6;
end if;
if it <= 9999999 and it > 999999 then
  nRet:=7;
end if;
return nRet;
end itam;

-----------------------------------------------

--
-- Nome : itostr
-- Descricao : procedimento que converte de inteiro para ustring
-- Parametros :
-- num - indica o inteiro
-- str - indica a ustring
--
procedure itostr(num: in integer;str: in out ustring) is
 sS:string(1..itam(num));
begin
 itoa(num,sS,10);
 str:=to_ustring(copy(to_ustring(sS),1,itam(num)));
end itostr;

--------------------------------------------------------------

--
-- Nome : deletar
-- Descricao : funcao que deleta um pedaco da string
-- Parametros :
-- str - a string a ser cortada
-- ini - a posicao inicial do corte
-- tam - o tamanho do corte
--
procedure deletar(str: in out ustring;ini,tam: in integer) is
 St: ustring; 
 Ik: integer:=0;
begin
for Ik in 1..(ini - 1) loop
  St:=St & copy(str, Ik, 1);
end loop;

for Ik in (ini+tam)..length(str) loop
   St:= St & copy(str, Ik, 1);
end loop;
str:=st;
end deletar;

-----------------------------------------------

--
-- Nome : inserir
-- Descricao : funcao que inclui um caracter numa string
-- Parametros :
-- origem - o caracter a ser incluido
-- alvo - a string que vai receber o caracter
-- ini - a posicao na string a inserir o caracter
--
procedure inserir(origem: in character;alvo: in out ustring;ini: in integer) is
 Ig: integer:=0;
 s1: ustring;
 s2: ustring;
begin
for Ig in 1..(ini - 1) loop
  s1 := s1 & copy(alvo, Ig, 1);
end loop;
s2 := s1 & origem;
for Ig in (length(s1) + 1)..length(alvo) loop
  s2 := s2 & copy(alvo, Ig, 1);
end loop;
alvo:=s2;
end inserir;

-----------------------------------------------

--
-- Nome : posstr
-- Descricao : funcao que retorna a posicao de um caracter numa string
-- Parametros :
-- origem - indica o caracter a ser encontrado na string
-- alvo - indica a string que vai ser pesquisada
--
function posstr(origem: in character;alvo: in ustring) return integer is
 j: integer:=0;
 str:string(1..length(alvo));
begin
str:=to_string(alvo);
for j in 1..length(alvo) loop
  if (origem=str(j)) then
     return j;
  end if;
end loop;
return 0;
end posstr;

-----------------------------------------------

--
-- Nome : Inkey
-- Descricao : Procedimento que identifica uma tecla do teclado.
-- Parametros :
-- chavefuncional - variavel que indica se e uma tecla funcional
-- ch - indica o caracter pressionado
-- cursorinicio - indica o estado do cursor inicial
-- cursorfim - indica o estado do cursor final
-- stype - cor do monitor 'C'olorido ou 'M'onocromatico
--
procedure InKey(chavefuncional: in out boolean;
                ch: in out character;cursorinicio,cursorfim: in character) is
begin

 case cursorinicio is
   when 'B' => setcursortype(solid);
   when 'S' => setcursortype(normal);
   when 'O' => setcursortype(none);
   when others => null;
 end case;

chavefuncional:=false;
get_immediate(ch);
if ch=Character'val(0) then
  chavefuncional:=true;
  get_immediate(ch);
end if;

if chavefuncional then
   case ch is
    when Character'val(15) => key := ShiftTab;
    when Character'val(18) => key := AltE;
    when Character'val(22) => key := AltU;
    when Character'val(24) => key := AltO;
    when Character'val(30) => key := AltA;
    when Character'val(31) => key := AltS;
    when Character'val(72) => key := UpArrow;
    when Character'val(80) => key := DownArrow;
    when Character'val(75) => key := LeftArrow;
    when Character'val(77) => key := RightArrow;
    when Character'val(73) => key := PgUp;
    when Character'val(81) => key := PgDn;
    when Character'val(71) => key := HomeKey;
    when Character'val(79) => key := EndKey;
    when Character'val(83) => key := DeleteKey;
    when Character'val(82) => key := InsertKey;
    when Character'val(59) => key := F1;
    when Character'val(60) => key := F2;
    when Character'val(61) => key := F3;
    when Character'val(62) => key := F4;
    when Character'val(63) => key := F5;
    when Character'val(64) => key := F6;
    when Character'val(65) => key := F7;
    when Character'val(66) => key := F8;
    when Character'val(67) => key := F9;
    when Character'val(68) => key := F10;
    when others => null;
   end case;
else
   case ch is
    when Character'val(1) => Key := CtrlA;
    when Character'val(8) => key := Bksp;
    when Character'val(9) => key := Tab;
    when Character'val(13) => key := CarriageReturn;
    when Character'val(27) => key := Esc;
    when Character'val(32) => key := SpaceKey;
    when Character'val(33)..Character'val(44) => key := TextKey;
    when Character'val(47) => key := TextKey;
    when Character'val(58)..Character'val(254) => key := TextKey;
    when Character'val(45) | Character'val(46) => key := NumberKey;
    when Character'val(48)..Character'val(57) => key := NumberKey;
    when others => null;
   end case;
end if;

 case cursorfim is
  when 'B' => setcursortype(solid);
  when 'S' => setcursortype(normal);
  when 'O' => setcursortype(none);
  when others => null;
 end case;

end inkey;

-----------------------------------------------

--
-- Nome : Repete
-- Descricao : funcao que retorna um texto repetido n vezes.
-- Parametros :
-- St - indica o texto a ser repetido
-- Tam - quantas vezes o texto se repetira
--
function Repete(St: in string;Tam: in integer) return string is
 cont : integer;
 Esp : ustring;
begin
 cont:=1;
 Esp:=null_unbounded_string;
 while (cont <= Tam) loop
    Esp:=Esp & St;
    cont:=cont + 1;
 end loop;
return to_string(Esp);
end repete;

-----------------------------------------------

--
-- Nome : Etexto
-- Descricao : procedimento que escreve o texto na tela com determinada cor.
-- Parametros :
-- c - posicao de coluna do texto
-- l - posicao de linha do texto
-- fg - cor do texto
-- bg - cor de fundo
-- texto - o texto a ser escrito
--
procedure Etexto(c,l: in integer;fg: in foreground_color;
                 bg: in background_color;texto: in string) is
begin
 textcolor(fg);
 textbackground(bg);
 gotoxy(c,l);
 cputs(texto);
end etexto;

-----------------------------------------------

--
-- Nome : Teladefundo
-- Descricao : procedimento que desenha os caracteres do fundo da tela.
-- Parametros :
-- tipo - o caracter a ser escrito no fundo
-- fg - cor do texto
-- bg - cor de fundo
--
procedure TeladeFundo(tipo: in string;fg: in foreground_color;
                      bg: in background_color) is
 l,c:integer:=0;
begin
for l in 3..24 loop
  for c in 1..80 loop
    Etexto(c,l,fg,bg,tipo);
  end loop;
end loop;
end teladefundo;

-----------------------------------------------

--
-- Nome : cabecalho
-- Descricao : procedimento que escreve o texto de cabecalho do sistema.
-- Parametros :
-- texto - o texto a ser escrito
-- tipo - o caracter de fundo.
-- fg - cor do texto
-- bg - cor de fundo
--
procedure cabecalho(texto: in string;tipo: in string;
                    fg: in foreground_color;bg: in background_color) is
 c : integer:=0;
begin
for c in 1..80 loop
  Etexto(c,1,fg,bg,tipo);
end loop;
center(1,texto,fg,bg);
end cabecalho;

-----------------------------------------------

--
-- Nome : rodape
-- Descricao : procedimento que escreve o texto no rodape da tela.
-- Parametros :
-- texto - o texto a ser escrito
-- tipo - o caracter de fundo.
-- fg - cor do texto
-- bg - cor de fundo
--
procedure rodape(texto: in string;tipo: in string;fg: in foreground_color;
                 bg: in background_color) is
 c:integer:=0;
begin
for c in 1..79 loop
  Etexto(c,25,fg,bg,tipo);
end loop;
center(25,texto,fg,bg);
end rodape;

-----------------------------------------------

--
-- Nome : DatadoSistema
-- Descricao : procedimento que escreve a data do sistema na tela.
-- Parametros :
-- l - posicao da linha na tela
-- c - posicao da coluna na tela
-- fg - cor do texto
-- bg - cor de fundo
--
procedure DatadoSistema(l,c: in integer;fg: in foreground_color;
                        bg: in background_color) is
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
  etexto(c,l,fg,bg, repete("0",2-itam(d)) & to_string(dia)
  & "/" & repete("0",2-itam(m)) & to_string(mes) & "/" & to_string(ano)); 
end DatadoSistema;

-----------------------------------------------

--
-- Nome : HoradoSistema
-- Descricao : procedimento que escreve a Hora do sistema na tela.
-- Parametros :
-- l - posicao da linha na tela
-- c - posicao da coluna na tela
-- fg - cor do texto
-- bg - cor de fundo
--
procedure HoradoSistema(l,c: in integer;fg: in foreground_color;
                        bg: in background_color) is
  h, m, s, dd, dh : integer:=0;
  hora, minuto, segundo : ustring;
begin
  dd:=integer(seconds(clock));
  h:=integer(float'truncation(float(dd)/3600.0));
  dh:=dd-(3600*h);
  m:=integer(float'truncation(float(dh)/60.0));
  s:=dh-(60*m);

  itostr(s,segundo);
  itostr(m,minuto);
  itostr(h,hora);
  etexto(c,l,fg,bg, repete("0",2-itam(h)) & to_string(hora)
  & ":" & repete("0",2-itam(m)) & to_string(minuto) & ":" &
  repete("0",2-itam(s)) & to_string(segundo)); 
end HoradoSistema;

----------------------------------------------------------------------

--
-- Nome : AbrirArquivo
-- Descricao : procedimento que Abri o tipo de arquivo selecionado.
-- Parametros :
-- tipo - indica o numero de qual arquivo a ser aberto
--
procedure AbrirArquivo(Tipo: in integer) is
begin
  if Tipo=1 then
     -- LivrosIO.create(LivrosFile,LivrosIO.Inout_File,"Livros.dat");
     if LivrosIO.is_open(LivrosFile)=false then
        LivrosIO.open(LivrosFile,LivrosIO.Inout_File,"Livros.dat");
     end if; 
     nTamLivros:=integer(LivrosIO.size(LivrosFile));
  end if;
  if tipo=2 then
     -- UsuariosIO.create(UsuariosFile,UsuariosIO.Inout_File,"Usuarios.dat");
     if UsuariosIO.is_open(UsuariosFile)=false then
        UsuariosIO.open(UsuariosFile,UsuariosIO.Inout_File,"Usuarios.dat");
     end if; 
     nTamUsuarios:=integer(UsuariosIO.size(UsuariosFile));
  end if;
  if Tipo=3 then
     -- EmprestimosIO.create(EmprestimosFile,EmprestimosIO.Inout_File,"Empresti.dat");
     if EmprestimosIO.is_open(EmprestimosFile)=false then
        EmprestimosIO.open(EmprestimosFile,EmprestimosIO.Inout_File,"Empresti.dat");
     end if; 
     nTamEmprestimos:=integer(EmprestimosIO.size(EmprestimosFile));
  end if;
  if Tipo=4 then
     if is_open(SobreFile)=false then
        open(SobreFile,In_File,"Sobre.dat");
     end if;
  end if;

end AbrirArquivo;

-------------------------------------------------------

--
-- Nome : fAtribuir
-- Descricao : procedimento atribui os dados tanto na string de buffer
-- como tambem nas variaves do registro especifico
-- Parametros :
-- ntipo - indica o numero do registro
-- ltipo - indica se vai atribuir ou nao
--
procedure fAtribuir(nTipo: in integer;ltipo: in boolean) is
 sS : ustring;
begin
if nTipo=1 then
 if lTipo=true then
   if bLivros'length > 0 then    
     Livros.Ninsc:=atoi(copy(to_ustring(bLivros),1,5));   
     Livros.Titulo:=to_ustring(copy(to_ustring(bLivros),6,30));
     Livros.Autor:=to_ustring(copy(to_ustring(bLivros),36,30));
     Livros.Area:=to_ustring(copy(to_ustring(bLivros),66,30));
     Livros.PChave:=to_ustring(copy(to_ustring(bLivros),96,10));
     Livros.Edicao:=atoi(copy(to_ustring(bLivros),106,4));   
     Livros.AnoPubli:=atoi(copy(to_ustring(bLivros),110,4));   
     Livros.Editora:=to_ustring(copy(to_ustring(bLivros),114,30));
     Livros.Volume:=atoi(copy(to_ustring(bLivros),144,4));   
     Livros.Estado:=element(to_ustring(copy(to_ustring(bLivros),148,1)),1);
   end if;
 else
   itostr(Livros.Ninsc,sS);   
   bLivros(1..5):=to_string(sS) & repete(" ",5-itam(Livros.Ninsc));
   bLivros(6..105):=to_string(Livros.Titulo) & repete(" ",30-length(Livros.Titulo)) &
   to_string(Livros.Autor) & repete(" ",30-length(Livros.Autor)) &
   to_string(Livros.Area) & repete(" ",30-length(Livros.Area)) &
   to_string(Livros.PChave) & repete(" ",10-length(Livros.PChave));
   itostr(Livros.Edicao,sS);
   bLivros(106..109):=to_string(sS) & repete(" ",4-itam(Livros.Edicao));
   itostr(Livros.AnoPubli,sS);
   bLivros(110..113):=to_string(sS) & repete(" ",4-itam(Livros.AnoPubli));
   bLivros(114..143):=to_string(Livros.Editora) & repete(" ",30-length(Livros.Editora));
   itostr(Livros.Volume,sS);
   bLivros(144..147):=to_string(sS) & repete(" ",4-itam(Livros.Volume));
   bLivros(148..150):=Livros.Estado & character'val(13) & character'val(10);
 end if;
elsif nTipo=2 then
 if lTipo=true then
   if bUsuarios'length > 0 then
     Usuarios.Ninsc:=atoi(copy(to_ustring(bUsuarios),1,5));
     Usuarios.Nome:=to_ustring(copy(to_ustring(bUsuarios),6,30));
     Usuarios.Ident:=to_ustring(copy(to_ustring(bUsuarios),36,10));

     Usuarios.Endereco.Logra:=to_ustring(copy(to_ustring(bUsuarios),46,30));
     Usuarios.Endereco.Numero:=atoi(copy(to_ustring(bUsuarios),76,5));
     Usuarios.Endereco.Compl:=to_ustring(copy(to_ustring(bUsuarios),81,10));
     Usuarios.Endereco.Bairro:=to_ustring(copy(to_ustring(bUsuarios),91,20));
     Usuarios.Endereco.Cep:=to_ustring(copy(to_ustring(bUsuarios),111,8));

     Usuarios.Telefone:=to_ustring(copy(to_ustring(bUsuarios),119,11));
     Usuarios.Categoria:=element(to_ustring(copy(to_ustring(bUsuarios),130,1)),1);
     Usuarios.Situacao:=atoi(copy(to_ustring(bUsuarios),131,1));
   end if;
 else
   itostr(Usuarios.Ninsc,sS);   
   bUsuarios(1..5):=to_string(sS) & repete(" ",5-itam(Usuarios.Ninsc));  
   bUsuarios(6..75):=to_string(Usuarios.Nome) & repete(" ",30-length(Usuarios.Nome)) & 
   to_string(Usuarios.Ident) & repete(" ",10-length(Usuarios.Ident)) & 
   to_string(Usuarios.Endereco.Logra) & repete(" ",30-length(Usuarios.Endereco.Logra)); 
   itostr(Usuarios.Endereco.Numero,sS);   
   bUsuarios(76..80):=to_string(sS) &
   repete(" ",5-itam(Usuarios.Endereco.Numero));

   bUsuarios(81..129):=to_string(Usuarios.Endereco.Compl) &
   repete(" ",10-length(Usuarios.Endereco.Compl)) & 
   to_string(Usuarios.Endereco.Bairro) & repete(" ",20-length(Usuarios.Endereco.Bairro)) & 
   to_string(Usuarios.Endereco.Cep) & repete(" ",8-length(Usuarios.Endereco.Cep)) & 
   to_string(Usuarios.Telefone) & repete(" ",11-length(Usuarios.Telefone));

   if Usuarios.Categoria=' ' then 
      bUsuarios(130..130):=" ";
   else
      bUsuarios(1..130):=bUsuarios(1..129) & Usuarios.Categoria;
   end if;
   itostr(Usuarios.Situacao,sS);
   bUsuarios(131..133):=to_string(sS) & character'val(13) & character'val(10);
 end if;
elsif nTipo=3 then
 if lTipo=true then
   if bEmprestimos'length > 0 then
      Emprestimos.NinscUsuario:=atoi(copy(to_ustring(bEmprestimos),1,5));
      Emprestimos.NinscLivro:=atoi(copy(to_ustring(bEmprestimos),6,5));
      Emprestimos.DtEmprestimo:=to_ustring(copy(to_ustring(bEmprestimos),11,10));
      Emprestimos.DtDevolucao:=to_ustring(copy(to_ustring(bEmprestimos),21,10));
      if copy(to_ustring(bEmprestimos),31,1)="T" then
         Emprestimos.Removido:=true;
      elsif copy(to_ustring(bEmprestimos),31,1)="F" then
         Emprestimos.Removido:=false;
      end if;
   end if;
 else
   itostr(Emprestimos.NinscUsuario,sS);   
   bEmprestimos(1..5):=to_string(sS) &
   repete(" ",5-itam(Emprestimos.NinscUsuario));
   itostr(Emprestimos.NinscLivro,sS);   
   bEmprestimos(6..10):=to_string(sS) &
   repete(" ",5-itam(Emprestimos.NinscLivro));
   bEmprestimos(11..30):=to_string(Emprestimos.DtEmprestimo) &
   repete(" ",10-length(Emprestimos.DtEmprestimo)) &
   to_string(Emprestimos.DtDevolucao) &
   repete(" ",10-length(Emprestimos.DtDevolucao));
   if Emprestimos.Removido=true then
       bEmprestimos(31..33):="T" & character'val(13) & character'val(10);
   else
       bEmprestimos(31..33):="F" & character'val(13) & character'val(10);
   end if;
  end if;
end if;

end fAtribuir;

end Rotinas;
