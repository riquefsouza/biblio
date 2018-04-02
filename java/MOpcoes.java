/*
  Implementacao da classe MOpcoes
*/

package biblio;
import java.io.*;

public class MOpcoes extends Graficos {

  public static File SobreFile1;
  public static InputStream SobreFile;

  public MOpcoes() {
  }

  /*
   Nome : formSobre
   Descricao : metodo que desenha o formulario de Sobre.
  */
  public void formSobre() throws IOException
  {
   int cont,ftam;
   char linha;

   AbrirArquivo();

   cont=0;
   ftam=SobreFile.available();
   while (cont!=ftam)
   {
     linha=(char) SobreFile.read();
     cont++;
     if (cont==764)
     {
       System.out.println("");
       System.out.println("Pressione para continuar...");
       LerStr();
     }
     else if(linha=='\n')
       System.out.println("");
     else
       System.out.print(linha);
   }
   System.out.println("");
   System.out.println("Pressione para continuar...");
   LerStr();
 
  }

  /*
   Nome : AbrirArquivo
   Descricao : metodo que Abri o tipo de arquivo selecionado.
  */
  public static void AbrirArquivo() throws IOException
  {
   SobreFile1 = new File("/jbuilder2/myclasses/biblio/Sobre.dat");
   SobreFile = new FileInputStream(SobreFile1);
   if (SobreFile1.exists()==false)
     System.out.println("O Arquivo de Sobre nao pode ser aberto");
  }


}
