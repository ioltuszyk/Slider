--[[for i=1, 5 do
	time.reset()
	for n=1, 200000 do
		h = Heuristics.Emptiness(state)
	end
	t = time.getElapsed()
	print("Empty Tiles: " ..h)
	print("Time: " .. t)
end]]--
--[[
for i=1, 5 do
	time.reset()
	for n=1, 200000 do
		h = -monotonicity(state)
	end
	t = time.getElapsed()
	print("Monotonicity: "..h)
	print("Time: " .. t)
end]]--

--[[function score(state)
	for i=1, 16 do
		
	end
end]]--

function manhatten_dist(ideal, actual)
	if (ideal == actual) then
		return 0
	end
	if(actual == 4 or actual == 8 or actual == 12 or actual == 16) then
		ax = 4
	else
		ax = actual % 4
	end
	ay = math.ceil(actual/4)

	if(ideal == 4 or ideal == 8 or ideal == 12 or ideal == 16) then
		ix = 4
	else
		ix = ideal % 4
	end
	iy = math.ceil(ideal/4)

	--print("ideal= " .. ideal .. " actual= ".. actual)
	--print("ax= ".. ax .." ay= ".. ay .." ix= ".. ix .." iy= ".. iy .. " Dist= ".. math.abs(ax - ix) + math.abs(ay - iy))

	return (math.abs(ax - ix) + math.abs(ay - iy))
end

function dist(ideal, actual)
	--print("ideal= " .. ideal .. " actual= ".. actual)
	if (ideal == actual) then
		return 0
	end
	if(actual == 4 or actual == 8 or actual == 12 or actual == 16) then
		ax = 4
	else
		ax = actual % 4
	end

	if(ideal == 4 or ideal == 8 or ideal == 12 or ideal == 16) then
		ix = 4
	else
		ix = ideal % 4
	end
	return math.abs(ax - ix)
end
function col_dist(ideal, actual)
	if (ideal == actual) then
		return 0
	end
	if(actual == 1 or actual == 2 or actual == 3 or actual == 4) then ay = 1
	elseif(actual == 5 or actual == 6 or actual == 7 or actual == 8) then ay = 2
	elseif(actual == 9 or actual == 10 or actual == 11 or actual == 12) then ay = 3
	elseif(actual == 13 or actual == 14 or actual == 15 or actual == 16) then ay = 4 end

	if(ideal == 1 or ideal == 2 or ideal == 3 or ideal == 4) then iy = 1
	elseif(ideal == 5 or ideal == 6 or ideal == 7 or ideal == 8) then iy = 2
	elseif(ideal == 9 or ideal == 10 or ideal == 11 or ideal == 12) then iy = 3
	elseif(ideal == 13 or ideal == 14 or ideal == 15 or ideal == 16) then iy = 4 end
	return math.abs(ay - iy)
end
function Heuristics.Monotonicity(state)
	local tile_dic = {}
	table.insert(tile_dic, {state.Tiles[1], 1, 0, false, 0}) --value, index, row dist, checked, col dist
	table.insert(tile_dic, {state.Tiles[2], 2, 0, false, 0})
	table.insert(tile_dic, {state.Tiles[3], 3, 0, false, 0})
	table.insert(tile_dic, {state.Tiles[4], 4, 0, false, 0})

	table.insert(tile_dic, {state.Tiles[5], 5, 0, false, 0})
	table.insert(tile_dic, {state.Tiles[6], 6, 0, false, 0})
	table.insert(tile_dic, {state.Tiles[7], 7, 0, false, 0})
	table.insert(tile_dic, {state.Tiles[8], 8, 0, false, 0})

	table.insert(tile_dic, {state.Tiles[9], 9, 0, false, 0})
	table.insert(tile_dic, {state.Tiles[10], 10, 0, false, 0})
	table.insert(tile_dic, {state.Tiles[11], 11, 0, false, 0})
	table.insert(tile_dic, {state.Tiles[12], 12, 0, false, 0})

	table.insert(tile_dic, {state.Tiles[13], 13, 0, false, 0})
	table.insert(tile_dic, {state.Tiles[14], 14, 0, false, 0})
	table.insert(tile_dic, {state.Tiles[15], 15, 0, false, 0})
	table.insert(tile_dic, {state.Tiles[16], 16, 0, false, 0})


	ideal = 1 --Row 1
	while ideal < 5 do
		max = 0
		if (tile_dic[1][1] > max and tile_dic[1][4] == false) then max = tile_dic[1][1] index = tile_dic[1][2] end
		if (tile_dic[2][1] > max and tile_dic[2][4] == false) then max = tile_dic[2][1] index = tile_dic[2][2] end
		if (tile_dic[3][1] > max and tile_dic[3][4] == false) then max = tile_dic[3][1] index = tile_dic[3][2] end
		if (tile_dic[4][1] > max and tile_dic[4][4] == false) then max = tile_dic[4][1] index = tile_dic[4][2] end
		if (max == 0) then
			break
		end
		tile_dic[index][3] = dist(ideal, index)
		tile_dic[index][4] = true
		ideal = ideal + 1
	end
	
	ideal = 5 --Row 2
	while ideal < 9 do
		max = 0
		if (tile_dic[5][1] > max and tile_dic[5][4] == false) then max = tile_dic[5][1] index = tile_dic[5][2] end
		if (tile_dic[6][1] > max and tile_dic[6][4] == false) then max = tile_dic[6][1] index = tile_dic[6][2] end
		if (tile_dic[7][1] > max and tile_dic[7][4] == false) then max = tile_dic[7][1] index = tile_dic[7][2] end
		if (tile_dic[8][1] > max and tile_dic[8][4] == false) then max = tile_dic[8][1] index = tile_dic[8][2] end
		if (max == 0) then
			break
		end
		tile_dic[index][3] = dist(ideal, index)
		tile_dic[index][4] = true
		ideal = ideal + 1
	end

	ideal = 9 --Row 3
	while ideal < 13 do
		max = 0
		if (tile_dic[9][1] > max and tile_dic[9][4] == false) then max = tile_dic[9][1] index = tile_dic[9][2] end
		if (tile_dic[10][1] > max and tile_dic[10][4] == false) then max = tile_dic[10][1] index = tile_dic[10][2] end
		if (tile_dic[11][1] > max and tile_dic[11][4] == false) then max = tile_dic[11][1] index = tile_dic[11][2] end
		if (tile_dic[12][1] > max and tile_dic[12][4] == false) then max = tile_dic[12][1] index = tile_dic[12][2] end
		if (max == 0) then
			break
		end
		tile_dic[index][3] = dist(ideal, index)
		tile_dic[index][4] = true
		ideal = ideal + 1
	end

	ideal = 13 --Row 4
	while ideal < 17 do
		max = 0
		if (tile_dic[13][1] > max and tile_dic[13][4] == false) then max = tile_dic[13][1] index = tile_dic[13][2] end
		if (tile_dic[14][1] > max and tile_dic[14][4] == false) then max = tile_dic[14][1] index = tile_dic[14][2] end
		if (tile_dic[15][1] > max and tile_dic[15][4] == false) then max = tile_dic[15][1] index = tile_dic[15][2] end
		if (tile_dic[16][1] > max and tile_dic[16][4] == false) then max = tile_dic[16][1] index = tile_dic[16][2] end
		if (max == 0) then
			break
		end
		tile_dic[index][3] = dist(ideal, index)
		tile_dic[index][4] = true
		ideal = ideal + 1
	end

	ideal = 1 --col 1
	while true do
		max = 0
		if (tile_dic[1][1] > max and tile_dic[1][4] == true) then max = tile_dic[1][1] index = tile_dic[1][2] end
		if (tile_dic[5][1] > max and tile_dic[5][4] == true) then max = tile_dic[5][1] index = tile_dic[5][2] end
		if (tile_dic[9][1] > max and tile_dic[9][4] == true) then max = tile_dic[9][1] index = tile_dic[9][2] end
		if (tile_dic[13][1] > max and tile_dic[13][4] == true) then max = tile_dic[13][1] index = tile_dic[13][2] end
		if (max == 0) then
			break
		end
		tile_dic[index][5] = col_dist(ideal, index)
		tile_dic[index][4] = false
		if ideal == 1 then ideal = 5 
		elseif ideal == 5 then ideal = 9
		elseif ideal == 9 then ideal = 13
		elseif ideal == 13 then break end
	end

	ideal = 2 --col 2
	while true do
		max = 0
		if (tile_dic[2][1] > max and tile_dic[2][4] == true) then max = tile_dic[2][1] index = tile_dic[2][2] end
		if (tile_dic[6][1] > max and tile_dic[6][4] == true) then max = tile_dic[6][1] index = tile_dic[6][2] end
		if (tile_dic[10][1] > max and tile_dic[10][4] == true) then max = tile_dic[10][1] index = tile_dic[10][2] end
		if (tile_dic[14][1] > max and tile_dic[14][4] == true) then max = tile_dic[14][1] index = tile_dic[14][2] end
		if (max == 0) then
			break
		end
		tile_dic[index][5] = col_dist(ideal, index)
		tile_dic[index][4] = false
		if ideal == 2 then ideal = 6 
		elseif ideal == 6 then ideal = 10
		elseif ideal == 10 then ideal = 14
		elseif ideal == 14 then break end
	end

	ideal = 3 --col 3
	while true do
		max = 0
		if (tile_dic[3][1] > max and tile_dic[3][4] == true) then max = tile_dic[3][1] index = tile_dic[3][2] end
		if (tile_dic[7][1] > max and tile_dic[7][4] == true) then max = tile_dic[7][1] index = tile_dic[7][2] end
		if (tile_dic[11][1] > max and tile_dic[11][4] == true) then max = tile_dic[11][1] index = tile_dic[11][2] end
		if (tile_dic[15][1] > max and tile_dic[15][4] == true) then max = tile_dic[15][1] index = tile_dic[15][2] end
		if (max == 0) then
			break
		end
		tile_dic[index][5] = col_dist(ideal, index)
		tile_dic[index][4] = false
		if ideal == 3 then ideal = 7 
		elseif ideal == 7 then ideal = 11
		elseif ideal == 11 then ideal = 15
		elseif ideal == 15 then break end
	end

		ideal = 4 --col 4
	while true do
		max = 0
		if (tile_dic[4][1] > max and tile_dic[4][4] == true) then max = tile_dic[4][1] index = tile_dic[4][2] end
		if (tile_dic[8][1] > max and tile_dic[8][4] == true) then max = tile_dic[8][1] index = tile_dic[8][2] end
		if (tile_dic[12][1] > max and tile_dic[12][4] == true) then max = tile_dic[12][1] index = tile_dic[12][2] end
		if (tile_dic[16][1] > max and tile_dic[16][4] == true) then max = tile_dic[16][1] index = tile_dic[16][2] end
		if (max == 0) then
			break
		end
		tile_dic[index][5] = col_dist(ideal, index)
		tile_dic[index][4] = false
		if ideal == 4 then ideal = 8 
		elseif ideal == 8 then ideal = 12
		elseif ideal == 12 then ideal = 16
		elseif ideal == 16 then break end
	end


	h = (tile_dic[1][1] * tile_dic[1][3])+(tile_dic[2][1] * tile_dic[2][3])+(tile_dic[3][1] * tile_dic[3][3])+(tile_dic[4][1] * tile_dic[4][3])+(tile_dic[5][1] * tile_dic[5][3])+(tile_dic[6][1] * tile_dic[6][3])+(tile_dic[7][1] * tile_dic[7][3])+(tile_dic[8][1] * tile_dic[8][3])+(tile_dic[9][1] * tile_dic[9][3])+(tile_dic[10][1] * tile_dic[10][3])+(tile_dic[11][1] * tile_dic[11][3])+(tile_dic[12][1] * tile_dic[12][3])+(tile_dic[13][1] * tile_dic[13][3])+(tile_dic[14][1] * tile_dic[14][3])+(tile_dic[15][1] * tile_dic[15][3])+(tile_dic[16][1] * tile_dic[16][3])
	h = h + (tile_dic[1][1] * tile_dic[1][5])+(tile_dic[2][1] * tile_dic[2][5])+(tile_dic[3][1] * tile_dic[3][5])+(tile_dic[4][1] * tile_dic[4][5])+(tile_dic[5][1] * tile_dic[5][5])+(tile_dic[6][1] * tile_dic[6][5])+(tile_dic[7][1] * tile_dic[7][5])+(tile_dic[8][1] * tile_dic[8][5])+(tile_dic[9][1] * tile_dic[9][5])+(tile_dic[10][1] * tile_dic[10][5])+(tile_dic[11][1] * tile_dic[11][5])+(tile_dic[12][1] * tile_dic[12][5])+(tile_dic[13][1] * tile_dic[13][5])+(tile_dic[14][1] * tile_dic[14][5])+(tile_dic[15][1] * tile_dic[15][5])+(tile_dic[16][1] * tile_dic[16][5])
	return -h
end

--[[for i=1, 1 do
	time.reset()
	for n=1, 1 do
		h = -Heuristics.Monotonicity(state)
	end
	t = time.getElapsed()
	print("Heuristics.Monotonicity: "..h)
	print("Time: " .. t)
end]]--

function monotonicity(state)
	local tile_dic = {}
	--[[for i=1, 16 do
	table.insert(tile_dic, {state.Tiles[i], i, 0, false}) --value, index, mat dist, checked
	end]]--
	table.insert(tile_dic, {state.Tiles[1], 1, 0, false}) --value, index, mat dist, checked
	table.insert(tile_dic, {state.Tiles[2], 2, 0, false})
	table.insert(tile_dic, {state.Tiles[3], 3, 0, false})
	table.insert(tile_dic, {state.Tiles[4], 4, 0, false})
	table.insert(tile_dic, {state.Tiles[5], 5, 0, false})
	table.insert(tile_dic, {state.Tiles[6], 6, 0, false})
	table.insert(tile_dic, {state.Tiles[7], 7, 0, false})
	table.insert(tile_dic, {state.Tiles[8], 8, 0, false})
	table.insert(tile_dic, {state.Tiles[9], 9, 0, false})
	table.insert(tile_dic, {state.Tiles[10], 10, 0, false})
	table.insert(tile_dic, {state.Tiles[11], 11, 0, false})
	table.insert(tile_dic, {state.Tiles[12], 12, 0, false})
	table.insert(tile_dic, {state.Tiles[13], 13, 0, false})
	table.insert(tile_dic, {state.Tiles[14], 14, 0, false})
	table.insert(tile_dic, {state.Tiles[15], 15, 0, false})
	table.insert(tile_dic, {state.Tiles[16], 16, 0, false})
	--get largest tile value
	local ideal = 1
	local checked = 1
	local max = 0

	while ideal < 5 do
		if (tile_dic[1][1] > max and tile_dic[1][4] == false) then max = tile_dic[1][1] index = tile_dic[1][2] end
		if (tile_dic[2][1] > max and tile_dic[2][4] == false) then max = tile_dic[2][1] index = tile_dic[2][2] end
		if (tile_dic[3][1] > max and tile_dic[3][4] == false) then max = tile_dic[3][1] index = tile_dic[3][2] end
		if (tile_dic[4][1] > max and tile_dic[4][4] == false) then max = tile_dic[4][1] index = tile_dic[4][2] end

		if (tile_dic[5][1] > max and tile_dic[5][4] == false) then max = tile_dic[5][1] index = tile_dic[5][2] end
		if (tile_dic[6][1] > max and tile_dic[6][4] == false) then max = tile_dic[6][1] index = tile_dic[6][2] end
		if (tile_dic[7][1] > max and tile_dic[7][4] == false) then max = tile_dic[7][1] index = tile_dic[7][2] end
		if (tile_dic[8][1] > max and tile_dic[8][4] == false) then max = tile_dic[8][1] index = tile_dic[8][2] end

		if (tile_dic[9][1] > max and tile_dic[9][4] == false) then max = tile_dic[9][1] index = tile_dic[9][2] end
		if (tile_dic[10][1] > max and tile_dic[10][4] == false) then max = tile_dic[10][1] index = tile_dic[10][2] end
		if (tile_dic[11][1] > max and tile_dic[11][4] == false) then max = tile_dic[11][1] index = tile_dic[11][2] end
		if (tile_dic[12][1] > max and tile_dic[12][4] == false) then max = tile_dic[12][1] index = tile_dic[12][2] end

		if (tile_dic[13][1] > max and tile_dic[13][4] == false) then max = tile_dic[13][1] index = tile_dic[13][2] end
		if (tile_dic[14][1] > max and tile_dic[14][4] == false) then max = tile_dic[14][1] index = tile_dic[14][2] end
		if (tile_dic[15][1] > max and tile_dic[15][4] == false) then max = tile_dic[15][1] index = tile_dic[15][2] end
		if (tile_dic[16][1] > max and tile_dic[16][4] == false) then max = tile_dic[16][1] index = tile_dic[16][2] end

		if (max == 0) then
			break
		end
		tile_dic[index][3] = manhatten_dist(ideal, index)
		tile_dic[index][4] = true

		--Updating values
		max = 0
		checked = checked + 1
		ideal = ideal+1
		--[[if ideal == 1 then ideal = 2 end
		if ideal == 2 then ideal = 3 end
		if ideal == 3 then ideal = 4 end
		if ideal == 4 then ideal = 8 end
		if ideal == 5 then ideal = 9 end
		if ideal == 6 then ideal = 5 end
		if ideal == 7 then ideal = 6 end
		if ideal == 8 then ideal = 7 end
		if ideal == 9 then ideal = 10 end
		if ideal == 10 then ideal = 11 end
		if ideal == 11 then ideal = 12 end
		if ideal == 12 then ideal = 16 end
		if ideal == 13 then ideal = 17 end
		if ideal == 14 then ideal = 13 end
		if ideal == 15 then ideal = 14 end
		if ideal == 16 then ideal = 15 end]]--

	end
	h = 0
	h = (tile_dic[1][1] * tile_dic[1][3])+(tile_dic[2][1] * tile_dic[2][3])+(tile_dic[3][1] * tile_dic[3][3])+(tile_dic[4][1] * tile_dic[4][3])+(tile_dic[5][1] * tile_dic[5][3])+(tile_dic[6][1] * tile_dic[6][3])+(tile_dic[7][1] * tile_dic[7][3])+(tile_dic[8][1] * tile_dic[8][3])+(tile_dic[9][1] * tile_dic[9][3])+(tile_dic[10][1] * tile_dic[10][3])+(tile_dic[11][1] * tile_dic[11][3])+(tile_dic[12][1] * tile_dic[12][3])+(tile_dic[13][1] * tile_dic[13][3])+(tile_dic[14][1] * tile_dic[14][3])+(tile_dic[15][1] * tile_dic[15][3])+(tile_dic[16][1] * tile_dic[16][3])
	return -h*0.6
end