#ifndef GAME_HPP
#define GAME_HPP

#include "Puzzle.hpp"

_ENTER_NAMESPACE_SLIDER_

class Game
{
public:
	Game(int, int);
	~Game();
private:
	Board* m_board;
};

_EXIT_NAMESPACE_SLIDER_

#endif // !GAME_HPP
