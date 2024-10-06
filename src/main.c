#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <lua5.4/lua.h>
#include <lua5.4/lualib.h>
#include <lua5.4/lauxlib.h>

#define STR(x) VAL(x)
#define VAL(x) #x

#define PALIFORGE_LIB_PATH_STR STR(PALIFORGE_LIB_PATH) // because c macros are weird

#define PALIFORGE_LIB_ENTRYPOINT_PATH PALIFORGE_LIB_PATH_STR "/main.lua"

int interactively_run(lua_State *L) {
	char *hi = luaL_checkstring(L, 1);
	system(hi);
	return 0;
}

void main() {
	lua_State *L = luaL_newstate(); 

	luaL_openlibs(L);

	lua_pushstring(L, PALIFORGE_LIB_PATH_STR);
	lua_setglobal(L, "PALIFORGE_LUA_LIB_STR");

	lua_pushcfunction(L, *interactively_run);
	lua_setglobal(L, "interactively_run");

	int res = luaL_dofile(L, PALIFORGE_LIB_ENTRYPOINT_PATH);
	if (res != LUA_OK) {
		fprintf(stderr, lua_tostring(L,-1));
	}
}
