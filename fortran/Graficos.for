C     ------------------
C     Modulo de Graficos
C     ------------------

C     ---------------------------------------------------------------
C     Nome : formSplash
C     Descricao : procedimento que desenha a tela inicial do sistema.
C     ---------------------------------------------------------------
      subroutine formSplash
      integer cont

      write(*,*) 'ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ'
     *ÄÄÄ¿'
      write(*,*) '³  ²²²²²²²     ²    ²²²²²²²     ²       ²    ²²²²²²   '
     *   ³'
      write(*,*) '³ ²²²    ²²²   ²²  ²²²    ²²²   ²²      ²²  ²²²  ²²²  '
     *   ³'
      write(*,*) '³ ²²²²²²²²²    ²²  ²²²²²²²²²    ²²      ²²  ²²    ²²  '
     *   ³'
      write(*,*) '³ ²²²    ²²²   ²²  ²²²    ²²²   ²²²     ²²  ²²    ²²  '
     *   ³'
      write(*,*) '³ ²²²²   ²²²   ²²  ²²²²   ²²²   ²²²²    ²²  ²²²  ²²²  '
     *   ³'
      write(*,*) '³  ²²²²²²²²²   ²²   ²²²²²²²²²   ²²²²²²  ²²   ²²²²²²   '
     *   ³'
      write(*,*) '³ Programa Desenvolvido por Henrique Figueiredo de Sou'
     *za ³'
      write(*,*) '³ Todos os Direitos Reservados - 1999   Versao 1.0    '
     *   ³'
      write(*,*) '³ Linguagem Usada Nesta Versao << FORTRAN >>          '
     *   ³'
      write(*,*) 'ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ'
     *ÄÄÄÙ'
      do cont=1,12
       write(*,*)
      end do
      write(*,*) 'pressione para continuar...'
      read(*,*) 
      return
      end

C     ---------------------------------------------------------------
C     Nome : Menu
C     Descricao : procedimento que escreve a linha de opcoes do menu.
C     ---------------------------------------------------------------
      subroutine Menu
      write(*,20) 
20    format(1X,'Ú',76('Ä'),'¿')
      write(*,*) '³ (A)cervo  (U)suarios  (E)mprestimos e Devolucoes  (O'
     *)pcoes                 ³'
      write(*,40) 
40    format(1X,'À',76('Ä'),'Ù')
      write(*,*) 'Escolha uma opcao > '
      return
      end

C     -------------------------------------------------------------------
C     Nome : SubMenu
C     Descricao : procedimento que escreve as linhas de opcoes do submenu
C     Parametros :
C     num - indica o numero do submenu
C     -------------------------------------------------------------------
      subroutine SubMenu(num)
      integer num

      if (num.eq.1) then
        write(*,*) 'ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿'
        write(*,*) '³ 1. Cadastrar livros   ³'
        write(*,*) '³ 2. Alterar livros     ³'
        write(*,*) '³ 3. Consultar livros > ³'
        write(*,*) '³ 4. Voltar ao menu     ³'
        write(*,*) 'ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ'
      else if (num.eq.2) then
        write(*,*) 'ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿'
        write(*,*) '³ 1. Cadastrar usuarios   ³'
        write(*,*) '³ 2. Alterar usuarios     ³'
        write(*,*) '³ 3. Consultar usuarios > ³'
        write(*,*) '³ 4. Voltar ao menu       ³'
        write(*,*) 'ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ'
      else if (num.eq.3) then
        write(*,*) 'ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿'
        write(*,*) '³ 1. Emprestar livros                   ³'
        write(*,*) '³ 2. Devolver livros                    ³'
        write(*,*) '³ 3. Consultar Emprestimos e Devolucoes ³'
        write(*,*) '³ 4. Voltar ao menu                     ³'
        write(*,*) 'ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ'
      else if (num.eq.4) then
        write(*,*) 'ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿'
        write(*,*) '³ 1. Sobre o sistema ³'
        write(*,*) '³ 2. Sair do sistema ³'
        write(*,*) '³ 3. Voltar ao menu  ³'
        write(*,*) 'ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ'
      else if (num.eq.5) then
        write(*,*) 'ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿'
        write(*,*) '³ 1. Todos os livros   ³'
        write(*,*) '³ 2. Por Titulo        ³'
        write(*,*) '³ 3. Por Autor         ³'
        write(*,*) '³ 4. Por Area          ³'
        write(*,*) '³ 5. Por Palavra-chave ³'
        write(*,*) '³ 6. Voltar ao menu    ³'
        write(*,*) 'ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ'
      else if (num.eq.6) then
        write(*,*) 'ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿'
        write(*,*) '³ 1. Todos os Usuarios       ³'
        write(*,*) '³ 2. Por Numero de Inscricao ³'
        write(*,*) '³ 3. Por Nome                ³'
        write(*,*) '³ 4. Por Identidade          ³'
        write(*,*) '³ 5. Voltar ao menu          ³'
        write(*,*) 'ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ'
      end if
      write(*,*) 'Escolha uma opcao > '
      return
      end

C     -----------------------------------------------------------
C     Nome : formSobre
C     Descricao : procedimento que desenha o formulario de Sobre.
C     -----------------------------------------------------------
      subroutine formSobre
      integer fda
      character*1673 linha

      call AbrirArquivo(4)
      read(6,rec=1,iostat=fda) linha
      write(*,80) linha
80    format(1X,A1217)
      write(*,*) 'Pressione para continuar...'
      read(*,*)
      read(6,rec=2,iostat=fda) linha
      write(*,90) linha
90    format(1X,A457)
      write(*,*) 'Pressione para continuar...'
      read(*,*)
      return
      end

      integer function ArqTam
      integer fda,cont
      cont=1
      do while (fda.ne.-1)
        read(6,rec=cont,iostat=fda) 
        cont=cont+1
      end do
      ArqTam=cont
      return
      end

C     ----------------------------------------------------------------
C     Nome : AbrirArquivo
C     Descricao : procedimento que Abri o tipo de arquivo selecionado.
C     Parametros :
C     tipo - indica o numero de qual arquivo a ser aberto
C     ----------------------------------------------------------------
      subroutine AbrirArquivo(tipo)
      integer tipo

      logical exst
      integer TamRecLiv,TamRecUsu,TamRecEmp,TamRecSob
      
      TamRecLiv=150
      TamRecUsu=133
      TamRecEmp=33
      TamRecSob=1217

      if (tipo.eq.1) then
        inquire(file='Livros.dat',exist=exst)
        if (exst) then
          open(6,file='Livros.dat',status='old',access='direct',
     *         form='formatted',recl=TamRecLiv)
        else
          open(6,file='Livros.dat',status='new',access='direct',
     *         form='formatted',recl=TamRecLiv)
        end if
C       nTamLivros=ArqTam
      else if (tipo.eq.2) then
        inquire(file='Usuarios.dat',exist=exst)
        if (exst) then
          open(6,file='Usuarios.dat',status='old',access='direct',
     *         form='formatted',recl=TamRecUsu)
        else
          open(6,file='Usuarios.dat',status='new',access='direct',
     *         form='formatted',recl=TamRecUsu)
        end if
C       nTamUsuarios=ArqTam
      else if (tipo.eq.3) then
        inquire(file='Empresti.dat',exist=exst)
        if (exst) then
          open(6,file='Empresti.dat',status='old',access='direct',
     *         form='formatted',recl=TamRecEmp)
        else
          open(6,file='Empresti.dat',status='new',access='direct',
     *         form='formatted',recl=TamRecEmp)
        end if
C        nTamEmprestimos=ArqTam
      else if (tipo.eq.4) then
        inquire(file='Sobre.dat',exist=exst)
        if (exst) then
          open(6,file='Sobre.dat',status='old',access='direct',
     *         form='unformatted',recl=TamRecSob)
        end if
      end if
      return
      end

