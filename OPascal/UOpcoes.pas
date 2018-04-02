unit UOpcoes;

interface

uses crt, dos, URotinas, UBiblio;

{ Declaracao de tipos }

type

  TOpcoes = object(TBiblio)

   { variaveis do modulo de Opcoes }

   { Declaracao de Procedimentos }

   procedure formSair;
   procedure Controles_formSair(tipo:string;foco:boolean);
   procedure formSobre;
   procedure LerArquivoSobre;
   procedure Controles_formSobre(tipo:string;pos,col:integer;
                              foco:boolean);
  end;

implementation

{*******************Unidade de Opcoes**********************}

{
 Nome : formSair
 Descricao : procedimento que desenha o formulario de sair.
}
procedure TOpcoes.formSair;
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
procedure TOpcoes.Controles_formSair(tipo:string;foco:boolean);
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
procedure TOpcoes.formSobre;
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
procedure TOpcoes.LerArquivoSobre;
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
procedure TOpcoes.Controles_formSobre(tipo:string;pos,col:integer;foco:boolean);
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

end.
