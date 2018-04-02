/*
  Implementacao da classe EmprestimosRec
*/

package biblio;
import java.io.*;

public class EmprestimosRec {

  public EmprestimosRec() {
    nTamEmprestimos=0;
  }

  /* Registro de Emprestimos */
  int NinscUsuario;    /* Numero de inscricao do Usuario (5) */
  int NinscLivro;      /* Numero de inscricao do Livro (5) */
  String DtEmprestimo; /* Data de Emprestimo do Livro (10) */
  String DtDevolucao;  /* Data de Devolucao do Livro (10) */
  boolean Removido;    /* Removido - Indica exclusao logica */

  InputStream EmprestimosFile;
  int nTamEmprestimos;

}