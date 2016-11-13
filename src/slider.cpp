#include "../include/Game.hpp"
#include "../include/Ruleset.hpp"
#include "../include/Lua.hpp"

using namespace slider;

std::string path;

int main(int argc, char** argv)
{
	std::string fullPath(argv[0]);
	path = fullPath.substr(0, fullPath.find_last_of("\\"));

	Lua::Init(path);
	Lua::Run(path+"\\..\\test\\Lua\\example.lua", [](std::thread* luaThread)
	{
		if ((GetAsyncKeyState('Q')&0x8000)) // Q pressed event
		{
			/* stuff to be done while the lua script executes */
			printf("Pressed Q to exit execution\n");
			return true; // stop execution of the script
		}
	});

	Game game(4,4);
	Ruleset rules;

	//game.Apply(rules);

	do
	{
		//game.Evaluate(heuristic); // a decision
	} while (false);

	return 0;
}