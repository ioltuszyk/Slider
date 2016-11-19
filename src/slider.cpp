#include "../include/Slider.hpp"

int main(int argc, char** argv)
{
	Console::Init(argv);
	Lua::Init(Console::Path);
	printf("Displaying Instructions");
	bool instructions_closed;
	Lua::RunAsync(Console::Path+"..\\bin\\Lua\\instructions.lua", NULL, &instructions_closed);

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

	system("cls");
	//Lua::RunSync(path+"..\\bin\\Lua\\rulesets.lua");

	Console::PromptMenu("Main Menu", {
		{"Default", []() 
			{
				Lua::RunAsync(Console::Path+"..\\bin\\Lua\\Rules\\Default.lua", NULL, NULL);
			}
		}
	}, []() {
		//
	});

	/*while (true)
	{
		system("pause>nul");
		if (GetAsyncKeyState(VK_LEFT))
		{
			system("cls");
			//Lua::RunSync(Console::Path+"..\\bin\\Lua\\MoveLeft.lua");
		}
	}*/

	std::this_thread::sleep_for(std::chrono::microseconds(10000000000));
	return 0;
}