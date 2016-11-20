#ifndef CONSOLE_HPP
#define CONSOLE_HPP

#include <thread>
#include <vector>

#ifdef _WIN32
#include <Windows.h> /* For MessageBoxA and GetAsyncKeyState */
#else
#include <SDL.h> /* For SDL_ShowSimpleMessageBox and SDL_GetKeyState*/
#endif

namespace Console
{
	extern std::string Path;
	extern HANDLE Console;
	extern COORD CursorPos;

	struct MenuOption
	{
		std::string Label;
		std::function<void()> Func;
	};

	void Init(char**);
	void Animation(std::vector<char *>, bool*, long long);
	void SetCursorPos(int, int);
	void PromptMenu(std::string, std::vector<MenuOption>, std::function<void()>);
}

#endif // !CONSOLE_HPP
