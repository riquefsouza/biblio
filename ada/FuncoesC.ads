package FuncoesC is

   -- procedimentos e funcoes da stdlib.h --

   function atoi(S : in String) return integer;
   procedure itoa(valor: in integer;S: in out string;radix: in integer);
   procedure Adaexit(status: in integer);

   -- procedimentos e funcoes da conio.h --

   subtype X_Pos is Positive range 1 .. 80;
   subtype Y_Pos is Positive range 1 .. 50;
   type Background_Color is (Black, Blue, Green, Cyan, Red,
                             Magenta, Brown, Light_Gray);
   type Cursor_Size is (None, Solid, Normal);
   type Foreground_Color is (Black, Blue, Green, Cyan, Red, Magenta, Brown,
                             Light_Gray, Dark_Gray, Light_Blue, Light_Green,
                             Light_Cyan, Light_Red, Light_Magenta, Yellow,
                             White);

   procedure Clrscr;
   procedure Cputs (S : in String);
   procedure Gotoxy (X : in X_Pos; Y : in Y_Pos);
   procedure Setcursortype (Size : in Cursor_Size);
   procedure Textbackground (Color : in Background_Color);
   procedure Textcolor (Color : in Foreground_Color);


private

   -- funcoes de interface InLine --

   -- stdlib.h --

   pragma Inline (atoi);
   pragma Inline (itoa);
   pragma Inline (Adaexit);

   -- conio.h --

   pragma Import (C, Clrscr, "clrscr");
   pragma Import (C, Gotoxy, "gotoxy");
   pragma Inline (Cputs);
   pragma Inline (Textcolor);
   pragma Inline (Setcursortype);
   pragma Inline (Textbackground);

end FuncoesC;
