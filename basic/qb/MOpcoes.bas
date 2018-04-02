' Modulo de Opcoes

'$include:'biblio.inc'

'--------------------------------------------------------------------
' Nome : ControlesformSair
' Descricao : procedimento que realiza todo o controle de manuseio do
' formulario de Saida.
' Parametros :
' tipo - indica qual acao a executar
' foco - indica quais objeto terao foco
'--------------------------------------------------------------------
SUB ControlesformSair (tipo AS STRING, foco AS INTEGER)

IF tipo = " Sim " THEN
    SELECT CASE Botao(14, 30, black, white, black, blue, " Sim ", foco)
      CASE 1
          DesenhaBotao 14, 30, black, white, black, blue, " Sim ", false
          ControlesformSair " Nao ", true
      CASE 2
          COLOR lightgray, black
          CLS
          formSplash
          'Cursor_small("C");
          COLOR lightgray, black
          CLS
          END
    END SELECT
ELSEIF tipo = " Nao " THEN
    SELECT CASE Botao(14, 40, black, white, black, blue, " Nao ", foco)
      CASE 1
          DesenhaBotao 14, 40, black, white, black, blue, " Nao ", false
          ControlesformSair " Sim ", true
      CASE 2
          rodape "", " ", white, blue
    END SELECT
END IF

END SUB

'--------------------------------------------------------------------
' Nome : ControlesformSobre
' Descricao : procedimento que realiza todo o controle de manuseio do
' formulario de Sobre.
' Parametros :
' tipo - indica qual acao a executar
' pos - indica a ultima posicao da linha da lista de sobre
' col - indica a ultima posicao da coluna da lista de sobre
' foco - indica quais objeto terao foco
'--------------------------------------------------------------------
SUB ControlesformSobre (tipo AS STRING, posi AS INTEGER, col AS INTEGER, foco AS INTEGER)

IF tipo = "Fechar" THEN
    SELECT CASE Botao(20, 63, black, white, black, blue, " Fechar ", foco)
      CASE 1
          DesenhaBotao 20, 63, black, white, black, blue, " Fechar ", false
          ControlesformSobre "Lista", posi, col, true
      CASE 2
          CLOSE 4
          rodape "", " ", white, blue
          teladefundo "±", white, lightblue
    END SELECT
ELSEIF tipo = "Lista" THEN
    listapos = posi
    listacol = col
    IF lista(4, 6, 5, 13, 70, 43, 70, white, blue, foco) = 1 THEN
       desenhalista 4, 6, 5, 13, 70, white, blue, posi, col, false
       ControlesformSobre "Fechar", posi, col, true
    END IF
END IF

END SUB

'--------------------------------------------------------------------
' Nome : formSair
' Descricao : procedimento que desenha o formulario de sair.
'--------------------------------------------------------------------
SUB formSair
  teladefundo "±", white, lightblue
  rodape "Alerta !, Aviso de Saida do Sistema.", " ", yellow, red
  formulario CHR$(180) + "Sair do Sistema" + CHR$(195), 10, 25, 6, 27, white, blue, "±", lightgray, black
  Etexto 27, 12, white, blue, "Deseja Sair do Sistema ?"
  DesenhaBotao 14, 40, black, white, black, blue, " Nao ", false
  ControlesformSair " Sim ", true
END SUB

'--------------------------------------------------------------------
' Nome : formSobre
' Descricao : procedimento que desenha o formulario de Sobre.
'--------------------------------------------------------------------
SUB formSobre
  teladefundo "±", white, lightblue
  rodape "Informacoes sobre o sistema.", " ", white, blue
  formulario CHR$(180) + "Sobre o Sistema" + CHR$(195), 4, 2, 18, 76, white, blue, "±", lightgray, black
  LerArquivoSobre
  DesenhaBotao 20, 63, black, white, black, blue, " Fechar ", false
  ControlesformSobre "Lista", 0, 0, true
END SUB

'--------------------------------------------------------------------
' Nome : LerArquivoSobre
' Descricao : procedimento que le o arquivo de sobre a atribui ao vetor
' de lista.
'---------------------------------------------------------------------
SUB LerArquivoSobre
DIM cont AS INTEGER
DIM linha AS STRING

 AbrirArquivo SobreFile
 cont = 0
 DO WHILE NOT EOF(SobreFile)
   LINE INPUT #4, linha
   vLista(cont) = linha
   cont = cont + 1
 LOOP
END SUB


