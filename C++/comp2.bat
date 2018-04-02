gcc -Id:/biblio/c++ -Wall -g -c rotinas.cpp -o rotinas.o
gcc -Id:/biblio/c++ -Wall -g -c graficos.cpp -o graficos.o
gcc -Id:/biblio/c++ -Wall -g -c mlivros.cpp -o mlivros.o
gcc -Id:/biblio/c++ -Wall -g -c musuario.cpp -o musuario.o
gcc -Id:/biblio/c++ -Wall -g -c memprest.cpp -o memprest.o
gcc -Id:/biblio/c++ -Wall -g -c mopcoes.cpp -o mopcoes.o
gcc -Id:/biblio/c++ -Wall -g -c biblio.cpp -o biblio.o
gcc -o biblio.exe biblio.o graficos.o memprest.o mlivros.o mopcoes.o musuario.o rotinas.o
del *.o
