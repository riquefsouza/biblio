C     ------------------
C     Modulo de Graficos
C     ------------------

C     ---------------------------------------------------------------
C     Nome : formSplash
C     Descricao : procedimento que desenha a tela inicial do sistema.
C     ---------------------------------------------------------------
      subroutine formSplash
      integer cont

      write(*,*) '������������������������������������������������������'
     *��Ŀ'
      write(*,*) '�  �������     �    �������     �       �    ������   '
     *   �'
      write(*,*) '� ���    ���   ��  ���    ���   ��      ��  ���  ���  '
     *   �'
      write(*,*) '� ���������    ��  ���������    ��      ��  ��    ��  '
     *   �'
      write(*,*) '� ���    ���   ��  ���    ���   ���     ��  ��    ��  '
     *   �'
      write(*,*) '� ����   ���   ��  ����   ���   ����    ��  ���  ���  '
     *   �'
      write(*,*) '�  ���������   ��   ���������   ������  ��   ������   '
     *   �'
      write(*,*) '� Programa Desenvolvido por Henrique Figueiredo de Sou'
     *za �'
      write(*,*) '� Todos os Direitos Reservados - 1999   Versao 1.0    '
     *   �'
      write(*,*) '� Linguagem Usada Nesta Versao << FORTRAN >>          '
     *   �'
      write(*,*) '������������������������������������������������������'
     *����'
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
20    format(1X,'�',76('�'),'�')
      write(*,*) '� (A)cervo  (U)suarios  (E)mprestimos e Devolucoes  (O'
     *)pcoes                 �'
      write(*,40) 
40    format(1X,'�',76('�'),'�')
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
        write(*,*) '�����������������������Ŀ'
        write(*,*) '� 1. Cadastrar livros   �'
        write(*,*) '� 2. Alterar livros     �'
        write(*,*) '� 3. Consultar livros > �'
        write(*,*) '� 4. Voltar ao menu     �'
        write(*,*) '�������������������������'
      else if (num.eq.2) then
        write(*,*) '�������������������������Ŀ'
        write(*,*) '� 1. Cadastrar usuarios   �'
        write(*,*) '� 2. Alterar usuarios     �'
        write(*,*) '� 3. Consultar usuarios > �'
        write(*,*) '� 4. Voltar ao menu       �'
        write(*,*) '���������������������������'
      else if (num.eq.3) then
        write(*,*) '���������������������������������������Ŀ'
        write(*,*) '� 1. Emprestar livros                   �'
        write(*,*) '� 2. Devolver livros                    �'
        write(*,*) '� 3. Consultar Emprestimos e Devolucoes �'
        write(*,*) '� 4. Voltar ao menu                     �'
        write(*,*) '�����������������������������������������'
      else if (num.eq.4) then
        write(*,*) '��������������������Ŀ'
        write(*,*) '� 1. Sobre o sistema �'
        write(*,*) '� 2. Sair do sistema �'
        write(*,*) '� 3. Voltar ao menu  �'
        write(*,*) '����������������������'
      else if (num.eq.5) then
        write(*,*) '����������������������Ŀ'
        write(*,*) '� 1. Todos os livros   �'
        write(*,*) '� 2. Por Titulo        �'
        write(*,*) '� 3. Por Autor         �'
        write(*,*) '� 4. Por Area          �'
        write(*,*) '� 5. Por Palavra-chave �'
        write(*,*) '� 6. Voltar ao menu    �'
        write(*,*) '������������������������'
      else if (num.eq.6) then
        write(*,*) '����������������������������Ŀ'
        write(*,*) '� 1. Todos os Usuarios       �'
        write(*,*) '� 2. Por Numero de Inscricao �'
        write(*,*) '� 3. Por Nome                �'
        write(*,*) '� 4. Por Identidade          �'
        write(*,*) '� 5. Voltar ao menu          �'
        write(*,*) '������������������������������'
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

