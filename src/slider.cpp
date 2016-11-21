#include "../include/Slider.hpp"

int main(int argc, char** argv)
{
	Console::Init(argv);
	Lua::Init(Console::Path);
	printf("Displaying Instructions");
	bool instructions_closed = false;
	Lua::RunAsync(Console::Path+"..\\src\\Lua\\instructions.lua", NULL, &instructions_closed);

	std::vector<char *> ellipses = {".", ".", ".", "\b \b", "\b \b", "\b \b"};
	Console::Animation(ellipses, &instructions_closed, 200000);
Menu:
	system("cls");
	Console::PromptMenu("Main Menu", {
		{"Expectimax", []()
			{
				Lua::RunSync(Console::Path+"..\\src\\Lua\\classes.lua");
				Lua::RunSync(Console::Path+"..\\src\\Lua\\heuristic.lua");
				Lua::RunSync(Console::Path+"..\\src\\Lua\\Searches\\expectimax.lua");
			}
		},
		{"Optimistic Search (Depth 6)", []()
			{
				Lua::RunSync(Console::Path+"..\\src\\Lua\\classes.lua");
				Lua::RunSync(Console::Path+"..\\src\\Lua\\heuristic.lua");
				Lua::RunSync(Console::Path+"..\\src\\Lua\\Searches\\heuristic_depth_6.lua");
			}
		},
		{"Optimistic Search (Depth 4)", []()
			{
				Lua::RunSync(Console::Path+"..\\src\\Lua\\classes.lua");
				Lua::RunSync(Console::Path+"..\\src\\Lua\\heuristic.lua");
				Lua::RunSync(Console::Path+"..\\src\\Lua\\Searches\\heuristic_depth_4.lua");
			}
		},
		{"Local Optimum Search (Greedy)", []() 
			{
				Lua::RunSync(Console::Path+"..\\src\\Lua\\classes.lua");
				Lua::RunSync(Console::Path + "..\\src\\Lua\\heuristic.lua");
				Lua::RunSync(Console::Path+"..\\src\\Lua\\Searches\\heuristic_only.lua");
			}
		},
		{"Random", []()
			{
				Lua::RunSync(Console::Path+"..\\src\\Lua\\classes.lua");
				Lua::RunSync(Console::Path+"..\\src\\Lua\\Searches\\random.lua");
			}
		}
	}, []() {
		//
	});

	while (true)
	{
		system("pause>nul");
		if (GetAsyncKeyState(VK_ESCAPE))
		{
			goto Menu;
		}
		return 0;
	}
}