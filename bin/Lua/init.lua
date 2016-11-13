local ffi = require("ffi")
ffi.cdef([[
int MessageBoxA(void *w, const char *txt, const char *cap, int type);
]])
alert = function (title, msg)
    ffi.C.MessageBoxA(nil, msg, title, 0)
end
------------------------------------------------------------------------------
time = {
    start = os.clock()
}
time.reset = function ()
    time.start = os.clock()
end
time.getelapsed = function ()
    return os.clock()-time.start
end
------------------------------------------------------------------------------