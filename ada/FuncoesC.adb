with Interfaces, Interfaces.C, Interfaces.C.Strings, Unchecked_Conversion;
use  Interfaces, Interfaces.C, Interfaces.C.Strings;

package body FuncoesC is

   -- A interface da DJGPP da Stdlib.h --

   function Djgpp_atoi(Cp : in Chars_Ptr) return Integer;
   pragma Import (C, Djgpp_atoi, "atoi");

   procedure Djgpp_itoa(valor: in integer;buffer: in Chars_Ptr;radix: in integer);
   pragma Import (C, Djgpp_itoa, "itoa");

   procedure Djgpp_exit(status: in integer);
   pragma Import (C, Djgpp_exit, "exit");

   -- A interface da DJGPP da conio.h --

   procedure Djgpp_Cputs (Cp : in Chars_Ptr);
   pragma Import (C, Djgpp_Cputs, "cputs");

   procedure Djgpp_Setcursortype(Size : in Integer);
   pragma Import (C, Djgpp_Setcursortype, "_setcursortype");

   procedure Djgpp_Textcolor (Color : in Integer);
   pragma Import (C, Djgpp_Textcolor, "textcolor");

   procedure Djgpp_Textbackground (Color : in Integer);
   pragma Import (C, Djgpp_Textbackground, "textbackground");


   -- stdlib.h --

   function atoi(S : in String) return integer is
     str : chars_ptr := new_string(S);
     i : integer := 0;
   begin
      i:=djgpp_atoi(str);
      free(str);
      return i;
   end atoi;

   procedure itoa(valor: in integer;S: in out string;radix: in integer) is
     i : size_t;
     str : chars_ptr;
   begin
      str:=new_string(S);
      djgpp_itoa(valor,str,radix);
      i:=strlen(str);
      S(1..integer(i)):=value(str);
      free(str);      
   end itoa;

   procedure Adaexit(status: in integer) is 
   begin
      Djgpp_exit(status);
   end Adaexit;

   -- conio.h --

   procedure Cputs (S : in String) is
      Str : chars_ptr := New_String (S);
   begin
      Djgpp_Cputs (Str);
      Free (Str);
   end Cputs;

   procedure Setcursortype (Size : in Cursor_Size) is
   begin
      Djgpp_Setcursortype (Cursor_Size'Enum_rep (Size));
   end Setcursortype;

   procedure Textcolor (Color : in Foreground_Color) is
   begin
      Djgpp_Textcolor (Foreground_Color'Enum_rep (Color));
   end Textcolor;

   procedure Textbackground (Color : in Background_Color) is
   begin
      Djgpp_Textbackground (Background_Color'Enum_rep (Color));
   end Textbackground;

end FuncoesC;
