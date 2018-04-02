gcc -Id:/biblio/c -Wall -g -c rotinas.c -o rotinas.o
gcc -Id:/biblio/c -Wall -g -c graficos.c -o graficos.o
gcc -Id:/biblio/c -Wall -g -c mlivros.c -o mlivros.o
gcc -Id:/biblio/c -Wall -g -c musuario.c -o musuario.o
gcc -Id:/biblio/c -Wall -g -c memprest.c -o memprest.o
gcc -Id:/biblio/c -Wall -g -c mopcoes.c -o mopcoes.o
gcc -Id:/biblio/c -Wall -g -c biblio.c -o biblio.o
gcc -o biblio.exe biblio.o graficos.o memprest.o mlivros.o mopcoes.o musuario.o rotinas.o
del *.o
