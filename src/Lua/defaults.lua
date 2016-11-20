print("Manual Input Enabled")

currentState = State.new(nil)
currentState.Tiles = {
    0, 0, 128, 16,
    2, 64, 32, 32,
    4, 512, 0, 16,
    4, 512, 0, 0
}
math.randomseed(os.time())
--currentState.Tiles[math.random(#currentState.Tiles)] = math.random(2)*2
--currentState:Print()
currentState:Branch()
time.reset()
--for i=1, 50000 do
local decisions = {}
currentState:Branch()
for k, v in pairs(currentState.Tree) do
	currentState.Tree[k]:Print()
	h = monotonicity(currentState.Tree[k]) + empty_tiles(currentState.Tree[k]) + currentState.Tree[k].AdjacencyBonus
	decisions[k] = h
	print("Move: " .. k .. " Heuristic: ".. h .." Mono: " ..monotonicity(currentState.Tree[k]) .. " Empty: " ..empty_tiles(currentState.Tree[k]).. " Adj: " ..currentState.Tree[k].AdjacencyBonus)
end

local max = -math.huge
local direction
for k, v in pairs(decisions) do
	if (v > max) then
		max = v
		direction = k
	end
end

print("Direction: "..direction.." Heuristic: " .. max)
--end
print("Time: " .. time.getElapsed())
-- Uncomment for stress testing; manual keys enabled in slider.cpp