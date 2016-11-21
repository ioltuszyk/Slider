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

function Max_Value(state)
    local val = -math.huge
    for k, successor in pairs(state.Tree) do
        if (val<successor.Heuristic) then
            val = successor.Heuristic
        end
    end
    return val
end

function Exp_Value(state) -- when looking at
    local val = 0
    local probability = 1/16
    for k, successor in pairs(state.Tree) do
        val = val+probability*successor.Heuristic
    end
    return val
end

function Expectimax(state)
	state:Branch()
	decisions = {}
	if (state.MoveCount>0) then
		for a, b in pairs(state.Tree) do
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
											local heuristic = Heuristics.Emptiness(j)*2 + Heuristics.Monotonicity(j)/gscore(j)
											j.Heuristic = heuristic
										end
                                        h.Heuristic = Max_Value(h)
									end
								end
                                f.Heuristic = Exp_Value(f)
							end
						end
                        d.Heuristic = Max_Value(d)
					end
				end
                b.Heuristic = Exp_Value(b)
			end
		end
        state.Heuristic = Max_Value(state)
	end

    local max_currentState = -math.huge
    local choice_currentState = nil
    for a, b in pairs(currentState.Tree) do
        if (max_currentState<b.Heuristic) then
            max_currentState = b.Heuristic
            choice_currentState = a
        end
    end
    return choice_currentState
end

while (true) do
	clear()
    print("Current Score: "..gscore(currentState))
    currentState:Print()
    local direction = Expectimax(currentState)
    currentState = currentState.Tree[direction]
    print("Moved to...")
    if (currentState==nil) then
        print("Nothing; there are no more moves")
        wait(2.5)
		break
	end
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
    wait(1)
end

print()