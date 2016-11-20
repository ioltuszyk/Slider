print("Manual Input Enabled")

currentState = State.new(nil)
currentState.Tiles = {
    0, 0, 0, 2,
    0, 0, 0, 0,
    0, 0, 0, 0,
    2, 0, 0, 0
}
math.randomseed(os.time())
--currentState.Tiles[math.random(#currentState.Tiles)] = math.random(2)*2
--currentState:Print()
currentState:Branch()
time.reset()

currentState:Print()
while (true) do
    local decisions = {}
    currentState:Branch()
    for k, v in pairs(currentState.Tree) do
	    --currentState.Tree[k]:Print()
	    h = monotonicity(currentState.Tree[k]) + empty_tiles(currentState.Tree[k]) + currentState.Tree[k].AdjacencyBonus
	    decisions[k] = h
	    print("Move: " .. k .. " Heuristic: ".. h .." Mono: " ..monotonicity(currentState.Tree[k]) .. " Empty: " ..empty_tiles(currentState.Tree[k]).. " Adj: " ..currentState.Tree[k].AdjacencyBonus)
    end
    local max = -math.huge
    local direction = nil
    for k, v in pairs(decisions) do
	    if (v > max) then
		    max = v
		    direction = k
	    end
    end
    if (direction~=nil) then
        print("Direction: "..direction.." Heuristic: " .. max)
        currentState.Tree[direction]:Spawn()
        currentState = currentState.Tree[direction].Tree[math.random(#currentState.Tree[direction].Tree)]
    else
        break
    end
end
--[=====[while (true) do
    local decisions = {}
    currentState:Branch()
    for k, v in pairs(currentState.Tree) do
	    table.insert(decisions, k)
    end
    if (#decisions~=0) then
        local index = math.random(#decisions)
        currentState.Tree[decisions[index]]:Spawn()
        currentState = currentState.Tree[decisions[index]].Tree[math.random(#currentState.Tree[decisions[index]].Tree)]
    else
        break
    end
end--]=====]
currentState:Print()
--end
print("Time: " .. time.getElapsed())
-- Uncomment for stress testing; manual keys enabled in slider.cpp