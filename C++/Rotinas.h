/*
  Rotinas.h: interface para a classe Rotinas.
*/

//#include "Biblio.h"
#include <iostream.h>
#include <time.h>
#include <string.h>
#include <malloc.h>
#include <stdlib.h>
#include <stdio.h>

class Rotinas //: public Biblio
{
public:
    int tamArquivo(FILE *Arq,int tam);
    char *copy(char *string,int ini,int tam);
    void Cabecalho(char *texto); 
    Rotinas();
    virtual ~Rotinas();

};


