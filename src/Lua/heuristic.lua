Heuristics = {}

function Heuristics.Emptiness(state)
	local n_empty = 0
	if (state.Tiles[1] == 0) then n_empty = n_empty + 1 end 
	if (state.Tiles[2] == 0) then n_empty = n_empty + 1 end 
	if (state.Tiles[3] == 0) then n_empty = n_empty + 1 end 
	if (state.Tiles[4] == 0) then n_empty = n_empty + 1 end 
	if (state.Tiles[5] == 0) then n_empty = n_empty + 1 end 
	if (state.Tiles[6] == 0) then n_empty = n_empty + 1 end 
	if (state.Tiles[7] == 0) then n_empty = n_empty + 1 end 
	if (state.Tiles[8] == 0) then n_empty = n_empty + 1 end 
	if (state.Tiles[9] == 0) then n_empty = n_empty + 1 end 
	if (state.Tiles[10] == 0) then n_empty = n_empty + 1 end 
	if (state.Tiles[11] == 0) then n_empty = n_empty + 1 end 
	if (state.Tiles[12] == 0) then n_empty = n_empty + 1 end
	if (state.Tiles[13] == 0) then n_empty = n_empty + 1 end 
	if (state.Tiles[14] == 0) then n_empty = n_empty + 1 end 
	if (state.Tiles[15] == 0) then n_empty = n_empty + 1 end 
	if (state.Tiles[16] == 0) then n_empty = n_empty + 1 end
    return n_empty
end

function Heuristics.Monotonicity(state)
    local n_monotonic = 0
    -- promotes decreasing left->right
    local a = state.Tiles[1]-state.Tiles[2]-state.Tiles[3]-state.Tiles[4] + state.Tiles[2]-state.Tiles[3]-state.Tiles[4] + state.Tiles[3]-state.Tiles[4]
    local b = state.Tiles[5]-state.Tiles[6]-state.Tiles[7]-state.Tiles[8] + state.Tiles[6]-state.Tiles[7]-state.Tiles[8] + state.Tiles[7]-state.Tiles[8]
    local c = state.Tiles[9]-state.Tiles[10]-state.Tiles[11]-state.Tiles[12] + state.Tiles[10]-state.Tiles[11]-state.Tiles[12] + state.Tiles[11]-state.Tiles[12]
    local d = state.Tiles[13]-state.Tiles[14]-state.Tiles[15]-state.Tiles[16] + state.Tiles[14]-state.Tiles[15]-state.Tiles[16] + state.Tiles[15]-state.Tiles[16]
    n_monotonic = n_monotonic + a+b+c+d

    -- promotes decreasing up->right
    a = state.Tiles[1]-state.Tiles[5]-state.Tiles[9]-state.Tiles[13] + state.Tiles[5]-state.Tiles[9]-state.Tiles[13] + state.Tiles[9]-state.Tiles[13]
    b = state.Tiles[2]-state.Tiles[6]-state.Tiles[10]-state.Tiles[14] + state.Tiles[6]-state.Tiles[10]-state.Tiles[14] + state.Tiles[10]-state.Tiles[14]
    c = state.Tiles[3]-state.Tiles[7]-state.Tiles[11]-state.Tiles[15] + state.Tiles[7]-state.Tiles[11]-state.Tiles[15] + state.Tiles[11]-state.Tiles[15]
    d = state.Tiles[4]-state.Tiles[8]-state.Tiles[12]-state.Tiles[16] + state.Tiles[8]-state.Tiles[12]-state.Tiles[16] + state.Tiles[12]-state.Tiles[16]
    n_monotonic = n_monotonic + a+b+c+d
    return n_monotonic
end

function Heuristics.Score(state)
    score = 0
    for i=1, 16 do
        score = score + state.Tiles[i]
    end
    return score
end
