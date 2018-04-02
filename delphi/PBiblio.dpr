{
  Nome : Sistema de Automacao de Biblioteca (Biblio)
  Autor : Henrique Figueiredo de Souza
  Linguagem : Pascal
  Compiladores : Borland Turbo Pascal
                 Free Pascal Compiler
  Data de Realizacao : 4 de setembro de 1999
  Ultima Atualizacao : 15 de fevereiro de 2000
  Versao do Sistema : 1.0
  Nome do(s) Arquivo(s) e Como Compilar (nesta ordem) :
  1. Biblio.pas --> "tpc biblio.pas"
  1. Biblio.pas --> "ppc386 biblio.pas"

  Descricao :
  O Sistema e composto dos seguintes modulos:
  1.Modulo de Livros da Biblioteca
    Onde se realiza a manutencao dos livros da biblioteca
  2.Modulo de Usuarios da Bilioteca
    Onde se realiza a manutencao dos usuarios da biblioteca
  3.Modulo de Emprestimos e Devolucoes da Biblioteca
    Onde se efetua os emprestimos e devolucoes da biblioteca
  4.Modulo de Opcoes do sistema
    Onde e possivel ver sobre o sistema e sair dele
}

program PBiblio;

uses
  Forms,
  Biblio in 'Biblio.pas' {Form1};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
