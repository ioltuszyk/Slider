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


local leaf_nodes = {}
local total = 0
function Search()
    currentState:Branch()

    leaf_nodes = {}
    total = 0
    if (currentState.MoveCount>0) then
        for a, b in pairs(currentState.Tree) do
	        b:Spawn()
            if (#b.Tree~=0) then
                for c, d in pairs(b.Tree) do
                    d:Branch()
                    if (d.MoveCount>0) then
                        for e, f in pairs(d.Tree) do
	                        f:Spawn()
                            if (#f.Tree~=0) then
                                    for g, h in pairs(f.Tree) do
                                        h:Branch()
                                        if (h.MoveCount>0) then
                                            for i, j in pairs(h.Tree) do
	                                            j:Spawn()
                                                if (#j.Tree~=0) then
                                                    for k, l in pairs(j.Tree) do
                                                        l:Branch()
                                                        if (l.MoveCount>0) then
                                                            for n, o in pairs(l.Tree) do
                                                                local heuristic = Heuristics.Emptiness(o)*2 + Heuristics.Monotonicity(o)/Heuristics.Score(o)
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
	print("Current Score: "..Heuristics.Score(currentState))
	if (desiredState==nil) then
        currentState:Print()
        wait(2.5)
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