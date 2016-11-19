Board = {
	Width = 4,
	Height = 4,
	Size = 16
}

State = {}
State.__index = State
function State.new(parent)
	local state = {}
	setmetatable(state, State)
	state.Tiles = {}
	state.Parent = parent
	for i=1, Board.Size do
		state.Tiles[i] = 1
	end
	state.Tree = {}
	return state
end

function State:Branch()
	local move_left = State.new(self)
	move_left.Tiles = {unpack(self.Tiles)}
	for i=1, Board.Size, Board.Width do
		local values = {move_left.Tiles[i], move_left.Tiles[i+1], move_left.Tiles[i+2], move_left.Tiles[i+3]}
		local empty = false
		if (values[1]==0) then
			if (values[2]~=0) then
				values[1]=values[2]
				values[2] = 0
			elseif (values[3]~=0) then
				values[1]=values[3]
				values[3] = 0
			elseif (values[4]~=0) then
				values[1]=values[4]
				values[4] = 0
			else
				empty = true
			end
		end
		if (values[2]==0) then
			if (values[3]~=0) then
				values[2]=values[3]
				values[3] = 0
			elseif (values[4]~=0) then
				values[2]=values[4]
				values[4] = 0
			end
		end
		if (values[3]==0) then
			if (values[4]~=0) then
				values[3]=values[4]
				values[4] = 0
			end
		end
		if (not empty) then
			if (values[1]==values[2]) then
				values[1]=values[1]*2
				values[2]=0
			elseif (values[1]==values[3] and values[2]==0) then
				values[1]=values[1]*2
				values[3]=0
			elseif (values[1]==values[4] and values[2]==0 and values[3]==0) then
				values[1]=values[1]*2
				values[4]=0
			end
			if (values[2]==values[3]) then
				values[2]=values[2]*2
				values[3]=0
			elseif (values[2]==values[4] and values[3]==0) then
				values[2]=values[2]*2
				values[4]=0
			end
			if (values[3]==values[4]) then
				values[3]=values[3]*2
				values[4]=0
			end
		end
		if (values[1]==0) then
			if (values[2]~=0) then
				values[1]=values[2]
				values[2] = 0
			elseif (values[3]~=0) then
				values[1]=values[3]
				values[3] = 0
			elseif (values[4]~=0) then
				values[1]=values[4]
				values[4] = 0
			else
				empty = true
			end
		end
		if (values[2]==0) then
			if (values[3]~=0) then
				values[2]=values[3]
				values[3] = 0
			elseif (values[4]~=0) then
				values[2]=values[4]
				values[4] = 0
			end
		end
		if (values[3]==0) then
			if (values[4]~=0) then
				values[3]=values[4]
				values[4] = 0
			end
		end
		for k,v in pairs(values) do
			move_left.Tiles[i-1+k]=values[k]
		end
  end

  local move_right = State.new(self)
	move_right.Tiles = {unpack(self.Tiles)}
	for i=1, Board.Size, Board.Width do
		local values = {move_right.Tiles[i+3], move_right.Tiles[i+2], move_right.Tiles[i+1], move_right.Tiles[i]}
		local empty = false
		if (values[1]==0) then
			if (values[2]~=0) then
				values[1]=values[2]
				values[2] = 0
			elseif (values[3]~=0) then
				values[1]=values[3]
				values[3] = 0
			elseif (values[4]~=0) then
				values[1]=values[4]
				values[4] = 0
			else
				empty = true
			end
		end
		if (values[2]==0) then
			if (values[3]~=0) then
				values[2]=values[3]
				values[3] = 0
			elseif (values[4]~=0) then
				values[2]=values[4]
				values[4] = 0
			end
		end
		if (values[3]==0) then
			if (values[4]~=0) then
				values[3]=values[4]
				values[4] = 0
			end
		end
		if (not empty) then
			if (values[1]==values[2]) then
				values[1]=values[1]*2
				values[2]=0
			elseif (values[1]==values[3] and values[2]==0) then
				values[1]=values[1]*2
				values[3]=0
			elseif (values[1]==values[4] and values[2]==0 and values[3]==0) then
				values[1]=values[1]*2
				values[4]=0
			end
			if (values[2]==values[3]) then
				values[2]=values[2]*2
				values[3]=0
			elseif (values[2]==values[4] and values[3]==0) then
				values[2]=values[2]*2
				values[4]=0
			end
			if (values[3]==values[4]) then
				values[3]=values[3]*2
				values[4]=0
			end
		end
		if (values[1]==0) then
			if (values[2]~=0) then
				values[1]=values[2]
				values[2] = 0
			elseif (values[3]~=0) then
				values[1]=values[3]
				values[3] = 0
			elseif (values[4]~=0) then
				values[1]=values[4]
				values[4] = 0
			else
				empty = true
			end
		end
		if (values[2]==0) then
			if (values[3]~=0) then
				values[2]=values[3]
				values[3] = 0
			elseif (values[4]~=0) then
				values[2]=values[4]
				values[4] = 0
			end
		end
		if (values[3]==0) then
			if (values[4]~=0) then
				values[3]=values[4]
				values[4] = 0
			end
		end
		for k,v in pairs(values) do
			move_right.Tiles[i+Board.Width-k]=values[k]
		end
  end

	local move_up = State.new(self)
	move_up.Tiles = {unpack(self.Tiles)}
	for i=1, Board.Width, 1 do
		local values = {move_up.Tiles[i], move_up.Tiles[i+Board.Width], move_up.Tiles[i+Board.Width*2], move_up.Tiles[i+Board.Width*3]}
		local empty = false
		if (values[1]==0) then
			if (values[2]~=0) then
				values[1]=values[2]
				values[2] = 0
			elseif (values[3]~=0) then
				values[1]=values[3]
				values[3] = 0
			elseif (values[4]~=0) then
				values[1]=values[4]
				values[4] = 0
			else
				empty = true
			end
		end
		if (values[2]==0) then
			if (values[3]~=0) then
				values[2]=values[3]
				values[3] = 0
			elseif (values[4]~=0) then
				values[2]=values[4]
				values[4] = 0
			end
		end
		if (values[3]==0) then
			if (values[4]~=0) then
				values[3]=values[4]
				values[4] = 0
			end
		end
		if (not empty) then
			if (values[1]==values[2]) then
				values[1]=values[1]*2
				values[2]=0
			elseif (values[1]==values[3] and values[2]==0) then
				values[1]=values[1]*2
				values[3]=0
			elseif (values[1]==values[4] and values[2]==0 and values[3]==0) then
				values[1]=values[1]*2
				values[4]=0
			end
			if (values[2]==values[3]) then
				values[2]=values[2]*2
				values[3]=0
			elseif (values[2]==values[4] and values[3]==0) then
				values[2]=values[2]*2
				values[4]=0
			end
			if (values[3]==values[4]) then
				values[3]=values[3]*2
				values[4]=0
			end
		end
		if (values[1]==0) then
			if (values[2]~=0) then
				values[1]=values[2]
				values[2] = 0
			elseif (values[3]~=0) then
				values[1]=values[3]
				values[3] = 0
			elseif (values[4]~=0) then
				values[1]=values[4]
				values[4] = 0
			else
				empty = true
			end
		end
		if (values[2]==0) then
			if (values[3]~=0) then
				values[2]=values[3]
				values[3] = 0
			elseif (values[4]~=0) then
				values[2]=values[4]
				values[4] = 0
			end
		end
		if (values[3]==0) then
			if (values[4]~=0) then
				values[3]=values[4]
				values[4] = 0
			end
	  end
		for k,v in pairs(values) do
			move_up.Tiles[i+(k-1)*(Board.Width)]=values[k]
		end
  end

	local move_down = State.new(self)
	move_down.Tiles = {unpack(self.Tiles)}
	for i=1, Board.Width, 1 do
		local values = {move_down.Tiles[Board.Size-Board.Width+i], move_down.Tiles[Board.Size-Board.Width*2+i], move_down.Tiles[Board.Size-Board.Width*3+i], move_down.Tiles[i]}
		local empty = false
		if (values[1]==0) then
			if (values[2]~=0) then
				values[1]=values[2]
				values[2] = 0
			elseif (values[3]~=0) then
				values[1]=values[3]
				values[3] = 0
			elseif (values[4]~=0) then
				values[1]=values[4]
				values[4] = 0
			else
				empty = true
			end
		end
		if (values[2]==0) then
			if (values[3]~=0) then
				values[2]=values[3]
				values[3] = 0
			elseif (values[4]~=0) then
				values[2]=values[4]
				values[4] = 0
			end
		end
		if (values[3]==0) then
			if (values[4]~=0) then
				values[3]=values[4]
				values[4] = 0
			end
		end
		if (not empty) then
			if (values[1]==values[2]) then
				values[1]=values[1]*2
				values[2]=0
			elseif (values[1]==values[3] and values[2]==0) then
				values[1]=values[1]*2
				values[3]=0
			elseif (values[1]==values[4] and values[2]==0 and values[3]==0) then
				values[1]=values[1]*2
				values[4]=0
			end
			if (values[2]==values[3]) then
				values[2]=values[2]*2
				values[3]=0
			elseif (values[2]==values[4] and values[3]==0) then
				values[2]=values[2]*2
				values[4]=0
			end
			if (values[3]==values[4]) then
				values[3]=values[3]*2
				values[4]=0
			end
		end
		if (values[1]==0) then
			if (values[2]~=0) then
				values[1]=values[2]
				values[2] = 0
			elseif (values[3]~=0) then
				values[1]=values[3]
				values[3] = 0
			elseif (values[4]~=0) then
				values[1]=values[4]
				values[4] = 0
			else
				empty = true
			end
		end
		if (values[2]==0) then
			if (values[3]~=0) then
				values[2]=values[3]
				values[3] = 0
			elseif (values[4]~=0) then
				values[2]=values[4]
				values[4] = 0
			end
		end
		if (values[3]==0) then
			if (values[4]~=0) then
				values[3]=values[4]
				values[4] = 0
			end
	  	end
		for k,v in pairs(values) do
			move_down.Tiles[Board.Size-(Board.Width)+i-(k-1)*Board.Width]=values[k]
		end
 	end
    table.insert(self.Tree, move_left)
	table.insert(self.Tree, move_right)
   	table.insert(self.Tree, move_up)
	table.insert(self.Tree, move_down)
end

function State:Print()
  print(".-=-=-=-"..string.rep("=-=-=-=-", Board.Width)..".")
  print("|       "..string.rep("        ", Board.Width).."|")
  
  for i=1, Board.Size, Board.Width do
		local values = {self.Tiles[i], self.Tiles[i+1], self.Tiles[i+2], self.Tiles[i+3]}
    if i~=Board.Size then
      print("|\t"..table.concat(values, "\t").."\t|")
    else
      print("|\t"..table.concat(values, "\t").."\t||")
    end
  end
  print("|       "..string.rep("        ", Board.Width).."|")
  print("`-=-=-=-"..string.rep("=-=-=-=-", Board.Width).."'")
end