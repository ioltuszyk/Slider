collectgarbage()

Colors = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16}

Board = {
	Width = 4,
	Height = 4,
	Size = 16
}

State = {}
function State.new(parent)
	local state = {}
	setmetatable(state, {
        __index=State
    })

	state.Tiles = {}
	state.Parent = parent
    -- Heuristic-Related
    state.Heuristic = -math.huge
    state.AdjacencyBonus = 0
    --
	for i=1, Board.Size do
		state.Tiles[i] = 1
	end
	state.Tree = {}
    state.MoveCount = 0
    setmetatable(state.Tree, {
        __newindex = function (t,k,v)
            if (k=="Left" or k=="Right" or k=="Up" or k=="Down") then
                state.MoveCount = state.MoveCount + 1
            end
            rawset(t,k,v)
        end
    })
	return state
end

function State:Branch()
	local move_left = State.new(self)
    local move_left_changed = false
	move_left.Tiles = {unpack(self.Tiles)}
	for i=1, Board.Size, Board.Width do
		local values = {move_left.Tiles[i], move_left.Tiles[i+1], move_left.Tiles[i+2], move_left.Tiles[i+3]}
		local empty = false
		if (values[1]==0) then
			if (values[2]~=0) then
				values[1]=values[2]
				values[2] = 0
                move_left_changed = true
			elseif (values[3]~=0) then
				values[1]=values[3]
				values[3] = 0
                move_left_changed = true
			elseif (values[4]~=0) then
				values[1]=values[4]
				values[4] = 0
                move_left_changed = true
			else
				empty = true
			end
		end
		if (values[2]==0) then
			if (values[3]~=0) then
				values[2]=values[3]
				values[3] = 0
                move_left_changed = true
			elseif (values[4]~=0) then
				values[2]=values[4]
				values[4] = 0
                move_left_changed = true
			end
		end
		if (values[3]==0) then
			if (values[4]~=0) then
				values[3]=values[4]
				values[4] = 0
                move_left_changed = true
			end
		end
		if (not empty) then
			if (values[1]==values[2] and values[1]~=0) then
				values[1]=values[1]*2
				values[2]=0
                move_left.AdjacencyBonus = move_left.AdjacencyBonus+values[1]
                move_left_changed = true
			elseif (values[1]==values[3] and values[1]~=0 and values[2]==0) then
				values[1]=values[1]*2
				values[3]=0
                move_left.AdjacencyBonus = move_left.AdjacencyBonus+values[1]
                move_left_changed = true
			elseif (values[1]==values[4] and values[1]~=0 and values[2]==0 and values[3]==0) then
				values[1]=values[1]*2
				values[4]=0
                move_left.AdjacencyBonus = move_left.AdjacencyBonus+values[1]
                move_left_changed = true
			end
			if (values[2]==values[3] and values[2]~=0) then
				values[2]=values[2]*2
				values[3]=0
                move_left.AdjacencyBonus = move_left.AdjacencyBonus+values[2]
                move_left_changed = true
			elseif (values[2]==values[4] and values[2]~=0 and values[3]==0) then
				values[2]=values[2]*2
				values[4]=0
                move_left.AdjacencyBonus = move_left.AdjacencyBonus+values[2]
                move_left_changed = true
			end
			if (values[3]==values[4] and values[3]~=0) then
				values[3]=values[3]*2
				values[4]=0
                move_left.AdjacencyBonus = move_left.AdjacencyBonus+values[3]
                move_left_changed = true
			end
		end
		if (values[1]==0) then
			if (values[2]~=0) then
				values[1]=values[2]
				values[2] = 0
                move_left_changed = true
			elseif (values[3]~=0) then
				values[1]=values[3]
				values[3] = 0
                move_left_changed = true
			elseif (values[4]~=0) then
				values[1]=values[4]
				values[4] = 0
                move_left_changed = true
			else
				empty = true
			end
		end
		if (values[2]==0) then
			if (values[3]~=0) then
				values[2]=values[3]
				values[3] = 0
                move_left_changed = true
			elseif (values[4]~=0) then
				values[2]=values[4]
				values[4] = 0
                move_left_changed = true
			end
		end
		if (values[3]==0) then
			if (values[4]~=0) then
				values[3]=values[4]
				values[4] = 0
                move_left_changed = true
			end
		end
		for k,v in pairs(values) do
			move_left.Tiles[i-1+k]=values[k]
		end
    end
     
    local move_right = State.new(self)
    local move_right_changed = false
	move_right.Tiles = {unpack(self.Tiles)}
	for i=1, Board.Size, Board.Width do
		local values = {move_right.Tiles[i+3], move_right.Tiles[i+2], move_right.Tiles[i+1], move_right.Tiles[i]}
		local empty = false
		if (values[1]==0) then
			if (values[2]~=0) then
				values[1]=values[2]
				values[2] = 0
                move_right_changed = true
			elseif (values[3]~=0) then
				values[1]=values[3]
				values[3] = 0
                move_right_changed = true
			elseif (values[4]~=0) then
				values[1]=values[4]
				values[4] = 0
                move_right_changed = true
			else
				empty = true
			end
		end
		if (values[2]==0) then
			if (values[3]~=0) then
				values[2]=values[3]
				values[3] = 0
                move_right_changed = true
			elseif (values[4]~=0) then
				values[2]=values[4]
				values[4] = 0
                move_right_changed = true
			end
		end
		if (values[3]==0) then
			if (values[4]~=0) then
				values[3]=values[4]
				values[4] = 0
                move_right_changed = true
			end
		end
		if (not empty) then
			if (values[1]==values[2] and values[1]~=0) then
				values[1]=values[1]*2
				values[2]=0
                move_right.AdjacencyBonus = move_right.AdjacencyBonus+values[1]
                move_right_changed = true
			elseif (values[1]==values[3] and values[1]~=0 and values[2]==0) then
				values[1]=values[1]*2
				values[3]=0
                move_right.AdjacencyBonus = move_right.AdjacencyBonus+values[1]
                move_right_changed = true
			elseif (values[1]==values[4] and values[1]~=0 and values[2]==0 and values[3]==0) then
				values[1]=values[1]*2
				values[4]=0
                move_right.AdjacencyBonus = move_right.AdjacencyBonus+values[1]
                move_right_changed = true
			end
			if (values[2]==values[3] and values[2]~=0) then
				values[2]=values[2]*2
				values[3]=0
                move_right.AdjacencyBonus = move_right.AdjacencyBonus+values[2]
                move_right_changed = true
			elseif (values[2]==values[4] and values[2]~=0 and values[3]==0) then
				values[2]=values[2]*2
				values[4]=0
                move_right.AdjacencyBonus = move_right.AdjacencyBonus+values[2]
                move_right_changed = true
			end
			if (values[3]==values[4] and values[3]~=0) then
				values[3]=values[3]*2
				values[4]=0
                move_right.AdjacencyBonus = move_right.AdjacencyBonus+values[3]
                move_right_changed = true
			end
		end
		if (values[1]==0) then
			if (values[2]~=0) then
				values[1]=values[2]
				values[2] = 0
                move_right_changed = true
			elseif (values[3]~=0) then
				values[1]=values[3]
				values[3] = 0
                move_right_changed = true
			elseif (values[4]~=0) then
				values[1]=values[4]
				values[4] = 0
                move_right_changed = true
			else
				empty = true
			end
		end
		if (values[2]==0) then
			if (values[3]~=0) then
				values[2]=values[3]
				values[3] = 0
                move_right_changed = true
			elseif (values[4]~=0) then
				values[2]=values[4]
				values[4] = 0
                move_right_changed = true
			end
		end
		if (values[3]==0) then
			if (values[4]~=0) then
				values[3]=values[4]
				values[4] = 0
                move_right_changed = true
			end
		end
		for k,v in pairs(values) do
			move_right.Tiles[i+Board.Width-k]=values[k]
		end
  end

	local move_up = State.new(self)
    local move_up_changed = false
	move_up.Tiles = {unpack(self.Tiles)}
	for i=1, Board.Width, 1 do
		local values = {move_up.Tiles[i], move_up.Tiles[i+Board.Width], move_up.Tiles[i+Board.Width*2], move_up.Tiles[i+Board.Width*3]}
		local empty = false
		if (values[1]==0) then
			if (values[2]~=0) then
				values[1]=values[2]
				values[2] = 0
                move_up_changed = true
			elseif (values[3]~=0) then
				values[1]=values[3]
				values[3] = 0
                move_up_changed = true
			elseif (values[4]~=0) then
				values[1]=values[4]
				values[4] = 0
                move_up_changed = true
			else
				empty = true
			end
		end
		if (values[2]==0) then
			if (values[3]~=0) then
				values[2]=values[3]
				values[3] = 0
                move_up_changed = true
			elseif (values[4]~=0) then
				values[2]=values[4]
				values[4] = 0
                move_up_changed = true
			end
		end
		if (values[3]==0) then
			if (values[4]~=0) then
				values[3]=values[4]
				values[4] = 0
                move_up_changed = true
			end
		end
		if (not empty) then
			if (values[1]==values[2] and values[1]~=0) then
				values[1]=values[1]*2
				values[2]=0
                move_up.AdjacencyBonus = move_up.AdjacencyBonus+values[1]
                move_up_changed = true
			elseif (values[1]==values[3] and values[1]~=0 and values[2]==0) then
				values[1]=values[1]*2
				values[3]=0
                move_up.AdjacencyBonus = move_up.AdjacencyBonus+values[1]
                move_up_changed = true
			elseif (values[1]==values[4] and values[1]~=0 and values[2]==0 and values[3]==0) then
				values[1]=values[1]*2
				values[4]=0
                move_up.AdjacencyBonus = move_up.AdjacencyBonus+values[1]
                move_up_changed = true
			end
			if (values[2]==values[3] and values[2]~=0) then
				values[2]=values[2]*2
				values[3]=0
                move_up.AdjacencyBonus = move_up.AdjacencyBonus+values[2]
                move_up_changed = true
			elseif (values[2]==values[4] and values[2]~=0 and values[3]==0) then
				values[2]=values[2]*2
				values[4]=0
                move_up.AdjacencyBonus = move_up.AdjacencyBonus+values[2]
                move_up_changed = true
			end
			if (values[3]==values[4] and values[3]~=0) then
				values[3]=values[3]*2
				values[4]=0
                move_up.AdjacencyBonus = move_up.AdjacencyBonus+values[3]
                move_up_changed = true
			end
		end
		if (values[1]==0) then
			if (values[2]~=0) then
				values[1]=values[2]
				values[2] = 0
                move_up_changed = true
			elseif (values[3]~=0) then
				values[1]=values[3]
				values[3] = 0
                move_up_changed = true
			elseif (values[4]~=0) then
				values[1]=values[4]
				values[4] = 0
                move_up_changed = true
			else
				empty = true
			end
		end
		if (values[2]==0) then
			if (values[3]~=0) then
				values[2]=values[3]
				values[3] = 0
                move_up_changed = true
			elseif (values[4]~=0) then
				values[2]=values[4]
				values[4] = 0
                move_up_changed = true
			end
		end
		if (values[3]==0) then
			if (values[4]~=0) then
				values[3]=values[4]
				values[4] = 0
                move_up_changed = true
			end
	    end
		for k,v in pairs(values) do
			move_up.Tiles[i+(k-1)*(Board.Width)]=values[k]
		end
  end

	local move_down = State.new(self)
    local move_down_changed = false
	move_down.Tiles = {unpack(self.Tiles)}
	for i=1, Board.Width, 1 do
		local values = {move_down.Tiles[Board.Size-Board.Width+i], move_down.Tiles[Board.Size-Board.Width*2+i], move_down.Tiles[Board.Size-Board.Width*3+i], move_down.Tiles[i]}
		local empty = false
		if (values[1]==0) then
			if (values[2]~=0) then
				values[1]=values[2]
				values[2] = 0
                move_down_changed = true
			elseif (values[3]~=0) then
				values[1]=values[3]
				values[3] = 0
                move_down_changed = true
			elseif (values[4]~=0) then
				values[1]=values[4]
				values[4] = 0
                move_down_changed = true
			else
				empty = true
			end
		end
		if (values[2]==0) then
			if (values[3]~=0) then
				values[2]=values[3]
				values[3] = 0
                move_down_changed = true
			elseif (values[4]~=0) then
				values[2]=values[4]
				values[4] = 0
                move_down_changed = true
			end
		end
		if (values[3]==0) then
			if (values[4]~=0) then
				values[3]=values[4]
				values[4] = 0
                move_down_changed = true
			end
		end
		if (not empty) then
			if (values[1]==values[2] and values[1]~=0) then
				values[1]=values[1]*2
				values[2]=0
                move_down.AdjacencyBonus = move_down.AdjacencyBonus+values[1]
                move_down_changed = true
			elseif (values[1]==values[3] and values[1]~=0 and values[2]==0) then
				values[1]=values[1]*2
				values[3]=0
                move_down.AdjacencyBonus = move_down.AdjacencyBonus+values[1]
                move_down_changed = true
			elseif (values[1]==values[4] and values[1]~=0 and values[2]==0 and values[3]==0) then
				values[1]=values[1]*2
				values[4]=0
                move_down.AdjacencyBonus = move_down.AdjacencyBonus+values[1]
                move_down_changed = true
			end
			if (values[2]==values[3] and values[2]~=0) then
				values[2]=values[2]*2
				values[3]=0
                move_down.AdjacencyBonus = move_down.AdjacencyBonus+values[2]
                move_down_changed = true
			elseif (values[2]==values[4] and values[2]~=0 and values[3]==0) then
				values[2]=values[2]*2
				values[4]=0
                move_down.AdjacencyBonus = move_down.AdjacencyBonus+values[2]
                move_down_changed = true
			end
			if (values[3]==values[4] and values[3]~=0) then
				values[3]=values[3]*2
				values[4]=0
                move_down.AdjacencyBonus = move_down.AdjacencyBonus+values[3]
                move_down_changed = true
			end
		end
		if (values[1]==0) then
			if (values[2]~=0) then
				values[1]=values[2]
				values[2] = 0
                move_down_changed = true
			elseif (values[3]~=0) then
				values[1]=values[3]
				values[3] = 0
                move_down_changed = true
			elseif (values[4]~=0) then
				values[1]=values[4]
				values[4] = 0
                move_down_changed = true
			else
				empty = true
			end
		end
		if (values[2]==0) then
			if (values[3]~=0) then
				values[2]=values[3]
				values[3] = 0
                move_down_changed = true
			elseif (values[4]~=0) then
				values[2]=values[4]
				values[4] = 0
                move_down_changed = true
			end
		end
		if (values[3]==0) then
			if (values[4]~=0) then
				values[3]=values[4]
				values[4] = 0
                move_down_changed = true
			end
	  	end
		for k,v in pairs(values) do
			move_down.Tiles[Board.Size-(Board.Width)+i-(k-1)*Board.Width]=values[k]
		end
 	end

    if move_left_changed then self.Tree.Left = move_left else self.Tree.Left = nil end
	if move_right_changed then self.Tree.Right = move_right else self.Tree.Right = nil end
   	if move_up_changed then self.Tree.Up =  move_up else self.Tree.Up = nil end
	if move_down_changed then self.Tree.Down = move_down else self.Tree.Down = nil end
end

function State:Spawn()
    for k,v in pairs(self.Tiles) do
        if (v==0) then
            local valid_spawn = State.new(self)
            valid_spawn.Tiles = {unpack(self.Tiles)}
            valid_spawn.Tiles[k] = math.random(2)*2
            table.insert(self.Tree, valid_spawn)
        end
    end
end

function State:Print()
    printf(".-=-=-=-"..string.rep("=-=-=-=-", Board.Width)..".\n")
    printf("|       "..string.rep("        ", Board.Width).."|\n")
  
    for i=1, Board.Size, Board.Width do
	local values = {self.Tiles[i], self.Tiles[i+1], self.Tiles[i+2], self.Tiles[i+3]}
    if i~=Board.Size then
        printf("|\t")
        local a = (math.log(values[1])/math.log(2))
        local b = (math.log(values[2])/math.log(2))
        local c = (math.log(values[3])/math.log(2))
        local d = (math.log(values[4])/math.log(2))
        if a>=1 then
            colorize(tostring(values[1]).."\t", Colors[a])
        else
            printf("0\t")
        end
        if b>=1 then
            colorize(tostring(values[2]).."\t", Colors[b])
        else
            printf("0\t")
        end
        if c>=1 then
            colorize(tostring(values[3]).."\t", Colors[c])
        else
            printf("0\t")
        end
        if d>=1 then
            colorize(tostring(values[4]).."\t", Colors[d])
        else
            printf("0\t")
        end
        printf("|\n")
    end
  end
  printf("|       "..string.rep("        ", Board.Width).."|\n")
  printf("`-=-=-=-"..string.rep("=-=-=-=-", Board.Width).."'\n")
end
