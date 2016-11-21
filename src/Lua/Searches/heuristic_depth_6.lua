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
local total = 0
function Search()
    currentState:Branch()
    decisions = {}
    leaf_nodes = {}
    total = 0
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
	                                            j:Spawn()
                                                if (#j.Tree~=0) then
                                                    for k, l in pairs(j.Tree) do
                                                        l:Branch()
                                                        if (l.Tree.Left~=nil or l.Tree.Right~=nil or l.Tree.Up~=nil or l.Tree.Down~=nil) then
                                                            for n, o in pairs(l.Tree) do
                                                                local heuristic = monotonicity2(o)*2 + empty_tiles(o) + o.AdjacencyBonus*0.25
								                                o.Heuristic = heuristic
                                                                table.insert(leaf_nodes, o)
                                                                total=total+1
                                                            end
                                                        end
                                                        l.Tree = nil
                                                    end
                                                end
                                                j.Tree = nil
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
            currentState = v.Parent.Parent.Parent.Parent.Parent.Parent
        end
    end

    clear()
    print("Current Score: "..gscore(currentState).."\n")
	
	currentState:Print()
    if (desiredState==nil) then
        break
    end
    print("Trying to approach state:")
	print("Heuristic: "..desiredState.Heuristic)-- Mono: "..monotonicity2(desiredState)*2.." Empty Tiles: "..empty_tiles(desiredState).." Adj: "..desiredState.AdjacencyBonus*0.25)
    desiredState:Print()
    print("By moving to...")
    currentState:Print()
    print("Spawning...")
    currentState.Tree = {}
    currentState:Spawn()
    currentState = currentState.Tree[math.random(#currentState.Tree)]
    currentState:Print()
end
