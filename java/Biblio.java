/*
  Nome : Sistema de Automacao de Biblioteca (Biblio)
  Autor : Henrique Figueiredo de Souza
  Linguagem : Java
  Compilador :
  Data de Realizacao : 4 de setembro de 1999
  Ultima Atualizacao : 15 de fevereiro de 2000
  Versao do Sistema : 1.0
  Nome do(s) Arquivo(s) e Como Compilar (nesta ordem) :
  1. Rotinas.java  --> ""
  2. Graficos.java --> ""
  3. MLivros.java  --> ""
  4. MUsuario.java --> ""
  5. MEmprest.java --> ""
  6. MOpcoes.java  --> ""
  7. biblio.java   --> ""

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
*/
/* Implementacao da classe Biblio */

package biblio;
import biblio.Graficos;

public class Biblio {

  public Biblio() {
  }

  public static void main(String[] args) throws Exception {
   Graficos vGraficos = new Graficos();
   boolean bOp;
   String opMenu;

   vGraficos.formSplash();
   vGraficos.Cabecalho("Sistema de Automacao de Biblioteca");
   bOp=true;
   while(bOp)
   {
     vGraficos.Menu();
     opMenu=vGraficos.LerStr();
     if (opMenu.equals("A") || opMenu.equals("a"))
       ControlaMenus(1);
     else if (opMenu.equals("U") || opMenu.equals("u"))
       ControlaMenus(2);
     else if (opMenu.equals("E") || opMenu.equals("e")) 
       ControlaMenus(3);
     else if (opMenu.equals("O") || opMenu.equals("o")) 
       ControlaMenus(4);
     else
       System.out.println("Erro --> Opcao invalida digite de novo");   
   }

  }

  /*
   Nome : ControlaMenus
   Descricao : metodo que escreve as linhas de opcoes do submenu
   Parametros :
   num - indica o numero do submenu
  */
  public static void ControlaMenus(int num) throws Exception
  {
   int opSubMenu;
   boolean bSOp;
   Graficos vGraficos = new Graficos();
   MLivros vMLivros = new MLivros();
   MOpcoes vMOpcoes = new MOpcoes();

   bSOp=true;
   if(num==1)
   {
     while(bSOp)
     {
       vGraficos.SubMenu(1);
       opSubMenu=vGraficos.LerInt();
       switch(opSubMenu)
       {
        case 1: vMLivros.formLivros(); break;
        case 2: bSOp=false; break;
        case 3:
         {
           while(bSOp)
            {
              vGraficos.SubMenu(5);
              opSubMenu=vGraficos.LerInt();
              switch(opSubMenu)
              {
               case 1: bSOp=false; break;
               case 2: bSOp=false; break;
               case 3: bSOp=false; break;
               case 4: bSOp=false; break;
               case 5: bSOp=false; break;
               case 6: bSOp=false; break;
               default:
                System.out.println("Erro --> Opcao invalida digite de novo");
                break;
              }
            }
         }
        case 4: bSOp=false; break;
        default:
          System.out.println("Erro --> Opcao invalida digite de novo");
          break;
       }
     }
   }
   else if (num==2)
   {
     while(bSOp)
     {
       vGraficos.SubMenu(2);
       opSubMenu=vGraficos.LerInt();
       switch(opSubMenu)
        {
          case 1: bSOp=false; break;
          case 2: bSOp=false; break;
          case 3:
            {
              while(bSOp)
              {
               vGraficos.SubMenu(6);
               opSubMenu=vGraficos.LerInt();
               switch(opSubMenu)
               {
                case 1: bSOp=false; break;
                case 2: bSOp=false; break;
                case 3: bSOp=false; break;
                case 4: bSOp=false; break;
                case 5: bSOp=false; break;
                default:
                  System.out.println("Erro --> Opcao invalida digite de novo");
                  break;
               }
              }
            }
          case 4: bSOp=false; break;
          default:
           System.out.println("Erro --> Opcao invalida digite de novo");
           break;
        }
     }
   }
   else if (num==3)
   {
     while(bSOp)
     {
       vGraficos.SubMenu(3);
       opSubMenu=vGraficos.LerInt();
       switch(opSubMenu)
        {
          case 1: bSOp=false; break;
          case 2: bSOp=false; break;
          case 3: bSOp=false; break;
          case 4: bSOp=false; break;
          default:
           System.out.println("Erro --> Opcao invalida digite de novo");
           break;
        }
     }
    }
   else if (num==4)
   {
     while(bSOp)
     {
       vGraficos.SubMenu(4);
       opSubMenu=vGraficos.LerInt();
       switch(opSubMenu)
       {
         case 1: vMOpcoes.formSobre(); bSOp=false; break;
         case 2: System.exit(0); break;
         case 3: bSOp=false; break;
         default:
          System.out.println("Erro --> Opcao invalida digite de novo");
          break;
       }
     }
   }
  }
  
}
