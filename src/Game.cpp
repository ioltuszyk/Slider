#include "../include/Game.hpp"

using namespace slider;

//----------------------------------------------------------------------------
Game::Game(int width, int height)
{
	m_board = new Board(width, height);
	m_board->Init();
}

Game::~Game()
{
	Delete(m_board);
}
//----------------------------------------------------------------------------