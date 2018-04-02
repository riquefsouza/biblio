{ Modulo de Rotinas especificas }
unit rotinas2;

interface

uses crt, dos, rotinas1, grafico1;

type

  { Registro de Enderecos }

  rEnderecos = record
     sLogra : string[30];     { Logradouro (30) }
     nNumero : integer;       { Numero do Endereco (5) }
     sCompl : string[10];     { Complemento (10) }
     sBairro : string[20];    { Bairro do Endereco (20) }
     sCep : string[8];        { Cep do Endereco (8) }
  end;

  { Registro de Livros }

  rLivros = record
     nNinsc : integer;        { Numero de Inscricao do Livro (5) }
     sTitulo : string[30];    { Titulo do Livro (30) }
     sAutor : string[30];     { Autor do Livro (30) }
     sArea : string[30];      { Area de atuacao do Livro (30) }
     sPChave : string[10];    { Palavra-Chave para pesquisar o Livro (10) }
     nEdicao : integer;       { Edicao do Livro (4) }
     nAnoPubli : integer;     { Ano de Publicacao do Livro (4) }
     sEditora : String[30];   { Editora do Livro (30) }
     nVolume : integer;       { Volume do Livro (4) }
     cEstado : char;          { Estado Atual - (D)isponivel ou (E)mprestado (1) }
  end;

  { Registro de Usuarios }

  rUsuarios = record
     nNinsc : integer;        { Numero de inscricao do Usuario (5) }
     sNome : string[30];      { Nome completo do Usuario (30) }
     sIdent : string[10];     { Identidade do Usuario (10) }
     Endereco : rEnderecos;   { Endereco completo do Usuario (73) }
     sTelefone : string[11];  { Telefone do Usuario (11) }
     cCategoria : char;       { Categoria - (A)luno,(P)rofessor,(F)uncionario (1) }
     nSituacao : integer;     { Situacao - Numero de Livros em sua posse (1) }
  end;

  { Registro de Emprestimos }

  rEmprestimos = record
     nNinscUsuario : integer;    { Numero de inscricao do Usuario (5) }
     nNinscLivro : integer;      { Numero de inscricao do Livro (5) }
     sDtEmprestimo : string[10]; { Data de Emprestimo do Livro (10) }
     sDtDevolucao : string[10];  { Data de Devolucao do Livro (10) }
     bRemovido : boolean;        { Removido - Indica exclusao logica }
  end;

var
 { variaveis de configuracao }

 mnCor : array[1..15,1..2] of integer;
 sCaminhoDat, sCFundo:string;

 { variaveis de CaixaLista }

 msCaixaLista : array[1..5,1..20] of String[30];

 { variaveis do modulo de livros }

 Livros : rLivros;
 fLivros : file of rLivros;
 nTamLivros : integer;

 { variaveis do modulo de Usuarios }

 Usuarios : rUsuarios;
 fUsuarios : file of rUsuarios;
 nTamUsuarios : integer;

 { variaveis do modulo de Emprestimos }

 Emprestimos : rEmprestimos;
 fEmprestimos : file of rEmprestimos;
 nTamEmprestimos : integer;

 { variaveis do modulo de Opcoes }

 fSobre : Text;

{ Declaracao de Procedimentos de rotinas gerais }

procedure pAbrirArquivo(nnum:integer);
procedure pPadraoIni;
procedure pfrmSplash;
procedure pInicializa;

implementation

{
 Nome : pAbrirArquivo
 Descricao : procedimento que Abri o tipo de arquivo selecionado.
 Parametros :
 nnum - indica o numero de qual arquivo a ser aberto
}
procedure pAbrirArquivo(nnum:integer);
begin
  if nnum=1 then
   begin
     Assign(fLivros, sCaminhoDat+'Livros.dat');
     if fsearch(sCaminhoDat+'Livros.dat','')='' then
        rewrite(fLivros)
     else
        reset(fLivros);
     nTamLivros:=FileSize(fLivros);
   end;
  if nnum=2 then
   begin
     Assign(fUsuarios, sCaminhoDat+'Usuarios.dat');
     if fsearch(sCaminhoDat+'Usuarios.dat','')='' then
        rewrite(fUsuarios)
     else
        reset(fUsuarios);
     nTamUsuarios:=FileSize(fUsuarios);
   end;
  if nnum=3 then
   begin
     Assign(fEmprestimos, sCaminhoDat+'Empresti.dat');
     if fsearch(sCaminhoDat+'Empresti.dat','')='' then
        rewrite(fEmprestimos)
     else
        reset(fEmprestimos);
     nTamEmprestimos:=FileSize(fEmprestimos);
   end;
  if nnum=4 then
   begin
     Assign(fSobre, sCaminhoDat+'Sobre.dat');
     reset(fSobre);
   end;

end;

{-----------------------------------------------------}

{
 Nome : pPadraoIni
 Descricao : procedimento que mostra o vetor padrao de inicializacao
}
procedure pPadraoIni;
begin
  vsIni[1]:='[TamanhoDaTela]';
  vsIni[2]:='MaxLargura=80';
  vsIni[3]:='MaxAltura=25';
  vsIni[4]:='';
  vsIni[5]:='[ArquivosDat]';
  vsIni[6]:='CaminhoDat=c:\pascal\';
  vsIni[7]:='';
  vsIni[8]:='[CaracterFundo]';
  vsIni[9]:='NumFundo=1';
  vsIni[10]:='';
  vsIni[11]:='[Cores]';
  vsIni[12]:='1=00,01';
  vsIni[13]:='2=15,02';
  vsIni[14]:='3=14,03';
  vsIni[15]:='4=02,03';
  vsIni[16]:='5=01,02';
  vsIni[17]:='6=13,12';
  vsIni[18]:='7=05,15';
  vsIni[19]:='8=12,14';
  vsIni[20]:='9=15,12';
  vsIni[21]:='10=11,01';

end;

{-----------------------------------------------------}

{
 Nome : pfrmSplash
 Descricao : procedimento que desenha a tela inicial do sistema.
}
procedure pfrmSplash;
begin
  pSetaCursor(nenhum);
  pFrm('',fnCenTop(12),fnCenEsq(58),12,58,'±',white,blue,lightgray,black);
  pETexto(fnCenTop(12)+2,fnCenEsq(58)+3,' ²²²²²²²     ²    ²²²²²²²     ²       ²    ²²²²²² ',yellow,blue);
  pETexto(fnCenTop(12)+3,fnCenEsq(58)+3,'²²²    ²²²   ²²  ²²²    ²²²   ²²      ²²  ²²²  ²²²',yellow,blue);
  pETexto(fnCenTop(12)+4,fnCenEsq(58)+3,'²²²²²²²²²    ²²  ²²²²²²²²²    ²²      ²²  ²²    ²²',yellow,blue);
  pETexto(fnCenTop(12)+5,fnCenEsq(58)+3,'²²²    ²²²   ²²  ²²²    ²²²   ²²²     ²²  ²²    ²²',yellow,blue);
  pETexto(fnCenTop(12)+6,fnCenEsq(58)+3,'²²²²   ²²²   ²²  ²²²²   ²²²   ²²²²    ²²  ²²²  ²²²',yellow,blue);
  pETexto(fnCenTop(12)+7,fnCenEsq(58)+3,' ²²²²²²²²²   ²²   ²²²²²²²²²   ²²²²²²  ²²   ²²²²²² ',yellow,blue);
  pETexto(fnCenTop(12)+9,fnCenEsq(58)+2,'Programa Desenvolvido por Henrique Figueiredo de Souza',yellow,blue);
  pETexto(fnCenTop(12)+10,fnCenEsq(58)+2,'Todos os Direitos Reservados - 1999   Versao 1.0',yellow,blue);
  pETexto(fnCenTop(12)+11,fnCenEsq(58)+2,'Linguagem Usada Nesta Versao << PASCAL >>',yellow,blue);
  delay(2000);
end;

{---------------------------------------------------------------------}

{
 Nome : pInicializa
 Descricao : procedimento que carrega todas as variaveis do arquivo Ini.
}
procedure pInicializa;
var
 ncont,ni,ncode:integer;
 scor,scor1,scor2,stroca:string;
begin
  Val(fsLerIni('biblio.ini','TamanhoDaTela','MaxLargura'),ni,ncode);
  nMaxlrg:=ni;
  Val(fsLerIni('biblio.ini','TamanhoDaTela','MaxAltura'),ni,ncode);
  nMaxalt:=ni;
  if nMaxalt=25 then
     textmode(CO80);
  if nMaxalt=50 then
     TextMode(CO80 + Font8x8);
  sCaminhoDat:=fsLerIni('biblio.ini','ArquivosDat','CaminhoDat');
  Val(fsLerIni('biblio.ini','CaracterFundo','NumFundo'),ni,ncode);
  msCaixaLista[4,1]:=fsRepete(chr(177),16);
  msCaixaLista[4,2]:=fsRepete(chr(176),16);
  msCaixaLista[4,3]:=fsRepete(chr(178),16);
  msCaixaLista[4,4]:=fsRepete(chr(218),8)+fsRepete(chr(217),8);
  msCaixaLista[4,5]:=fsRepete(chr(180),8)+fsRepete(chr(195),8);
  msCaixaLista[4,6]:=fsRepete(chr(197),16);
  msCaixaLista[4,7]:=fsRepete('+',16);
  msCaixaLista[4,8]:=fsRepete('#',16);
  msCaixaLista[4,9]:=fsRepete(chr(194),8)+fsRepete(chr(193),8);
  msCaixaLista[4,10]:=fsRepete('@',4)+fsRepete('!',4)+fsRepete('?',4)+
  fsRepete('$',4);
  msCaixaLista[4,11]:=fsRepete('>',16);
  msCaixaLista[4,12]:=fsRepete('\',4)+fsRepete('/',12);
  msCaixaLista[4,13]:=fsRepete(chr(244),12)+fsRepete(chr(245),4);
  msCaixaLista[4,14]:=fsRepete(chr(174),2)+fsRepete(chr(237),14);
  msCaixaLista[4,15]:=fsRepete(chr(232),4)+fsRepete(chr(175),12);
  msCaixaLista[4,16]:=fsRepete(chr(230),8)+fsRepete(chr(231),8);
  sCFundo:=msCaixaLista[4,ni];

  for ncont:=1 to 12 do
   begin
    str(ncont,stroca);
    if ncont <= 9 then
      stroca:='0'+stroca;
    scor:=fsLerIni('biblio.ini','Cores',stroca);
    scor1:=copy(scor,1,2);
    val(scor1,ni,ncode);
    mnCor[ncont,1]:=ni;
    scor2:=copy(scor,4,2);
    val(scor2,ni,ncode);
    mnCor[ncont,2]:=ni;
   end;
end;

end.
