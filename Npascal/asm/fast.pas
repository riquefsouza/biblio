program fastwritedemo;
uses crt;
var
 vs:word;
 i,j:byte;
 s:string;

{$L fastwrit}
procedure fastwrite(x,y:byte;var s:string;fg,bg:byte); external;

begin
clrscr;
s:='XXXXXXX';
j:=5;

for i:=1 to 25 do
 begin
  fastwrite(j,i,s,yellow,black);
  inc(j,1);
 end;

for i:=1 downto 25 do
 begin
  fastwrite(j,i,s,yellow,black);
  inc(j,1);
 end;

gotoxy(1,24);
write('pressione enter...');
readln;
end.

