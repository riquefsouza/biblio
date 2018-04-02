C     ----------------- 
C     Modulo de Rotinas 
C     -----------------

C     ---------------------------------------------------------------------
C     Nome : cabecalho
C     Descricao : procedimento que escreve o texto de cabecalho do sistema.
C     Parametros :
C     texto - o texto do cabecalho
C     ---------------------------------------------------------------------
      subroutine cabecalho(texto)
      character*34 texto
      integer*2 ano, mes, dia
      integer*2 hora, min, seg, mseg 

      call getdat(ano,mes,dia)
      call gettim(hora, min, seg, mseg)
      write(*,9) 
9     format(1X,'Ú',76('Ä'),'¿')
      write(*,10) dia,mes,ano,texto,hora,min,seg
10    format(1X,'³ ',I2,'/',I2,'/',I4,11X,A34,11X,I2,':',I2,':',I2,' ³')
      write(*,11) 
11    format(1X,'À',76('Ä'),'Ù')
      return
      end
