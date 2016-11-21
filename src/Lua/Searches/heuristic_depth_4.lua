scores={}
for i=1, 32 do
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
												local heuristic = monotonicity2(j)*0.25 + j.AdjacencyBonus*0.25 + empty_tiles(j)
												j.Heuristic = heuristic
												table.insert(leaf_nodes, j)
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

		--clear()
		print("Current Score: "..gscore(currentState))
		--currentState:Print()
		if (desiredState==nil) then
			table.insert(scores, gscore(currentState))
			break
		end
		--print("Trying to approach state:")
		--print("Heuristic: "..desiredState.Heuristic)
		--desiredState:Print()
		--print("By moving to...")
		--currentState:Print()
		--print("Spawning...")
		currentState.Tree = {}
		currentState:Spawn()
		if (#currentState.Tree)~=0 then
			currentState = currentState.Tree[math.random(#currentState.Tree)]
			--currentState:Print()
		else
			--currentState:Print()
			break
		end
	end
end
avg = 0
for i=1, 1 do
	avg = avg + scores[i]
end
avg = avg/32
print("Average: "..avg)