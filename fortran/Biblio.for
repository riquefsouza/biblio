C     ---------------------------------------------------
C     Nome : Sistema de Automacao de Biblioteca (Biblio)
C     Autor : Henrique Figueiredo de Souza
C     Linguagem : Fortran
C     Compiladores : Microsoft Fortran
C                    G77         
C     Data de Realizacao : 4 de setembro de 1999
C     Ultima Atualizacao : 15 de fevereiro de 2000
C     Versao do Sistema : 1.0
C     Nome do(s) Arquivo(s) e Como Compilar (nesta ordem) :
C     1. Biblio.for --> "fl biblio.for"
C     1. biblio.for --> "g77 -g -c tra2gq.for -o tra2gq.o"
C     2. "gcc -o tra2gq.exe tra2gq.o -lm -lg2c"
C   
C
C     Descricao :
C     O Sistema e composto dos seguintes modulos:
C     1.Modulo de Acervos da Biblioteca
C       Onde se realiza a manutencao dos livros da biblioteca
C     2.Modulo de Usuarios da Bilioteca
C       Onde se realiza a manutencao dos usuarios da biblioteca
C     3.Modulo de Emprestimos e Devolucoes da Biblioteca
C       Onde se efetua os emprestimos e devolucoes da biblioteca
C     4.Modulo de Opcoes do sistema
C       Onde e possivel ver sobre o sistema e sair dele
C     -----------------------------------------------------------
      program biblio

C      include 'biblio.inc'

      logical bOp
      character opMenu*1
      common nTamLivros
      structure /LivrosRec/
        integer Ninsc
        character*30 Titulo
        character*30 Autor
        character*30 Area
        character*10 PChave
        integer Edicao
        integer AnoPubli
        character*30 Editora
        integer Volume
        character*1 Estado
      end structure
      record /LivrosRec/ Livros


C     ---------------------------
C     Bloco principal do programa 
C     ---------------------------
      call formSplash
      call cabecalho('Sistema de Automacao de Biblioteca')
      bOp=.true.
      do while (bOp)
       call Menu
       read(*,10) opMenu
10     format(A1)
       if (opMenu.eq.'A' .or. opMenu.eq.'a') then        
          call ControlaMenus(1)
       else if (opMenu.eq.'U' .or. opMenu.eq.'u') then
          call ControlaMenus(2)
       else if (opMenu.eq.'E' .or. opMenu.eq.'e') then
          call ControlaMenus(3)
       else if (opMenu.eq.'O' .or. opMenu.eq.'o') then
          call ControlaMenus(4)
       else
          write(*,*) 'Erro --> Opcao invalida digite de novo'
       end if
      end do

      end

C      include 'rotinas.for'
C      include 'graficos.for'
C      include 'MLivros.for'

C     ---------------------------------------------------------------------
C     Nome : cabecalho
C     Descricao : procedimento que escreve o texto de cabecalho do sistema.
C     Parametros :
C     texto - o texto do cabecalho
C     ---------------------------------------------------------------------
      subroutine cabecalho(texto)
      character*34 texto
      integer*2 ano, mes, dia
      integer*2 hora, min, seg, mseg 

      call getdat(ano,mes,dia)
      call gettim(hora, min, seg, mseg)
      write(*,20) 
20    format(1X,'Ú',76('Ä'),'¿')
      write(*,30) dia,mes,ano,texto,hora,min,seg
30    format(1X,'³ ',I2,'/',I2,'/',I4,11X,A34,11X,I2,':',I2,':',I2,' ³')
      write(*,40) 
40    format(1X,'À',76('Ä'),'Ù')
      return
      end

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
      write(*,50) 
50    format(1X,'Ú',76('Ä'),'¿')
      write(*,*) '³ (A)cervo  (U)suarios  (E)mprestimos e Devolucoes  (O'
     *)pcoes                 ³'
      write(*,60) 
60    format(1X,'À',76('Ä'),'Ù')
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
      write(*,70) linha
70    format(1X,A1217)
      write(*,*) 'Pressione para continuar...'
      read(*,*)
      read(6,rec=2,iostat=fda) linha
      write(*,80) linha
80    format(1X,A457)
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

      subroutine formLivros
      integer qLivros,cont
      logical bOp

      write(*,90) 
90    format(1X,'Ú',76('Ä'),'¿')
      write(*,*) '³ Cadastro de Livros                                  '
     *                       ³'
      write(*,100) 
100   format(1X,'À',76('Ä'),'Ù')
      write(*,*)
      bOp=.true.
      do while (bOp)
       write(*,*) 'Deseja cadastrar quantos livros (maximo de 99999) ?'
       read(*,110) qLivros
110    format(I10)
       if (qLivros.lt.1 .or. qLivros.gt.99999) then
         write(*,*) 'Erro --> Numero invalido digite de novo'
       else
         bOp=.false.
       end if
      end do
      do cont=1,qLivros
       write(*,120) cont,nTamLivros+1
120    format('(',I5.1,') Numero de Inscricao do Livro : ',I5)

       bOp=.true.
       do while (bOp)
        write(*,*) 'Titulo do Livro (maximo de 30) : '
        read(*,130) Livros.Titulo
130     format(A30)
        if (len(Livros.Titulo).le.0 .or. len(Livros.Titulo).gt.30) then
          write(*,*) 'Erro --> Tamanho do texto invalido digite de novo'
        else
          bOp=.false.
        end if
       end do

       bOp=.true.
       do while (bOp)
        write(*,*) 'Autor do Livro (maximo de 30) : '
        read(*,140) Livros.Autor
140     format(A30)
        if (len(Livros.Autor).le.0 .or. len(Livros.Autor).gt.30) then
          write(*,*) 'Erro --> Tamanho do texto invalido digite de novo'
        else
          bOp=.false.
        end if
       end do

       bOp=.true.
       do while (bOp)
        write(*,*) 'Area do Livro (maximo de 30) : '
        read(*,150) Livros.Area
150     format(A30)
        if (len(Livros.Area).le.0 .or. len(Livros.Area).gt.30) then
          write(*,*) 'Erro --> Tamanho do texto invalido digite de novo'
        else
          bOp=.false.
        end if
       end do

       bOp=.true.
       do while (bOp)
        write(*,*) 'Palavra Chave do Livro (maximo de 10) : '
        read(*,160) Livros.PChave
160     format(A10)
        if (len(Livros.PChave).le.0 .or. len(Livros.PChave).gt.10) then
          write(*,*) 'Erro --> Tamanho do texto invalido digite de novo'
        else
          bOp=.false.
        end if
       end do

       bOp=.true.
       do while (bOp)
        write(*,*) 'Numero da Edicao do Livro (maximo de 4) : '
        read(*,170) Livros.Edicao
170     format(I5)
        if (Livros.Edicao.le.0 .or. Livros.Edicao.gt.4) then
          write(*,*) 'Erro --> Tamanho do Numero invalido digite de novo'
        else
          bOp=.false.
        end if
       end do

      end do
      return
      end


C     -------------------------------------------------------------------
C     Nome : ControlaMenus
C     Descricao : procedimento que escreve as linhas de opcoes do submenu
C     Parametros :
C     num - indica o numero do submenu
C     -------------------------------------------------------------------
      subroutine ControlaMenus(num)
      integer num
      integer opSubMenu
      logical bSOp

      bSOp=.true.
      if (num.eq.1) then       
       do while (bSOp)
         call SubMenu(1)
         read(*,180) opSubMenu
180       format(I1)
         select case (opSubMenu)
          case (1)
           call formLivros 
          case (2)
            bSOp=.false.
          case (3)
            do while (bSOp)
              call SubMenu(5)
              read(*,190) opSubMenu
190           format(I1)
              select case (opSubMenu)
               case (1)
                bSOp=.false.
               case (2)
                bSOp=.false.
               case (3)
                bSOp=.false.
               case (4)
                bSOp=.false.
               case (5)
                bSOp=.false.
               case (6)
                bSOp=.false.
               case default
                write(*,*) 'Erro --> Opcao invalida digite de novo'
              end select
            end do
          case (4)
            bSOp=.false.
          case default
            write(*,*) 'Erro --> Opcao invalida digite de novo'
         end select
       end do
      else if (num.eq.2) then
       do while (bSOp)
         call SubMenu(2)
         read(*,200) opSubMenu
200       format(I1)
         select case (opSubMenu)
          case (1)
            bSOp=.false.
          case (2)
            bSOp=.false.
          case (3)
            do while (bSOp)
              call SubMenu(6)
              read(*,210) opSubMenu
210            format(I1)
              select case (opSubMenu)
               case (1)
                bSOp=.false.
               case (2)
                bSOp=.false.
               case (3)
                bSOp=.false.
               case (4)
                bSOp=.false.
               case (5)
                bSOp=.false.
               case default
                write(*,*) 'Erro --> Opcao invalida digite de novo'
              end select
            end do
          case (4)
            bSOp=.false.
          case default
            write(*,*) 'Erro --> Opcao invalida digite de novo'
         end select
       end do
      else if (num.eq.3) then
       do while (bSOp)
         call SubMenu(3)
         read(*,220) opSubMenu
220      format(I1)
         select case (opSubMenu)
          case (1)
            bSOp=.false.
          case (2)
            bSOp=.false.
          case (3)
            bSOp=.false.
          case (4)
            bSOp=.false.
          case default
            write(*,*) 'Erro --> Opcao invalida digite de novo'
         end select
       end do
      else if (num.eq.4) then       
       do while (bSOp)
         call SubMenu(4)
         read(*,230) opSubMenu
230       format(I1)
         select case (opSubMenu)
          case (1)
           call formSobre
           bSOp=.false.
          case (2)          
           stop
          case (3)
           bSOp=.false.
          case default
            write(*,*) 'Erro --> Opcao invalida digite de novo'
         end select
       end do
      end if
      return
      end
 
