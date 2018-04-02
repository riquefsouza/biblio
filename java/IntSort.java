// Exemplo de Programa em Java
// Entrada: um numero inteiro (integer), listlen, em que
//          listlen e menor do que 100, seguido de valores
//          length-integer
// Saida:   O numero e valores de entrada que sao maiores de
//          que a media de todos os valores de entrada

import java.io.*;

class IntSort {
public static void main(String args[]) throws IOException {
   DataInputStream in = new DataInputStream(System.in);
   int listlen, contador, soma = 0, media, resultado = 0;
   int[] intlist = new int[99];
   listlen = Integer.parseInt(in.readLine());
   if ((listlen > 0) && (listlen < 100)) {
   /* Leia a entrada em um array e compute a soma */
       for (contador = 0; contador < listlen; contador++) {
         intlist[contador] = Integer.valueOf(in.readLine()).intValue();
         soma += intlist[contador];
       }
   /* calcule a media */
       media = soma / listlen;
   /* conte os valores de entrada que sao > do que a media */
       for (contador = 0; contador < listlen; contador++) 
         if (intlist[contador] > media) resultado++;
   /* imprima o resultado */
         System.out.println("\nNumero de valores > do que a media e:" +
         resultado);
   }
   else
    System.out.println("Erro - o tamanho a lista de entrada nao e valido\n");
 }
}


