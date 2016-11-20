--print("Running")
--state = {Tiles = {2048, 0, 1024, 512, 257, 16, 32, 64, 128, 8, 4, 2, 0, 0, 0, 0}}
function empty_tiles(state)
	emptytiles = 0
	if (state.Tiles[1] == 0) then emptytiles = emptytiles + 1 end 
	if (state.Tiles[2] == 0) then emptytiles = emptytiles + 1 end 
	if (state.Tiles[3] == 0) then emptytiles = emptytiles + 1 end 
	if (state.Tiles[4] == 0) then emptytiles = emptytiles + 1 end 
	if (state.Tiles[5] == 0) then emptytiles = emptytiles + 1 end 
	if (state.Tiles[6] == 0) then emptytiles = emptytiles + 1 end 
	if (state.Tiles[7] == 0) then emptytiles = emptytiles + 1 end 
	if (state.Tiles[8] == 0) then emptytiles = emptytiles + 1 end 
	if (state.Tiles[9] == 0) then emptytiles = emptytiles + 1 end 
	if (state.Tiles[10] == 0) then emptytiles = emptytiles + 1 end 
	if (state.Tiles[11] == 0) then emptytiles = emptytiles + 1 end 
	if (state.Tiles[12] == 0) then emptytiles = emptytiles + 1 end
	if (state.Tiles[13] == 0) then emptytiles = emptytiles + 1 end 
	if (state.Tiles[14] == 0) then emptytiles = emptytiles + 1 end 
	if (state.Tiles[15] == 0) then emptytiles = emptytiles + 1 end 
	if (state.Tiles[16] == 0) then emptytiles = emptytiles + 1 end
	return emptytiles
end

--[[for i=1, 5 do
	time.reset()
	for n=1, 200000 do
		h = empty_tiles(state)
	end
	t = time.getElapsed()
	print("Empty Tiles: " ..h)
	print("Time: " .. t)
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

	return math.abs(ax - ix) + math.abs(ay - iy)
end

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

	while checked < 17 do
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
		if (1 <= ideal and ideal < 4) then
			ideal = ideal + 1
		elseif (ideal == 4) then
			ideal = 8
		elseif (5 < ideal and ideal <= 8) then
			ideal = ideal - 1
		elseif (ideal == 5) then
			ideal = 9
		elseif (9 <= ideal and ideal < 12) then
			ideal = ideal + 1
		elseif (ideal == 12) then
			ideal = 16
		elseif (13 < ideal and ideal <= 16) then
			ideal = ideal - 1
		end
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
	return -h
end
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
