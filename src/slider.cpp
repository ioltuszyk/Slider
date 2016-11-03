#include "../include/Game.hpp"

using namespace slider;

int main(int argc, char** argv)
{
	Game* game = new Game(4,4);

	DeletePointer(game);
	return 0;
}