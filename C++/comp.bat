bcc32 -c rotinas.cpp -o rotinas.obj
bcc32 -c graficos.cpp -o graficos.obj
bcc32 -c mlivros.cpp -o mlivros.obj 
bcc32 -c musuario.cpp -o musuario.obj 
bcc32 -c memprest.cpp -o memprest.obj
bcc32 -c mopcoes.cpp -o mopcoes.obj 
bcc32 -c biblio.cpp -o biblio.obj
ilink32 biblio.obj graficos.obj memprest.obj mlivros.obj mopcoes.obj musuario.obj rotinas.obj 
del *.obj
