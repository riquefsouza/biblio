package body MOpcoes is

--*******************Modulo de Opcoes**********************

--
-- Nome : formSair
-- Descricao : procedimento que desenha o formulario de sair.
--
procedure formSair is
begin
  teladefundo("±",white,blue);
  rodape("Alterta !, Aviso de Saida do Sistema."," ",yellow,red);
  formulario(character'val(180) & "Sair do Sistema" &
  character'val(195),10,25,6,27,white,blue,"±",light_gray,black);
  Etexto(27,12,white,blue,"Deseja Sair do Sistema ?");
  DesenhaBotao(14,40,black,light_gray,black,blue," Nao ",false);
  Controles_formSair(" Sim ",true);
end formSair;

--------------------------------------------------------------

--
-- Nome : Controles_formSair
-- Descricao : procedimento que realiza todo o controle de manuseio do
-- formulario de Saida.
-- Parametros :
-- tipo - indica qual acao a executar
-- foco - indica quais objeto terao foco
--
procedure Controles_formSair(tipo: in string;foco: in boolean) is
begin

if tipo=" Sim " then
    case Botao(14,30,black,light_gray,black,blue," Sim ",foco) is
      when 1 =>
          DesenhaBotao(14,30,black,light_gray,black,blue," Sim ",false);
          Controles_formSair(" Nao ",true);
      when 2 =>
          textcolor(light_gray);
          textbackground(black);
          clrscr;
          formSplash;
          setcursortype(normal);
          textcolor(light_gray);
          textbackground(black);
          clrscr;
          Adaexit(0);          
      when others => null;
    end case;
elsif tipo=" Nao " then
    case Botao(14,40,black,light_gray,black,blue," Nao ",foco) is
      when 1 =>
          DesenhaBotao(14,40,black,light_gray,black,blue," Nao ",false);
          Controles_formSair(" Sim ",true);
      when 2 => rodape(""," ",white,blue);
      when others => null;
    end case;
end if;

end Controles_formSair;

----------------------------------------------------------------

--
-- Nome : formSobre
-- Descricao : procedimento que desenha o formulario de Sobre.
--
procedure formSobre is
begin
  teladefundo("±",white,blue);
  rodape("Informacoes sobre o sistema."," ",white,blue);
  formulario(character'val(180) & "Sobre o Sistema" &
  character'val(195),4,2,18,76,white,blue,"±",light_gray,black);
  LerArquivoSobre;
  desenhaBotao(20,63,black,light_gray,black,blue," Fechar ",false);
  Controles_formSobre("Lista",0,0,true);
end formSobre;

---------------------------------------------------------

--
-- Nome : LerArquivoSobre
-- Descricao : procedimento que le o arquivo de sobre a atribui ao vetor
-- de lista.
--
procedure LerArquivoSobre is
 cont,Last:integer:=0;
 linha:string(1..80);
 MLinha : ustring;
begin
 AbrirArquivo(4);
 cont:=0;
 while (not Text_IO.end_of_file(SobreFile)) loop
   Text_IO.get_line(SobreFile,linha,Last);
   if Last < linha'Last then
      MLinha:=to_ustring(linha(1..Last));
   else
      MLinha:=to_ustring(linha(1..Last)) & MLinha;
   end if;

   vLista(cont):=Mlinha;
   cont:=cont+1;
 end loop;
end LerArquivoSobre;

----------------------------------------------------------------

--
-- Nome : Controles_formSobre
-- Descricao : procedimento que realiza todo o controle de manuseio do
-- formulario de Sobre.
-- Parametros :
-- tipo - indica qual acao a executar
-- pos - indica a ultima posicao da linha da lista de sobre
-- col - indica a ultima posicao da coluna da lista de sobre
-- foco - indica quais objeto terao foco
--
procedure Controles_formSobre(tipo: in string;pos,col: in integer;
          foco: in boolean) is
begin

if tipo="Fechar" then
    case Botao(20,63,black,light_gray,black,blue," Fechar ",foco) is
      when 1 =>
          DesenhaBotao(20,63,black,light_gray,black,blue," Fechar ",false);
          Controles_formSobre("Lista",pos,col,true);
      when 2 =>
          close(SobreFile);
          rodape(""," ",white,blue);
          teladefundo("±",white,blue);
      when others => null;
    end case;
elsif tipo="Lista" then
    Listapos:=pos;
    Listacol:=col;
    if lista(4,6,5,13,70,43,70,white,blue,foco)=1 then
        desenhalista(4,6,5,13,70,white,blue,pos,col,false);
        Controles_formSobre("Fechar",pos,col,true);
    end if;
end if;

end Controles_formSobre;

end MOpcoes;
