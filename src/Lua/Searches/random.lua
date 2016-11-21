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
	    table.insert(decisions, k)
    end
    if (#decisions~=0) then
        local index = math.random(#decisions)
        currentState.Tree[decisions[index]]:Spawn()
        currentState = currentState.Tree[decisions[index]].Tree[math.random(#currentState.Tree[decisions[index]].Tree)]
    else
        currentState:Print()
        break
    end
end
print(gscore(currentState))
print("Time: " .. time.getElapsed())