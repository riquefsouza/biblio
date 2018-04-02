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

   System.out.println("��������������������������������������������������������Ŀ");
   System.out.println("�  �������     �    �������     �       �    ������      �");
   System.out.println("� ���    ���   ��  ���    ���   ��      ��  ���  ���     �");
   System.out.println("� ���������    ��  ���������    ��      ��  ��    ��     �");
   System.out.println("� ���    ���   ��  ���    ���   ���     ��  ��    ��     �");
   System.out.println("� ����   ���   ��  ����   ���   ����    ��  ���  ���     �");
   System.out.println("�  ���������   ��   ���������   ������  ��   ������      �");
   System.out.println("� Programa Desenvolvido por Henrique Figueiredo de Souza �");
   System.out.println("� Todos os Direitos Reservados - 1999   Versao 1.0       �");
   System.out.println("� Linguagem Usada Nesta Versao << Java >>                �");
   System.out.println("����������������������������������������������������������");
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
    System.out.print("�������������������������������������������������������");
    System.out.println("���������������������Ŀ"); 
    System.out.print("� (A)cervo  (U)suarios  (E)mprestimos e Devolucoes  ");
    System.out.println("(O)pcoes                 �");
    System.out.print("�������������������������������������������������������");
    System.out.println("�����������������������");  
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
     System.out.println("�����������������������Ŀ");
     System.out.println("� 1. Cadastrar livros   �");
     System.out.println("� 2. Alterar livros     �");
     System.out.println("� 3. Consultar livros > �");
     System.out.println("� 4. Voltar ao menu     �");
     System.out.println("�������������������������");
   }
   else if(num==2) 
   {
     System.out.println("�������������������������Ŀ");
     System.out.println("� 1. Cadastrar usuarios   �");
     System.out.println("� 2. Alterar usuarios     �");
     System.out.println("� 3. Consultar usuarios > �");
     System.out.println("� 4. Voltar ao menu       �");
     System.out.println("���������������������������");
   }
   else if(num==3) 
   {
     System.out.println("���������������������������������������Ŀ");
     System.out.println("� 1. Emprestar livros                   �");
     System.out.println("� 2. Devolver livros                    �");
     System.out.println("� 3. Consultar Emprestimos e Devolucoes �");
     System.out.println("� 4. Voltar ao menu                     �");
     System.out.println("�����������������������������������������");
   }
   else if(num==4) 
   {
     System.out.println("��������������������Ŀ");
     System.out.println("� 1. Sobre o sistema �");
     System.out.println("� 2. Sair do sistema �");
     System.out.println("� 3. Voltar ao menu  �");
     System.out.println("����������������������");
   }
   else if(num==5)
   {
     System.out.println("����������������������Ŀ");
     System.out.println("� 1. Todos os livros   �");
     System.out.println("� 2. Por Titulo        �");
     System.out.println("� 3. Por Autor         �");
     System.out.println("� 4. Por Area          �");
     System.out.println("� 5. Por Palavra-chave �");
     System.out.println("� 6. Voltar ao menu    �");
     System.out.println("������������������������");
   }
   else if(num==6)
   {
     System.out.println("����������������������������Ŀ");
     System.out.println("� 1. Todos os Usuarios       �");
     System.out.println("� 2. Por Numero de Inscricao �");
     System.out.println("� 3. Por Nome                �");
     System.out.println("� 4. Por Identidade          �");
     System.out.println("� 5. Voltar ao menu          �");
     System.out.println("������������������������������");
   }  
   System.out.println("Escolha uma opcao > ");
  }

} 
