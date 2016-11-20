function empty_tiles(state)
	--time.reset()
	emptytiles = 0
	for i=1, 16 do
		if (state.Tiles[i] == 0) then
			emptytiles = emptytiles + 1
		end
	end
	--print(time.getElapsed())
	return emptytiles
end

state = {
	Tiles = {2048, 0, 1024, 512, 257, 16, 32, 64, 128, 8, 4, 2, 0, 0, 0, 0}
}

--[[time.reset()
for n=1, 200000 do
	h = empty_tiles(state)
end
print("Empty Tiles: " ..h)
print("Time: " .. time.getElapsed())]]--

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
	for i=1, 16 do
		table.insert(tile_dic, {state.Tiles[i], i, 0, false}) --value, index, mat dist, checked
	end

	--get largest tile value
	local ideal = 1
	local checked = 1
	local max = 0

	while checked < 17 do
		for i=1, 16 do
			if (tile_dic[i][1] > max and tile_dic[i][4] == false) then
				max = tile_dic[i][1]
				index = tile_dic[i][2]
			end
		end
		if (max == 0) then
			break
		end
		tile_dic[index][3] = manhatten_dist(ideal, index)
		tile_dic[index][4] = true

		--Updating values
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
		max = 0
		checked = checked + 1

	end
	h = 0
	for i=1, 16 do
		h = h + (tile_dic[i][3] * tile_dic[i][1])
	end
	return -h
end

time.reset()
for n=1, 200000 do
	h = -monotonicity(state)
end
print("Monotonicity: "..h)
print("Time: " .. time.getElapsed())
