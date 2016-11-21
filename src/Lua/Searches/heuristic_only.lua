currentState = State.new(nil)
currentState.Tiles = {
    0, 0, 0, 0,
    0, 0, 0, 0,
    0, 0, 0, 0,
    0, 0, 0, 0
}
math.randomseed(os.time())
currentState.Tiles[math.random(#currentState.Tiles)] = math.random(2)*2

time.reset()
while (true) do
    local decisions = {}
    currentState:Branch()
    for k, v in pairs(currentState.Tree) do
	    local h = monotonicity2(currentState.Tree[k]) + empty_tiles(currentState.Tree[k]) + currentState.Tree[k].AdjacencyBonus*0.25
	    decisions[k] = h
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
        currentState.Tree[direction]:Spawn()
        currentState = currentState.Tree[direction].Tree[math.random(#currentState.Tree[direction].Tree)]
    else
        currentState:Print()
        break
    end
end
print(gscore(currentState))
print("Time: " .. time.getElapsed())