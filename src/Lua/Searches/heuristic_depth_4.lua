local currentState = State.new(nil)
currentState.Tiles = {
    0, 0, 0, 0,
    0, 0, 0, 0,
    0, 0, 0, 0,
    0, 0, 0, 0
}
math.randomseed(os.time())
currentState.Tiles[math.random(#currentState.Tiles)] = math.random(2)*2
currentState:Print()

local decisions = {}
local leaf_nodes = {}
function Minimax()
    currentState:Branch()
    decisions = {}
    leaf_nodes = {}
    for a, b in pairs(currentState.Tree) do
	    b:Spawn()
        for c, d in pairs(b.Tree) do
            d:Branch()
            for e, f in pairs(d.Tree) do
	            f:Spawn()
                for g, h in pairs(f.Tree) do
                    h:Branch()
                    for i, j in pairs(h.Tree) do
	                    local heuristic = monotonicity(j) + empty_tiles(j) + j.AdjacencyBonus*0.25
                        j.Heuristic = heuristic
                        table.insert(leaf_nodes, j)
                    end
                    h.Tree = nil
                end
                f.Tree = nil
            end
            d.Tree = nil
        end
        b.Tree = nil
    end
end

while (true) do
    Minimax()

    local max = -math.huge
    local desiredState
    for k, v in pairs(leaf_nodes) do
        if (max<v.Heuristic) then
            max = v.Heuristic
            desiredState = v
            currentState = v.Parent.Parent.Parent.Parent
        end
    end

    clear()
    print("Current Score: "..gscore(currentState).."\n")
    if (desiredState==nil) then
        break
    end
    print("Trying to approach state:")
    desiredState:Print()
    print("By moving to...")
    currentState:Print()
    print("Spawning...")
    currentState.Tree = {}
    currentState:Spawn()
    currentState = currentState.Tree[math.random(#currentState.Tree)]
    currentState:Print()
end
