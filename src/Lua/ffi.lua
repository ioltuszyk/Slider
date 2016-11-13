local ffi = require("ffi")
ffi.cdef[[
int printf(const char *fmt, ...);
]]