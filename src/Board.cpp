#include "../include/Board.hpp"

using namespace slider;

//----------------------------------------------------------------------------
ConstBoard::ConstBoard(int width, int height)
{
	m_width = width;
	m_height = height;
}
//----------------------------------------------------------------------------
Board::~Board()
{
	m_stateHistory.clear();
}

void Board::Init()
{
	State initState(m_width, m_height);
	m_stateHistory.push_back(initState);
}
//----------------------------------------------------------------------------