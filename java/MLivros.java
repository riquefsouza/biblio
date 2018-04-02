/*
  Implementacao da classe MLivros
*/

package biblio;
import java.io.*;

public class MLivros extends Graficos {

  public static LivrosRec Livros = new LivrosRec();
  public static File LivrosFile;

  public MLivros() {
  }

  /*
   Nome : AbrirArquivo
   Descricao : metodo que Abri o tipo de arquivo selecionado.
  */
  public static void AbrirArquivo() throws IOException
  {
    LivrosFile = new File("/jbuilder2/myclasses/biblio/Livros.dat");
    Livros.LivrosFile = new FileInputStream(LivrosFile);
    if (LivrosFile.exists()==false)
    {
      System.out.println("O Arquivo de Livros nao pode ser aberto");
      System.out.println("Criando o arquivo de Livros");
    }
    Livros.nTamLivros=tamArquivo(Livros.LivrosFile,150);

  }

  public void formLivros() throws IOException
  {
   int qLivros,cont;
   boolean bOp;

   System.out.print("ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ");
   System.out.println("ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿");

   System.out.print("³ Cadastro de Livros                                  ");
   System.out.println("                       ³");
   System.out.print("ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ");
   System.out.println("ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ");
   System.out.println("");

   AbrirArquivo();

   bOp=true;
   qLivros=0;
   while(bOp)
   {
     System.out.print("Deseja cadastrar quantos livros (maximo de 99999) ? ");
     qLivros=LerInt();
     if (qLivros < 1 || qLivros > 99999)
       System.out.println("Erro --> Numero invalido digite de novo");
     else
       bOp=false;
   }

   Livros.nTamLivros=tamArquivo(Livros.LivrosFile,150);
   for(cont=1;cont<=qLivros;cont++)
   {
    Livros.nTamLivros++;
    System.out.println("(" + cont + ") Numero de Inscricao do Livro : " + Livros.nTamLivros);
    Digita_formLivros(cont);
   }

  }

  public static void Digita_formLivros(int cont)
  {
    boolean bOp;

    bOp=true;
    while(bOp)
    {
      System.out.print("(" + cont + ") Titulo do Livro (maximo de 30) : ");
      Livros.Titulo=LerStr();
      if (Livros.Titulo.length()<=0 || Livros.Titulo.length()>30)
        System.out.println("Erro --> Tamanho do texto invalido digite de novo");
      else
        bOp=false;
    }

    bOp=true;
    while(bOp)
    {
      System.out.print("(" + cont + ") Autor do Livro (maximo de 30) : ");
      Livros.Autor=LerStr();
      if (Livros.Autor.length()<=0 || Livros.Autor.length()>30)
        System.out.println("Erro --> Tamanho do texto invalido digite de novo");
      else
        bOp=false;
    }

    bOp=true;
    while(bOp)
    {
      System.out.print("(" + cont + ") Area do Livro (maximo de 30) : ");
      Livros.Area=LerStr();
      if (Livros.Area.length()<=0 || Livros.Area.length()>30)
        System.out.println("Erro --> Tamanho do texto invalido digite de novo");
      else
        bOp=false;
    }

    bOp=true;
    while(bOp)
    {
      System.out.print("(" + cont + ") Palavra Chave do Livro (maximo de 10) : ");
      Livros.PChave=LerStr();
      if (Livros.PChave.length()<=0 || Livros.PChave.length()>10)
        System.out.println("Erro --> Tamanho do texto invalido digite de novo");
      else
        bOp=false;
    }

    bOp=true;
    while(bOp)
    {
     System.out.print("(" + cont + ") Numero da Edicao do Livro (maximo de 4) : ");
     Livros.Edicao=LerInt();
     if (Livros.Edicao<=0 || Livros.Edicao>9999)
       System.out.println("Erro --> Tamanho do Numero invalido digite de novo");
     else
       bOp=false;
    }

  }


}
