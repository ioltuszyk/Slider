#include "../include/Game.hpp"
#include "../include/Ruleset.hpp"
#include "../include/Lua.hpp"

#include <vector>

using namespace slider;

int main(int argc, char** argv)
{
	std::string fullPath(argv[0]);
	std::string path = fullPath.substr(0, fullPath.find_last_of("\\")+1);

	printf("Showing Instructions");
	Lua::Init(path);
	bool instructions_closed = false;
	Lua::RunAsync(path+"..\\bin\\Lua\\instructions.lua", NULL, &instructions_closed);
	std::vector<char *> ellipses_anim = {".", ".", ".", "\b \b", "\b \b", "\b \b"};
	while (!instructions_closed)
	{
		for (auto i:ellipses_anim)
		{
			printf(i);
			if (!instructions_closed)
			{
				std::this_thread::sleep_for(std::chrono::microseconds(200000));
			}
		}
	}
	//Lua::RunSync(path+"..\\bin\\Lua\\rulesets.lua");

	Game game(4, 4);
	Ruleset rules;

	//game.Apply(rules);
	do
	{
		//game.Evaluate(heuristic); // a decision
	} while (false);

	return 0;
}