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
	Lua::Run(path+"\\..\\test\\Lua\\example.lua", [](bool* isExecuting, std::thread* luaThread)
	{
		do // respond to events during script execution and/or perform tasks
		{
			if ((GetAsyncKeyState('Q') & 0x8000)) // Q pressed event
			{
				/* stuff to be done while the lua script executes */
				printf("Pressed Q to exit execution\n"); 
				break; // stop execution of the script
			}
		} while (*isExecuting); // note: can join if expected to finish
		luaThread->detach(); // always detach before destructor...
		luaThread->~thread(); // if you want to stop the execution of the script
	}); // needs abstraction

	Game game(4,4);
	Ruleset rules;

	//game.Apply(rules);

	do
	{
		//game.Evaluate(heuristic); // a decision
	} while (false);

	return 0;
}