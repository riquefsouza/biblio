{ Modulo de Rotinas gerais }
unit rotinas1;

interface

uses crt, dos;

{ Declaracao de tipos }

type

  tModoCursor = (nenhum,normal,solido);

  tTeclas = (TNULL, TF1, TF2, TF3, TF4, TF5, TF6, TF7, TF8, TF9, TF10,
             TRET, TTAB, TSHTAB, TBS, TUP, TDOWN, TRIGHT, TLEFT, TDEL,
             TINS, THOME, TESC, TEND, TTEXTO, TNUMERO, TSPACE, TPGUP,
             TPGDN, TCTRLA, TALTA, TALTE, TALTU, TALTS, TALTO);
var

 { variaveis gerais }

 nTecla : tTeclas;
 cTecla : char;

 { variaveis de configuracao }

 vsIni : array[1..30] of String;
 nMaxlrg, nMaxalt : integer;

{ Declaracao de funcoes de rotinas gerais }

function fnTeclar:tTeclas;
function fsZeros(stxt:string;ntam:integer):string;
function fsRepete(stxt:string;ntam:integer):string;
function fsDataAtual:string;
function fnConverteData(sdat:string):integer;
function fsSomaDias(sdat:string;nqtd:integer):string;
function fnSubDatas(sdat1:string;sdat2:string):integer;
function fnDiaSemana(ndia,nmes,nano:integer):integer;
function fnCenTop(nalt:integer):integer;
function fnCenEsq(nlrg:integer):integer;
function fsLerIni(sarq,scabeca,sindice:string):string;
function fsDecHex(ndec:integer):string;

{ Declaracao de Procedimentos de rotinas gerais }

procedure pSetaCursor(ntip:tModoCursor);
procedure pCen(ntop:integer;stxt:string;nfg,nbg:integer);
procedure pBeep(nfreq,ntempo:integer);
procedure pETexto(ntop,nesq:integer;stxt:string;nfg,nbg:integer);
procedure pTelaFundo(stxt:string;nfg,nbg:integer);
procedure pCabecalho(stxt:string;ctxt:char;nfg,nbg:integer);
procedure pRodape(stxt:string;ctxt:char;nfg,nbg:integer);
procedure pDataSistema(ntop,nesq,nfg,nbg:integer);
procedure pHoraSistema(ntop,nesq,nfg,nbg:integer);
procedure pSlvIni(sarq:string;nqtd:integer);

implementation

{
 Nome : pSetaCursor
 Descricao : Procedimento que muda o modo do cursor na tela.
 Parametros :
 ntip - indica o tipo de cursor
}
procedure pSetaCursor(ntip:tModoCursor);
var
 nregs : registers;
begin
if ntip=nenhum then 
 begin
  with nregs do
   begin
    AH:=$01;
    CH:=$20;
    CL:=$20;
   end;
 end
else if ntip=normal then 
 begin
  with nregs do
   begin
    AH:=$01;
    CH:=6;
    CL:=7;
   end;
 end
else if ntip=solido then 
 begin
  with nregs do
   begin
    AH:=$01;
    CH:=0;
    CL:=7;
   end;
 end;
intr($10,nregs);
end;

{------------------------------------------------------------------}

{
 Nome : pCen
 Descricao : Procedimento que centraliza um texto na tela.
 Parametros :
 ntop - posicao de linha na tela
 stxt - texto a ser centralizado
 nfg - cor do texto
 nbg - cod de fundo
}
procedure pCen(ntop:integer;stxt:string;nfg,nbg:integer);
var
 nesq:integer;
begin
 nesq:=(nMaxlrg div 2)-(length(stxt) div 2);
 pETexto(ntop,nesq,stxt,nfg,nbg);
end;

{------------------------------------------}

{
 Nome : pBeep
 Descricao : Procedimento que gera um beep.
 Parametros :
 nfreq - frequencia do beep.
 ntempo - duracao do beep.
}
procedure pBeep(nfreq,ntempo:integer);
begin
 sound(nfreq);
 delay(ntempo);
 nosound;
end;

{-------------------------------------------}

{
 Nome : fnTeclar
 Descricao : funcao que identifica uma tecla do teclado.
}
function fnTeclar:tTeclas;
var
 bchave : boolean;
begin

bchave:=false;
cTecla:=readkey;
if (cTecla=#0) then
 begin
  bchave:=true;
  cTecla:=readkey;
 end;

if bchave then
   case ord(cTecla) of
    15: nTecla := TSHTAB;
    18: nTecla := TALTE;
    22: nTecla := TALTU;
    24: nTecla := TALTO;
    30: nTecla := TALTA;
    31: nTecla := TALTS;
    72: nTecla := TUP;
    80: nTecla := TDOWN;
    75: nTecla := TLEFT;
    77: nTecla := TRIGHT;
    73: nTecla := TPGUP;
    81: nTecla := TPGDN;
    71: nTecla := THOME;
    79: nTecla := TEND;
    83: nTecla := TDEL;
    82: nTecla := TINS;
    59: nTecla := TF1;
    60: nTecla := TF2;
    61: nTecla := TF3;
    62: nTecla := TF4;
    63: nTecla := TF5;
    64: nTecla := TF6;
    65: nTecla := TF7;
    66: nTecla := TF8;
    67: nTecla := TF9;
    68: nTecla := TF10;
   end
else
   Case Ord(cTecla) of
     1: nTecla := TCTRLA;
     8: nTecla := TBS;
     9: nTecla := TTAB;
    13: nTecla := TRET;
    27: nTecla := TESC;
    32: nTecla := TSPACE;
    33..44, 47, 58..254: nTecla := TTEXTO;
    45..46, 48..57: nTecla := TNUMERO;
   end;
fnTeclar:=nTecla;
end;

{-----------------------------------------------------------}

{
 Nome : fsRepete
 Descricao : funcao que retorna um texto repetido n vezes.
 Parametros :
 stxt - indica o texto a ser repetido
 ntam - quantas vezes o texto se repetira
}
function fsRepete(stxt:string;ntam:integer):string;
var
 ncont:integer;
 sesp:String;
begin
 ncont:=1;
 sesp:='';
 while (ncont <= ntam) do
  begin
    sesp:=sesp+stxt;
    ncont:=ncont+1;
  end;
  fsRepete:=sesp;
end;

{-------------------------------------------}

{
 Nome : pETexto
 Descricao : procedimento que escreve o texto na tela com determinada cor.
 Parametros :
 ntop - posicao de linha do texto
 nesq - posicao de coluna do texto
 stxt - o texto a ser escrito
 nfg - cor do texto
 nbg - cor de fundo
}
procedure pETexto(ntop,nesq:integer;stxt:string;nfg,nbg:integer);
begin
 textcolor(nfg);
 textbackground(nbg);
 gotoxy(nesq,ntop);
 write(stxt);
end;

{-------------------------------------------}

{
 Nome : pTelaFundo
 Descricao : procedimento que desenha os caracteres do fundo da tela.
 Parametros :
 stxt - o caracter a ser escrito no fundo
 nfg - cor do texto
 nbg - cor de fundo
}
procedure pTelaFundo(stxt:string;nfg,nbg:integer);
var
 ntop,ncont,nesq:integer;
begin
for ntop:=3 to nMaxalt-1 do
 begin
  nesq:=1;
  for ncont:=1 to (nMaxlrg div 16) do
   begin
    pETexto(ntop,nesq,stxt,nfg,nbg);
    nesq:=nesq+16;
   end;
 end;
end;

{-------------------------------------------}

{
 Nome : pCabecalho
 Descricao : procedimento que escreve o texto de cabecalho do sistema.
 Parametros :
 stxt - o texto a ser escrito
 ctxt - o caracter de fundo.
 nfg - cor do texto
 nbg - cor de fundo
}
procedure pCabecalho(stxt:string;ctxt:char;nfg,nbg:integer);
var
 ncont:integer;
begin
for ncont:=1 to nMaxlrg do
  pETexto(1,ncont,ctxt,nfg,nbg);
pCen(1,stxt,nfg,nbg);
end;

{-------------------------------------------}

{
 Nome : pRodape
 Descricao : procedimento que escreve o texto no rodape da tela.
 Parametros :
 stxt - o texto a ser escrito
 ctxt - o caracter de fundo.
 nfg - cor do texto
 nbg - cor de fundo
}
procedure pRodape(stxt:string;ctxt:char;nfg,nbg:integer);
var
 ncont:integer;
begin
for ncont:=1 to nMaxlrg-1 do
  pETexto(nMaxalt,ncont,ctxt,nfg,nbg);
pCen(nMaxalt,stxt,nfg,nbg);
end;

{-------------------------------------------}

{
 Nome : pDataSistema
 Descricao : procedimento que escreve a data do sistema na tela.
 Parametros :
 ntop - posicao da linha na tela
 nesq - posicao da coluna na tela
 nfg - cor do texto
 nbg - cor de fundo
}
procedure pDataSistema(ntop,nesq,nfg,nbg:integer);
const
  vsdias : array [0..6] of String[9] = ('Domingo','Segunda','Terca',
     'Quarta','Quinta','Sexta','Sabado');
var
  ndia, nmes, nano, ndow : Word;
  sdia, smes, sano : string;
begin
  getdate(nano,nmes,ndia,ndow);
  str(ndia,sdia);
  str(nmes,smes);
  str(nano,sano);
  pETexto(ntop,nesq,vsdias[ndow] + ', '+ fsZeros(sdia,2) + '/'+
  fsZeros(smes,2) + '/'+ sano,nfg,nbg);
end;

{-------------------------------------------}

{
 Nome : pHoraSistema
 Descricao : procedimento que escreve a Hora do sistema na tela.
 Parametros :
 ntop - posicao da linha na tela
 nesq - posicao da coluna na tela
 nfg - cor do texto
 nbg - cor de fundo
}
procedure pHoraSistema(ntop,nesq,nfg,nbg:integer);
var
  nhor, nmin, nseg, nmseg : Word;
  shor, smin, sseg : string;
begin
  gettime(nhor,nmin,nseg,nmseg);
  str(nhor,shor);
  str(nmin,smin);
  str(nseg,sseg);
  pETexto(ntop,nesq,fsZeros(shor,2)+':'+fsZeros(smin,2)+':'+
  fsZeros(sseg,2),nfg,nbg);
end;

{-------------------------------------------}

{
 Nome : fsZeros
 Descricao : funcao que escreve zeros na frente de uma string.
 Parametros :
 stxt - a string a receber zeros a frente
 ntam - o tamanho da string
}
function fsZeros(stxt:string;ntam:integer) : string;
var
 ncont : integer;
 saux : string;
begin
  saux:='';
  if ntam<>length(stxt) then
    begin
      for ncont:=1 to ntam-length(stxt) do
        saux:=saux + '0';
    end;
  fsZeros:=saux+stxt;
end;

{--------------------------------------------------------}

{
 Nome : fsDataAtual
 Descricao : funcao que retorna a data atual do sistema
}
function fsDataAtual:string;
var
  ndia, nmes, nano, ndow : Word;
  sdia, smes, sano : string;
begin
  getdate(nano,nmes,ndia,ndow);
  str(ndia,sdia);
  str(nmes,smes);
  str(nano,sano);
  fsDataAtual:=fsZeros(sdia,2)+'/'+fsZeros(smes,2)+'/'+fsZeros(sano,4);
end;

{--------------------------------------------------------}

{
 Nome : fnConverteData
 Descricao : funcao que converte a data em string para numero.
 Parametros :
 sdat - data a ser convertida
}
function fnConverteData(sdat:string):integer;
var
  saux : string;
  naux, ncod : integer;
begin
 saux:=copy(sdat,7,4)+copy(sdat,4,2)+copy(sdat,1,2);
 Val(saux,naux,ncod);
 fnConverteData:=naux;
end;

{--------------------------------------------------------}

{
 Nome : fnSubDatas
 Descricao : funcao que subtrai duas datas e retorna o numero de dias
 Parametros :
 sdat1 - data inicial
 sdat2 - data final
}
function fnSubDatas(sdat1:string;sdat2:string):integer;
var
 ndia,nmes,nano,ndia1,nmes1,nano1,ndia2,nmes2,nano2:integer;
 ni,ncod,ndias:integer;
 vnudiames:array[1..12] of integer;
begin
 ndias:=0;
 vnudiames[1]:=31;
 vnudiames[2]:=28;
 vnudiames[3]:=31;
 vnudiames[4]:=30;
 vnudiames[5]:=31;
 vnudiames[6]:=30;
 vnudiames[7]:=31;
 vnudiames[8]:=31;
 vnudiames[9]:=30;
 vnudiames[10]:=31;
 vnudiames[11]:=30;
 vnudiames[12]:=31;

 val(copy(sdat1,1,2),ni,ncod);
 ndia1:=ni;
 val(copy(sdat1,4,2),ni,ncod);
 nmes1:=ni;
 val(copy(sdat1,7,4),ni,ncod);
 nano1:=ni;

 val(copy(sdat2,1,2),ni,ncod);
 ndia2:=ni;
 val(copy(sdat2,4,2),ni,ncod);
 nmes2:=ni;
 val(copy(sdat2,7,4),ni,ncod);
 nano2:=ni;

 for nano:=nano1 to nano2 do
  begin
    for nmes:=nmes1 to 12 do
     begin
       { ano bissexto }
       if (nano mod 4)=0 then
         vnudiames[2]:=29
       else
         vnudiames[2]:=28;
       { data final }
       if (nano=nano2) and (nmes=nmes2) then
         vnudiames[nmes2]:=ndia2;
       for ndia:=ndia1 to vnudiames[nmes] do
          ndias:=ndias+1;
       if (nano=nano2) and (nmes=nmes2) then
         begin
           fnSubDatas:=ndias-1;
           exit;
         end;
       ndia1:=1;
     end;
    nmes1:=1;
  end;
  
end;

{--------------------------------------------------------}

{
 Nome : fsSomaDias
 Descricao : funcao que soma um determinado numero de dias a uma data.
 Parametros :
 sdat - a data a ser somada
 nqtd - numero de dias a serem somados
}
function fsSomaDias(sdat:string;nqtd:integer):string;
var
 ndia,nmes,nano,ndia1,nmes1,nano1,nano2:integer;
 ni,ncod,ndias:integer;
 saux,saux2:string;
 vnudiames:array[1..12] of integer;
begin
 ndias:=0;
 vnudiames[1]:=31;
 vnudiames[2]:=28;
 vnudiames[3]:=31;
 vnudiames[4]:=30;
 vnudiames[5]:=31;
 vnudiames[6]:=30;
 vnudiames[7]:=31;
 vnudiames[8]:=31;
 vnudiames[9]:=30;
 vnudiames[10]:=31;
 vnudiames[11]:=30;
 vnudiames[12]:=31;

 val(copy(sdat,1,2),ni,ncod);
 ndia1:=ni;
 val(copy(sdat,4,2),ni,ncod);
 nmes1:=ni;
 val(copy(sdat,7,4),ni,ncod);
 nano1:=ni;

 nano2:=nano1 + (nqtd div 365);

 for nano:=nano1 to nano2 do
  begin
    for nmes:=nmes1 to 12 do
     begin
       { ano bissexto }
       if (nano mod 4)=0 then
         vnudiames[2]:=29
       else
         vnudiames[2]:=28;
       for ndia:=ndia1 to vnudiames[nmes] do
          begin
            ndias:=ndias+1;
            if ndias=nqtd+1 then
              begin
                str(ndia,saux);
                saux2:=fsZeros(saux,2)+'/';
                str(nmes,saux);
                saux2:=saux2+fsZeros(saux,2)+'/';
                str(nano,saux);
                saux2:=saux2+fsZeros(saux,4);
                fsSomaDias:=saux2;
                exit;
            end;
          end;
       ndia1:=1;
     end;
    nmes1:=1;
  end;

end;

{-----------------------------------------------------}

{
 Nome : fsLerIni
 Descricao : procedimento que le o arquivo de inicializacao do sistema.
 Parametros :
 sarq - arquivo de inicializacao
 scabeca - cabecalho dos parametros
 sindice - indice do parametro
}
function fsLerIni(sarq,scabeca,sindice:string):string;
var
 ntam:integer;
 bachou1, bachou2:boolean;
 slinha:string;
 finifile:Text;
begin
 Assign(finifile, sarq);
 if fsearch(sarq,'')='' then
   begin
    writeln('Arquivo de inicializacao nao encontrado');
    halt;
   end
 else
  begin
    reset(finifile);

    bachou1:=false;
    bachou2:=false;
    ntam:=length(sindice);
    slinha:='';
    while not eof(finifile) do
     begin
       readln(finifile,slinha);
       if slinha='['+scabeca+']' then
         bachou1:=true;
       if bachou1=true then
         begin
           if sindice=copy(slinha,1,ntam) then
             begin                  
              fsLerIni:=copy(slinha,ntam+2,length(slinha));
              bachou2:=true;
             end;
         end;
      end;
    close(finifile);
    if bachou2=false then
      fsLerIni:='';
  end;
end;

{-----------------------------------------------------}

{
 Nome : pSlvIni
 Descricao : procedimento que salva no arquivo de inicializacao do sistema.
 Parametros :
 sarq - arquivo de inicializacao
 nqtd - quantidade de linhas
}
procedure pSlvIni(sarq:string;nqtd:integer);
var
 ncont:integer;
 finifile:Text;
begin
 Assign(finifile, sarq);
 rewrite(finifile);
 for ncont:=1 to nqtd do
  writeln(finifile,vsIni[ncont]);
 close(finifile);
end;

{--------------------------------------------------------}

{
 Nome : fnDiaSemana
 Descricao : funcao que retorna o dia da semana
 Parametros :
 ndia - dia da data
 nmes - mes da data
 nano - ano da data
}
function fnDiaSemana(ndia,nmes,nano:integer):integer;
var
 ndia1,nmes1,nano1,ndow:integer;
 vnudiames:array[1..12] of integer;
begin
 ndow:=2;
 vnudiames[1]:=31;
 vnudiames[2]:=28;
 vnudiames[3]:=31;
 vnudiames[4]:=30;
 vnudiames[5]:=31;
 vnudiames[6]:=30;
 vnudiames[7]:=31;
 vnudiames[8]:=31;
 vnudiames[9]:=30;
 vnudiames[10]:=31;
 vnudiames[11]:=30;
 vnudiames[12]:=31;

 for nano1:=1980 to nano do
  begin
    for nmes1:=1 to 12 do
     begin
       { ano bissexto }
       if (nano1 mod 4)=0 then
         vnudiames[2]:=29
       else
         vnudiames[2]:=28;
       for ndia1:=1 to vnudiames[nmes1] do
        begin       
         if (ndia1=ndia) and (nmes1=nmes) and (nano1=nano) then
           begin
             fnDiaSemana:=ndow;
             exit;
           end;
         if ndow=6 then
           ndow:=0
         else
           ndow:=ndow+1;
        end;
     end;
  end;
  
end;

{--------------------------------------------------------}

{
 Nome : fsNumExtenso
 Descricao : funcao que retorna o numero escrito por extenso
 Parametros :
 nnum - o numero
}
function fsNumExtenso(nnum:integer):string;
var
 vsnex : array[0..38] of string[15];
 ntam, ni, nj : integer;
 snum1, snum2, srnum1, srnum2, sk: string;
begin
{ unidades }
vsnex[0]:='zero';
vsnex[1]:='um';
vsnex[2]:='dois';
vsnex[3]:='tres';
vsnex[4]:='quatro';
vsnex[5]:='cinco';
vsnex[6]:='seis';
vsnex[7]:='sete';
vsnex[8]:='oito';
vsnex[9]:='nove';
{ unidades de dez }
vsnex[10]:='dez';
vsnex[11]:='onze';
vsnex[12]:='doze';
vsnex[13]:='treze';
vsnex[14]:='quatorze';
vsnex[15]:='quinze';
vsnex[16]:='dezesseis';
vsnex[17]:='dezessete';
vsnex[18]:='dezoito';
vsnex[19]:='dezenove';
{ dezenas }
vsnex[20]:='vinte';
vsnex[21]:='trinta';
vsnex[22]:='quarenta';
vsnex[23]:='cinquenta';
vsnex[24]:='sessenta';
vsnex[25]:='setenta';
vsnex[26]:='oitenta';
vsnex[27]:='noventa';
{ centenas }
vsnex[28]:='cem';
vsnex[29]:='cento';
vsnex[30]:='duzentos';
vsnex[31]:='trezentos';
vsnex[32]:='quatrocentos';
vsnex[33]:='quinhetos';
vsnex[34]:='seiscentos';
vsnex[35]:='setecentos';
vsnex[36]:='oitocentos';
vsnex[37]:='novecentos';
{ milhar }
vsnex[38]:='mil';

str(nnum,snum1);
ntam:=length(snum1);

for ni:=ntam downto 1 do
 snum2:=snum2+copy(snum1,ni,1);

{rnum1:=vsnex[copy(snum2,1,1)];}

if ntam>=2 then
begin
 for ni:=10 to 19 do
  begin
    str(ni,sk);
    if copy(snum2,1,2)=sk then
       srnum2:=vsnex[ni];
  end;
 nj:=0;
 for ni:=20 to 27 do
  begin
    nj:=nj+10;
    str(nj,sk);
    if copy(snum2,1,2)=sk then
       srnum2:=vsnex[ni]+' e '+srnum1;
  end;
end;

if ntam>=3 then
begin

 for ni:=28 to 37 do
  begin
    if nnum=ni then
       srnum2:=vsnex[ni];
  end;
end;

end;

{-----------------------------------------------------}

{
 Nome : fnCenTop
 Descricao : funcao que centraliza o topo.
 Parametros :
 nalt - altura do formulario
}
function fnCenTop(nalt:integer):integer;
begin
  fnCenTop:=trunc((nMaxalt-nalt) div 2);
end;

{-----------------------------------------------------}

{
 Nome : fnCenEsq
 Descricao : funcao que centraliza a esquerda
 Parametros :
 nlrg - largura do formulario
}
function fnCenEsq(nlrg:integer):integer;
begin
  fnCenEsq:=trunc((nMaxlrg-nlrg) div 2);
end;

{-----------------------------------------------------}
        
{
 Nome : fsDecHex
 Descricao : funcao que converte de decimal para hexadecimal
 Parametros :
 ndec : o decimal
}
function fsDecHex(ndec:integer):string;
var
 vsalfa : array[1..6] of string[1];
 nresto,ndiv : integer;
 sret,sresto,sdiv : string;
begin
 vsalfa[1]:='A';
 vsalfa[2]:='B';
 vsalfa[3]:='C';
 vsalfa[4]:='D';
 vsalfa[5]:='E';
 vsalfa[6]:='F';

sret:='';

if ndec<=15 then
begin
 if ndec>=10 then
   sret:=vsalfa[ndec-9]
 else
  begin
   str(ndec,sdiv);
   sret:=sdiv;
  end;
end
else
begin
 ndiv:=trunc(ndec div 16);
 nresto:=(ndec mod 16);
 while (nresto <= 16) and (ndiv >= 16) do
  begin
    if nresto >= 10 then
      sret:=vsalfa[nresto-9]+sret
    else
     begin
      str(nresto,sresto);
      sret:=sresto+sret;
     end;
    nresto:=(ndiv mod 16);
    ndiv:=trunc(ndiv div 16);
  end;

 str(nresto,sresto);

 if (ndiv >= 10) and (nresto >= 10) then
  sret:=vsalfa[ndiv-9]+sret+vsalfa[nresto-9]
 else if ndiv >= 10 then
   sret:=vsalfa[ndiv-9]+sret+sresto
 else if nresto >= 10 then
  begin
   str(ndiv,sdiv);
   sret:=sdiv+sret+vsalfa[nresto-9]
  end
 else
  begin
   str(ndiv,sdiv);
   sret:=sdiv+sret+sresto;
  end;
end;
 fsDecHex:=sret;
end;

end.
