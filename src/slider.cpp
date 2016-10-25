extern "C"
{
#include <luaconf.h>
#include <lua.h>
#include <lualib.h>
#include <lauxlib.h>
#include <luajit.h>
}

int main(int argc, char** argv)
{
	lua_State* L = lua_open();
	luaL_openlibs(L);
	luaL_dofile(L, "test/example.lua");
	lua_close(L);

	return 0;
}