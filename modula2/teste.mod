MODULE Teste;
FROM Rotinas IMPORT Ss,LENGTH,Copy,Repete;
FROM ANSISYS IMPORT Attribute, SetAttribute, Mode, SetMode,
ClearScreen, GotoRowCol;
FROM Terminal IMPORT WriteString, Write, WriteLn, GetKeyStroke;
FROM InOut IMPORT WriteInt, WriteCard;
FROM StdStrings IMPORT String, Assign, Length, Append, Compare,
CompareResult;
FROM UxFiles IMPORT File, OpenMode, FileMode, Open, Close, EndFile, SetPos,
ReadNBytes,WriteNBytes, Create;
FROM TextInOut IMPORT Read,ReadString;
FROM SYSTEM IMPORT ADDRESS, ADR, TSIZE, CAST, BYTE, INCADR;
FROM AsciiTime IMPORT StructTimeToAscii; 
FROM SysClock IMPORT GetClock, DateTime;
FROM Rotinas IMPORT LENGTH, UsuariosRec;
FROM IntStr IMPORT Alignment, Give, Value;
FROM RealStr IMPORT Alignment, GiveFloat;

VAR
 dt1,dt2:String;

PROCEDURE RetDataAtual():String;
VAR
  datahora :  DateTime;
  strdh,dia,mes,ano,sRet : String;
BEGIN
 GetClock(datahora);
 StructTimeToAscii(strdh,datahora);
 dia:=Copy(strdh,10,2);
 mes:=Copy(strdh,6,3);
 ano:=Copy(strdh,1,4);

 IF Compare(mes,"Jan")=equal THEN mes:="01";
 ELSIF Compare(mes,"Feb")=equal THEN mes:="02";
 ELSIF Compare(mes,"Mar")=equal THEN mes:="03";
 ELSIF Compare(mes,"Apr")=equal THEN mes:="04";
 ELSIF Compare(mes,"May")=equal THEN mes:="05";
 ELSIF Compare(mes,"Jun")=equal THEN mes:="06";
 ELSIF Compare(mes,"Jul")=equal THEN mes:="07";
 ELSIF Compare(mes,"Aug")=equal THEN mes:="08";
 ELSIF Compare(mes,"Sep")=equal THEN mes:="09";
 ELSIF Compare(mes,"Oct")=equal THEN mes:="10";
 ELSIF Compare(mes,"Nov")=equal THEN mes:="11";
 ELSIF Compare(mes,"Dez")=equal THEN mes:="12";
 END;
 dia:=Ss(Repete("0",2-LENGTH(dia)),dia); 
 sRet:=Ss(dia,Ss("/",Ss(mes,Ss("/",ano))));
 RETURN(sRet);

END RetDataAtual;

(*--------------------------------------------------------*)

PROCEDURE ConverteData(dt:String):INTEGER;
VAR
  sAux:String;
  nAux:INTEGER;
BEGIN
 sAux:=Ss(Copy(dt,7,4),Ss(Copy(dt,4,2),Copy(dt,1,2)));
 nAux:=Value(sAux);
 RETURN(nAux);
END ConverteData;

(*--------------------------------------------------------*)

PROCEDURE SubtraiDatas(dt1:String;dt2:String):INTEGER;
VAR
 dia,mes,ano,dia1,mes1,ano1,dia2,mes2,ano2:INTEGER;
 i,c,dias:INTEGER;
 udiames: ARRAY[1..12] OF INTEGER;
BEGIN
 dias:=0;
 udiames[1]:=31;
 udiames[2]:=28;
 udiames[3]:=31;
 udiames[4]:=30;
 udiames[5]:=31;
 udiames[6]:=30;
 udiames[7]:=31;
 udiames[8]:=31;
 udiames[9]:=30;
 udiames[10]:=31;
 udiames[11]:=30;
 udiames[12]:=31;

 i:=Value(Copy(dt1,1,2));
 dia1:=i;
 i:=Value(Copy(dt1,4,2));
 mes1:=i;
 i:=Value(Copy(dt1,7,4));
 ano1:=i;

 i:=Value(Copy(dt2,1,2));
 dia2:=i;
 i:=Value(Copy(dt2,4,2));
 mes2:=i;
 i:=Value(Copy(dt2,7,4));
 ano2:=i;

 FOR ano:=ano1 TO ano2 DO
    FOR mes:=mes1 TO 12 DO
       (* ano bissexto *)
       IF (ano MOD 4)=0 THEN
         udiames[2]:=29;
       END;
       (* data final *)
       IF (ano=ano2) AND (mes=mes2) THEN
         udiames[mes2]:=dia2;
       END;
       FOR dia:=dia1 TO udiames[mes] DO
          dias:=dias+1;
       END;
       IF (ano=ano2) AND (mes=mes2) THEN
           RETURN(dias-1);
       END;
       dia1:=1;
    END;
    mes1:=1;
 END;

END SubtraiDatas;

(*--------------------------------------------------------*)

PROCEDURE SomaDias(dt1:String;qtddias:INTEGER):String;
VAR
 dia,mes,ano,dia1,mes1,ano1,dia2,mes2,ano2:INTEGER;
 i,c,dias:INTEGER;
 sAux,sAux2:String;
 udiames: ARRAY[1..12] OF INTEGER;
BEGIN
 dias:=0;
 udiames[1]:=31;
 udiames[2]:=28;
 udiames[3]:=31;
 udiames[4]:=30;
 udiames[5]:=31;
 udiames[6]:=30;
 udiames[7]:=31;
 udiames[8]:=31;
 udiames[9]:=30;
 udiames[10]:=31;
 udiames[11]:=30;
 udiames[12]:=31;

 i:=Value(Copy(dt1,1,2));
 dia1:=i;
 i:=Value(Copy(dt1,4,2));
 mes1:=i;
 i:=Value(Copy(dt1,7,4));
 ano1:=i;

 ano2:=ano1 + (qtddias DIV 365);

 FOR ano:=ano1 TO ano2 DO
    FOR mes:=mes1 TO 12 DO
       (* ano bissexto *)
       IF (ano MOD 4)=0 THEN
         udiames[2]:=29;
       END;
       FOR dia:=dia1 TO udiames[mes] DO
            dias:=dias+1;
            IF dias=qtddias+1 THEN
                Give(sAux,dia,1,left);
                sAux2:=Ss(Repete("0",2-LENGTH(sAux)),Ss(sAux, "/"));
                Give(sAux,mes,1,left);
                sAux2:=Ss(sAux2,Ss(Repete("0",2-LENGTH(sAux)),Ss(sAux, "/")));
                Give(sAux,ano,1,left);
                sAux2:=Ss(sAux2,sAux);
                RETURN(sAux2);
            END;
       END;
       dia1:=1;
    END;
    mes1:=1;
 END;

END SomaDias;

PROCEDURE DiadaSemana(dt:String):String;
VAR
  sRet:String;
  ds:ARRAY[1..7] OF String;
  ndias,ix,jx,antdiv:INTEGER;
  bFlag:BOOLEAN;
BEGIN
 ix:=0;
 ndias:=0;
 bFlag:=FALSE;
 ds[1]:="Domingo";
 ds[2]:="Segunda";
 ds[3]:="Terca";
 ds[4]:="Quarta";
 ds[5]:="Quinta";
 ds[6]:="Sexta";
 ds[7]:="Sabado";
 ndias:=SubtraiDatas("01/01/1995",dt);
 IF (ndias >= 1) AND (ndias <= 6) THEN
    ix:=ndias;
 ELSE
    WHILE bFlag=FALSE DO
       jx:=(ndias DIV 7);
       ix:=(ndias MOD 7);
       IF (jx < 7) AND (ix < 7) THEN
          bFlag:=TRUE;
          ix:=ix+1;
       END;
       IF (jx < 7) AND (ix = 0) THEN
          bFlag:=TRUE;
          ix:=0;
       END;
       ndias:=jx;
    END;
 END;
 sRet:=ds[ix];
 RETURN(sRet);
END DiadaSemana;


BEGIN
 ClearScreen;
 dt1:="01/01/1995";
 dt2:="23/02/2000";
 WriteString("23/02/2000");WriteLn;
 WriteInt(SubtraiDatas(dt1,dt2),5);WriteLn;
 WriteInt((1882 MOD 7),5);WriteLn;
 WriteString(DiadaSemana("23/02/2000"));
END Teste.
