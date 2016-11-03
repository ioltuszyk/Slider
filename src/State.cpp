#include "../include/State.hpp"

using namespace slider;

//----------------------------------------------------------------------------
State::State(int width, int height)
{
	size_t nbit = (size_t)width*(size_t)height;
	m_pOccupied = new std::vector<bool>(nbit, false);
	m_width = width;
	m_height = height;
}

State::~State()
{
}

void State::SetOccupied(int column, int row, bool value)
{
	if (column<m_width && row<m_height && column>=0&&row>=0)
	{
		(*m_pOccupied)[row*m_width+column] = value;
	}
}

void State::PrintOccupied()
{
	std::vector<bool>::iterator it;
	std::vector<bool>::iterator start = m_pOccupied->begin();
	for (it = m_pOccupied->begin(); it!=m_pOccupied->end(); it++)
	{
		if ((it-m_pOccupied->begin())%4==0 && (it-m_pOccupied->begin())!=0)
		{
			std::cout<<std::endl;
		}
		std::cout<<*it;
	}
	std::cout<<std::endl;
}
//----------------------------------------------------------------------------