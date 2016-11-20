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
	Lua::RunSync(Console::Path+"..\\bin\\Lua\\classes.lua");

	Console::PromptMenu("Main Menu", {
		{"Default", []() 
			{
				Lua::RunSync(Console::Path+"..\\bin\\Lua\\heuristic.lua");
			}
		}
	}, []() {
		//
	});

	bool manual = true;
	while (true)
	{
		system("pause>nul");
		if (GetAsyncKeyState(VK_SPACE))
		{
			manual = !manual;
			if (manual)
			{
				Console::SetCursorPos(0, 0);
				printf("Manual Input Enabled ");
				Console::SetCursorPos(20, 0);
			}
			else
			{
				Console::SetCursorPos(0, 0);
				printf("Manual Input Disabled");
			}
		}
		if (GetAsyncKeyState(VK_LEFT))
		{
			if (manual)
			{ 
				system("cls");
				Lua::RunSync(Console::Path+"..\\bin\\Lua\\manual_left.lua");
			}

		}
		else if (GetAsyncKeyState(VK_RIGHT))
		{
			if (manual)
			{
				system("cls");
				Lua::RunSync(Console::Path+"..\\bin\\Lua\\manual_right.lua");
			}
		}
		else if (GetAsyncKeyState(VK_UP))
		{
			if (manual)
			{
				system("cls");
				Lua::RunSync(Console::Path+"..\\bin\\Lua\\manual_up.lua");
			}
		}
		else if (GetAsyncKeyState(VK_DOWN))
		{
			if (manual)
			{
				system("cls");
				Lua::RunSync(Console::Path+"..\\bin\\Lua\\manual_down.lua");
			}
		}
	}

	return 0;
}