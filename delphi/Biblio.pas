unit Biblio;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Menus, ExtCtrls;

type

  TForm1 = class(TForm)
    Edit1: TEdit;
    Timer1: TTimer;
    procedure Edit1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormPaint(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
     procedure BlocoPrincipal;

    { Declaracao de funcoes de rotinas }

    function Zeros(s:string;tam:integer):String;
    function Repete(St:string;Tam:integer):String;
    function RetDataAtual:string;
    function ConverteData(dt:string):integer;
    function SomaDias(dt1:string;qtddias:integer):string;
    function SubtraiDatas(dt1:string;dt2:string):integer;

    { Declaracao de funcoes de graficos }
    procedure Digita( var S: string;JanelaTam,MaxTam,X,Y : Integer;
                  fg,bg : TColor;FT : Char);

    procedure SubMenu(numero,qtd,maxtam,topo,esquerda,ultpos:integer;lfg,lbg,
               fg,bg:TColor);
    procedure SubMenuUp(numero,qtd,maxtam,topo,esquerda,ultpos:integer;
         lfg,lbg,fg,bg:TColor);
    procedure SubMenuDown(numero,qtd,maxtam,topo,esquerda,ultpos:integer;
         lfg,lbg,fg,bg:TColor);

    procedure Botao(topo,esquerda:integer;fg,bg,sfg,sbg:TColor;
                texto:string;foco:boolean);
    procedure BotaoDown(topo,esquerda:integer;fg,bg,sfg,sbg:TColor;
                texto:string);
    procedure Lista(tipo,topo,esquerda,altura,largura,tlinhas,tcolunas:integer;
               fg,bg:TColor;var Listapos,Listacol:integer;foco:boolean);
    procedure ListaUp(tipo,topo,esquerda,altura,largura:integer;
               fg,bg:TColor;var Listapos,Listacol:integer);
    procedure ListaDown(tipo,topo,esquerda,altura,largura,tlinhas:integer;
               fg,bg:TColor;var Listapos,Listacol:integer);
    procedure ListaLeft(tipo,topo,esquerda,altura,largura:integer;
               fg,bg:TColor;var Listapos,Listacol:integer);
    procedure ListaRight(tipo,topo,esquerda,altura,largura,tcolunas:integer;
               fg,bg:TColor;var Listapos,Listacol:integer);

    function TiposLista(tipo,largura,pos,col:integer):string;

    { Declaracao de funcoes de MLivros }

    function PesLivros(tipo:char;campo:string;nCod2:integer;sCod2:string;
                   nTamsCod:integer):integer;
    function VerificaLivros:boolean;

    { Declaracao de funcoes de MUSuario }

 {   function PesUsuarios(tipo:char;campo:string;nCod2:integer;sCod2:string;
                   nTamsCod:integer):integer;
    function PesBinaria(Chave:integer):integer;
    function VerificaUsuarios:boolean;

    { Declaracao de funcoes de MEmprest }

  {  function PesEmprestimos(nCodUsuario,nCodLivro:integer):integer;

    { Declaracao de Procedimentos de Biblio }

    procedure ControlaMenus(tipo:char;ultpos:integer;tf:boolean);

    { Declaracao de Procedimentos de rotinas }

    procedure EscreveXY(x,y:integer;S:String);
    procedure center(y:integer;s:string;fg,bg:TColor);
    procedure beep(freq,time:integer);
    procedure Etexto(c,l:integer;fg,bg:TColor;texto:string);
    procedure TeladeFundo(tipo:char;fg,bg:TColor);
    procedure cabecalho(texto:string;tipo:char;fg,bg:TColor);
    procedure rodape(texto:string;tipo:char;fg,bg:TColor);
    procedure DatadoSistema(l,c:integer;fg,bg:TColor);
    procedure HoradoSistema(l,c:integer;fg,bg:TColor);
    procedure AbrirArquivo(Tipo:integer);

    { Declaracao de Procedimentos de graficos }

    procedure formulario(titulo:string;topo,esquerda,
                     altura,largura:integer;fg,bg:TColor;
                     sombra:char;sfg,sbg:TColor);
    procedure Menu(qtd,topo:integer;fg,bg,lfg,lbg:TColor;
              pos2,mfg,mbg,cont2:integer);
    procedure DesenhaBotao(topo,esquerda:integer;fg,bg,sfg,sbg:TColor;
                       texto:string;foco:boolean);
    procedure DesenhaLista(tipo,topo,esquerda,altura,largura:integer;
                       fg,bg:TColor;pos,col:integer;foco:boolean);
    procedure formSplash;

    { Declaracao de Procedimentos de MLivros }

    procedure formLivros(tipo:integer;titulo,rod:string);
    procedure Limpar_Livros;
    procedure Rotulos_formLivros(l:integer);
    procedure Controles_formLivros(tipo:string;tipo2,pos,col:integer;rod:string;
                               foco:boolean);
    procedure Atribuir_vLivros(limpar:boolean);
    procedure Digita_formLivros;
    procedure SalvarLivros(tipo:integer);

    { Declaracao de Procedimentos de MUsuario }

  {  procedure formUsuarios(tipo:integer;titulo,rod:string);
    procedure Limpar_Usuarios;
    procedure Rotulos_formUsuarios(l:integer);
    procedure Controles_formUsuarios(tipo:string;tipo2,pos,
          col:integer;rod:string;foco:boolean);
    procedure Atribuir_vUsuarios(limpar:boolean);
    procedure Digita_formUsuarios;
    procedure SalvarUsuarios(tipo:integer);

    { Declaracao de Procedimentos de MEmprest }

  {  procedure formEmprestimos(tipo:integer;titulo,rod:string);
    procedure Limpar_Emprestimos;
    procedure Rotulos_formEmprestimos(tipo,l:integer);
    procedure Controles_formEmprestimos(tipo:string;tipo2,pos,
          col:integer;rod:string;foco:boolean);
    procedure Atribuir_vEmprestimos(limpar:boolean);
    procedure SalvarEmprestimos(tipo:integer);

    { Declaracao de Procedimentos de MOpcoes }

    procedure formSair;
    procedure Controles_formSair(tipo:string;foco:boolean);
    procedure formSobre;
    procedure LerArquivoSobre;
    procedure Controles_formSobre(tipo:string;pos,col:integer;
                              foco:boolean);

  end;

var
  Form1: TForm1;

type

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

 sKey : Keys;
 vkey:word;
 shift: Tshiftstate;
 //Fk:boolean;
 //Ch:char;
 S:string;
 I,C:integer;
 bSubMenu,bBotao,bControles_formSair,bControles_formSobre:boolean;
 SubMenu_numero,SubMenu_cont,SubMenu_cont2:integer;
 tipo_Controles_formSair,tipo_Controles_formSobre:string;

 { variaveis de menu }

 vMenu : array[1..10] of String[30];
 vSubMenu : array[1..10,1..10] of String[35];

 { variaveis de lista }

 vLista : array[0..50] of String;
 bLista : boolean;
 Lista_Listapos,Lista_Listacol:integer;
 
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

const
 compFont = 8;
 altuFont = 16;

implementation

{$R *.DFM}

{--------------------- Modulo de Rotinas -------------------------------}

{
 Nome : EscreveXY
 Descricao : Procedimento que permite ter um controle do posicionamento
 do cursor, sem piscadas ou erros de repeticao de visualizacao.
 Parametros :
 x - posicao de coluna na tela
 y - posicao de linha na tela
 S - o resultado do que foi digitado
}
procedure TForm1.EscreveXY(x,y:integer;S:String);
begin
canvas.TextOut((x*compFont)-compFont,(y*altuFont)-altuFont,S);
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
procedure TForm1.center(y:integer;s:string;fg,bg:TColor);
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
procedure TForm1.beep(freq,time:integer);
begin
 {sound(freq);
 delay(time);
 nosound;}
end;

{------------------------------------------}

{
 Nome : Repete
 Descricao : funcao que retorna um texto repetido n vezes.
 Parametros :
 St - indica o texto a ser repetido
 Tam - quantas vezes o texto se repetira
}
function TForm1.Repete(St:string;Tam:integer):String;
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
procedure TForm1.Etexto(c,l:integer;fg,bg:TColor;texto:string);
begin
 canvas.Font.Color:=fg;
 canvas.Brush.Color:=bg;
 EscreveXY(c,l,texto);
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
procedure TForm1.TeladeFundo(tipo:char;fg,bg:TColor);
var
 l,c:integer;
begin
for l:=3 to 29 do
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
procedure TForm1.cabecalho(texto:string;tipo:char;fg,bg:TColor);
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
procedure TForm1.rodape(texto:string;tipo:char;fg,bg:TColor);
var
 c:integer;
begin
for c:=1 to 80 do
  Etexto(c,30,fg,bg,tipo);
center(30,texto,fg,bg);
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
procedure TForm1.DatadoSistema(l,c:integer;fg,bg:TColor);
const
  dias : array [0..6] of String[9] = ('Domingo','Segunda','Terca',
     'Quarta','Quinta','Sexta','Sabado');
begin
// Etexto(c,l,fg,bg,dias[dayofweek(date)]+', '+FormatDateTime('dd/mm/yyyy',now));
 Etexto(c,l,fg,bg,FormatDateTime('dd/mm/yyyy',now));
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
procedure TForm1.HoradoSistema(l,c:integer;fg,bg:TColor);
begin
  Etexto(c,l,fg,bg,FormatDateTime('hh:mm:ss', now));
end;

{-------------------------------------------}

{
 Nome : Zeros
 Descricao : funcao que escreve zeros na frente de uma string.
 Parametros :
 s - a string a receber zeros a frente
 tam - o tamanho da string
}
function TForm1.Zeros(s:string;tam:integer) : String;
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

{-----------------------------------------------------}

{
 Nome : AbrirArquivo
 Descricao : procedimento que Abri o tipo de arquivo selecionado.
 Parametros :
 tipo - indica o numero de qual arquivo a ser aberto
}
procedure TForm1.AbrirArquivo(Tipo:integer);
begin
  if Tipo=1 then
   begin
     AssignFile(LivrosFile, 'Livros.dat');
     if Filesearch('Livros.dat','')='' then
        rewrite(LivrosFile)
     else
        reset(LivrosFile);
     nTamLivros:=FileSize(LivrosFile);
   end;
  if tipo=2 then
   begin
     AssignFile(UsuariosFile, 'Usuarios.dat');
     if Filesearch('Usuarios.dat','')='' then
        rewrite(UsuariosFile)
     else
        reset(UsuariosFile);
     nTamUsuarios:=FileSize(UsuariosFile);
   end;
  if Tipo=3 then
   begin
     AssignFile(EmprestimosFile, 'Empresti.dat');
     if Filesearch('Empresti.dat','')='' then
        rewrite(EmprestimosFile)
     else
        reset(EmprestimosFile);
     nTamEmprestimos:=FileSize(EmprestimosFile);
   end;
  if Tipo=4 then
   begin
     AssignFile(SobreFile, 'Sobre.dat');
     reset(SobreFile);
   end;

end;

{--------------------------------------------------------}

{
 Nome : RetDataAtual
 Descricao : funcao que retorna a data atual do sistema
}
function TForm1.RetDataAtual:string;
begin
  RetDataAtual:=datetostr(date);
end;

{--------------------------------------------------------}

{
 Nome : ConverteData
 Descricao : funcao que converte a data em string para numero.
 Parametros :
 dt - data a ser convertida
}
function TForm1.ConverteData(dt:string):integer;
var
  sAux:string;
begin
 sAux:=copy(dt,7,4)+copy(dt,4,2)+copy(dt,1,2);
 ConverteData:=strtoint(sAux);
end;

{--------------------------------------------------------}

{
 Nome : SubtraiDatas
 Descricao : funcao que subtrai duas datas e retorna o numero de dias
 Parametros :
 dt1 - data inicial
 dt2 - data final
}
function TForm1.SubtraiDatas(dt1:string;dt2:string):integer;
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
function TForm1.SomaDias(dt1:string;qtddias:integer):string;
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

{------------------------ Modulo de Graficos --------------------------}

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
procedure TForm1.formulario(titulo:string;topo,esquerda,
                     altura,largura:integer;fg,bg:TColor;
                     sombra:char;sfg,sbg:TColor);
var
 cont,cont2:integer;
begin
  Etexto(esquerda,topo,fg,bg,'Ú');
  for cont:=1 to largura-1 do
   begin
     EscreveXY(esquerda+cont,topo,'Ä');
   end;
  EscreveXY(esquerda+2,topo,titulo);
  EscreveXY(esquerda+largura,topo,'¿');
  for cont:=1 to altura-1 do
   begin
    EscreveXY(esquerda,topo+cont,'³');
    for cont2:=1 to largura-1 do
      begin
        EscreveXY(esquerda+cont2,topo+cont,' ');
      end;
    EscreveXY(esquerda+largura,topo+cont,'³');
    Etexto(esquerda+largura+1,topo+cont,sfg,sbg,sombra);
    canvas.font.color:=fg;
    canvas.brush.color:=bg;
   end;
  EscreveXY(esquerda,topo+altura,'À');
  for cont:=1 to largura-1 do
   begin
     Etexto(esquerda+cont,topo+altura,fg,bg,'Ä');
     Etexto(esquerda+cont+1,topo+altura+1,sfg,sbg,sombra);
   end;
  Etexto(esquerda+largura,topo+altura,fg,bg,'Ù');
  Etexto(esquerda+largura+1,topo+altura,sfg,sbg,sombra);
  EscreveXY(esquerda+largura+1,topo+altura+1,sombra);
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
procedure TForm1.SubMenu(numero,qtd,maxtam,topo,esquerda,ultpos:integer;
         lfg,lbg,fg,bg:TColor);
var
 cont:integer;
begin
 canvas.font.color:=fg;
 canvas.brush.color:=bg;
 for cont:=0 to qtd-1 do
  begin
    EscreveXY(esquerda,topo+cont,
    vSubMenu[numero,cont+1]+
    Repete(' ',maxtam-length(vSubMenu[numero,cont+1])));
  end;
 Etexto(esquerda,topo+ultpos-1,lfg,lbg,vSubMenu[numero,ultpos]+
 Repete(' ',maxtam-length(vSubMenu[numero,ultpos])));

 SubMenu_cont:=ultpos-2;
 SubMenu_cont2:=ultpos-1;
 SubMenu_numero:=numero;
 bSubMenu:=true;

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
procedure TForm1.Menu(qtd,topo:integer;fg,bg,lfg,lbg:TColor;pos2,mfg,mbg,cont2:integer);
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

{-----------------------------------------------------------------}

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
procedure TForm1.DesenhaBotao(topo,esquerda:integer;fg,bg,sfg,sbg:TColor;
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
procedure TForm1.Botao(topo,esquerda:integer;fg,bg,sfg,sbg:TColor;
                texto:string;foco:boolean);
begin
DesenhaBotao(topo,esquerda,fg,bg,sfg,sbg,texto,foco);
bBotao:=true;

{until sKey=Tab;
 if skey=Tab then
    Botao:=1;}

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
procedure TForm1.DesenhaLista(tipo,topo,esquerda,altura,largura:integer;
                       fg,bg:TColor;pos,col:integer;foco:boolean);
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
function TForm1.TiposLista(tipo,largura,pos,col:integer):string;
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
procedure TForm1.Lista(tipo,topo,esquerda,altura,largura,tlinhas,tcolunas:integer;
               fg,bg:TColor;
               var Listapos,Listacol:integer;foco:boolean);
begin
DesenhaLista(tipo,topo,esquerda,altura,largura,fg,bg,
Listapos,listacol,foco);
bLista:=true;
Lista_Listapos:=Listapos;
Lista_Listacol:=Listacol;
end;

{-----------------------------------------------------}

{
 Nome : formSplash
 Descricao : procedimento que desenha a tela inicial do sistema.
}
procedure TForm1.formSplash;
begin
  formulario('',6,10,12,58,clWhite,clNavy,'±',clSilver,clblack);
  Etexto(13, 8,clyellow,clNavy,' ²²²²²²²     ²    ²²²²²²²     ²       ²    ²²²²²² ');
  Etexto(13, 9,clyellow,clNavy,'²²²    ²²²   ²²  ²²²    ²²²   ²²      ²²  ²²²  ²²²');
  Etexto(13,10,clyellow,clNavy,'²²²²²²²²²    ²²  ²²²²²²²²²    ²²      ²²  ²²    ²²');
  Etexto(13,11,clyellow,clNavy,'²²²    ²²²   ²²  ²²²    ²²²   ²²²     ²²  ²²    ²²');
  Etexto(13,12,clyellow,clNavy,'²²²²   ²²²   ²²  ²²²²   ²²²   ²²²²    ²²  ²²²  ²²²');
  Etexto(13,13,clyellow,clNavy,' ²²²²²²²²²   ²²   ²²²²²²²²²   ²²²²²²  ²²   ²²²²²² ');
  Etexto(12,15,clyellow,clNavy,'Programa Desenvolvido por Henrique Figueiredo de Souza');
  Etexto(12,16,clyellow,clNavy,'Todos os Direitos Reservados - 1999   Versao 1.0');
  Etexto(12,17,clyellow,clNavy,'Linguagem Usada Nesta Versao << PASCAL >>');
end;


{*******************Modulo de Opcoes**********************}

{
 Nome : formSair
 Descricao : procedimento que desenha o formulario de sair.
}
procedure TForm1.formSair;
begin
  teladefundo('±',clwhite,clblue);
  rodape('Alterta !, Aviso de Saida do Sistema.',' ',clyellow,clred);
  formulario(chr(180)+'Sair do Sistema'+chr(195),10,25,6,27,clwhite,clnavy,'±',clsilver,clblack);
  Etexto(27,12,clwhite,clnavy,'Deseja Sair do Sistema ?');
  DesenhaBotao(14,40,clblack,clsilver,clblack,clnavy,' Nao ',false);
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
procedure TForm1.Controles_formSair(tipo:string;foco:boolean);
begin
if tipo=' Sim ' then
  Botao(14,30,clblack,clsilver,clblack,clnavy,' Sim ',foco)
else if tipo=' Nao ' then
  Botao(14,40,clblack,clsilver,clblack,clnavy,' Nao ',foco);
tipo_Controles_formSair:=tipo;
bControles_formSair:=true;
end;

{-------------------------------------------}

{
 Nome : formSobre
 Descricao : procedimento que desenha o formulario de Sobre.
}
procedure TForm1.formSobre;
begin
  teladefundo('±',clwhite,clblue);
  rodape('Informacoes sobre o sistema.',' ',clwhite,clnavy);
  formulario(chr(180)+'Sobre o Sistema'+chr(195),4,2,18,76,clwhite,clnavy,'±',clsilver,clblack);
  LerArquivoSobre;
  desenhaBotao(20,63,clblack,clsilver,clblack,clnavy,' Fechar ',false);
  Controles_formSobre('Lista',0,0,true);
end;

{-----------------------------------------------------}

{
 Nome : LerArquivoSobre
 Descricao : procedimento que le o arquivo de sobre a atribui ao vetor
 de lista.
}
procedure TForm1.LerArquivoSobre;
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
procedure TForm1.Controles_formSobre(tipo:string;pos,col:integer;foco:boolean);
begin
if tipo='Fechar' then
 Botao(20,63,clblack,clsilver,clblack,clnavy,' Fechar ',foco)
else if tipo='Lista' then
 lista(4,6,5,13,70,43,72,clwhite,clnavy,pos,col,foco);
tipo_Controles_formSobre:=tipo;
bControles_formSobre:=true;

end;


{---------------------------------------------------------------------}

{
 Nome : ControlaMenus
 Descricao : procedimento que faz todo o controle de manuseio dos submenus.
 Parametros :
 tipo - indica qual o submenu selecionado do menu
 ultpos - indica a ultima posicao da opcao de submenu selecionada
 tf - indica se vai redesenhar a tela de fundo
}
procedure TForm1.ControlaMenus(tipo:char;ultpos:integer;tf:boolean);
begin

if tf=true then
  teladefundo('±',clwhite,clblue);

if tipo='A' then
  begin
    Menu(4,2,clblack,clsilver,clred,clsilver,1,clyellow,clsilver,1);
    rodape('Controle do Acervo da Biblioteca.',' ',clwhite,clnavy);
    formulario('',3,3,4,20,clblack,clsilver,'±',clsilver,clblack);
    SubMenu(1,3,16,4,5,ultpos,clyellow,clsilver,clblack,clsilver);
  end
else if tipo='U' then
  begin
    Menu(4,2,clblack,clsilver,clred,clsilver,10,clyellow,clsilver,2);
    rodape('Controle de Usuarios da Biblioteca.',' ',clwhite,clnavy);
    formulario('',3,12,4,22,clblack,clsilver,'±',clsilver,clblack);
    SubMenu(2,3,18,4,14,ultpos,clyellow,clsilver,clblack,clsilver);
  end
else if tipo='E' then
  begin
    Menu(4,2,clblack,clsilver,clred,clsilver,21,clyellow,clsilver,3);
    rodape('Controle de Emprestimos e Devolucoes da Biblioteca.',' ',
    clwhite,clnavy);
    formulario('',3,23,4,37,clblack,clsilver,'±',clsilver,clblack);
    SubMenu(3,3,16,4,25,ultpos,clyellow,clsilver,clblack,clsilver);
  end
else if tipo='O' then
  begin
    Menu(4,2,clblack,clsilver,clred,clsilver,48,clyellow,clsilver,4);
    rodape('Opcoes do Sistema de Biblioteca.',' ',clwhite,clnavy);
    formulario('',3,50,3,18,clblack,clsilver,'±',clsilver,clblack);
    SubMenu(4,2,16,4,52,ultpos,clyellow,clsilver,clblack,clsilver);
  end
else if tipo='5' then
  begin
    formulario('',6,23,6,20,clblack,clsilver,'±',clsilver,clblack);
    SubMenu(5,5,18,7,25,ultpos,clyellow,clsilver,clblack,clsilver);
  end
else if tipo='6' then
  begin
    formulario('',6,34,5,26,clblack,clsilver,'±',clsilver,clblack);
    SubMenu(6,4,24,7,36,ultpos,clyellow,clsilver,clblack,clsilver);
  end;

end;

{ Bloco principal do programa }
procedure TForm1.BlocoPrincipal;
var key:word;shift:TShiftState;
begin
  teladefundo('±',clwhite,clblue);
  cabecalho('Sistema de Automacao de Biblioteca',' ',clwhite,clnavy);
  rodape('',' ',clwhite,clnavy);
  DatadoSistema(1,1,clwhite,clnavy);
  HoradoSistema(1,73,clwhite,clnavy);

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

  Menu(4,2,clblack,clsilver,clred,clsilver,0,clwhite,clblack,0);
  formSplash;

{  teladefundo('±',clwhite,clblue);
  Menu(4,2,clblack,clsilver,clred,clsilver,0,clwhite,clblack,0);
  rodape('',' ',clwhite,clnavy);}


end;

procedure TForm1.Edit1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
if key=13 then
 begin
  edit1.top:=edit1.top+20;
  edit1.left:=edit1.left+20;
 end;

end;

procedure TForm1.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var l,c:integer;
begin
//canvas.textout(30,30,inttostr(key));
{ Alt }
if ssAlt in Shift then
begin
 for l:=3 to 15 do
  for c:=1 to 80 do
    Etexto(c,l,clwhite,clblue,'±');

 case Key of
  65:ControlaMenus('A',1,true); { Alt-A }
  85:ControlaMenus('U',1,true); { Alt-U }
  69:ControlaMenus('E',1,true); { Alt-E }
  79:ControlaMenus('O',1,true); { Alt-O }
 end;
end;
{ Ctrl }
if bBotao=true then
begin
 if bControles_formSair=true then
  if key=17 then
   if tipo_Controles_formSair=' Sim ' then
    begin
     DesenhaBotao(14,30,clblack,clsilver,clblack,clnavy,' Sim ',false);
     Controles_formSair(' Nao ',true);
    end
   else
    begin
     DesenhaBotao(14,40,clblack,clsilver,clblack,clnavy,' Nao ',false);
     Controles_formSair(' Sim ',true);
    end;
end;

if (bBotao=true) or (bLista=true) then
begin
 if bControles_formSobre=true then
  if key=17 then
   if tipo_Controles_formSobre='Fechar' then
    begin
     DesenhaBotao(20,63,clblack,clsilver,clblack,clnavy,' Fechar ',false);
     Controles_formSobre('Lista',Lista_listapos,Lista_listacol,true);
    end
   else
    begin
     desenhalista(4,6,5,13,70,clwhite,clnavy,Lista_listapos,Lista_listacol,false);
     Controles_formSobre('Fechar',Lista_listapos,Lista_listacol,true);
    end;
end;

{ UpArrow }
if bSubMenu=true then
begin
 if key=38 then
  case SubMenu_numero of
   1:SubMenuUp(1,3,16,4,5,1,clyellow,clsilver,clblack,clsilver);
   2:SubMenuUp(2,3,18,4,14,1,clyellow,clsilver,clblack,clsilver);
   3:SubMenuUp(3,3,16,4,25,1,clyellow,clsilver,clblack,clsilver);
   4:SubMenuUp(4,2,16,4,52,1,clyellow,clsilver,clblack,clsilver);
   5:SubMenuUp(5,5,18,7,25,1,clyellow,clsilver,clblack,clsilver);
   6:SubMenuUp(6,4,24,7,36,1,clyellow,clsilver,clblack,clsilver);
  end;
end;
if bLista=true then
begin
 if key=38 then
  if bControles_formSobre=true then
   if tipo_Controles_formSobre='Lista' then
    listaUp(4,6,5,13,70,clwhite,clnavy,Lista_listapos,Lista_listacol);
end;
{ DownArrow }
if bSubMenu=true then
begin
 if key=40 then
  case SubMenu_numero of
   1:SubMenuDown(1,3,16,4,5,1,clyellow,clsilver,clblack,clsilver);
   2:SubMenuDown(2,3,18,4,14,1,clyellow,clsilver,clblack,clsilver);
   3:SubMenuDown(3,3,16,4,25,1,clyellow,clsilver,clblack,clsilver);
   4:SubMenuDown(4,2,16,4,52,1,clyellow,clsilver,clblack,clsilver);
   5:SubMenuDown(5,5,18,7,25,1,clyellow,clsilver,clblack,clsilver);
   6:SubMenuDown(6,4,24,7,36,1,clyellow,clsilver,clblack,clsilver);
  end;
end;
if bLista=true then
begin
 if key=40 then
  if bControles_formSobre=true then
   if tipo_Controles_formSobre='Lista' then
    listaDown(4,6,5,13,70,43,clwhite,clnavy,Lista_listapos,Lista_listacol);
end;
{ LeftArrow }
if bSubMenu=true then
begin
 if key=37 then
   case SubMenu_numero of
    1:ControlaMenus('O',1,true);
    2:ControlaMenus('A',1,true);
    3:ControlaMenus('U',1,true);
    4:ControlaMenus('E',1,true);
    5:ControlaMenus('A',3,true);
    6:ControlaMenus('U',3,true);
   end;
end;
if bLista=true then
begin
 if key=37 then
  if bControles_formSobre=true then
   if tipo_Controles_formSobre='Lista' then
    listaLeft(4,6,5,13,70,clwhite,clnavy,Lista_listapos,Lista_listacol);
end;
{ RightArrow }
if bSubMenu=true then
begin
 if key=39 then
   case SubMenu_numero of
    1:ControlaMenus('U',1,true);
    2:ControlaMenus('E',1,true);
    3:ControlaMenus('O',1,true);
    4:ControlaMenus('A',1,true);
    5:ControlaMenus('U',1,true);
    6:ControlaMenus('E',1,true);
   end;
end;
if bLista=true then
begin
 if key=39 then
  if bControles_formSobre=true then
   if tipo_Controles_formSobre='Lista' then
    listaRight(4,6,5,13,70,70,clwhite,clnavy,Lista_listapos,Lista_listacol);
end;
{ CarriageReturn }
if bSubMenu=true then
begin
 if Key=13 then
  case SubMenu_numero of
   1:begin
      case SubMenu_cont2+3 of
       3:begin
         formLivros(1,'Cadastrar Livros',
         'Cadastro dos Livros do Acervo da Biblioteca.');
         bSubMenu:=false;
         end;
       4:begin
         formLivros(2,'Alterar Livros',
         'Altera os Livros do Acervo da Biblioteca.');
         bSubMenu:=false;
         end;
       5:ControlaMenus('5',1,false);
      end;
     end;
   2:begin
      case SubMenu_cont2+3 of
{      3:formUsuarios(1,'Cadastrar Usuarios',
         'Cadastro dos Usuarios da Biblioteca.');
       4:formUsuarios(2,'Alterar Usuarios',
         'Altera os Usuarios da Biblioteca.');}
       5:ControlaMenus('6',1,false);
      end;
     end;
{   3:begin
      case SubMenu_cont2+3 of
       3:formEmprestimos(1,'Emprestar Livros',
         'Efetua os Emprestimos de Livros da Biblioteca.');
       4:formEmprestimos(2,'Devolver Livros',
         'Efetua a Devolucao dos Livros da Biblioteca.');
       5:formEmprestimos(3,'Consultar Emprestimos e Devolucoes',
         'Consulta os Emprestimos e Devolucoes dos Livros da Biblioteca.');
      end;
     end;}
   4:begin
      case SubMenu_cont2+3 of
       3:begin
          bSubMenu:=false;
          key:=0;
          formSobre;
         end;
       4:begin
          bSubMenu:=false;
          key:=0;
          formSair;
         end;
      end;
     end;
{   5:begin
      case SubMenu_cont2+3 of
       3:formLivros(7,'Consultar Todos os Livros',
         'Consulta Todos os Livros do Acervo da Biblioteca.');
       4:formLivros(3,'Consultar Livros por Titulo',
         'Consulta os Livros por Titulo do Acervo da Biblioteca.');
       5:formLivros(4,'Consultar Livros por Autor',
         'Consulta os Livros por Autor do Acervo da Biblioteca.');
       6:formLivros(5,'Consultar Livros por Area',
         'Consulta os Livros por Area do Acervo da Biblioteca.');
       7:formLivros(6,'Consultar Livros por Palavra-chave',
         'Consulta os Livros por Palavra-chave do Acervo da Biblioteca.');
      end;
     end;
   6:begin
     case SubMenu_cont2+3 of
       3:formUsuarios(6,'Consultar Todos os Usuarios',
         'Consulta Todos os Usuarios da Biblioteca.');
       4:formUsuarios(3,'Consultar Usuarios por Numero de Inscricao',
         'Consulta os Usuarios por Numero de Inscricao.');
       5:formUsuarios(4,'Consultar Usuarios por Nome',
         'Consulta os Usuarios por Nome.');
       6:formUsuarios(5,'Consultar Usuarios por Identidade',
         'Consulta os Usuarios por Numero de Identidade.');
      end;
     end;}
  end;
end;

if bBotao=true then
begin
 if Key=13 then
  begin

   if bControles_formSair=true then
    begin
     if tipo_Controles_formSair=' Sim ' then
      begin
       BotaoDown(14,30,clblack,clsilver,clblack,clnavy,' Sim ');
       //form1.Color:=clblack;
       //formSplash;
       application.Terminate;
       bBotao:=false;
      end
     else
      begin
       bControles_formSair:=false;
       teladefundo('±',clwhite,clblue);
       rodape('',' ',clwhite,clnavy);
      end;
    end;

   if bControles_formSobre=true then
    begin
     if tipo_Controles_formSobre='Fechar' then
      begin
       closeFile(SobreFile);
       rodape('',' ',clwhite,clnavy);
       teladefundo('±',clwhite,clblue);
       bControles_formSobre:=false;
      end
    end;

  end;
end;
 { if ssAlt in Shift then
  case Key of
    69: skey := AltE;
    85: skey := AltU;
    79: skey := AltO;
    65: skey := AltA;
    83: skey := AltS;
  end;

 if ssCtrl in Shift then
  case Key of
     65: sKey := CtrlA;
  end;

  case Key of
    16: skey := ShiftTab;
    38: skey := UpArrow;
    40: skey := DownArrow;
    37: skey := LeftArrow;
    39: skey := RightArrow;
    33: skey := PgUp;
    34: skey := PgDn;
    36: skey := HomeKey;
    35: skey := EndKey;
    46: skey := DeleteKey;
    45: skey := InsertKey;
    112: skey := F1;
    113: skey := F2;
    114: skey := F3;
    115: skey := F4;
    116: skey := F5;
    117: skey := F6;
    118: skey := F7;
    119: skey := F8;
    120: skey := F9;
    121: skey := F10;
     8: skey := Bksp;
//     9: skey := Tab;
    13: skey := CarriageReturn;
    27: skey := Esc;
    32: skey := SpaceKey;
    65..90: skey := TextKey;
    96..105: skey := NumberKey;
   end;}

end;

procedure TForm1.FormPaint(Sender: TObject);
begin
 blocoPrincipal;
end;


procedure TForm1.SubMenuUp(numero,qtd,maxtam,topo,esquerda,ultpos:integer;
         lfg,lbg,fg,bg:TColor);
begin
       bSubMenu:=true;
       SubMenu_cont:=SubMenu_cont-1;
       SubMenu_cont2:=SubMenu_cont2-1;
       if SubMenu_cont2=-1 then
         begin
          SubMenu_cont:=-2;
          SubMenu_cont2:=qtd-1;
         end;

       Etexto(esquerda,topo+SubMenu_cont+2,fg,bg,vSubMenu[numero,SubMenu_cont+3]+
       Repete(' ',maxtam-length(vSubMenu[numero,SubMenu_cont+3])));
       Etexto(esquerda,topo+SubMenu_cont2,lfg,lbg,vSubMenu[numero,SubMenu_cont2+1]+
       Repete(' ',maxtam-length(vSubMenu[numero,SubMenu_cont2+1])));

       if SubMenu_cont=-2 then
          SubMenu_cont:=qtd-2;

end;

procedure TForm1.SubMenuDown(numero,qtd,maxtam,topo,esquerda,ultpos:integer;
         lfg,lbg,fg,bg:TColor);
begin
       bSubMenu:=true;
       SubMenu_cont:=SubMenu_cont+1;
       SubMenu_cont2:=SubMenu_cont2+1;
       if SubMenu_cont2=qtd then
          SubMenu_cont2:=0;

       Etexto(esquerda,topo+SubMenu_cont,fg,bg,vSubMenu[numero,SubMenu_cont+1]+
       Repete(' ',maxtam-length(vSubMenu[numero,SubMenu_cont+1])));
       Etexto(esquerda,topo+SubMenu_cont2,lfg,lbg,vSubMenu[numero,SubMenu_cont2+1]+
       Repete(' ',maxtam-length(vSubMenu[numero,SubMenu_cont2+1])));

       if SubMenu_cont=qtd-1 then
          SubMenu_cont:=-1;

end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin
teladefundo('±',clwhite,clblue);
timer1.Enabled:=false;
end;

procedure TForm1.BotaoDown(topo,esquerda:integer;fg,bg,sfg,sbg:TColor;
                texto:string);
var
 tam,cont:integer;
begin
 tam:=length(texto);
 Etexto(esquerda+1,topo,fg,bg,chr(16)+texto+chr(17));
 Etexto(esquerda,topo,sfg,sbg,' ');
 for cont:=1 to tam+2 do
  Etexto(esquerda+cont,topo+1,sfg,sbg,' ');
 //delay(500);
end;

procedure TForm1.ListaUp(tipo,topo,esquerda,altura,largura:integer;
               fg,bg:TColor;var Listapos,Listacol:integer);
var
 cont2:integer;
 posicao,sLista:string;
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

procedure TForm1.ListaDown(tipo,topo,esquerda,altura,largura,tlinhas:integer;
               fg,bg:TColor;var Listapos,Listacol:integer);
var
 cont2:integer;
 posicao,sLista:string;
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

procedure TForm1.ListaLeft(tipo,topo,esquerda,altura,largura:integer;
               fg,bg:TColor;var Listapos,Listacol:integer);
var
 cont2:integer;
 coluna,sLista:string;
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

procedure TForm1.ListaRight(tipo,topo,esquerda,altura,largura,tcolunas:integer;
               fg,bg:TColor;var Listapos,Listacol:integer);
var
 cont2:integer;
 coluna,sLista:string;
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
function TForm1.PesLivros(tipo:char;campo:string;nCod2:integer;sCod2:string;
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
procedure TForm1.formLivros(tipo:integer;titulo,rod:string);
begin
  teladefundo('±',clwhite,clblue);
  rodape(rod,' ',clwhite,clnavy);
  formulario(chr(180)+titulo+chr(195),4,2,18,76,clwhite,clnavy,'±',clsilver,clblack);

  vLivros[1]:=Repete(' ',5);
  Atribuir_vLivros(true);
  AbrirArquivo(1);
  if (tipo=1) or (tipo=2) then
    begin
     Rotulos_formLivros(0);
     DesenhaBotao(20,45,clblack,clsilver,clblack,clnavy,' Salvar ',false);
     DesenhaBotao(20,60,clblack,clsilver,clblack,clnavy,' Fechar ',false);
    end;
  if (tipo=3) or (tipo=4) or (tipo=5) or (tipo=6) then
    begin
     DesenhaBotao(20,60,clblack,clsilver,clblack,clnavy,' Fechar ',false);
     Rotulos_formLivros(2);
     Etexto(2,7,clwhite,clnavy,chr(195)+Repete(chr(196),75)+chr(180));
    end;
  if tipo=7 then
     DesenhaBotao(20,60,clblack,clsilver,clblack,clnavy,' Fechar ',false);

  if tipo=3 then
    begin
     Etexto(5,6,clwhite,clnavy,'Titulo : ');
     Etexto(14,6,clblack,clwhite,Repete(' ',30));
    end;
  if tipo=4 then
    begin
     Etexto(5,6,clwhite,clnavy,'Autor : ');
     Etexto(13,6,clblack,clwhite,Repete(' ',30));
    end;
  if tipo=5 then
    begin
     Etexto(5,6,clwhite,clnavy,'Area : ');
     Etexto(12,6,clblack,clwhite,Repete(' ',30));
    end;
  if tipo=6 then
    begin
     Etexto(5,6,clwhite,clnavy,'Palavra-Chave : ');
     Etexto(21,6,clblack,clwhite,Repete(' ',10));
    end;

  Limpar_Livros;
{  if tipo=1 then
     Controles_formLivros('2',1,0,0,rod,false)  { cadastrar }
 { else if tipo=2 then
     Controles_formLivros('1',2,0,0,rod,false)  { alterar }
{  else if tipo=3 then
     Controles_formLivros('3',3,0,0,rod,false) { consultar por titulo }
{  else if tipo=4 then
     Controles_formLivros('4',4,0,0,rod,false) { consultar por Autor }
{  else if tipo=5 then
     Controles_formLivros('5',5,0,0,rod,false) { consultar por Area }
{  else if tipo=6 then
     Controles_formLivros('6',6,0,0,rod,false) { consultar por Palavra-chave }
{  else if tipo=7 then
     Controles_formLivros('7',7,0,0,rod,true); { consultar todos }

end;

{-------------------------------------------}

{
 Nome : Limpar_Livros
 Descricao : procedimento limpa as variaveis do registro de livros.
}
procedure TForm1.Limpar_Livros;
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
procedure TForm1.Rotulos_formLivros(l:integer);
begin
  Etexto(5,6+l,clwhite,clnavy,'Numero de Inscricao : ');
  Etexto(27,6+l,clblack,clwhite,vlivros[1]);
  Etexto(35,6+l,clwhite,clnavy,'Titulo : ');
  Etexto(44,6+l,clblack,clwhite,vlivros[2]);
  Etexto(5,8+l,clwhite,clnavy,'Autor : ');
  Etexto(13,8+l,clblack,clwhite,vlivros[3]);
  Etexto(5,10+l,clwhite,clnavy,'Area : ');
  Etexto(12,10+l,clblack,clwhite,vlivros[4]);
  Etexto(5,12+l,clwhite,clnavy,'Palavra-Chave : ');
  Etexto(21,12+l,clblack,clwhite,vlivros[5]);
  Etexto(35,12+l,clwhite,clnavy,'Edicao : ');
  Etexto(44,12+l,clblack,clwhite,vlivros[6]);
  Etexto(5,14+l,clwhite,clnavy,'Ano de Publicacao : ');
  Etexto(25,14+l,clblack,clwhite,vlivros[7]);
  Etexto(35,14+l,clwhite,clnavy,'Editora : ');
  Etexto(45,14+l,clblack,clwhite,vlivros[8]);
  Etexto(5,16+l,clwhite,clnavy,'Volume : ');
  Etexto(14,16+l,clblack,clwhite,vlivros[9]);
  Etexto(22,16+l,clwhite,clnavy,'Estado Atual : ');
  Etexto(37,16+l,clblack,clwhite,vlivros[10]);
  Etexto(40,16+l,clwhite,clnavy,'(D)isponivel ou (E)mprestado');

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
procedure TForm1.Controles_formLivros(tipo:string;tipo2,pos,col:integer;rod:string;
                               foco:boolean);
begin
if tipo='1' then
   begin
      Digita(S,5,5,28,5,clblack,clwhite,'N'); { Ninsc }
      Val(S,I,C);
      Livros.Ninsc:=I;
      if (length(S) > 0) and (S<>Repete(' ',length(S))) then
        begin
         DesenhaBotao(20,45,clblack,clsilver,clblack,clnavy,' Salvar ',false);
         if PesLivros('N','Ninsc',I,'',0)<>-1 then
           begin
                Atribuir_vLivros(false);
                Rotulos_formLivros(0);
                rodape(rod,' ',clwhite,clnavy);
                Controles_formLivros('2',tipo2,pos,col,rod,false);
           end
         else
           begin
            str(I,S);
            Atribuir_vLivros(true);
            Rotulos_formLivros(0);
            rodape('Numero de Inscricao, nao encontrado !',' ',clyellow,clred);
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
            Etexto(27,6,clblack,clwhite,S);
            S:='';
          end
        else if tipo2=2 then
          begin
            AbrirArquivo(1);
            if PesLivros('N','Ninsc',I,'',0)=-1 then
              rodape('Numero de Inscricao, nao encontrado !',' ',clyellow,clred);
          end;
          Digita_formLivros;
      end;
      Controles_formLivros('Salvar',tipo2,pos,col,rod,true);
   end
else if tipo='3' then
    begin
      S:='';
      Digita(S,30,30,15,5,clblack,clwhite,'T');
      Livros.Titulo:=S;
      if (length(S) > 0) and (S<>Repete(' ',length(S))) then
        begin
         if PesLivros('S','Titulo',0,S,length(S))<>-1 then
           begin
              Atribuir_vLivros(false);
              Rotulos_formLivros(2);
              rodape(rod,' ',clwhite,clnavy);
           end
         else
           begin
            Atribuir_vLivros(true);
            Rotulos_formLivros(2);
            rodape('Titulo do Livro, nao encontrado !',' ',clyellow,clred);
           end;
        end;
        Controles_formLivros('Fechar',tipo2,pos,col,rod,true);
    end
else if tipo='4' then
    begin
      S:='';
      Digita(S,30,30,14,5,clblack,clwhite,'T');
      Livros.Autor:=S;
      if (length(S) > 0) and (S<>Repete(' ',length(S))) then
        begin
         if PesLivros('S','Autor',0,S,length(S))<>-1 then
           begin
              Atribuir_vLivros(false);
              Rotulos_formLivros(2);
              rodape(rod,' ',clwhite,clnavy);
           end
         else
           begin
            Atribuir_vLivros(true);
            Rotulos_formLivros(2);
            rodape('Autor do Livro, nao encontrado !',' ',clyellow,clred);
           end;
        end;
        Controles_formLivros('Fechar',tipo2,pos,col,rod,true);
    end
else if tipo='5' then
    begin
      S:='';
      Digita(S,4,4,13,5,clblack,clwhite,'T');
      Livros.Area:=S;
      if (length(S) > 0) and (S<>Repete(' ',length(S))) then
        begin
         if PesLivros('S','Area',0,S,length(S))<>-1 then
           begin
              Atribuir_vLivros(false);
              Rotulos_formLivros(2);
              rodape(rod,' ',clwhite,clnavy);
           end
         else
           begin
            Atribuir_vLivros(true);
            Rotulos_formLivros(2);
            rodape('Area do Livro, nao encontrada !',' ',clyellow,clred);
           end;
        end;
        Controles_formLivros('Fechar',tipo2,pos,col,rod,true);
    end
else if tipo='6' then
    begin
      S:='';
      Digita(S,10,10,22,5,clblack,clwhite,'T');
      Livros.PChave:=S;
      if (length(S) > 0) and (S<>Repete(' ',length(S))) then
        begin
         if PesLivros('S','Pchave',0,S,length(S))<>-1 then
           begin
              Atribuir_vLivros(false);
              Rotulos_formLivros(2);
              rodape(rod,' ',clwhite,clblue);
           end
         else
           begin
            Atribuir_vLivros(true);
            Rotulos_formLivros(2);
            rodape('Palavra-Chave do Livro, nao encontrado !',' ',clyellow,clred);
           end;
        end;
        Controles_formLivros('Fechar',tipo2,pos,col,rod,true);
    end
{else if tipo='7' then
  begin
    if lista(1,6,5,13,70,nTamLivros+2,220,clwhite,clnavy,pos,col,foco)=1 then
      begin
        desenhalista(1,6,5,13,70,clwhite,clnavy,pos,col,false);
        Controles_formLivros('Fechar',tipo2,pos,col,rod,true);
      end;
  end
else if tipo='Salvar' then
  begin
    case Botao(20,45,clblack,clsilver,clblack,clnavy,' Salvar ',foco) of
      1:begin
          DesenhaBotao(20,45,clblack,clsilver,clblack,clnavy,' Salvar ',false);
          Controles_formLivros('Fechar',tipo2,pos,col,rod,true);
        end;
      2:begin
          SalvarLivros(tipo2);
          DesenhaBotao(20,45,clblack,clsilver,clblack,clnavy,' Salvar ',false);
          Controles_formLivros('Fechar',tipo2,pos,col,rod,true);
        end;
    end;
  end
else if tipo = 'Fechar' then
  begin
    case Botao(20,60,clblack,clsilver,clblack,clnavy,' Fechar ',foco) of
      1:begin
          DesenhaBotao(20,60,clblack,clsilver,clblack,clnavy,' Fechar ',false);
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
         rodape('',' ',clwhite,clblue);
         closeFile(LivrosFile);
        end;
    end;
  end;}

end;

{-------------------------------------------------------}

{
 Nome : Atribuir_vLivros
 Descricao : procedimento que atribui ou limpa o vetor de livros.
 Parametros :
 limpar - indica se vai limpar ou atribuir os vetores
}
procedure TForm1.Atribuir_vLivros(limpar:boolean);
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
procedure TForm1.Digita_formLivros;
begin
     with Livros do
      begin
        S:=Titulo;
        Digita(S,30,30,45,5,clblack,clwhite,'T');
        Titulo:=S;
        S:=Autor;
        Digita(S,30,30,14,7,clblack,clwhite,'T');
        Autor:=S;
        S:=Area;
        Digita(S,30,30,13,9,clblack,clwhite,'T');
        Area:=S;
        S:=PChave;
        Digita(S,10,10,22,11,clblack,clwhite,'T');
        Pchave:=S;
        Str(Edicao,S);
        Digita(S,4,4,45,11,clblack,clwhite,'N');
        Val(S,I,C);
        Edicao:=I;
        Str(AnoPubli,S);
        Digita(S,4,4,26,13,clblack,clwhite,'N');
        Val(S,I,C);
        AnoPubli:=I;
        S:=Editora;
        Digita(S,30,30,46,13,clblack,clwhite,'T');
        Editora:=S;
        str(Volume,S);
        Digita(S,4,4,15,15,clblack,clwhite,'N');
        Val(S,I,C);
        Volume:=I;
        S:=Estado;
        Digita(S,1,1,38,15,clblack,clwhite,'T');
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
function TForm1.VerificaLivros:boolean;
begin
with Livros do
 begin
  str(Ninsc,S);
  if (length(S) = 0) and (S=Repete(' ',length(S))) then
    begin
      rodape('Numero de Inscricao, nao cadastrado !',' ',clyellow,clred);
      VerificaLivros:=false;
      exit
    end;
  if (length(Titulo) = 0) and (Titulo=Repete(' ',length(Titulo))) then
    begin
      rodape('Titulo, nao cadastrado !',' ',clyellow,clred);
      VerificaLivros:=false;
      exit
    end;
  if (length(Autor) = 0) and (Autor=Repete(' ',length(Autor))) then
    begin
      rodape('Autor, nao cadastrado !',' ',clyellow,clred);
      VerificaLivros:=false;
      exit
    end;
  if (length(Area) = 0) and (Area=Repete(' ',length(Area))) then
    begin
      rodape('Area, nao cadastrada !',' ',clyellow,clred);
      VerificaLivros:=false;
      exit
    end;
  if (length(Pchave) = 0) and (Pchave=Repete(' ',length(Pchave))) then
    begin
      rodape('Palavra-Chave, nao cadastrada !',' ',clyellow,clred);
      VerificaLivros:=false;
      exit
    end;
  str(Edicao,S);
  if (length(S) = 0) and (S=Repete(' ',length(S))) then
    begin
      rodape('Edicao, nao cadastrada !',' ',clyellow,clred);
      VerificaLivros:=false;
      exit
    end;
  str(AnoPubli,S);
  if (length(S) = 0) and (S=Repete(' ',length(S))) then
    begin
      rodape('Ano de Publicacao, nao cadastrado !',' ',clyellow,clred);
      VerificaLivros:=false;
      exit
    end;
  if (length(Editora) = 0) and (Editora=Repete(' ',length(Editora))) then
    begin
      rodape('Editora, nao cadastrada !',' ',clyellow,clred);
      VerificaLivros:=false;
      exit
    end;
  str(Volume,S);
  if (length(S) = 0) and (S=Repete(' ',length(S))) then
    begin
      rodape('Volume, nao cadastrado !',' ',clyellow,clred);
      VerificaLivros:=false;
      exit
    end;
  if (length(Estado) = 0) and (Estado=Repete(' ',length(Estado))) then
    begin
      rodape('Estado, nao cadastrado !',' ',clyellow,clred);
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
procedure TForm1.SalvarLivros(tipo:integer);
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
  rodape('Estado Atual, Cadastrado Incorretamente !',' ',clyellow,clred);
end;

end;

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
}
procedure TForm1.Digita( var S: string;JanelaTam,MaxTam,X,Y : Integer;
                  fg,bg : TColor;FT : Char);
begin
 edit1.Visible:=true;
 edit1.SetFocus;
 edit1.Width:=compFont*JanelaTam;
 edit1.MaxLength:=MaxTam;
 edit1.Left:=((X*compFont)-compFont)-compFont;
 edit1.Top:=((Y*altuFont)-altuFont)+altuFont;
 edit1.Font.Color:=fg;
 edit1.Color:=bg;
end;

end.

