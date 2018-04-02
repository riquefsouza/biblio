{ Modulo de Opcoes }
unit mopcoes;

interface

uses crt, dos, rotinas1, grafico1, rotinas2, grafico2;

{ Declaracao de Procedimentos de mopcoes }

procedure pFrmSair; 
procedure pConFrmSair(stip:string;bfco:boolean); 
procedure pFrmSobre; 
procedure pLerArquivoSobre; 
procedure pConFrmSobre(stip:string;npos,ncol:integer;
                              bfco:boolean); 
procedure pFrmCalendario;
procedure pConFrmCalendario(stip:string;bfco:boolean); 
procedure pFrmCalculadora; 
procedure pConFrmCalculadora(stip:string;bfco:boolean); 
procedure pFrmCores; 
procedure pConFrmCores(stip:string;nopc1,nopc2,nopc3:integer;
                              bfco:boolean); 
procedure pFrmConfig(bcond:boolean);
procedure pConFrmConfig(stip:string;nopc,nopc2:integer;bfco:boolean); 
procedure pFrmTabAscii; 
procedure pConFrmTabAscii(stip:string;bfco:boolean); 
procedure pFrmQuebraCabeca; 
procedure pConFrmQuebraCabeca(stip:string;bfco:boolean);

implementation

{
 Nome : pFrmSair
 Descricao : procedimento que desenha o formulario de sair.
}
procedure pFrmSair;
begin
  pTelaFundo(sCFundo,mnCor[5,1],mnCor[5,2]);
  pRodape('Alterta !, Aviso de Saida do Sistema.',' ',mnCor[7,1],mnCor[7,2]);
  pFrm(chr(180)+'Sair do Sistema'+chr(195),10,25,6,27,chr(177),mnCor[8,1],
  mnCor[8,2],lightgray,black);
  pETexto(12,27,'Deseja Sair do Sistema ?',mnCor[8,1],mnCor[8,2]);
  pDesBotao(14,40,' Nao ',mnCor[9,1],mnCor[9,2],black,mnCor[8,2],false);
  pConFrmSair(' Sim ',true);
end;

{-------------------------------------------}

{
 Nome : pConFrmSair
 Descricao : procedimento que realiza todo o controle de manuseio do
 formulario de Saida.
 Parametros :
 stip - indica qual acao a executar
 bfco - indica quais objeto terao foco
}
procedure pConFrmSair(stip:string;bfco:boolean);
begin

if stip=' Sim ' then
  begin
    case fnBotao(14,30,' Sim ',mnCor[9,1],mnCor[9,2],black,mnCor[8,2],bfco) of
      1:begin
          pDesBotao(14,30,' Sim ',mnCor[9,1],
          mnCor[9,2],black,mnCor[8,2],false);
          pConFrmSair(' Nao ',true);
        end;
      2:begin
          pETexto(1,1,'.Fim.',lightgray,black);
          clrscr;
          {pFrmSplash;}
          pETexto(1,1,'.Fim.',lightgray,black);
          clrscr;
          pSetaCursor(normal);
          halt;
        end;
    end;
  end
else if stip=' Nao ' then
  begin
    case fnBotao(14,40,' Nao ',mnCor[9,1],mnCor[9,2],black,mnCor[8,2],bfco) of
      1:begin
          pDesBotao(14,40,' Nao ',mnCor[9,1],mnCor[9,2],
          black,mnCor[8,2],false);
          pConFrmSair(' Sim ',true);
        end;
      2:pRodape('',' ',mnCor[6,1],mnCor[6,2]);
    end;
  end;

end;

{-------------------------------------------}

{
 Nome : pFrmSobre
 Descricao : procedimento que desenha o formulario de Sobre.
}
procedure pFrmSobre;
begin
  pTelaFundo(sCFundo,mnCor[5,1],mnCor[5,2]);
  pRodape('Informacoes sobre o sistema.',' ',mnCor[6,1],mnCor[6,2]);
  pFrm(chr(180)+'Sobre o Sistema'+chr(195),4,2,18,76,chr(177),mnCor[8,1],
  mnCor[8,2],lightgray,black);
  pLerArquivoSobre;
  pDesBotao(20,63,' Fechar ',mnCor[9,1],mnCor[9,2],black,mnCor[8,2],false);
  pConFrmSobre('Lista',0,0,true);
end;

{-----------------------------------------------------}

{
 Nome : pLerArquivoSobre
 Descricao : procedimento que le o arquivo de sobre a atribui ao vetor
 de lista.
}
procedure pLerArquivoSobre;
var
 ncont:integer;
 slinha:string;
begin
 pAbrirArquivo(4);
 ncont:=0;
 while not eof(fSobre) do
  begin
   readln(fSobre,slinha);
   vsLista[ncont]:=slinha;
   ncont:=ncont+1;
  end;
end;

{-----------------------------------------------------}

{
 Nome : pConFrmSobre
 Descricao : procedimento que realiza todo o controle de manuseio do
 formulario de Sobre.
 Parametros :
 stip - indica qual acao a executar
 npos - indica a ultima posicao da linha da lista de sobre
 ncol - indica a ultima posicao da coluna da lista de sobre
 bfco - indica quais objeto terao foco
}
procedure pConFrmSobre(stip:string;npos,ncol:integer;bfco:boolean);
begin

if stip='Fechar' then
  begin
    case fnBotao(20,63,' Fechar ',mnCor[9,1],mnCor[9,2],black,mnCor[8,2],bfco) of
      1:begin
          pDesBotao(20,63,' Fechar ',mnCor[9,1],mnCor[9,2],
          black,mnCor[8,2],false);
          pConFrmSobre('Lista',npos,ncol,true);
        end;
      2:begin
          close(fSobre);
          pRodape('',' ',mnCor[6,1],mnCor[6,2]);
          pTelaFundo(sCFundo,mnCor[5,1],mnCor[5,2]);
        end;
    end;
  end
else if stip='Lista' then
  begin
    nListapos:=npos;
    nListacol:=ncol;
    if fnLista(4,6,5,13,70,43,71,mnCor[8,1],mnCor[8,2],
       mnCor[10,1],mnCor[10,2],bfco)=1 then
      begin
        pDesLista(4,6,5,13,70,43,71,mnCor[8,1],mnCor[8,2],
        mnCor[10,1],mnCor[10,2],nListapos,nListacol,false);
        pConFrmSobre('Fechar',npos,ncol,true);
      end;
  end;

end;

{-----------------------------------------------------}

{
 Nome : pFrmCalendario
 Descricao : procedimento que desenha o formulario de calendario na tela.
}
procedure pFrmCalendario;
begin
  pTelaFundo(sCFundo,mnCor[5,1],mnCor[5,2]);
  pRodape('Calendario do Sistema.',' ',mnCor[6,1],mnCor[6,2]);
  pFrm(chr(180)+' Calendario '+chr(195),5,8,14,68,chr(177),mnCor[8,1],
  mnCor[8,2],lightgray,black);
  pDesBotao(17,63,' Fechar ',mnCor[9,1],mnCor[9,2],black,mnCor[8,2],false);
  pConFrmCalendario('Calendario',true);
end;

{-----------------------------------------------------}

{
 Nome : pConFrmCalendario
 Descricao : procedimento que realiza todo o controle de manuseio do
 formulario de Calendario.
 Parametros :
 stip - indica qual acao a executar
 bfco - indica quais objeto terao foco
}
procedure pConFrmCalendario(stip:string;bfco:boolean);
var
 nano, nmes, ndia, ndow, nhor, nmin, nseg, nms : Word;
begin
if stip='Fechar' then
  begin
    case fnBotao(17,63,' Fechar ',mnCor[9,1],mnCor[9,2],black,mnCor[8,2],bfco) of
      1:begin
          pDesBotao(17,63,' Fechar ',mnCor[9,1],mnCor[9,2],
          black,mnCor[8,2],false);
          pConFrmCalendario('Calendario',true);
        end;
      2:begin
          pRodape('',' ',mnCor[6,1],mnCor[6,2]);
          pTelaFundo(sCFundo,mnCor[5,1],mnCor[5,2]);
        end;
    end;
  end
else if stip='Calendario' then
  begin
    GetDate(nano,nmes,ndia,ndow);
    GetTime(nhor,nmin,nseg,nms);
    pCalendario(1,6,10,ndia,nmes,nano,nhor,nmin,nseg,mnCor[8,1],mnCor[8,2],
    mnCor[9,1],mnCor[9,2],black,mnCor[8,2],true);
    pConFrmCalendario('Fechar',true);
  end;

end;

{-----------------------------------------------------}

{
 Nome : pFrmCalculadora
 Descricao : procedimento que desenha o formulario de calculadora na tela.
}
procedure pFrmCalculadora;
begin
  pTelaFundo(sCFundo,mnCor[5,1],mnCor[5,2]);
  pRodape('Calculadora do Sistema.',' ',mnCor[6,1],mnCor[6,2]);
  pFrm(chr(180)+' Calculadora '+chr(195),fnCenTop(14),fnCenEsq(43),
  14,43,chr(177),mnCor[8,1],mnCor[8,2],lightgray,black);
  pDesBotao(fnCenTop(14)+12,fnCenEsq(43)+29,
  ' Fechar ',mnCor[9,1],mnCor[9,2],black,mnCor[8,2],false);
  pConFrmCalculadora('Calculadora',true);
end;

{-----------------------------------------------------}

{
 Nome : pConFrmCalculadora
 Descricao : procedimento que realiza todo o controle de manuseio do
 formulario de Calendario.
 Parametros :
 stip - indica qual acao a executar
 bfco - indica quais objeto terao foco
}
procedure pConFrmCalculadora(stip:string;bfco:boolean);
begin

if stip='Fechar' then
  begin
    case fnBotao(fnCenTop(14)+12,fnCenEsq(43)+29,' Fechar ',
         mnCor[9,1],mnCor[9,2],black,mnCor[8,2],bfco) of
      1:begin
          pDesBotao(fnCenTop(14)+12,fnCenEsq(43)+29,
          ' Fechar ',mnCor[9,1],mnCor[9,2],black,mnCor[8,2],false);
          pConFrmCalculadora('Calculadora',true);
        end;
      2:begin
          pRodape('',' ',mnCor[6,1],mnCor[6,2]);
          pTelaFundo(sCFundo,mnCor[5,1],mnCor[5,2]);
        end;
    end;
  end
else if stip='Calculadora' then
  begin
    pCalculadora(fnCenTop(14)+1,fnCenEsq(43)+2,
    mnCor[8,1],mnCor[8,2],mnCor[9,1],mnCor[9,2],black,mnCor[8,2],true);
    pConFrmCalculadora('Fechar',true);
  end;

end;

{-----------------------------------------------------}

{
 Nome : pFrmCores
 Descricao : procedimento que desenha o formulario de cores na tela.
}
procedure pFrmCores;
var
  nopc,ncont:integer;
begin
  pTelaFundo(sCFundo,mnCor[5,1],mnCor[5,2]);
  pRodape('Altera as cores da tela do sistema.',' ',mnCor[6,1],mnCor[6,2]);
  pFrm(chr(180)+' Cores '+chr(195),fnCenTop(17),fnCenEsq(70),
  17,70,chr(177),mnCor[8,1],mnCor[8,2],lightgray,black);
  pETexto(fnCenTop(17)+2,fnCenEsq(70)+2,'Item :',mnCor[8,1],mnCor[8,2]);
  pETexto(fnCenTop(17)+2,fnCenEsq(70)+31,'Texto :',mnCor[8,1],mnCor[8,2]);
  pETexto(fnCenTop(17)+2,fnCenEsq(70)+51,'Fundo :',mnCor[8,1],mnCor[8,2]);
  pETexto(fnCenTop(17)+13,fnCenEsq(70)+20,
  ' Escolha as cores para o item ',mnCor[8,1],mnCor[8,2]);
  pDesBotao(fnCenTop(17)+15,fnCenEsq(70)+20,
  ' Padrao ',mnCor[9,1],mnCor[9,2],black,mnCor[8,2],false);
  pDesBotao(fnCenTop(17)+15,fnCenEsq(70)+34,
  ' Salvar ',mnCor[9,1],mnCor[9,2],black,mnCor[8,2],false);
  pDesBotao(fnCenTop(17)+15,fnCenEsq(70)+49,
  ' Fechar ',mnCor[9,1],mnCor[9,2],black,mnCor[8,2],false);
  msCaixaLista[1,1]:='Cabecalho';
  msCaixaLista[1,2]:='Menu opcao';
  msCaixaLista[1,3]:='Menu selecionado';
  msCaixaLista[1,4]:='Menu';
  msCaixaLista[1,5]:='Tela de fundo';
  msCaixaLista[1,6]:='Linha de status';
  msCaixaLista[1,7]:='Linha de status alerta';
  msCaixaLista[1,8]:='Formularios';
  msCaixaLista[1,9]:='Botoes';
  msCaixaLista[1,10]:='Barras de rolagem';
  msCaixaLista[1,11]:='Caixas de digitacao';
  msCaixaLista[1,12]:='Caixas de opcoes';

  msCaixaLista[2,1]:='Preto';
  msCaixaLista[2,2]:='Azul';
  msCaixaLista[2,3]:='Verde';
  msCaixaLista[2,4]:='Ciano';
  msCaixaLista[2,5]:='Vermelho';
  msCaixaLista[2,6]:='Magenta';
  msCaixaLista[2,7]:='Marrom';
  msCaixaLista[2,8]:='Branco';
  msCaixaLista[2,9]:='Cinza';
  msCaixaLista[2,10]:='Azul lum.';
  msCaixaLista[2,11]:='Verde lum.';
  msCaixaLista[2,12]:='Ciano lum.';
  msCaixaLista[2,13]:='Vermelho lum.';
  msCaixaLista[2,14]:='Rosa';
  msCaixaLista[2,15]:='Amarelo';
  msCaixaLista[2,16]:='Branco lum.';
  for ncont:=1 to 16 do
    msCaixaLista[3,ncont]:=msCaixaLista[2,ncont];

  pDesCaixaLista(2,fnCenTop(17)+3,fnCenEsq(70)+31,8,17,16,0,1,1,mnCor[12,1],
  mnCor[12,2],mnCor[9,1],mnCor[9,2],mnCor[10,1],mnCor[10,2],false);
  pDesCaixaLista(3,fnCenTop(17)+3,fnCenEsq(70)+51,8,17,16,0,1,1,mnCor[12,1],
  mnCor[12,2],mnCor[9,1],mnCor[9,2],mnCor[10,1],mnCor[10,2],false);

  nopc:=1;

  pConFrmCores('Cores',nopc,1,1,true);
end;

{-----------------------------------------------------}

{
 Nome : pConFrmCores
 Descricao : procedimento que realiza todo o controle de manuseio do
 formulario de Cores.
 Parametros :
 stip - indica qual acao a executar
 nopc1, nopc2, nopc3 - opcoes
 bfco - indica quais objeto terao foco
}
procedure pConFrmCores(stip:string;nopc1,nopc2,nopc3:integer;bfco:boolean);
begin
if stip='Padrao' then
  begin
    case fnBotao(fnCenTop(17)+15,fnCenEsq(70)+20,' Padrao ',
         mnCor[9,1],mnCor[9,2],black,mnCor[8,2],bfco) of
      1:begin
          pDesBotao(fnCenTop(17)+15,fnCenEsq(70)+20,
          ' Padrao ',mnCor[9,1],mnCor[9,2],black,mnCor[8,2],false);
          pConFrmCores('Salvar',nopc1,nopc2,nopc3,true);
        end;
      2:begin
        end;
    end;
  end
else if stip='Salvar' then
  begin
    case fnBotao(fnCenTop(17)+15,fnCenEsq(70)+34,' Salvar ',
         mnCor[9,1],mnCor[9,2],black,mnCor[8,2],bfco) of
      1:begin
          pDesBotao(fnCenTop(17)+15,fnCenEsq(70)+34,
          ' Salvar ',mnCor[9,1],mnCor[9,2],black,mnCor[8,2],false);
          pConFrmCores('Fechar',nopc1,nopc2,nopc3,true);
        end;
      2:begin
        end;
    end;
  end
else if stip='Fechar' then
  begin
    case fnBotao(fnCenTop(17)+15,fnCenEsq(70)+49,' Fechar ',
         mnCor[9,1],mnCor[9,2],black,mnCor[8,2],bfco) of
      1:begin
          pDesBotao(fnCenTop(17)+15,fnCenEsq(70)+49,
          ' Fechar ',mnCor[9,1],mnCor[9,2],black,mnCor[8,2],false);
          pConFrmCores('Cores',nopc1,nopc2,nopc3,true);
        end;
      2:begin
          pRodape('',' ',mnCor[6,1],mnCor[6,2]);
          pTelaFundo(sCFundo,mnCor[5,1],mnCor[5,2]);
        end;
    end;
  end
else if stip='Cores' then
  begin
    nopc1:=fnCaixaLista(1,fnCenTop(17)+3,fnCenEsq(70)+2,8,26,12,nopc1,
    mnCor[12,1],mnCor[12,2],mnCor[9,1],mnCor[9,2],mnCor[10,1],mnCor[10,2],
    true);

    nopc2:=fnCaixaLista(2,fnCenTop(17)+3,fnCenEsq(70)+31,8,17,16,
    mnCor[nopc1,1]+1,mnCor[12,1],mnCor[12,2],mnCor[9,1],mnCor[9,2],
    mnCor[10,1],mnCor[10,2],true);

    nopc3:=fnCaixaLista(3,fnCenTop(17)+3,fnCenEsq(70)+51,8,17,16,
    mnCor[nopc1,2]+1,mnCor[12,1],mnCor[12,2],mnCor[9,1],mnCor[9,2],
    mnCor[10,1],mnCor[10,2],true);

    pConFrmCores('Padrao',nopc1,nopc2,nopc3,true);
  end;

end;

{-----------------------------------------------------}

{
 Nome : pFrmConfig
 Descricao : procedimento que desenha o formulario de configuracoes na tela.
 Parametros :
 bcond - condicao de releitura
}
procedure pFrmConfig(bcond:boolean);
var
 nopc:integer;
begin
  pTelaFundo(sCFundo,mnCor[5,1],mnCor[5,2]);
  pRodape('Altera a configuracao do sistema.',' ',mnCor[6,1],mnCor[6,2]);
  pFrm(chr(180)+' Configuracao '+chr(195),fnCenTop(15),fnCenEsq(70),
  15,70,chr(177),mnCor[8,1],mnCor[8,2],lightgray,black);
  pDesBotao(fnCenTop(15)+13,fnCenEsq(70)+28,
  ' Salvar ',mnCor[9,1],mnCor[9,2],black,mnCor[8,2],false);
  pDesBotao(fnCenTop(15)+13,fnCenEsq(70)+41,
  ' Fechar ',mnCor[9,1],mnCor[9,2],black,mnCor[8,2],false);
  pETexto(fnCenTop(15)+2,fnCenEsq(70)+2,'Modo de Tela :',
  mnCor[8,1],mnCor[8,2]);
  pETexto(fnCenTop(15)+5,fnCenEsq(70)+2,
  'Caminho dos arquivos de dados : ',mnCor[8,1],mnCor[8,2]);
  pETexto(fnCenTop(15)+6,fnCenEsq(70)+2,fsRepete(' ',30),
  mnCor[11,1],mnCor[11,2]);
  pETexto(fnCenTop(15)+6,fnCenEsq(70)+2,sCaminhoDat,
  mnCor[11,1],mnCor[11,2]);

  pETexto(fnCenTop(15)+2,fnCenEsq(70)+46,'Escolha o fundo :',
  mnCor[8,1],mnCor[8,2]);
  pDesCaixaLista(4,fnCenTop(15)+3,fnCenEsq(70)+46,8,19,16,0,1,1,mnCor[12,1],
  mnCor[12,2],mnCor[9,1],mnCor[9,2],mnCor[10,1],mnCor[10,2],false);

  if bcond=true then
   begin
     vsOpcaoBotao[1]:='25 Linhas x 80 Colunas';
     vsOpcaoBotao[2]:='50 Linhas x 80 Colunas';
     if (nMaxlrg=80) and (nMaxalt=25) then
       nopc:=1;
     if (nMaxlrg=80) and (nMaxalt=50) then
       nopc:=2;
     pConFrmConfig('Config',nopc,1,true);
   end;
end;

{-----------------------------------------------------}

{
 Nome : pConFrmConfig
 Descricao : procedimento que realiza todo o controle de manuseio do
 formulario de Configuracao.
 Parametros :
 stip - indica qual acao a executar
 nopc - indica a opcao do modo de tela
 nopc2 - indica a opcao de muda tela de fundo
 bfco - indica quais objeto terao foco
}
procedure pConFrmConfig(stip:string;nopc,nopc2:integer;bfco:boolean);
begin
if stip='Salvar' then
  begin
    case fnBotao(fnCenTop(15)+13,fnCenEsq(70)+28,' Salvar ',
         mnCor[9,1],mnCor[9,2],black,mnCor[8,2],bfco) of
      1:begin
          pDesBotao(fnCenTop(15)+13,fnCenEsq(70)+28,
          ' Salvar ',mnCor[9,1],mnCor[9,2],black,mnCor[8,2],false);
        end;
      2:begin
          pDesBotao(fnCenTop(15)+13,fnCenEsq(70)+28,
          ' Salvar ',mnCor[9,1],mnCor[9,2],black,mnCor[8,2],false);

          pPadraoIni;

          if nopc=1 then
           begin           
            vsIni[2]:='MaxLargura=80';
            vsIni[3]:='MaxAltura=25';           
            textmode(CO80);
            nMaxlrg:=80;
            nMaxalt:=25;
           end;

          if nopc=2 then
           begin
            vsIni[2]:='MaxLargura=80';
            vsIni[3]:='MaxAltura=50';            
            TextMode(CO80 + Font8x8);
            nMaxlrg:=80;
            nMaxalt:=50;
           end;
            
          vsIni[6]:='CaminhoDat='+sCaminhoDat;
          str(nopc2,sS);
          vsIni[9]:='NumFundo='+sS;
          pSlvIni('biblio.ini',21);

          clrscr;
          pCabecalho('Sistema de Automacao de Biblioteca',' ',
          mnCor[1,1],mnCor[1,2]);

          pMenu(2,4,mnCor[4,1],mnCor[4,2],mnCor[2,1],mnCor[2,2],0,
          mnCor[3,1],mnCor[3,2],0);
          pDataSistema(1,1,mnCor[1,1],mnCor[1,2]);
          pHoraSistema(1,nMaxlrg-7,mnCor[1,1],mnCor[1,2]);
          pFrmConfig(false);
        end;
    end;
    pConFrmConfig('Fechar',nopc,nopc2,true);
  end
else if stip='Fechar' then
  begin
    case fnBotao(fnCenTop(15)+13,fnCenEsq(70)+41,' Fechar ',
         mnCor[9,1],mnCor[9,2],black,mnCor[8,2],bfco) of
      1:begin
          pDesBotao(fnCenTop(15)+13,fnCenEsq(70)+41,
          ' Fechar ',mnCor[9,1],mnCor[9,2],black,mnCor[8,2],false);
          pConFrmConfig('Config',nopc,nopc2,true);
        end;
      2:begin
          pRodape('',' ',mnCor[6,1],mnCor[6,2]);
          pTelaFundo(sCFundo,mnCor[5,1],mnCor[5,2]);
        end;
    end;
  end
else if stip='Config' then
  begin
    nopc:=fnOpcaoBotao(fnCenTop(15)+2,fnCenEsq(70)+17,
    2,22,nopc,mnCor[12,1],mnCor[12,2],true);
    sS:=sCaminhoDat;
    sS:=fsDigita(fnCenTop(15)+5,fnCenEsq(70)+3,sS,30,30,'T',0,
    mnCor[11,1],mnCor[11,2]); 
    sCaminhoDat:=sS;
    nopc2:=fnCaixaLista(4,fnCenTop(15)+3,fnCenEsq(70)+46,8,19,16,nopc2,
    mnCor[12,1],mnCor[12,2],mnCor[9,1],mnCor[9,2],mnCor[10,1],mnCor[10,2],
    true);
    pConFrmConfig('Salvar',nopc,nopc2,true);
  end;

end;

{-----------------------------------------------------}

{
 Nome : pFrmTabAscii
 Descricao : procedimento que desenha o formulario de tabela ascii.
}
procedure pFrmTabAscii;
begin
  pTelaFundo(sCFundo,mnCor[5,1],mnCor[5,2]);
  pRodape('Tabela Ascii.',' ',mnCor[6,1],mnCor[6,2]);
  pFrm(chr(180)+' Tabela Ascii '+chr(195),fnCenTop(15),fnCenEsq(70),
  15,70,chr(177),mnCor[8,1],mnCor[8,2],lightgray,black);
  pDesBotao(fnCenTop(15)+13,fnCenEsq(70)+55,
  ' Fechar ',mnCor[9,1],mnCor[9,2],black,mnCor[8,2],false);
  pConFrmTabAscii('Ascii',true);
end;

{-----------------------------------------------------}

{
 Nome : pConFrmTabAscii
 Descricao : procedimento que realiza todo o controle de manuseio do
 formulario de tabela ascii.
 Parametros :
 stip - indica qual acao a executar
 bfco - indica quais objeto terao foco
}
procedure pConFrmTabAscii(stip:string;bfco:boolean);
begin
if stip='Fechar' then
  begin
    case fnBotao(fnCenTop(15)+13,fnCenEsq(70)+55,' Fechar ',
         mnCor[9,1],mnCor[9,2],black,mnCor[8,2],bfco) of
      1:begin
          pDesTabAscii(fnCenTop(15)+1,fnCenEsq(70)+2,
          mnCor[8,1],mnCor[8,2],mnCor[9,1],mnCor[9,2],false);
          pDesBotao(fnCenTop(15)+13,fnCenEsq(70)+55,
          ' Fechar ',mnCor[9,1],mnCor[9,2],black,mnCor[8,2],false);
          pConFrmTabAscii('Ascii',true);
        end;
      2:begin
          pRodape('',' ',mnCor[6,1],mnCor[6,2]);
          pTelaFundo(sCFundo,mnCor[5,1],mnCor[5,2]);
        end;
    end;
  end
else if stip='Ascii' then
  begin
    pTabAscii(fnCenTop(15)+1,fnCenEsq(70)+2,
    mnCor[8,1],mnCor[8,2],mnCor[9,1],mnCor[9,2],true);
    pConFrmTabAscii('Fechar',true);
  end;

end;

{-----------------------------------------------------}

{
 Nome : pFrmQuebraCabeca
 Descricao : procedimento que desenha o formulario de Quebra-Cabeca.
}
procedure pFrmQuebraCabeca;
begin
  pTelaFundo(sCFundo,mnCor[5,1],mnCor[5,2]);
  pRodape('Quebra-Cabeca.',' ',mnCor[6,1],mnCor[6,2]);
  pFrm(chr(180)+' Quebra-Cabeca '+chr(195),fnCenTop(14),fnCenEsq(45),
  14,45,chr(177),mnCor[8,1],mnCor[8,2],lightgray,black);
  pDesBotao(fnCenTop(14)+12,fnCenEsq(45)+31,
  ' Fechar ',mnCor[9,1],mnCor[9,2],black,mnCor[8,2],false);
  pConFrmQuebraCabeca('QuebraCabeca',true);
end;

{-----------------------------------------------------}

{
 Nome : pConFrmQuebraCabeca
 Descricao : procedimento que realiza todo o controle de manuseio do
 formulario de QuebraCabeca.
 Parametros :
 stip - indica qual acao a executar
 bfco - indica quais objeto terao foco
}
procedure pConFrmQuebraCabeca(stip:string;bfco:boolean);
begin
if stip='Fechar' then
  begin
    case fnBotao(fnCenTop(14)+12,fnCenEsq(45)+31,' Fechar ',
         mnCor[9,1],mnCor[9,2],black,mnCor[8,2],bfco) of
      1:begin
          pDesQuebraCabeca(fnCenTop(14)+1,fnCenEsq(45)+2,
          mnCor[8,1],mnCor[8,2],mnCor[9,1],mnCor[9,2],false);
          pDesBotao(fnCenTop(14)+12,fnCenEsq(45)+31,
          ' Fechar ',mnCor[9,1],mnCor[9,2],black,mnCor[8,2],false);
          pConFrmQuebraCabeca('QuebraCabeca',true);
        end;
      2:begin
          pRodape('',' ',mnCor[6,1],mnCor[6,2]);
          pTelaFundo(sCFundo,mnCor[5,1],mnCor[5,2]);
        end;
    end;
  end
else if stip='QuebraCabeca' then
  begin
    pQuebraCabeca(fnCenTop(14)+1,fnCenEsq(45)+2,
    mnCor[8,1],mnCor[8,2],mnCor[9,1],mnCor[9,2],true);
    pConFrmQuebraCabeca('Fechar',true);
  end;

end;

end.
