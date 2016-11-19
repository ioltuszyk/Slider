--FFI Functions
local ffi = require("ffi")
ffi.cdef([[
int MessageBoxA(void *w, const char *txt, const char *cap, int type);
]])
alert = function (title, msg)
    ffi.C.MessageBoxA(nil, msg, title, 0)
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
--[[
    wait(int seconds)
]]