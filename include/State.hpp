#ifndef STATE_HPP
#define STATE_HPP

#include "Slider.hpp"

_ENTER_NAMESPACE_SLIDER_

class State
{
public:
	State(int, int);
	~State();
private:
	
};

typedef std::vector<State> StateHistory;

_EXIT_NAMESPACE_SLIDER_

#endif // !STATE_HPP