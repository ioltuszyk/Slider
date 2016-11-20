#ifndef LUA_HPP
#define LUA_HPP

#include <thread>
#include <chrono>
#include <vector>

#include "Console.hpp"

#ifdef _WIN32
#include <Windows.h> /* For MessageBoxA and GetAsyncKeyState */
#else
#include <SDL.h> /* For SDL_ShowSimpleMessageBox and SDL_GetKeyState*/
#endif

extern "C"
{
#include "LuaJIT\luaconf.h"
#include "LuaJIT\lua.h"
#include "LuaJIT\lualib.h"
#include "LuaJIT\lauxlib.h"
#include "LuaJIT\luajit.h"
}

namespace Lua
{
	extern lua_State* State;

	static int wait0(lua_State* State)
	{
		int argc = lua_gettop(State);
		for (int i = 1; i<=argc; i++)
		{
			if (lua_isnumber(State, i))
			{
				int us = (int)(lua_tonumber(State, i)*1000000);
				std::this_thread::sleep_for(std::chrono::microseconds(us));
			}
		}
		
		return 0;
	}
	static const struct luaL_Reg waitLib[] = // wait(seconds)
	{
		{"wait", wait0},
		{NULL, NULL}
	};

	static int color0(lua_State* State)
	{
		int argc = lua_gettop(State);
		if (argc == 2)
		{
			if (lua_isstring(State, 1) & lua_isnumber(State, 2))
			{
				std::string text = lua_tostring(State, 1);
				int color = lua_tointeger(State, 2);
				SetConsoleTextAttribute(Console::Console, color);
				lua_getglobal(State, "printf");
				lua_pushstring(State, text.c_str());
				lua_call(State, 1, 0);
				SetConsoleTextAttribute(Console::Console, 0x07);
			}
		}

		return 0;
	}
	static const struct luaL_Reg colorLib[] = // color(name)
	{
		{"colorize", color0},
		{NULL, NULL}
	};

	void Init(std::string);
	void Execute(lua_State*, std::string, std::function<void()>, bool*);
	void RunAsync(std::string, std::function<void()>, bool*);
	void RunSync(std::string);
}

#endif // !LUA_HPP