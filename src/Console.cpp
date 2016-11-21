#include "../include/Console.hpp"

namespace Console
{
	std::string Path;
	HANDLE Console;
	COORD CursorPos;
}

void Console::Init(char** path)
{
	Path = ((std::string)path[0]).substr(0, ((std::string)path[0]).find_last_of("\\")+1);
	Console = GetStdHandle(STD_OUTPUT_HANDLE);
}

void Console::Animation(std::vector<char *> anim, bool* end, long long wait)
{
	while (!*end)
	{
		for (auto i:anim)
		{
			printf(i);
			if (!*end)
			{
				std::this_thread::sleep_for(std::chrono::microseconds(wait));
			}
		}
	}
}

void Console::SetCursorPos(int x, int y)
{
	CursorPos.X = x;
	CursorPos.Y = y;
	SetConsoleCursorPosition(Console, CursorPos);
}

void Console::PromptMenu(std::string title, std::vector<MenuOption> options, std::function<void()> ret)
{
	bool running = true;

	const int nOptions = options.size()+3;
	int selectedOption = 2;
	int menuBreak;
	std::function<void()> selectedFunction = options[0].Func;

	SetCursorPos(0, 0); printf(title.c_str());
	SetCursorPos(0, 2); printf(" >");
	for (auto i:options)
	{
		SetCursorPos(2, selectedOption++);	printf(" %s [ ]", i.Label.c_str());
		if (selectedOption==3)
		{
			SetCursorPos(2+i.Label.size()+3, selectedOption-1); printf("-");
		}
	}
	menuBreak = selectedOption;
	SetCursorPos(2, (selectedOption++));	printf(" ----------------");
	SetCursorPos(2, (selectedOption++));	printf(" Confirm");
	SetCursorPos(2, (selectedOption++));	printf(" Return");
	selectedOption = 2;
	SetCursorPos(0, selectedOption);
	while (running)
	{
		system("pause>nul");

		if (GetAsyncKeyState(VK_DOWN)&&selectedOption!=nOptions+1)
		{
			SetCursorPos(0, selectedOption); printf("  ");
			if (++selectedOption==menuBreak)
			{
				selectedOption++;
			}
			SetCursorPos(0, selectedOption); printf(" >");
			SetCursorPos(0, selectedOption);
			continue;
		}
		if (GetAsyncKeyState(VK_UP)&&selectedOption!=2)
		{
			SetCursorPos(0, selectedOption); printf("  ");
			if (--selectedOption==menuBreak)
			{
				selectedOption--;
			}
			SetCursorPos(0, selectedOption); printf(" >");
			SetCursorPos(0, selectedOption);
			continue;
		}
		if (GetAsyncKeyState(VK_RETURN))
		{
			if ((selectedOption-2)<nOptions-2)
			{
				selectedFunction = options[selectedOption-2].Func;
				int optClear = 2;
				for (auto i:options)
				{
					if (optClear!=selectedOption)
					{
						SetCursorPos(2+i.Label.size()+2, optClear++); printf("[ ]");
						SetCursorPos(0, selectedOption);
					}
					else
					{
						SetCursorPos(2+i.Label.size()+2, optClear++); printf("[-]");
						SetCursorPos(0, selectedOption);
					}
				}
			}
			else if ((selectedOption-2)==nOptions-2)
			{
				// confirm
				system("cls");
				selectedFunction();
				return;
			}
			else
			{
				// return
				system("cls");
				ret();
				return;
			}
		}
	}
}