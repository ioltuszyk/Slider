print("Manual Input Enabled")

currentState = State.new(nil)
currentState.Tiles = {
    0, 0, 0, 0, 0
    0, 0, 0, 0, 0
    0, 0, 0, 0, 0
    0, 0, 0, 0, 0
}
currentState:Print()

--[[
time.reset()

for i=1, 50000 do
    initialState:Branch()
end
initialState.Tree[144322]:Print()

print(time.getElapsed())
]]

-- Uncomment for stress testing; manual keys enabled in slider.cpp