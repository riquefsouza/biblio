# biblio
Library Automation System Console ANSI


1)	Módulo de controle de acervo da biblioteca

O acervo da biblioteca é composto de livros. Antes de ser colocado a disposição do público, ao ser adquirido, o livro deve ser cadastrado. O cadastro de um livro contém as seguintes informações: título, autor ou autores (no máximo 3), área, palavras-chave (no máximo 3), edição, ano da publicação, editora, volume, número de inscrição no acervo da biblioteca e estado atual (disponível, emprestado). O número de inscrição é calculado automaticamente, somando-se um ao número do último livro cadastrado. 
   É possível, a qualquer momento, alterar as informações relativas a qualquer item do acervo. 
   Não deve ser possível excluir um item do acervo. 
   As consultas ao acervo podem ser feitas por: título, autor, área ou palavra-chave. Se algum item do acervo satisfizer a consulta, os dados sobre o(s) mesmo(s) deve(m) ser exibidos.

2)	Módulo de controle dos usuários da biblioteca

Para retirar livros da biblioteca, é necessário que a pessoa seja um usuário cadastrado. O cadastro de um usuário deve conter as seguintes informações: nome, identidade, endereço completo (logradouro, número, complemento, bairro, cep), telefone para contato, categoria de usuario (aluno, professor, funcionário), número de inscrição na biblioteca e situação de usuário (número de livros em sua posse). O número de inscrição é calculado automaticamente, somando-se um ao número do último usuário cadastrado.
   O sistema deve permitir, sempre que necessário, a alteração das informações contidas no cadastro de um usuário.
   A consulta aos dados de um usuário pode ser feita a partir de seu nome, de seu número de identidade ou de seu número de inscrição na biblioteca. Se algum usuário satisfizer a pesquisa, seus dados completos devem ser exibidos.

3)	Módulo de controle de empréstimos e devoluções

Regras de empréstimo :
1.	Um usuário pode Ter em sua posse, no máximo, quatro livros.
2.	O período de empréstimo varia conforme a categoria do usuário : uma semana para funcionário, duas semanas para estudante e um mês para professores.
O empréstimo de livros é feito da seguinte forma :
1.	Entra-se com o número de inscrição do usuário e o título do livro. Se o usuário estiver apto (livros < 4) a levar o livro e o livro estiver disponível, então o empréstimo é efetuado.
2.	O cadastro de um empréstimo tem os seguintes dados : número de inscrição do usuário, título do livro, data do empréstimo e a data de devolução.
3.	Ao ser efetuado o empréstimo, os dados do usuário (quantidade de livros em seu poder) e os dados do livro (estado atual) devem ser atualizados. Se o usuário estiver em atraso, deve ser cobrada uma multa de R$ 0,50 (cinqüenta centavos) por cada dia de atraso.
4.	Quando o usuário devolver o livro a biblioteca. Seus dados (quantidade de livros em seu poder) e os dados do livro (estado atual) devem ser atualizados. O cadastro do empréstimo deve ser excluído.

Tabela de Enderecos 

Logra : string;     { Logradouro (30) }
Numero : integer;   { Numero do Endereco (5) }
Compl : string;     { Complemento (10) }
Bairro : string;    { Bairro do Endereco (20) }
Cep : string;       { Cep do Endereco (8) }

tabela de Livros 

Ninsc : integer;    { Numero de Inscricao do Livro (5) }
Titulo : string;    { Titulo do Livro (30) }
Autor : string;     { Autor do Livro (30) }
Area : string;      { Area de atuacao do Livro (30) }
PChave : string;    { Palavra-Chave para pesquisar o Livro (10) }
Edicao : integer;   { Edicao do Livro (4) }
AnoPubli : integer; { Ano de Publicacao do Livro (4) }
Editora : String;   { Editora do Livro (30) }
Volume : integer;   { Volume do Livro (4) }
Estado : char;      { Estado Atual - (D)isponivel ou (E)mprestado (1) }

tabela de Usuarios 

Ninsc : integer;       { Numero de inscricao do Usuario (5) }
Nome : string;         { Nome completo do Usuario (30) }
Ident : string;        { Identidade do Usuario (10) }
Endereco : rEnderecos; { Endereco completo do Usuario (73) }
Telefone : string;     { Telefone do Usuario (11) }
Categoria : char;   { Categoria - (A)luno,(P)rofessor,(F)uncionario (1) }
Situacao : integer;    { Situacao - Numero de Livros em sua posse (1) }

tabela de Emprestimos 

NinscUsuario : integer; { Numero de inscricao do Usuario (5) }
NinscLivro : integer;   { Numero de inscricao do Livro (5) }
DtEmprestimo : date;    { Data de Emprestimo do Livro (10) }
DtDevolucao : date;     { Data de Devolucao do Livro (10) }




