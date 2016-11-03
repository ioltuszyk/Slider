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
	m_vStateHistory.clear();
}

void Board::Init()
{
	State initState(m_width, m_height);
	m_vStateHistory.push_back(initState);
}

State* Board::GetCurrentState()
{
	return &m_vStateHistory.back();
}
//----------------------------------------------------------------------------