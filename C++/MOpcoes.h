/*
  MOpcoes.h: interface para a classe MOpcoes.
*/

#include <iostream.h>
#include <stdio.h>

class MOpcoes : public Graficos  
{
public:
    void AbrirArquivo();
    void formSobre();
    FILE *SobreFile;
    MOpcoes();
    virtual ~MOpcoes();

};


