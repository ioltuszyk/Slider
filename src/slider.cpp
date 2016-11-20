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
		{"Default", []() 
			{
				Lua::RunSync(Console::Path+"..\\src\\Lua\\classes.lua");
				Lua::RunSync(Console::Path+"..\\src\\Lua\\defaults.lua");
			}
		},
		{"Heuristic Test", []()
			{
				Lua::RunSync(Console::Path+"..\\src\\Lua\\heuristic.lua");
			}
		}
	}, []() {
		//
	});

	bool manual = true;
	while (true)
	{
		system("pause>nul");
		if (GetAsyncKeyState(VK_ESCAPE))
		{
			goto Menu; // don't hate me
		}
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
				// Run minimax
				Lua::RunSync(Console::Path+"..\\src\\Lua\\minimax.lua");
			}
		}
		if (GetAsyncKeyState(VK_LCONTROL) & GetAsyncKeyState('Z'))
		{
			if (manual)
			{
				system("cls");
				Lua::RunSync(Console::Path+"..\\src\\Lua\\manual_return.lua");
			}
		}
		else if (GetAsyncKeyState(VK_LEFT))
		{
			if (manual)
			{ 
				system("cls");
				Lua::RunSync(Console::Path+"..\\src\\Lua\\manual_left.lua");
			}

		}
		else if (GetAsyncKeyState(VK_RIGHT))
		{
			if (manual)
			{
				system("cls");
				Lua::RunSync(Console::Path+"..\\src\\Lua\\manual_right.lua");
			}
		}
		else if (GetAsyncKeyState(VK_UP))
		{
			if (manual)
			{
				system("cls");
				Lua::RunSync(Console::Path+"..\\src\\Lua\\manual_up.lua");
			}
		}
		else if (GetAsyncKeyState(VK_DOWN))
		{
			if (manual)
			{
				system("cls");
				Lua::RunSync(Console::Path+"..\\src\\Lua\\manual_down.lua");
			}
		}
	}

	return 0;
}