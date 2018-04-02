{
  Nome : Sistema de Automacao de Biblioteca (Biblio)
  Autor : Henrique Figueiredo de Souza
  Linguagem : Pascal
  Compilador : Borland Turbo Pascal 
  Data de Realizacao : 4 de setembro de 1999
  Ultima Atualizacao : 15 de fevereiro de 2000
  Versao do Sistema : 1.0
  Nome do(s) Arquivo(s) e Como Compilar (nesta ordem) :
  1. Biblio.pas --> "tpc biblio.pas"

  Descricao :
  O Sistema e composto dos seguintes modulos:
  1.Modulo de Livros da Biblioteca
    Onde se realiza a manutencao dos livros da biblioteca
  2.Modulo de Usuarios da Bilioteca
    Onde se realiza a manutencao dos usuarios da biblioteca
  3.Modulo de Emprestimos e Devolucoes da Biblioteca
    Onde se efetua os emprestimos e devolucoes da biblioteca
  4.Modulo de Opcoes do sistema
    Onde e possivel ver sobre o sistema e sair dele
}
program Biblio;

uses Dos,crt;

{ Declaracao de tipos }

type

  ModoCursor = (nenhum,normal,solido);

  Keys = ( NullKey, F1, F2, F3, F4, F5, F6, F7, F8, F9, F10,
           CarriageReturn, Tab, ShiftTab, Bksp, UpArrow,
           DownArrow, RightArrow, LeftArrow, DeleteKey,
           InsertKey, HomeKey, Esc, EndKey, TextKey,
           NumberKey, SpaceKey, PgUp, PgDn, CtrlA, AltA,
           AltE, AltU, AltS, AltO);

  { Registro de Enderecos }

  Enderecos = Record
     Logra : String[30];     { Logradouro (30) }
     Numero : integer;       { Numero do Endereco (5) }
     Compl : String[10];     { Complemento (10) }
     Bairro : String[20];    { Bairro do Endereco (20) }
     Cep : String[8];        { Cep do Endereco (8) }
  end;

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

{ Declaracao de variaveis globais }

var

 { variaveis gerais }

 Key : Keys;
 Fk:boolean;
 Ch:char;
 S:string;
 I,C:integer;

 { variaveis de menu }

 vMenu : array[1..10] of String[30];
 vSubMenu : array[1..10,1..10] of String[35];

 { variaveis de lista }

 vLista : array[0..50] of String;

 { variaveis do modulo de livros }

 Livros : LivrosRec;
 LivrosFile : File of LivrosRec;
 nTamLivros : integer;
 vLivros : array[1..10] of string[30];

 { variaveis do modulo de Usuarios }

 Usuarios : UsuariosRec;
 UsuariosFile : File of UsuariosRec;
 nTamUsuarios : integer;
 vUsuarios : array[1..11] of String[30];

 { variaveis do modulo de Emprestimos }

 Emprestimos : EmprestimosRec;
 EmprestimosFile : File of EmprestimosRec;
 nTamEmprestimos : integer;
 vEmprestimos : array[1..5] of String[10];

 { variaveis do modulo de Opcoes }

 SobreFile : Text;

{ Declaracao de funcoes }

function Zeros(s:string;tam:integer):String; forward;
function Repete(St:string;Tam:integer):String; forward;
function SubMenu(numero,qtd,maxtam,topo,esquerda,ultpos,lfg,lbg,
               fg,bg:integer):integer; forward;
function Botao(topo,esquerda,fg,bg,sfg,sbg:integer;
                texto:string;foco:boolean):integer; forward;
function Lista(tipo,topo,esquerda,altura,largura,tlinhas,tcolunas,
               fg,bg:integer;
               var Listapos,Listacol:integer;foco:boolean): integer; forward;
function TiposLista(tipo,largura,pos,col:integer):string; forward;

{ Modulo de Livros }

function PesLivros(tipo:char;campo:string;nCod2:integer;sCod2:string;
                   nTamsCod:integer):integer; forward;
function VerificaLivros:boolean; forward;

{ Modulo de Usuarios }

function PesUsuarios(tipo:char;campo:string;nCod2:integer;sCod2:string;
                   nTamsCod:integer):integer; forward;
function PesBinaria(Chave:integer):integer; forward;
function VerificaUsuarios:boolean; forward;

{ Modulo de Emprestimos }

function PesEmprestimos(nCodUsuario,nCodLivro:integer):integer; forward;
function RetDataAtual:string; forward;
function ConverteData(dt:string):integer; forward;
function SomaDias(dt1:string;qtddias:integer):string; forward;
function SubtraiDatas(dt1:string;dt2:string):integer; forward;

{ Declaracao de Procedimentos }

procedure EscreveRapido(x,y:integer;
                        var S:String;fg,bg:Integer); forward;
Procedure SetaCursor(tipo:ModoCursor); forward;
procedure center(y:integer;s:string;fg,bg:integer); forward;
procedure beep(freq,time:integer); forward;
procedure InKey(var chavefuncional:boolean;
                var ch:char;cursorinicio,cursorfim:char); forward;
procedure Digita( var S: string;JanelaTam,MaxTam,X,Y : Integer;
                  fg,bg : Integer;FT : Char; Fundo : integer); forward;
procedure Etexto(c,l,fg,bg:integer;texto:string); forward;
procedure TeladeFundo(tipo:char;fg,bg:integer); forward;
procedure cabecalho(texto:string;tipo:char;fg,bg:integer); forward;
procedure rodape(texto:string;tipo:char;fg,bg:integer); forward;
procedure DatadoSistema(l,c,fg,bg:integer); forward;
procedure HoradoSistema(l,c,fg,bg:integer); forward;
procedure formulario(titulo:string;topo,esquerda,
                     altura,largura,fg,bg:integer;
                     sombra:char;sfg,sbg:integer); forward;
procedure Menu(qtd,topo,fg,bg,lfg,lbg,pos2,mfg,mbg,cont2:integer); forward;
procedure ControlaMenus(tipo:char;ultpos:integer;tf:boolean); forward;
procedure DesenhaBotao(topo,esquerda,fg,bg,sfg,sbg:integer;
                       texto:string;foco:boolean); forward;
procedure DesenhaLista(tipo,topo,esquerda,altura,largura,
                       fg,bg,pos,col:integer;foco:boolean); forward;
procedure AbrirArquivo(Tipo:integer); forward;
procedure formSplash; forward;

{ Modulo de Livros }

procedure formLivros(tipo:integer;titulo,rod:string); forward;
procedure Limpar_Livros; forward;
procedure Rotulos_formLivros(l:integer); forward;
procedure Controles_formLivros(tipo:string;tipo2,pos,col:integer;rod:string;
                               foco:boolean); forward;
procedure Atribuir_vLivros(limpar:boolean); forward;
procedure Digita_formLivros; forward;
procedure SalvarLivros(tipo:integer); forward;

{ Modulo de Usuarios }

procedure formUsuarios(tipo:integer;titulo,rod:string); forward;
procedure Limpar_Usuarios; forward;
procedure Rotulos_formUsuarios(l:integer); forward;
procedure Controles_formUsuarios(tipo:string;tipo2,pos,
          col:integer;rod:string;foco:boolean); forward;
procedure Atribuir_vUsuarios(limpar:boolean); forward;
procedure Digita_formUsuarios; forward;
procedure SalvarUsuarios(tipo:integer); forward;

{ Modulo de Emprestimos e Devolucoes }

procedure formEmprestimos(tipo:integer;titulo,rod:string); forward;
procedure Limpar_Emprestimos; forward;
procedure Rotulos_formEmprestimos(tipo,l:integer); forward;
procedure Controles_formEmprestimos(tipo:string;tipo2,pos,
          col:integer;rod:string;foco:boolean); forward;
procedure Atribuir_vEmprestimos(limpar:boolean); forward;
procedure SalvarEmprestimos(tipo:integer); forward;

{ Modulo de Opcoes }

procedure formSair; forward;
procedure Controles_formSair(tipo:string;foco:boolean); forward;
procedure formSobre; forward;
procedure LerArquivoSobre; forward;
procedure Controles_formSobre(tipo:string;pos,col:integer;
                              foco:boolean); forward;

{-----------------------------------------------------------------}

{ Rotinas Fundamentais }

{
 Nome : EscreveRapido
 Descricao : Procedimento que permite ter um controle do posicionamento
 do cursor, sem piscadas ou erros de repeticao de visualizacao.
 Parametros :
 x - posicao de coluna na tela
 y - posicao de linha na tela
 S - o resultado do que foi digitado
 fg - cor do texto
 bg - cor de fundo
}
procedure EscreveRapido(x,y:integer;var S:String;fg,bg:Integer);
begin
 textcolor(fg);
 textbackground(bg);
 gotoxy(x-1,y+1);
 write(S);

{
inline ($50/         (* PUSH AX       *)
        $53/         (* PUSH BX       *)
        $51/         (* PUSH CX       *)
        $52/         (* PUSH DX       *)
        $1E/         (* PUSH DS       *)
        $06/         (* PUSH ES       *)
        $57/         (* PUSH DI       *)
        $56/         (* PUSH SI       *)
        $8B/$5E/<x/  (* MOV  BX,x     *)
        $8B/$46/<y/  (* MOV  AX,y     *)
        $4B/         (* DEC  BX       *)
        $4B/         (* DEC  AX       *)
        $B9/$50/$00/ (* MOV  CX,0050  *)
        $F7/$E1/     (* MUL  CX       *)
        $03/$C3/     (* ADD  AX,BX    *)
        $B9/$02/$00/ (* MOV  CX,0002  *)
        $F7/$E1/     (* MUL  CX       *)
        $8B/$F8/     (* MUL  DI,AX    *)
        $8B/$5E/<bg/ (* MOV  BX,bg    *)
        $8B/$46/<fg/ (* MOV  AX,fg    *)
        $B9/$04/$00/ (* MOV  CX,0004  *)
        $D3/$E3/     (* SHL  BX,CL    *)
        $03/$D8/     (* ADD  BX,AX    *)
        $86/$DF/     (* XCHG BL,BH    *)
        $BA/$DA/$03/ (* MOV  DX,03DA  *)
        $B8/$00/$B8/ (* MOV  AX,B800  *)
        $8E/$C0/     (* MOV  ES,AX    *)
        $C5/$76/<s/  (* LDS  SI,s     *)
        $8A/$0C/     (* MOV  CL,[SI]  *)
        $80/$F9/$00/ (* CMP  CL,00    *)
        $74/$15/     (* JZ   2E06     *)
        $FC/         (* CLD           *)
        $46/         (* INC  SI       *)
        $8A/$1C/     (* MOV  BL,[SI]  *)
        $EC/         (* IN   AL,DX    *)
        $A8/$01/     (* TEST AL,01    *)
        $75/$FB/     (* JNZ  2DF5     *)
        $FA/         (* CLI           *)
        $EC/         (* IN   AL,DX    *)
        $A8/$01/     (* TEST AL,01    *)
        $74/$FB/     (* JZ   2DBF     *)
        $8B/$C3/     (* MOV  AX,BX    *)
        $AB/         (* STOSW         *)
        $FB/         (* STI           *)
        $E2/$EC/     (* LOOP 2DF2     *)
        $5E/         (* POP  SI       *)
        $5F/         (* POP  DI       *)
        $07/         (* POP  ES       *)
        $1F/         (* POP  DS       *)
        $5A/         (* POP  DX       *)
        $59/         (* POP  CX       *)
        $5B/         (* POP  BX       *)
        $58/         (* POP  AX       *)
        $E9/$00/$00/ (* JMP  2E11     *)
        $8B/$E5/     (* MOV  SP,BP    *)
        $5D/         (* POP  BP       *)
        $C2/$0E/$00);(* RET  000E     *)
        }
end;

{--------------------------------------------------------------------}

{
 Nome : SetaCursor
 Descricao : Procedimento que muda o modo do cursor na tela.
 Parametros :
 tipo - indica o tipo de cursor
}
Procedure SetaCursor(tipo:ModoCursor);
var
 Regs:Registers;
begin
if tipo=nenhum then 
 begin
  with regs do
   begin
    AH:=$01;
    CH:=$20;
    CL:=$20;
   end;
 end
else if tipo=normal then 
 begin
  with regs do
   begin
    AH:=$01;
    CH:=6;
    CL:=7;
   end;
 end
else if tipo=solido then 
 begin
  with regs do
   begin
    AH:=$01;
    CH:=0;
    CL:=7;
   end;
 end;
intr($10,regs);
end;

{------------------------------------------------------------------}

{
 Nome : Center
 Descricao : Procedimento que centraliza um texto na tela.
 Parametros :
 y - posicao de linha na tela
 s - texto a ser centralizado
 fg - cor do texto
 bg - cod de fundo
}
procedure center(y:integer;s:string;fg,bg:integer);
var
 x:integer;
begin
 x:=40-(length(s) div 2);
 etexto(x,y,fg,bg,s);
end;

{------------------------------------------}

{
 Nome : Beep
 Descricao : Procedimento que gera um beep.
 Parametros :
 freq - frequencia do beep.
 time - duracao do beep.
}
procedure beep(freq,time:integer);
begin
 sound(freq);
 delay(time);
 nosound;
end;

{-------------------------------------------}

{
 Nome : Inkey
 Descricao : Procedimento que identifica uma tecla do teclado.
 Parametros :
 chavefuncional - variavel que indica se e uma tecla funcional
 ch - indica o caracter pressionado
 cursorinicio - indica o estado do cursor inicial
 cursorfim - indica o estado do cursor final
}
procedure InKey(var chavefuncional:boolean;
                var ch:char;cursorinicio,cursorfim:char);
begin

 case cursorinicio of
  'B':setacursor(solido);
  'S':setacursor(normal);
  'O':setacursor(nenhum);
 end;

chavefuncional:=false;
ch:=readkey;
if (ch=#0) then
 begin
  chavefuncional:=true;
  ch:=readkey;
 end;

if chavefuncional then
   case ord(ch) of
    15: key := ShiftTab;
    18: key := AltE;
    22: key := AltU;
    24: key := AltO;
    30: key := AltA;
    31: key := AltS;
    72: key := UpArrow;
    80: key := DownArrow;
    75: key := LeftArrow;
    77: key := RightArrow;
    73: key := PgUp;
    81: key := PgDn;
    71: key := HomeKey;
    79: key := EndKey;
    83: key := DeleteKey;
    82: key := InsertKey;
    59: key := F1;
    60: key := F2;
    61: key := F3;
    62: key := F4;
    63: key := F5;
    64: key := F6;
    65: key := F7;
    66: key := F8;
    67: key := F9;
    68: key := F10;
   end
else
   Case Ord(ch) of
     1: Key := CtrlA;
     8: key := Bksp;
     9: key := Tab;
    13: key := CarriageReturn;
    27: key := Esc;
    32: key := SpaceKey;
    33..44, 47, 58..254: key := TextKey;
    45..46, 48..57: key := NumberKey;
   end;

   case cursorfim of
    'B':setacursor(solido);
    'S':setacursor(normal);
    'O':setacursor(nenhum);
   end;

end;

{-----------------------------------------------------------}

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
procedure Digita( var S: string;JanelaTam,MaxTam,X,Y : Integer;
                  fg,bg : Integer;FT : Char;Fundo : integer);
var
   xx, i, j, p : integer;
   ch : char;
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
i:=length(s);
while s[i] = char(Fundo) do
  i:=i-1;
s[0]:=char(i);
setacursor(normal);
end;

{-------------------------------------------}

begin
j:=length(s)+1;
for i:=j to MaxTam do
   s[i]:=char(Fundo);
s[0]:=char(MaxTam);

tempstr:=copy(s,1,JanelaTam);
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
   else if (ch='-') and ((p>1) or (s[1]='-')) then
    begin
     beep(100,250);
     key:=nullkey;
    end
   else if (ch='.') then
    begin
     if not((pos('.',s)=0) or (pos('.',s)=p)) then
       begin
        beep(100,250);
        key:=nullkey;
       end
     else if (pos('.',s)=p) then
       delete(s,p,1);
     end;
    end;

 case key of

   NumberKey, TextKey, SpaceKey :
     begin
      if (length(s) = MaxTam) then
        begin
         if p = MaxTam then
          begin
           delete(s,MaxTam,1);
           s:=s+ch;
           if p = JanelaTam+compensacao then
             compensacao:=compensacao + 1;
           tempstr:=copy(s,compensacao,JanelaTam);
           EscreveRapido(x,y,tempstr,fg,bg);
          end
         else
          begin
           if InsertOn then
             begin
              delete(s,MaxTam,1);
              insert(ch,s,p);
              if p = JanelaTam+compensacao then
                 compensacao:=compensacao+1;
              if p < MaxTam then
                 p:=p+1;
              tempstr:=copy(s,compensacao,JanelaTam);
              EscreveRapido(x,y,tempstr,fg,bg);
             end
           else 
             begin
              delete(s,p,1);
              insert(ch,s,p);
              if p = JanelaTam + compensacao then
                 compensacao:=compensacao+1;
              if p < MaxTam then
                 p:=p+1;
              tempstr:=copy(s,compensacao,JanelaTam);
              EscreveRapido(x,y,tempstr,fg,bg);
             end;
           end;
          end
        else
          begin
            if InsertOn then
              begin
               insert(ch,s,p);
              end
            else
              begin
               delete(s,p,1);
               insert(ch,s,p);
              end;
            if p = JanelaTam+compensacao then
               compensacao:=compensacao+1;
            if p < MaxTam then
               p:=p+1;
            tempstr:=copy(s,compensacao,JanelaTam);
            EscreveRapido(x,y,tempstr,fg,bg);
          end;
        end;

   Bksp:
     begin
      if p>1 then
        begin
         p:=p-1;
         delete(s,p,1);
         s:=s+char(Fundo);
         if compensacao > 1 then
           compensacao:=compensacao - 1;
         tempstr:=copy(s,compensacao,JanelaTam);
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
             tempstr:=copy(s,compensacao,JanelaTam);
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
      if (s[p] <> char(Fundo)) and (p < MaxTam) then
        begin
         p:=p+1;
         if p = (JanelaTam+compensacao) then
           begin
             compensacao:=compensacao + 1;
             tempstr:=copy(s,compensacao,JanelaTam);
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
      delete(s,p,1);
      s:=s+char(Fundo);
      if ((Length(s)+1)-compensacao) >= JanelaTam then
        begin
          tempstr:=copy(s,compensacao,JanelaTam);
          EscreveRapido(x,y,tempstr,fg,bg);
        end
      else
        begin
          tempstr:=copy(s,compensacao,JanelaTam);
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
 Nome : Repete
 Descricao : funcao que retorna um texto repetido n vezes.
 Parametros :
 St - indica o texto a ser repetido
 Tam - quantas vezes o texto se repetira
}
function Repete(St:string;Tam:integer):String;
var
 cont:integer;
 Esp:String;
begin
 cont:=1;
 Esp:='';
 while (cont <= Tam) do
  begin
    Esp:=Esp+St;
    cont:=cont+1;
  end;
  Repete:=Esp;
end;

{-------------------------------------------}

{
 Nome : Etexto
 Descricao : procedimento que escreve o texto na tela com determinada cor.
 Parametros :
 c - posicao de coluna do texto
 l - posicao de linha do texto
 fg - cor do texto
 bg - cor de fundo
 texto - o texto a ser escrito
}
procedure Etexto(c,l,fg,bg:integer;texto:string);
begin
 textcolor(fg);
 textbackground(bg);
 gotoxy(c,l);
 write(texto);
end;

{-------------------------------------------}

{
 Nome : Teladefundo
 Descricao : procedimento que desenha os caracteres do fundo da tela.
 Parametros :
 tipo - o caracter a ser escrito no fundo
 fg - cor do texto
 bg - cor de fundo
}
procedure TeladeFundo(tipo:char;fg,bg:integer);
var
 l,c:integer;
begin
for l:=3 to 24 do
  for c:=1 to 80 do
    Etexto(c,l,fg,bg,tipo);
end;

{-------------------------------------------}

{
 Nome : cabecalho
 Descricao : procedimento que escreve o texto de cabecalho do sistema.
 Parametros :
 texto - o texto a ser escrito
 tipo - o caracter de fundo.
 fg - cor do texto
 bg - cor de fundo
}
procedure cabecalho(texto:string;tipo:char;fg,bg:integer);
var
 c:integer;
begin
for c:=1 to 80 do
  Etexto(c,1,fg,bg,tipo);
center(1,texto,fg,bg);
end;

{-------------------------------------------}

{
 Nome : rodape
 Descricao : procedimento que escreve o texto no rodape da tela.
 Parametros :
 texto - o texto a ser escrito
 tipo - o caracter de fundo.
 fg - cor do texto
 bg - cor de fundo
}
procedure rodape(texto:string;tipo:char;fg,bg:integer);
var
 c:integer;
begin
for c:=1 to 79 do
  Etexto(c,25,fg,bg,tipo);
center(25,texto,fg,bg);
end;

{-------------------------------------------}

{
 Nome : DatadoSistema
 Descricao : procedimento que escreve a data do sistema na tela.
 Parametros :
 l - posicao da linha na tela
 c - posicao da coluna na tela
 fg - cor do texto
 bg - cor de fundo
}
procedure DatadoSistema(l,c,fg,bg:integer);
const
  dias : array [0..6] of String[9] = ('Domingo','Segunda','Terca',
     'Quarta','Quinta','Sexta','Sabado');
var
  y, m, d, dow : Word;
  dia,mes,ano:string;
begin
  GetDate(y,m,d,dow);
  str(d,dia);
  str(m,mes);
  str(y,ano);
  Etexto(c,l,fg,bg, dias[dow] + ', '+ zeros(dia,2) + '/'+
  zeros(mes,2) + '/'+ ano);
end;

{-------------------------------------------}

{
 Nome : HoradoSistema
 Descricao : procedimento que escreve a Hora do sistema na tela.
 Parametros :
 l - posicao da linha na tela
 c - posicao da coluna na tela
 fg - cor do texto
 bg - cor de fundo
}
procedure HoradoSistema(l,c,fg,bg:integer);
var
  h, m, s, ms : Word;
  hora,minuto,segundo : string;
begin
  GetTime(h,m,s,ms);
  str(h,hora);
  str(m,minuto);
  str(s,segundo);
  Etexto(c,l,fg,bg,Zeros(hora,2)+':'+Zeros(minuto,2)+':'+Zeros(segundo,2));
end;

{-------------------------------------------}

{
 Nome : Zeros
 Descricao : funcao que escreve zeros na frente de uma string.
 Parametros :
 s - a string a receber zeros a frente
 tam - o tamanho da string
}
function Zeros(s:string;tam:integer) : String;
var
 cont : integer;
 aux : string;
begin
  aux:='';
  if tam<>length(s) then
    begin
      for cont:=1 to tam-length(s) do
        aux:=aux + '0';
    end;
  zeros:=aux+s;
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
procedure formulario(titulo:string;topo,esquerda,
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
function SubMenu(numero,qtd,maxtam,topo,esquerda,ultpos,lfg,lbg,
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
procedure Menu(qtd,topo,fg,bg,lfg,lbg,pos2,mfg,mbg,cont2:integer);
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
 Nome : ControlaMenus
 Descricao : procedimento que faz todo o controle de manuseio dos submenus.
 Parametros :
 tipo - indica qual o submenu selecionado do menu
 ultpos - indica a ultima posicao da opcao de submenu selecionada
 tf - indica se vai redesenhar a tela de fundo
}
procedure ControlaMenus(tipo:char;ultpos:integer;tf:boolean);
begin

if tf=true then
  teladefundo('±',white,lightblue);

if tipo='A' then
  begin
    Menu(4,2,black,lightgray,red,lightgray,1,yellow,lightgray,1);
    rodape('Controle do Acervo da Biblioteca.',' ',white,blue);
    formulario('',3,3,4,20,black,lightgray,'±',lightgray,black);
    case SubMenu(1,3,16,4,5,ultpos,yellow,lightgray,black,lightgray) of
      1:ControlaMenus('O',1,true);
      2:ControlaMenus('U',1,true);
      3:formLivros(1,'Cadastrar Livros',
        'Cadastro dos Livros do Acervo da Biblioteca.');
      4:formLivros(2,'Alterar Livros',
        'Altera os Livros do Acervo da Biblioteca.');
      5:ControlaMenus('5',1,false);
    end;
  end
else if tipo='U' then
  begin
    Menu(4,2,black,lightgray,red,lightgray,10,yellow,lightgray,2);
    rodape('Controle de Usuarios da Biblioteca.',' ',white,blue);
    formulario('',3,12,4,22,black,lightgray,'±',lightgray,black);
    case SubMenu(2,3,18,4,14,ultpos,yellow,lightgray,black,lightgray) of
      1:ControlaMenus('A',1,true);
      2:ControlaMenus('E',1,true);
      3:formUsuarios(1,'Cadastrar Usuarios',
        'Cadastro dos Usuarios da Biblioteca.');
      4:formUsuarios(2,'Alterar Usuarios',
        'Altera os Usuarios da Biblioteca.');
      5:ControlaMenus('6',1,false);
    end;
  end
else if tipo='E' then
  begin
    Menu(4,2,black,lightgray,red,lightgray,21,yellow,lightgray,3);
    rodape('Controle de Emprestimos e Devolucoes da Biblioteca.',' ',
    white,blue);
    formulario('',3,23,4,37,black,lightgray,'±',lightgray,black);
    case SubMenu(3,3,16,4,25,ultpos,yellow,lightgray,black,lightgray) of
      1:ControlaMenus('U',1,true);
      2:ControlaMenus('O',1,true);
      3:formEmprestimos(1,'Emprestar Livros',
        'Efetua os Emprestimos de Livros da Biblioteca.');
      4:formEmprestimos(2,'Devolver Livros',
        'Efetua a Devolucao dos Livros da Biblioteca.');
      5:formEmprestimos(3,'Consultar Emprestimos e Devolucoes',
        'Consulta os Emprestimos e Devolucoes dos Livros da Biblioteca.');
    end;
  end
else if tipo='O' then
  begin
    Menu(4,2,black,lightgray,red,lightgray,48,yellow,lightgray,4);
    rodape('Opcoes do Sistema de Biblioteca.',' ',white,blue);
    formulario('',3,50,3,18,black,lightgray,'±',lightgray,black);
    case SubMenu(4,2,16,4,52,ultpos,yellow,lightgray,black,lightgray) of
      1:ControlaMenus('E',1,true);
      2:ControlaMenus('A',1,true);
      3:formSobre;
      4:formSair;
    end;
  end
else if tipo='5' then
  begin
    formulario('',6,23,6,20,black,lightgray,'±',lightgray,black);
    case SubMenu(5,5,18,7,25,ultpos,yellow,lightgray,black,lightgray) of
      1:ControlaMenus('A',3,true);
      2:ControlaMenus('U',1,true);
      4:formLivros(3,'Consultar Livros por Titulo',
        'Consulta os Livros por Titulo do Acervo da Biblioteca.');
      5:formLivros(4,'Consultar Livros por Autor',
        'Consulta os Livros por Autor do Acervo da Biblioteca.');
      6:formLivros(5,'Consultar Livros por Area',
        'Consulta os Livros por Area do Acervo da Biblioteca.');
      7:formLivros(6,'Consultar Livros por Palavra-chave',
        'Consulta os Livros por Palavra-chave do Acervo da Biblioteca.');
      3:formLivros(7,'Consultar Todos os Livros',
        'Consulta Todos os Livros do Acervo da Biblioteca.');
    end;
  end
else if tipo='6' then
  begin
    formulario('',6,34,5,26,black,lightgray,'±',lightgray,black);
    case SubMenu(6,4,24,7,36,ultpos,yellow,lightgray,black,lightgray) of
      1:ControlaMenus('U',3,true);
      2:ControlaMenus('E',1,true);
      4:formUsuarios(3,'Consultar Usuarios por Numero de Inscricao',
        'Consulta os Usuarios por Numero de Inscricao.');
      5:formUsuarios(4,'Consultar Usuarios por Nome',
        'Consulta os Usuarios por Nome.');
      6:formUsuarios(5,'Consultar Usuarios por Identidade',
        'Consulta os Usuarios por Numero de Identidade.');
      3:formUsuarios(6,'Consultar Todos os Usuarios',
        'Consulta Todos os Usuarios da Biblioteca.');

    end;
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
procedure DesenhaBotao(topo,esquerda,fg,bg,sfg,sbg:integer;
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
function Botao(topo,esquerda,fg,bg,sfg,sbg:integer;
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
procedure DesenhaLista(tipo,topo,esquerda,altura,largura,
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
function TiposLista(tipo,largura,pos,col:integer):string;
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
function Lista(tipo,topo,esquerda,altura,largura,tlinhas,tcolunas,
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
procedure AbrirArquivo(Tipo:integer);
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

{******************Modulo de Usuarios**********************}

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
function PesUsuarios(tipo:char;campo:string;nCod2:integer;sCod2:string;
                     nTamsCod:integer):integer;
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
function PesBinaria(Chave:integer):integer;
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
procedure formUsuarios(tipo:integer;titulo,rod:string);
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
procedure Limpar_Usuarios;
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
procedure Rotulos_formUsuarios(l:integer);
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
procedure Controles_formUsuarios(tipo:string;tipo2,pos,col:integer;
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
procedure Atribuir_vUsuarios(limpar:boolean);
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
procedure Digita_formUsuarios;
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
function VerificaUsuarios:boolean;
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
procedure SalvarUsuarios(tipo:integer);
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

{**************Modulo de Emprestimos e Devolucoes******************}

{
 Nome : RetDataAtual
 Descricao : funcao que retorna a data atual do sistema
}
function RetDataAtual:string;
var
  y, m, d, dow : Word;
  dia,mes,ano:string;
begin
  GetDate(y,m,d,dow);
  str(d,dia);
  str(m,mes);
  str(y,ano);
  RetDataAtual:=zeros(dia,2)+'/'+zeros(mes,2)+'/'+zeros(ano,4);
end;

{--------------------------------------------------------}

{
 Nome : ConverteData
 Descricao : funcao que converte a data em string para numero.
 Parametros :
 dt - data a ser convertida
}
function ConverteData(dt:string):integer;
var
  sAux:string;
  nAux:integer;
begin
 sAux:=copy(dt,7,4)+copy(dt,4,2)+copy(dt,1,2);
 Val(sAux,nAux,C);
 ConverteData:=nAux;
end;

{--------------------------------------------------------}

{
 Nome : SubtraiDatas
 Descricao : funcao que subtrai duas datas e retorna o numero de dias
 Parametros :
 dt1 - data inicial
 dt2 - data final
}
function SubtraiDatas(dt1:string;dt2:string):integer;
var
 dia,mes,ano,dia1,mes1,ano1,dia2,mes2,ano2:integer;
 i,c,dias:integer;
 udiames:array[1..12] of integer;
begin
 dias:=0;
 udiames[1]:=31;
 udiames[2]:=28;
 udiames[3]:=31;
 udiames[4]:=30;
 udiames[5]:=31;
 udiames[6]:=30;
 udiames[7]:=31;
 udiames[8]:=31;
 udiames[9]:=30;
 udiames[10]:=31;
 udiames[11]:=30;
 udiames[12]:=31;

 val(copy(dt1,1,2),i,c);
 dia1:=i;
 val(copy(dt1,4,2),i,c);
 mes1:=i;
 val(copy(dt1,7,4),i,c);
 ano1:=i;

 val(copy(dt2,1,2),i,c);
 dia2:=i;
 val(copy(dt2,4,2),i,c);
 mes2:=i;
 val(copy(dt2,7,4),i,c);
 ano2:=i;

 for ano:=ano1 to ano2 do
  begin
    for mes:=mes1 to 12 do
     begin
       { ano bissexto }
       if (ano mod 4)=0 then
         udiames[2]:=29;
       { data final }
       if (ano=ano2) and (mes=mes2) then
         udiames[mes2]:=dia2;
       for dia:=dia1 to udiames[mes] do
          dias:=dias+1;
       if (ano=ano2) and (mes=mes2) then
         begin
           SubtraiDatas:=dias-1;
           exit;
         end;
       dia1:=1;
     end;
    mes1:=1;
  end;
  
end;

{--------------------------------------------------------}

{
 Nome : SomaDias
 Descricao : funcao que soma um determinado numero de dias a uma data.
 Parametros :
 dt1 - a data a ser somada
 qtddias - numero de dias a serem somados
}
function SomaDias(dt1:string;qtddias:integer):string;
var
 dia,mes,ano,dia1,mes1,ano1,ano2:integer;
 i,c,dias:integer;
 sAux,sAux2:string;
 udiames:array[1..12] of integer;
begin
 dias:=0;
 udiames[1]:=31;
 udiames[2]:=28;
 udiames[3]:=31;
 udiames[4]:=30;
 udiames[5]:=31;
 udiames[6]:=30;
 udiames[7]:=31;
 udiames[8]:=31;
 udiames[9]:=30;
 udiames[10]:=31;
 udiames[11]:=30;
 udiames[12]:=31;

 val(copy(dt1,1,2),i,c);
 dia1:=i;
 val(copy(dt1,4,2),i,c);
 mes1:=i;
 val(copy(dt1,7,4),i,c);
 ano1:=i;

 ano2:=ano1 + (qtddias div 365);

 for ano:=ano1 to ano2 do
  begin
    for mes:=mes1 to 12 do
     begin
       { ano bissexto }
       if (ano mod 4)=0 then
         udiames[2]:=29;
       for dia:=dia1 to udiames[mes] do
          begin
            dias:=dias+1;
            if dias=qtddias+1 then
              begin
                str(dia,sAux);
                sAux2:=zeros(sAux,2)+'/';
                str(mes,sAux);
                sAux2:=sAux2+zeros(sAux,2)+'/';
                str(ano,sAux);
                sAux2:=sAux2+zeros(sAux,4);
                SomaDias:=sAux2;
                exit;
            end;
          end;
       dia1:=1;
     end;
    mes1:=1;
  end;

end;

{--------------------------------------------------------}

{
 Nome : PesEmprestimos
 Descricao : funcao que pesquisa as informacoes contidas no arquivo de
 Emprestimos.
 Parametros :
 nCodUsuario - codigo do campo de numero de inscricao do usuario
 sCodLivro - codigo do campo de numero de inscricao do livro
}
function PesEmprestimos(nCodUsuario,nCodLivro:integer):integer;
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
procedure formEmprestimos(tipo:integer;titulo,rod:string);
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
procedure Limpar_Emprestimos;
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
procedure Rotulos_formEmprestimos(tipo,l:integer);
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
procedure Controles_formEmprestimos(tipo:string;tipo2,pos,col:integer;
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
    if PesUsuarios('N','Ninsc',I,'',0)<>-1 then
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
        if PesLivros('N','Ninsc',I,'',0)<>-1 then
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
procedure Atribuir_vEmprestimos(limpar:boolean);
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
procedure SalvarEmprestimos(tipo:integer);
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

{*******************Modulo de Opcoes**********************}

{
 Nome : formSair
 Descricao : procedimento que desenha o formulario de sair.
}
procedure formSair;
begin
  teladefundo('±',white,lightblue);
  rodape('Alterta !, Aviso de Saida do Sistema.',' ',yellow,red);
  formulario(chr(180)+'Sair do Sistema'+chr(195),10,25,6,27,white,blue,'±',lightgray,black);
  Etexto(27,12,white,blue,'Deseja Sair do Sistema ?');
  DesenhaBotao(14,40,black,white,black,blue,' Nao ',false);
  Controles_formSair(' Sim ',true);
end;

{-------------------------------------------}

{
 Nome : Controles_formSair
 Descricao : procedimento que realiza todo o controle de manuseio do
 formulario de Saida.
 Parametros :
 tipo - indica qual acao a executar
 foco - indica quais objeto terao foco
}
procedure Controles_formSair(tipo:string;foco:boolean);
begin

if tipo=' Sim ' then
  begin
    case Botao(14,30,black,white,black,blue,' Sim ',foco) of
      1:begin
          DesenhaBotao(14,30,black,white,black,blue,' Sim ',false);
          Controles_formSair(' Nao ',true);
        end;
      2:begin
          textcolor(lightgray);
          textbackground(black);
          clrscr;
          formSplash;
          setacursor(normal);
          textcolor(lightgray);
          textbackground(black);
          clrscr;
          halt;
        end;
    end;
  end
else if tipo=' Nao ' then
  begin
    case Botao(14,40,black,white,black,blue,' Nao ',foco) of
      1:begin
          DesenhaBotao(14,40,black,white,black,blue,' Nao ',false);
          Controles_formSair(' Sim ',true);
        end;
      2:rodape('',' ',white,blue);
    end;
  end;

end;

{-------------------------------------------}

{
 Nome : formSobre
 Descricao : procedimento que desenha o formulario de Sobre.
}
procedure formSobre;
begin
  teladefundo('±',white,lightblue);
  rodape('Informacoes sobre o sistema.',' ',white,blue);
  formulario(chr(180)+'Sobre o Sistema'+chr(195),4,2,18,76,white,blue,'±',lightgray,black);
  LerArquivoSobre;
  desenhaBotao(20,63,black,white,black,blue,' Fechar ',false);
  Controles_formSobre('Lista',0,0,true);
end;

{-----------------------------------------------------}

{
 Nome : LerArquivoSobre
 Descricao : procedimento que le o arquivo de sobre a atribui ao vetor
 de lista.
}
procedure LerArquivoSobre;
var
 cont:integer;
 linha:string;
begin
 AbrirArquivo(4);
 cont:=0;
 while not eof(SobreFile) do
  begin
   readln(SobreFile,linha);
   vLista[cont]:=linha;
   cont:=cont+1;
  end;
end;

{-----------------------------------------------------}

{
 Nome : Controles_formSobre
 Descricao : procedimento que realiza todo o controle de manuseio do
 formulario de Sobre.
 Parametros :
 tipo - indica qual acao a executar
 pos - indica a ultima posicao da linha da lista de sobre
 col - indica a ultima posicao da coluna da lista de sobre
 foco - indica quais objeto terao foco
}
procedure Controles_formSobre(tipo:string;pos,col:integer;foco:boolean);
begin

if tipo='Fechar' then
  begin
    case Botao(20,63,black,white,black,blue,' Fechar ',foco) of
      1:begin
          DesenhaBotao(20,63,black,white,black,blue,' Fechar ',false);
          Controles_formSobre('Lista',pos,col,true);
        end;
      2:begin
          close(SobreFile);
          rodape('',' ',white,blue);
          teladefundo('±',white,lightblue);
        end;
    end;
  end
else if tipo='Lista' then
  begin
    if lista(4,6,5,13,70,43,72,white,blue,pos,col,foco)=1 then
      begin
        desenhalista(4,6,5,13,70,white,blue,pos,col,false);
        Controles_formSobre('Fechar',pos,col,true);
      end;
  end;

end;

{-----------------------------------------------------}

{
 Nome : formSplash
 Descricao : procedimento que desenha a tela inicial do sistema.
}
procedure formSplash;
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

{ Bloco principal do programa }

begin
  clrscr;
  teladefundo('±',white,lightblue);
  cabecalho('Sistema de Automacao de Biblioteca',' ',white,blue);
  rodape('',' ',white,blue);
  DatadoSistema(1,1,white,blue);
  HoradoSistema(1,73,white,blue);

  vMenu[1]:='Acervo';
  vMenu[2]:='Usuarios';
  vMenu[3]:='Emprestimos e Devolucoes';
  vMenu[4]:='Opcoes';

  vSubMenu[1,1]:='Cadastrar livros';
  vSubMenu[1,2]:='Alterar livros';
  vSubMenu[1,3]:='Consultar livros >';

  vSubMenu[2,1]:='Cadastrar usuarios';
  vSubMenu[2,2]:='Alterar usuarios';
  vSubMenu[2,3]:='Consultar usuarios >';

  vSubMenu[3,1]:='Emprestar livros';
  vSubMenu[3,2]:='Devolver livros';
  vSubMenu[3,3]:='Consultar Emprestimos e Devolucoes';

  vSubMenu[4,1]:='Sobre o sistema';
  vSubMenu[4,2]:='Sair do sistema';

  vSubMenu[5,1]:='Todos os livros';
  vSubMenu[5,2]:='Por Titulo';
  vSubMenu[5,3]:='Por Autor';
  vSubMenu[5,4]:='Por Area';
  vSubMenu[5,5]:='Por Palavra-chave';

  vSubMenu[6,1]:='Todos os Usuarios';
  vSubMenu[6,2]:='Por Numero de Inscricao';
  vSubMenu[6,3]:='Por Nome';
  vSubMenu[6,4]:='Por Identidade';

  Menu(4,2,black,lightgray,red,lightgray,0,white,black,0);
  formSplash;

  Repeat
   teladefundo('±',white,lightblue);
   Menu(4,2,black,lightgray,red,lightgray,0,white,black,0);

   inkey(Fk,Ch,'O','O');

   if key=AltA then
      ControlaMenus('A',1,true);
   if key=AltU then
      ControlaMenus('U',1,true);
   if key=AltE then
      ControlaMenus('E',1,true);
   if key=AltO then
      ControlaMenus('O',1,true);

  until Key = Esc;

end.
