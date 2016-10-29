#ifndef SLIDER_HPP
#define SLIDER_HPP

#include <vector>

//{ Namespace Definitions

/*	Used immediately after the last include directive in a file. */
#define _ENTER_NAMESPACE_SLIDER_ namespace slider {
#define _EXIT_NAMESPACE_SLIDER_ }

//}

_ENTER_NAMESPACE_SLIDER_
//{	Memory Utils

template<class T>
void Delete(T* element)
{
	delete element;
}

//}
_EXIT_NAMESPACE_SLIDER_

#endif // !SLIDER_HPP
