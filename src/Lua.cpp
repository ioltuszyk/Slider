#include "../include/Lua.hpp"

namespace Lua
{
	lua_State* State;
}

//----------------------------------------------------------------------------
void Lua::Init(std::string path)
{
	State = luaL_newstate();

	/* Standard Libraries */
	luaL_openlibs(State);
	luaopen_ffi(State);
	lua_setglobal(State, "ffi");

	/* C Libraries */
	lua_getglobal(State, "_G");
	luaL_register(State, NULL, waitLib);
	/* ... */
	lua_pop(State, 1);

	/* Lua Libraries */
	char * initPath = (char *)malloc(1+strlen(path.c_str())+strlen("\\..\\bin\\Lua\\init.lua"));
	strcpy(initPath, path.c_str());
	strcat(initPath, "..\\bin\\Lua\\init.lua");
	luaL_dofile(State, initPath);
	free(initPath);
}

void Lua::Execute(lua_State* state, std::string file, std::function<void()> end, bool* status)
{
	luaL_dofile(state, file.c_str());
	if (end!=NULL)
	{
		end();
	}
	if (status!=NULL)
	{
		*status = true;
	}
}

void Lua::RunAsync(std::string file, std::function<void()> end, bool* status)
{
	if (status!=NULL)
	{
		*status = false;
	}
	std::thread routine(Execute, State, file, end, status);
	routine.detach();
}

void Lua::RunSync(std::string file)
{
	luaL_dofile(State, file.c_str());
}
//----------------------------------------------------------------------------