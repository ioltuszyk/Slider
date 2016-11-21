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
function Search()
    currentState:Branch()
    decisions = {}
    leaf_nodes = {}
    if (currentState.Tree.Left~=nil or currentState.Tree.Right~=nil or currentState.Tree.Up~=nil or currentState.Tree.Down~=nil) then
        for a, b in pairs(currentState.Tree) do
	        b:Spawn()
            if (#b.Tree~=0) then
                for c, d in pairs(b.Tree) do
                    d:Branch()
                    if (d.Tree.Left~=nil or d.Tree.Right~=nil or d.Tree.Up~=nil or d.Tree.Down~=nil) then
                        for e, f in pairs(d.Tree) do
	                        f:Spawn()
                            if (#f.Tree~=0) then
                                for g, h in pairs(f.Tree) do
                                    h:Branch()
                                    if (h.Tree.Left~=nil or h.Tree.Right~=nil or h.Tree.Up~=nil or h.Tree.Down~=nil) then
                                        for i, j in pairs(h.Tree) do
	                                        local heuristic = monotonicity(j) + empty_tiles(j) + j.AdjacencyBonus*0.25
                                            j.Heuristic = heuristic
                                            table.insert(leaf_nodes, j)
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
    end

    local highb = -math.huge
    local lowd = math.huge
    local highf = -math.huge
    local lowh = math.huge
    local highj = -math.huge
    local index = {nil, nil, nil, nil}
    if (currentState.Tree.Left~=nil or currentState.Tree.Right~=nil or currentState.Tree.Up~=nil or currentState.Tree.Down~=nil) then
        -- wants to pick highest from all b's:
        for a, b in pairs(currentState.Tree) do
            if (#b.Tree~=0) then
                -- wants to pick lowest from all d's
                for c, d in pairs(b.Tree) do
                        if (d.Tree.Left~=nil or d.Tree.Right~=nil or d.Tree.Up~=nil or d.Tree.Down~=nil) then
                        -- wants to pick highest from all f's
                        for e, f in pairs(d.Tree) do
                            if (#f.Tree~=0) then
                                -- wants to pick lowest from all h's
                                for g, h in pairs(f.Tree) do
                                    if (h.Tree.Left~=nil or h.Tree.Right~=nil or h.Tree.Up~=nil or h.Tree.Down~=nil) then
                                        -- wants to pick highest from all j's
                                        for i, j in pairs(h.Tree) do
                                            if (highj<=j.Heuristic) then
                                                highj = j.Heuristic
                                                index[4] = i
                                            end
                                        end
                                    end
                                    h.Tree = nil
                                end
                            end
                            f.Tree = nil
                        end
                    end
                    d.Tree = nil
                end
            end
            b.Tree = nil
        end
    end
end

while (true) do
    Search()

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
    if (#currentState.Tree)~=0 then
        currentState = currentState.Tree[math.random(#currentState.Tree)]
        currentState:Print()
    else
        currentState:Print()
        break
    end
end
