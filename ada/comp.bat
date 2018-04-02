gcc -O3 -c -gnatp -gnatn -s -m486 funcoesc.adb
gcc -gnatc -c rotinas.ads
gcc -c rotinas.adb
gcc -gnatc -c graficos.ads
gcc -c graficos.adb
gcc -gnatc -c mlivros.ads
gcc -c mlivros.adb
gcc -gnatc -c musuario.ads
gcc -c musuario.adb
gcc -gnatc -c memprest.ads
gcc -c memprest.adb
gcc -gnatc -c mopcoes.ads
gcc -c mopcoes.adb
gcc -c biblio.adb
gnatmake biblio.adb
del *.o
del *.ali
