#include "../include/Game.hpp"

using namespace slider;

//----------------------------------------------------------------------------
Game::Game(int width, int height)
{
	m_pBoard = new Board(width, height);
	m_pBoard->Init();
	// temp...
	m_pBoard->GetCurrentState()->SetOccupied(0, 0, true);
	m_pBoard->GetCurrentState()->PrintOccupied();
	// getter; todo: more work on state
}

Game::~Game()
{
	DeletePointer(m_pBoard);
}
//----------------------------------------------------------------------------