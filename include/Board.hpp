#ifndef BOARD_HPP
#define BOARD_HPP

#include "Slider.hpp"
#include "State.hpp"

_ENTER_NAMESPACE_SLIDER_

class ConstBoard
{
public:
	ConstBoard(int, int);
protected:
	int m_width;
	int m_height;
};

class Board : public ConstBoard
{
public:
	using ConstBoard::ConstBoard;
	~Board();

	void Init();
private:
	StateHistory m_stateHistory;
};

_EXIT_NAMESPACE_SLIDER_

#endif // !BOARD_HPP