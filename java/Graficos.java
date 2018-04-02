/*
  Implementacao da classe Graficos
*/


package biblio;

public class Graficos extends Rotinas {

  public Graficos() {

  }

  /*
   Nome : formSplash
   Descricao : metodo que desenha a tela inicial do sistema.
  */
  public void formSplash() {
   int cont;

   System.out.println("ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿");
   System.out.println("³  ²²²²²²²     ²    ²²²²²²²     ²       ²    ²²²²²²      ³");
   System.out.println("³ ²²²    ²²²   ²²  ²²²    ²²²   ²²      ²²  ²²²  ²²²     ³");
   System.out.println("³ ²²²²²²²²²    ²²  ²²²²²²²²²    ²²      ²²  ²²    ²²     ³");
   System.out.println("³ ²²²    ²²²   ²²  ²²²    ²²²   ²²²     ²²  ²²    ²²     ³");
   System.out.println("³ ²²²²   ²²²   ²²  ²²²²   ²²²   ²²²²    ²²  ²²²  ²²²     ³");
   System.out.println("³  ²²²²²²²²²   ²²   ²²²²²²²²²   ²²²²²²  ²²   ²²²²²²      ³");
   System.out.println("³ Programa Desenvolvido por Henrique Figueiredo de Souza ³");
   System.out.println("³ Todos os Direitos Reservados - 1999   Versao 1.0       ³");
   System.out.println("³ Linguagem Usada Nesta Versao << Java >>                ³");
   System.out.println("ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ");
   for(cont=1;cont<=12;cont++)
      System.out.println("");
   System.out.println("Pressione para continuar...");
   LerStr();
  }

  /*
   Nome : Menu
   Descricao : procedimento que escreve a linha de opcoes do menu.
  */
  public void Menu()
  {
    System.out.print("ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ");
    System.out.println("ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿"); 
    System.out.print("³ (A)cervo  (U)suarios  (E)mprestimos e Devolucoes  ");
    System.out.println("(O)pcoes                 ³");
    System.out.print("ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ");
    System.out.println("ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ");  
    System.out.print("Escolha uma opcao > ");
  }

  /*
   Nome : SubMenu
   Descricao : procedimento que escreve as linhas de opcoes do submenu
   Parametros :
   num - indica o numero do submenu
  */
  public void SubMenu(int num)
  {
   if (num==1)
   {
     System.out.println("ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿");
     System.out.println("³ 1. Cadastrar livros   ³");
     System.out.println("³ 2. Alterar livros     ³");
     System.out.println("³ 3. Consultar livros > ³");
     System.out.println("³ 4. Voltar ao menu     ³");
     System.out.println("ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ");
   }
   else if(num==2) 
   {
     System.out.println("ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿");
     System.out.println("³ 1. Cadastrar usuarios   ³");
     System.out.println("³ 2. Alterar usuarios     ³");
     System.out.println("³ 3. Consultar usuarios > ³");
     System.out.println("³ 4. Voltar ao menu       ³");
     System.out.println("ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ");
   }
   else if(num==3) 
   {
     System.out.println("ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿");
     System.out.println("³ 1. Emprestar livros                   ³");
     System.out.println("³ 2. Devolver livros                    ³");
     System.out.println("³ 3. Consultar Emprestimos e Devolucoes ³");
     System.out.println("³ 4. Voltar ao menu                     ³");
     System.out.println("ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ");
   }
   else if(num==4) 
   {
     System.out.println("ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿");
     System.out.println("³ 1. Sobre o sistema ³");
     System.out.println("³ 2. Sair do sistema ³");
     System.out.println("³ 3. Voltar ao menu  ³");
     System.out.println("ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ");
   }
   else if(num==5)
   {
     System.out.println("ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿");
     System.out.println("³ 1. Todos os livros   ³");
     System.out.println("³ 2. Por Titulo        ³");
     System.out.println("³ 3. Por Autor         ³");
     System.out.println("³ 4. Por Area          ³");
     System.out.println("³ 5. Por Palavra-chave ³");
     System.out.println("³ 6. Voltar ao menu    ³");
     System.out.println("ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ");
   }
   else if(num==6)
   {
     System.out.println("ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿");
     System.out.println("³ 1. Todos os Usuarios       ³");
     System.out.println("³ 2. Por Numero de Inscricao ³");
     System.out.println("³ 3. Por Nome                ³");
     System.out.println("³ 4. Por Identidade          ³");
     System.out.println("³ 5. Voltar ao menu          ³");
     System.out.println("ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ");
   }  
   System.out.println("Escolha uma opcao > ");
  }

} 
