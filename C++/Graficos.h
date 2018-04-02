/*
  Graficos.h: interface para a classe Graficos.
*/

#include "Rotinas.h"
#include <iostream.h>
#include <stdio.h>

class Graficos : public Rotinas  
{
public:	
	void SubMenu(int num);
	void Menu();
	void formSplash();
	Graficos();
	virtual ~Graficos();

};

