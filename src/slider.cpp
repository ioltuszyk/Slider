#include "../include/Slider.hpp"

int main(int argc, char** argv)
{
	Console::Init(argv);
	Lua::Init(Console::Path);

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
	printf("\b\b\b            \b\b\b");
	//Lua::RunSync(path+"..\\bin\\Lua\\rulesets.lua");

	Console::PromptMenu("Main Menu", {
		{"Default", []()
			{
				printf("Test\n");
			}
		},
		{"Other", []()
			{
			}
		}
	});

	return 0;
}