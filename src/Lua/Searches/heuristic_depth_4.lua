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
function Search()
	currentState:Branch()
	decisions = {}
	leaf_nodes = {}
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
											local heuristic = Heuristics.Emptiness(j)--*2 + Heuristics.Monotonicity(j)--Heuristics.Score(j)
											j.Heuristic = heuristic
											table.insert(leaf_nodes, j)
										end
                                    else
                                        local heuristic = Heuristics.Emptiness(h)--*2 + Heuristics.Monotonicity(j)--Heuristics.Score(j)
										h.Heuristic = heuristic
                                        table.insert(leaf_nodes, h)
                                    end 
									h.Tree = nil
								end
							else
                                local heuristic = Heuristics.Emptiness(f)--*2 + Heuristics.Monotonicity(j)--Heuristics.Score(j)
								f.Heuristic = heuristic
                                table.insert(leaf_nodes, f)
                            end 
							f.Tree = nil
						end
					else
                        local heuristic = Heuristics.Emptiness(d)--*2 + Heuristics.Monotonicity(j)--Heuristics.Score(j)
						d.Heuristic = heuristic
                        table.insert(leaf_nodes, d)
                    end 
					d.Tree = nil
				end
			else
                local heuristic = Heuristics.Emptiness(b)--*2 + Heuristics.Monotonicity(j)--Heuristics.Score(j)
				b.Heuristic = heuristic
                table.insert(leaf_nodes, b)
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
            local par = v.Parent
            if (par~=nil) then
                par = par.Parent
                if (par~=nil) then
                    par = par.Parent
                    if (par~=nil) then
                        par = par.Parent
                    end
                end
            end
			currentState = par
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