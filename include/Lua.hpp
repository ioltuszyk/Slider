#ifndef LUA_HPP
#define LUA_HPP

#include <thread> /* For async execution of lua*/
#include <chrono> /* For sleep_for */
#include <Windows.h> /* For MessageBoxA and GetAsyncKeyState;
	need alternatives for linux */

#include "Slider.hpp"
extern "C"
{
#include "LuaJIT\luaconf.h"
#include "LuaJIT\lua.h"
#include "LuaJIT\lualib.h"
#include "LuaJIT\lauxlib.h"
#include "LuaJIT\luajit.h"
}

_ENTER_NAMESPACE_SLIDER_

namespace Lua
{
	enum ThreadReturn
	{
		FINISH,
		REPEAT,
		ABORT,
		GUARD
	};

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

_EXIT_NAMESPACE_SLIDER_

#endif // !LUA_HPP