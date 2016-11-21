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

function Minimax()
    currentState:Branch()
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
	                                        local heuristic = monotonicity(j) + empty_tiles(j) + j.AdjacencyBonus*0.25
                                            j.Heuristic = heuristic
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


    if (currentState.MoveCount>0) then
        local decision
        for a, b in pairs(currentState.Tree) do
            if (#b.Tree~=0) then
                for c, d in pairs(b.Tree) do
                    if (d.MoveCount>0) then
                        for e, f in pairs(d.Tree) do
                            if (#f.Tree~=0) then
                                for g, h in pairs(f.Tree) do
                                    if (h.MoveCount>0) then
                                        for i, j in pairs(h.Tree) do
                                            if h.Heuristic<(-j.Heuristic) then
                                                h.Heuristic = -j.Heuristic
                                            end
                                        end
                                    end
                                    h.Tree = nil
                                    if f.Heuristic<(-h.Heuristic) then
                                        f.Heuristic = -h.Heuristic
                                    end
                                end
                            end
                            f.Tree = nil
                            if d.Heuristic<(-f.Heuristic) then
                                d.Heuristic = -f.Heuristic
                            end
                        end
                    end
                    if b.Heuristic<(-d.Heuristic) then
                        b.Heuristic = -d.Heuristic
                    end
                    d.Tree = nil
                end
            end
            b.Tree = nil
            if currentState.Heuristic<(-b.Heuristic) then
                currentState.Heuristic = -b.Heuristic
                decision = b
            end
            return decision
        end
    end
end

while (true) do
    currentState = Minimax()
    currentState:Print()
    clear()
    print("Score: "..gscore(currentState).."\n")
    if (currentState==nil) then
        break
    end
    print("Moved to:")
    currentState:Print()
    print("From:")
    currentState.Parent:Print()
    print("Spawning...")
    currentState.Tree = {}
    currentState:Spawn()
    if (#currentState.Tree)~=0 then
        currentState = currentState.Tree[math.random(#currentState.Tree)]
    else
        break
    end
end
