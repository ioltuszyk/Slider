#ifndef LUA_HPP
#define LUA_HPP

#include <thread>
#include <chrono>
#include <vector>

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

	void Init(std::string);
	void Execute(lua_State*, std::string, std::function<void()>, bool*);
	void RunAsync(std::string, std::function<void()>, bool*);
	void RunSync(std::string);
}

#endif // !LUA_HPP