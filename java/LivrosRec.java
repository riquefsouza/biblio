/*
  Implementacao da classe LivrosRec
*/

package biblio;
import java.io.*;

public class LivrosRec {

  public LivrosRec() {
    nTamLivros=0;
  }

  /* Registro de Livros */
  int Ninsc;        /* Numero de Inscricao do Livro (5) */
  String Titulo;    /* Titulo do Livro (30) */
  String Autor;     /* Autor do Livro (30) */
  String Area;      /* Area de atuacao do Livro (30) */
  String PChave;    /* Palavra-Chave para pesquisar o Livro (10) */
  int Edicao;       /* Edicao do Livro (4) */
  int AnoPubli;     /* Ano de Publicacao do Livro (4) */
  String Editora;   /* Editora do Livro (30) */
  int Volume;       /* Volume do Livro (4) */
  char Estado;      /* Estado Atual - (D)isponivel ou (E)mprestado */

  InputStream LivrosFile;
  int nTamLivros;

}
