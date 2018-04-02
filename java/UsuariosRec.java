/*
  Implementacao da classe UsuariosRec
*/

package biblio;
import java.io.*;

public class UsuariosRec {

  public UsuariosRec() {
    nTamUsuarios=0;
  }

  /* Registro de Enderecos */
  /* Endereco completo do Usuario (73) */
  String Logra;  /* Logradouro (30) */
  int Numero;    /* Numero do Endereco (5) */
  String Compl;  /* Complemento (10) */
  String Bairro; /* Bairro do Endereco (20) */
  String Cep;    /* Cep do Endereco (8) */

  /* Registro de Usuarios */
  int Ninsc;       /* Numero de inscricao do Usuario (5) */
  String Nome;     /* Nome completo do Usuario (30) */
  String Ident;    /* Identidade do Usuario (10) */
  String Telefone; /* Telefone do Usuario (11) */
  char Categoria;  /* Categoria - (A)luno,(P)rofessor,(F)uncionario */
  int Situacao;    /* Situacao - Numero de Livros em sua posse (1) */

  InputStream UsuariosFile;
  int nTamUsuarios;

}