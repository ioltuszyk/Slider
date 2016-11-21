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
	    local h = Heuristics.Emptiness(currentState.Tree[k])*2+Heuristics.Monotonicity(currentState.Tree[k])/Heuristics.Score(currentState.Tree[k])
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
print(Heuristics.Score(currentState))
print("Time: " .. time.getElapsed())