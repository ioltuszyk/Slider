#ifndef STATE_HPP
#define STATE_HPP

#include "Slider.hpp"

_ENTER_NAMESPACE_SLIDER_

class State
{
public:
	State(int, int);
	~State();

	void SetOccupied(int, int, bool);
	void State::PrintOccupied();
private:
	std::vector<bool>* m_pOccupied;
	int m_width;
	int m_height;
};

typedef std::vector<State> StateHistory;

_EXIT_NAMESPACE_SLIDER_

#endif // !STATE_HPP