C     ----------------
C     Modulo de Livros
C     ----------------

      subroutine formLivros
      integer qLivros,cont
      logical bOp

      write(*,10) 
10    format(1X,'Ú',76('Ä'),'¿')
      write(*,*) '³ Cadastro de Livros                                  '
     *                       ³'
      write(*,20) 
20    format(1X,'À',76('Ä'),'Ù')
      write(*,*)
      bOp=.true.
      do while (bOp)
       write(*,*) 'Deseja cadastrar quantos livros (maximo de 99999) ?'
       read(*,30) qLivros
30     format(I10)
       if (qLivros.lt.1 .or. qLivros.gt.99999) then
         write(*,*) 'Erro --> Numero invalido digite de novo'
       else
         bOp=.false.
       end if
      end do
      do cont=1,qLivros
       write(*,40) cont,nTamLivros+1
40     format('(',I5.1,') Numero de Inscricao do Livro : ',I5)

       bOp=.true.
       do while (bOp)
        write(*,*) 'Titulo do Livro (maximo de 30) : '
        read(*,50) Livros.Titulo
50      format(A30)
        if (len(Livros.Titulo).le.0 .or. len(Livros.Titulo).gt.30) then
          write(*,*) 'Erro --> Tamanho do texto invalido digite de novo'
        else
          bOp=.false.
        end if
       end do

       bOp=.true.
       do while (bOp)
        write(*,*) 'Autor do Livro (maximo de 30) : '
        read(*,60) Livros.Autor
60      format(A30)
        if (len(Livros.Autor).le.0 .or. len(Livros.Autor).gt.30) then
          write(*,*) 'Erro --> Tamanho do texto invalido digite de novo'
        else
          bOp=.false.
        end if
       end do

       bOp=.true.
       do while (bOp)
        write(*,*) 'Area do Livro (maximo de 30) : '
        read(*,70) Livros.Area
70      format(A30)
        if (len(Livros.Area).le.0 .or. len(Livros.Area).gt.30) then
          write(*,*) 'Erro --> Tamanho do texto invalido digite de novo'
        else
          bOp=.false.
        end if
       end do

       bOp=.true.
       do while (bOp)
        write(*,*) 'Palavra Chave do Livro (maximo de 10) : '
        read(*,80) Livros.PChave
80      format(A10)
        if (len(Livros.PChave).le.0 .or. len(Livros.PChave).gt.10) then
          write(*,*) 'Erro --> Tamanho do texto invalido digite de novo'
        else
          bOp=.false.
        end if
       end do

       bOp=.true.
       do while (bOp)
        write(*,*) 'Numero da Edicao do Livro (maximo de 4) : '
        read(*,90) Livros.Edicao
90      format(I5)
        if (Livros.Edicao.le.0 .or. Livros.Edicao.gt.4) then
          write(*,*) 'Erro --> Tamanho do Numero invalido digite de novo'
        else
          bOp=.false.
        end if
       end do

      end do
      return
      end
