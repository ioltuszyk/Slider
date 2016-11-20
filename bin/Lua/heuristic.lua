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
	Tiles = {1, 0, 1, 0, 1, 1, 1, 0, 1, 1, 0, 1, 1, 1, 1, 1}
}

time.reset()
for n=1, 200000 do
	h = empty_tiles(state)
end
print("Empty Tiles: " .. time.getElapsed())

print(h)

function merges(state)
	--not optimized for the position its moving into, ill leave it like this until i can test it properly.
	local cur = 1
	local merge = 0
	
	while cur < 16 do
		print("cur: ".. cur)
		if (state.Tiles[cur] == state.Tiles[cur + 1]) then
			merge = merge + 1
			if (cur == 3) then
				cur = 5
			elseif (cur == 7) then
				cur = 9
			elseif (cur == 11) then
				cur = 13
			else
				cur = cur + 2
			end
		else
			cur = cur + 1
			print("hello")
		end
	end
	--cur = 1
	--[[while true do
		if (cur >= 16) do
			break
		end

		if (state.Tiles[cur] == state.Tiles[cur + 4]) then
			merge = merge + 1
			cur = cur + 8

			if (cur >= 13) then
				cur = 2
			end
			if (cur >= 14) then
				cur = 3
			end
			if (cur >= 15) then
				cur = 4
			end
		else
			cur = cur + 1
		end
	end]]--
	return merge
end

state = {
	Tiles = {1, 0, 1, 0, 1, 1, 1, 0, 1, 1, 0, 1, 1, 1, 1, 1}
}

time.reset()
--for n=1, 20 do
h = merges(state)
--end
print("Merges: " .. time.getElapsed())

print(h)
