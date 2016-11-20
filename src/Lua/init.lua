--FFI Functions
local ffi = require("ffi")
ffi.cdef([[
int MessageBoxA( void *w, const char *txt, const char *cap, int type );
int system(const char *command);
]])
alert = function (title, msg)
    ffi.C.MessageBoxA(nil, msg, title, 0)
end
clear = function ()
    ffi.C.system("cls")
end
--Pure Lua Functions----------------------------------------------------------
time = {
    start = os.clock()
}
time.reset = function ()
    time.start = os.clock()
end
time.getElapsed = function ()
    return os.clock()-time.start
end
printf = function(s,...)
    return io.write(s:format(...))
end -- function
--[[
    wait(int seconds)
]]