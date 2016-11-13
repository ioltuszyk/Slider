#include "../include/Game.hpp"
#include "../include/Ruleset.hpp"
#include "../include/Lua.hpp"

using namespace slider;

int main(int argc, char** argv)
{
	std::string fullPath(argv[0]);
	std::string path = fullPath.substr(0, fullPath.find_last_of("\\")+1);

	Lua::Init(path);
	printf("Displaying instructions\n");
	Lua::Run(path+"..\\bin\\Lua\\instructions.lua", [](std::thread* luaThread)
	{
		printf(".");
		std::this_thread::sleep_for(std::chrono::microseconds(50000));
		printf(".");
		std::this_thread::sleep_for(std::chrono::microseconds(50000));
		printf(".");
		std::this_thread::sleep_for(std::chrono::microseconds(50000));
		printf("\b \b");
		std::this_thread::sleep_for(std::chrono::microseconds(50000));
		printf("\b \b");
		std::this_thread::sleep_for(std::chrono::microseconds(50000));
		printf("\b \b");
		std::this_thread::sleep_for(std::chrono::microseconds(50000));
		return false;
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