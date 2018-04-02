/*
  Implementacao da classe Rotinas
*/

package biblio;
import java.util.Date;
import java.io.*;

public class Rotinas {

  public Rotinas() {
  }

  /*
   Nome : LerInt
   Descricao : metodo de leitura de inteiros.
  */
  public static int LerInt() {
    byte[] bytes = new byte[160];
     try{
        System.in.read(bytes);
     } catch(Exception e)  {
        System.out.println("Erro : " + e);
     }
    char[] caracts = new char[160];
    for (int i=0;i<160;i++)
      caracts[i]= (char) bytes[i];
    String str = new String(caracts);
    return (Integer.parseInt(str.trim()));
  }

  /*
   Nome : LerStr
   Descricao : metodo de leitura de strings.
  */
  public static String LerStr(){
    byte[] bytes = new byte[160];
    try{
       System.in.read(bytes);
    }catch(Exception e)  {
     System.out.println("Erro : " + e);
    }
    char[] caracts = new char[160];
    for (int i=0;i<160;i++)
     caracts[i]= (char) bytes[i];
    String str =(new String(caracts)).trim();
    return str;
  }

  /*
   Nome : LerDouble
   Descricao : metodo de leitura de numeros com ponto flutuante.
  */
  public static double LerDouble() {
     byte[] bytes = new byte[160];
     try{
        System.in.read(bytes);
     } catch(Exception e)  {
        System.out.println("Erro : " + e);
     }
    char[] caracts = new char[160];
    for (int i=0;i<160;i++)
      caracts[i]= (char) bytes[i];
    String str = new String(caracts);
    Double dobro =  Double.valueOf(str.trim());
    return (dobro.doubleValue());
  }

  /*
   Nome : cabecalho
   Descricao : metodo que escreve o texto de cabecalho do sistema.
   Parametros :
   texto - o texto do cabecalho
  */
  public void Cabecalho(String texto) {
   Date tempo = new Date();
   String datahora,dia,data,mes,ano,hora;

   datahora=tempo.toString();
   dia=datahora.substring(8,10);
   mes=datahora.substring(4,7);
   if(mes.equals("Jan")==true) mes="01";
   if(mes.equals("Feb")==true) mes="02";
   if(mes.equals("Mar")==true) mes="03";
   if(mes.equals("Apr")==true) mes="04";
   if(mes.equals("May")==true) mes="05";
   if(mes.equals("Jun")==true) mes="06";
   if(mes.equals("Jul")==true) mes="07";
   if(mes.equals("Aug")==true) mes="08";
   if(mes.equals("Sep")==true) mes="09";
   if(mes.equals("Oct")==true) mes="10";
   if(mes.equals("Nov")==true) mes="11";
   if(mes.equals("Dez")==true) mes="12";
   ano=datahora.substring(24,28);
   data=dia + "/" + mes + "/" + ano;
   hora=datahora.substring(11,19);

   System.out.print("ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ");
   System.out.println("ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿");
   System.out.println("³ " + data + "           " + texto + "           " + hora + " ³");
   System.out.print("ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ");
   System.out.println("ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ");
  }

  /*
   Nome : tamArquivo
   Descricao : funcao que retorna o tamanho de um arquivo
   Parametros :
   Arq - o nome do arquivo
   tam - tamanho do registro
  */
  public static int tamArquivo(InputStream Arq,int tam) throws IOException
  {
   int cont,ftam;
   byte Local[] = new byte[tam];

   cont=0;
   ftam=Arq.available();
   if(ftam!=0){
    while((cont*tam)!=ftam){
     Arq.read(Local,(tam*cont),tam);
     cont++;
    }
   }

   return cont;
  }

}
