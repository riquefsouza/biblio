DECLARE SUB ControlaMenusArq (ultpos AS INTEGER, tf AS INTEGER)
DECLARE SUB ControlaMenusUsr (ultpos AS INTEGER, tf AS INTEGER)
DECLARE SUB ControlaMenusEmp (ultpos AS INTEGER, tf AS INTEGER)
DECLARE SUB ControlaMenusOpc (ultpos AS INTEGER, tf AS INTEGER)
DECLARE SUB ControlaMenus5 (ultpos AS INTEGER, tf AS INTEGER)
DECLARE SUB ControlaMenus6 (ultpos AS INTEGER, tf AS INTEGER)
' Nome : Sistema de Automacao de Biblioteca (Biblio)
' Autor : Henrique Figueiredo de Souza
' Linguagem : Basic
' intepretador : QBasic
' Compilador : QuickBasic
' Data de Realizacao : 4 de setembro de 1999
' Ultima Atualizacao : 15 de fevereiro de 2000
' Versao do Sistema : 1.0
' Nome do(s) Arquivo(s) e Como Compilar (nesta ordem) :
' 0. biblio.mak   --> "Arquivo de projeto"
' 0. biblio.inc   --> "Arquivo de cabecalho de declaracoes"
' 1. biblio.bas   --> "bc biblio.bas/O/T/C:512;"
' 2. rotinas.bas  --> "bc rotinas.bas/O/T/C:512;"
' 3. graficos.bas --> "bc graficos.bas/O/T/C:512;"
' 4. mlivros.bas  --> "bc mlivros.bas/O/T/C:512;"
' 5. musuario.bas --> "bc musuario.bas/O/T/C:512;"
' 6. memprest.bas --> "bc memprest.bas/O/T/C:512;"
' 7. mopcoes.bas  --> "bc mopcoes.bas/O/T/C:512;"
' 8. link /EX biblio.obj+rotinas.obj+graficos.obj+mlivros.obj+
'    musuario.obj+memprest.obj+mopcoes.obj
'
' Descricao :
' O Sistema e composto dos seguintes modulos:
' 1.Modulo de Livros da Biblioteca
'   Onde se realiza a manutencao dos livros da biblioteca
' 2.Modulo de Usuarios da Bilioteca
'   Onde se realiza a manutencao dos usuarios da biblioteca
' 3.Modulo de Emprestimos e Devolucoes da Biblioteca
'   Onde se efetua os emprestimos e devolucoes da biblioteca
' 4.Modulo de Opcoes do sistema
'   Onde e possivel ver sobre o sistema e sair dele
'
'programa Biblio

'$INCLUDE: 'biblio.inc'

'-----------------------------------------------------------------

'Bloco principal do programa
 
  CLS
  teladefundo "±", white, lightblue
  cabecalho "Sistema de Automacao de Biblioteca", " ", white, blue
  rodape "", " ", white, blue
  DatadoSistema 1, 1, white, blue
  HoradoSistema 1, 73, white, blue

  vMenu(1) = "Acervo"
  vMenu(2) = "Usuarios"
  vMenu(3) = "Emprestimos e Devolucoes"
  vMenu(4) = "Opcoes"
                  
  vSubMenu(1, 1) = "Cadastrar livros"
  vSubMenu(1, 2) = "Alterar livros"
  vSubMenu(1, 3) = "Consultar livros >"

  vSubMenu(2, 1) = "Cadastrar usuarios"
  vSubMenu(2, 2) = "Alterar usuarios"
  vSubMenu(2, 3) = "Consultar usuarios >"

  vSubMenu(3, 1) = "Emprestar livros"
  vSubMenu(3, 2) = "Devolver livros"
  vSubMenu(3, 3) = "Consultar Emprestimos e Devolucoes"

  vSubMenu(4, 1) = "Sobre o sistema"
  vSubMenu(4, 2) = "Sair do sistema"

  vSubMenu(5, 1) = "Todos os livros"
  vSubMenu(5, 2) = "Por Titulo"
  vSubMenu(5, 3) = "Por Autor"
  vSubMenu(5, 4) = "Por Area"
  vSubMenu(5, 5) = "Por Palavra-chave"

  vSubMenu(6, 1) = "Todos os Usuarios"
  vSubMenu(6, 2) = "Por Numero de Inscricao"
  vSubMenu(6, 3) = "Por Nome"
  vSubMenu(6, 4) = "Por Identidade"

  Menu 4, 2, black, lightgray, red, lightgray, 0, white, black, 0
  formSplash
 
  teladefundo "±", white, lightblue
  Menu 4, 2, black, lightgray, red, lightgray, 0, white, black, 0

DO
  
   sKey$ = inkeyEx$

   IF sKey$ = "AltA" THEN
      ControlaMenusArq 1, true
      teladefundo "±", white, lightblue
      Menu 4, 2, black, lightgray, red, lightgray, 0, white, black, 0
   END IF
   IF sKey$ = "AltU" THEN
      ControlaMenusUsr 1, true
      teladefundo "±", white, lightblue
      Menu 4, 2, black, lightgray, red, lightgray, 0, white, black, 0
   END IF
   IF sKey$ = "AltE" THEN
      ControlaMenusEmp 1, true
      teladefundo "±", white, lightblue
      Menu 4, 2, black, lightgray, red, lightgray, 0, white, black, 0
   END IF
   IF sKey$ = "AltO" THEN
      ControlaMenusOpc 1, true
      teladefundo "±", white, lightblue
      Menu 4, 2, black, lightgray, red, lightgray, 0, white, black, 0
   END IF
    
LOOP UNTIL sKey$ = "Esc"

'---------------------------------------------------------------------------
' Nome : ControlaMenus
' Descricao : procedimento que faz todo o controle de manuseio dos submenus.
' Parametros :
' tipo - indica qual o submenu selecionado do menu
' ultpos - indica a ultima posicao da opcao de submenu selecionada
' tf - indica se vai redesenhar a tela de fundo
'---------------------------------------------------------------------------

SUB ControlaMenus5 (ultpos AS INTEGER, tf AS INTEGER)

IF tf = true THEN
  teladefundo "±", white, lightblue
END IF


    formulario "", 6, 23, 6, 20, black, lightgray, "±", lightgray, black
    SELECT CASE SubMenu(5, 5, 18, 7, 25, ultpos, yellow, lightgray, black, lightgray)
      CASE 1
          ControlaMenusArq 3, true
      CASE 2
          ControlaMenusUsr 1, true
      CASE 4
          formLivros 3, "Consultar Livros por Titulo", "Consulta os Livros por Titulo do Acervo da Biblioteca."
      CASE 5
          formLivros 4, "Consultar Livros por Autor", "Consulta os Livros por Autor do Acervo da Biblioteca."
      CASE 6
          formLivros 5, "Consultar Livros por Area", "Consulta os Livros por Area do Acervo da Biblioteca."
      CASE 7
          formLivros 6, "Consultar Livros por Palavra-chave", "Consulta os Livros por Palavra-chave do Acervo da Biblioteca."
      CASE 3
          formLivros 7, "Consultar Todos os Livros", "Consulta Todos os Livros do Acervo da Biblioteca."
    END SELECT
END SUB

SUB ControlaMenus6 (ultpos AS INTEGER, tf AS INTEGER)

IF tf = true THEN
  teladefundo "±", white, lightblue
END IF


    formulario "", 6, 34, 5, 26, black, lightgray, "±", lightgray, black
    SELECT CASE SubMenu(6, 4, 24, 7, 36, ultpos, yellow, lightgray, black, lightgray)
      CASE 1
          ControlaMenusUsr 3, true
      CASE 2
          ControlaMenusEmp 1, true
      CASE 4
          formUsuarios 3, "Consultar Usuarios por Numero de Inscricao", "Consulta os Usuarios por Numero de Inscricao."
      CASE 5
          formUsuarios 4, "Consultar Usuarios por Nome", "Consulta os Usuarios por Nome."
      CASE 6
          formUsuarios 5, "Consultar Usuarios por Identidade", "Consulta os Usuarios por Numero de Identidade."
      CASE 3
          formUsuarios 6, "Consultar Todos os Usuarios", "Consulta Todos os Usuarios da Biblioteca."
    END SELECT

END SUB

SUB ControlaMenusArq (ultpos AS INTEGER, tf AS INTEGER)

IF tf = true THEN
  teladefundo "±", white, lightblue
END IF


    rodape "Controle do Acervo da Biblioteca.", " ", white, blue
    formulario "", 3, 3, 4, 20, black, lightgray, "±", lightgray, black
    Menu 4, 2, black, lightgray, red, lightgray, 1, yellow, lightgray, 1
    SELECT CASE SubMenu(1, 3, 16, 4, 5, ultpos, yellow, lightgray, black, lightgray)
      CASE 1
          ControlaMenusOpc 1, true
      CASE 2
          ControlaMenusUsr 1, true
      CASE 3
          formLivros 1, "Cadastrar Livros", "Cadastro dos Livros do Acervo da Biblioteca."
      CASE 4
          formLivros 2, "Alterar Livros", "Altera os Livros do Acervo da Biblioteca."
      CASE 5
          ControlaMenus5 1, false
    END SELECT
END SUB

SUB ControlaMenusEmp (ultpos AS INTEGER, tf AS INTEGER)

IF tf = true THEN
  teladefundo "±", white, lightblue
END IF


    Menu 4, 2, black, lightgray, red, lightgray, 21, yellow, lightgray, 3
    rodape "Controle de Emprestimos e Devolucoes da Biblioteca.", " ", white, blue
    formulario "", 3, 23, 4, 37, black, lightgray, "±", lightgray, black
    SELECT CASE SubMenu(3, 3, 16, 4, 25, ultpos, yellow, lightgray, black, lightgray)
      CASE 1
          ControlaMenusUsr 1, true
      CASE 2
          ControlaMenusOpc 1, true
      CASE 3
          formEmprestimos 1, "Emprestar Livros", "Efetua os Emprestimos de Livros da Biblioteca."
      CASE 4
          formEmprestimos 2, "Devolver Livros", "Efetua a Devolucao dos Livros da Biblioteca."
      CASE 5
          formEmprestimos 3, "Consultar Emprestimos e Devolucoes", "Consulta os Emprestimos e Devolucoes dos Livros da Biblioteca."
    END SELECT
END SUB

SUB ControlaMenusOpc (ultpos AS INTEGER, tf AS INTEGER)

IF tf = true THEN
  teladefundo "±", white, lightblue
END IF


    Menu 4, 2, black, lightgray, red, lightgray, 48, yellow, lightgray, 4
    rodape "Opcoes do Sistema de Biblioteca.", " ", white, blue
    formulario "", 3, 50, 3, 18, black, lightgray, "±", lightgray, black
    SELECT CASE SubMenu(4, 2, 16, 4, 52, ultpos, yellow, lightgray, black, lightgray)
      CASE 1
          ControlaMenusEmp 1, true
      CASE 2
          ControlaMenusArq 1, true
      CASE 3
          formSobre
      CASE 4
          formSair
    END SELECT
END SUB

SUB ControlaMenusUsr (ultpos AS INTEGER, tf AS INTEGER)

IF tf = true THEN
  teladefundo "±", white, lightblue
END IF


    Menu 4, 2, black, lightgray, red, lightgray, 10, yellow, lightgray, 2
    rodape "Controle de Usuarios da Biblioteca.", " ", white, blue
    formulario "", 3, 12, 4, 22, black, lightgray, "±", lightgray, black
    SELECT CASE SubMenu(2, 3, 18, 4, 14, ultpos, yellow, lightgray, black, lightgray)
      CASE 1
          ControlaMenusArq 1, true
      CASE 2
          ControlaMenusEmp 1, true
      CASE 3
          formUsuarios 1, "Cadastrar Usuarios", "Cadastro dos Usuarios da Biblioteca."
      CASE 4
          formUsuarios 2, "Alterar Usuarios", "Altera os Usuarios da Biblioteca."
      CASE 5
          ControlaMenus6 1, false
    END SELECT
END SUB

