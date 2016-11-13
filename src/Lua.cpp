#include "../include/Lua.hpp"

using namespace slider;

_ENTER_NAMESPACE_SLIDER_
namespace Lua // Multiply-defined symbols otherwise
{
	bool executing = false;
	lua_State* State;
}
_EXIT_NAMESPACE_SLIDER_

//----------------------------------------------------------------------------
void Lua::Init(std::string path)
{
	printf("Initializing Lua Module\n");
	State = luaL_newstate();

	/* Standard Libraries */
	luaL_openlibs(State);
	luaopen_ffi(State);
	lua_setglobal(State, "ffi");

	/* C Libraries */
	lua_getglobal(State, "_G");
	luaL_register(State, NULL, waitLibs);
	/* ... */
	lua_pop(State, 1);

	/* Lua Libraries */
	char * initPath = (char *)malloc(1+strlen(path.c_str())+strlen("\\..\\bin\\Lua\\init.lua"));
	strcpy(initPath, path.c_str());
	strcat(initPath, "\\..\\bin\\Lua\\init.lua");
	luaL_dofile(State, initPath);
	free(initPath);
}

void Lua::FromFile(lua_State* state, std::string file)
{
	executing = true;
	luaL_dofile(state, file.c_str());
	executing = false;
}

void Lua::Run(std::string file, std::function<bool(std::thread*)> func)
{
	std::thread luaThread(FromFile, State, file);
	if (func==NULL)
	{
		luaThread.join();
	}
	else
	{
		bool issuedBreak = false;
		do // respond to events during script execution and/or perform tasks
		{
			issuedBreak = func(&luaThread);
		} while (executing & !issuedBreak); // note: can join if expected to finish
		luaThread.detach(); // always detach before destructor...
		luaThread.~thread(); // if you want to stop the execution of the script
	}
}
//----------------------------------------------------------------------------