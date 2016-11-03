#ifndef SLIDER_HPP
#define SLIDER_HPP

#include <iostream>
#include <vector>
#include <cmath>

//{ Namespace Definitions

/*	Used immediately after the last include directive in a file. */
#define _ENTER_NAMESPACE_SLIDER_ namespace slider {
#define _EXIT_NAMESPACE_SLIDER_ }

//}

_ENTER_NAMESPACE_SLIDER_
//{	Memory Utils

template<class T>
void DeletePointer(T* element)
{
	delete element;
};

template<class T>
void DeleteVector(T vector)
{
	for (auto p = vector.begin(); p!=vector.end(); ++p)
	{
		delete *p;
	}
	vector.clear();
};


//}
_EXIT_NAMESPACE_SLIDER_

#endif // !SLIDER_HPP
