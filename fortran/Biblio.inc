C     -------------------
C     Declaracao de tipos
C     -------------------

C     ------------------------
C     Registro de Enderecos 
C      Logradouro (30)
C      Numero do Endereco (5)
C      Complemento (10) 
C      Bairro do Endereco (20)
C      Cep do Endereco (8)
C     ------------------------
C      structure /Enderecos/
C        character*30 Logra   
C        integer*5 Numero
C        character*10 Compl
C        character*20 Bairro
C        character*8 Cep
C      end structure
C     ------------------------------------------------
C     Registro de Livros
C      Numero de Inscricao do Livro (5)
C      Titulo do Livro (30)
C      Autor do Livro (30)
C      Area de atuacao do Livro (30) 
C      Palavra-Chave para pesquisar o Livro (10)
C      Edicao do Livro (4)
C      Ano de Publicacao do Livro (4)
C      Editora do Livro (30)
C      Volume do Livro (4)
C      Estado Atual - (D)isponivel ou (E)mprestado (1)
C     ------------------------------------------------
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
C     --------------------------------------------------
C     Registro de Usuarios
C      Numero de inscricao do Usuario (5) 
C      Nome completo do Usuario (30)
C      Identidade do Usuario (10)
C      Endereco completo do Usuario (73)
C      Telefone do Usuario (11)
C      Categoria - (A)luno,(P)rofessor,(F)uncionario (1)
C      Situacao - Numero de Livros em sua posse (1) 
C     --------------------------------------------------
C      structure /UsuariosRec/
C        integer*5 Ninsc
C        character*30 Nome
C        character*10 Ident
C        record /Enderecos/ Endereco    
C        character*11 Telefone
C        character*1 Categoria
C        integer*1 Situacao
C      end structure
C     -----------------------------------
C     Registro de Emprestimos
C      Numero de inscricao do Usuario (5)
C      Numero de inscricao do Livro (5)
C      Data de Emprestimo do Livro (10)
C      Data de Devolucao do Livro (10)
C      Removido - Indica exclusao logica 
C     -----------------------------------
C      structure /EmprestimosRec/
C        integer*5 NinscUsuario
C        integer*5 NinscLivro
C        character*10 DtEmprestimo
C        character*10 DtDevolucao
C        logical*1 Removido
C      end structure
C     -------------------------------
C     Declaracao de variaveis globais
C     -------------------------------
      logical bOp
C     -----------------
C     variaveis de menu 
C     -----------------
      character opMenu*1
C     -----------------------------
C     variaveis do modulo de livros
C     -----------------------------
      record /LivrosRec/ Livros
C      character LivrosFile*12
      common nTamLivros
C      character vLivros(10)*30
C     -------------------------------
C     variaveis do modulo de Usuarios
C     -------------------------------
C      record /UsuariosRec/ Usuarios
C      character UsuariosFile*12
      common nTamUsuarios
C      character vUsuarios(11)*30
C     ----------------------------------
C     variaveis do modulo de Emprestimos 
C     ----------------------------------
C      record /EmprestimosRec/ Emprestimos
C      character EmprestimosFile*12
      common nTamEmprestimos
C      character vEmprestimos(5)*10
C     -----------------------------
C     variaveis do modulo de Opcoes 
C     -----------------------------
C      character SobreFile*12

C     -----------------------------
C     declaracao das funcoes
C     -----------------------------

