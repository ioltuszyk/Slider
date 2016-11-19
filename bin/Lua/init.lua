local ffi = require("ffi")
ffi.cdef([[
int MessageBoxA(void *w, const char *txt, const char *cap, int type);
]])
alert = function (title, msg)
    ffi.C.MessageBoxA(nil, msg, title, 0)
end
--Pure Lua Functions----------------------------------------------------------
time = {
    start = os.clock()
}
time.reset = function ()
    time.start = os.clock()
end
time.getElapsed = function ()
    return os.clock()-time.start
end
--Rules Related---------------------------------------------------------------
Board = {
    Bounds = {4,4},
    History = {}
}
function Board:GetCurrentState()
    if (#self.History>0) then
        return self.History[#self.History]
    end
end

Tile = {}
Tile.__index = Tile
function Tile.new(index, parent, left, up, right, down)
    local tile = {}
    setmetatable(tile, Tile)
    tile.Index = index
    tile.Parent = parent
    tile.Value = 1
    tile.Left = left
    tile.Up = up
    tile.Right = right
    tile.Down = down
    return tile
end
function Tile:GetValue()
    return self.Value
end
function Tile:SetValue(value)
    self.Value = value
end
function Tile:GetDirection(direction)
    return self[direction]
end
function Tile:SetDirection(direction)
    if (direction == "Left") then
        self[direction] = self.Parent[self.Index-1]
    elseif (direction == "Up") then
        self[direction] = self.Parent[self.Index-Board.Bounds[1]]
    elseif (direction == "Right") then
        self[direction] = self.Parent[self.Index+1]
    elseif (direction == "Down") then
        self[direction] = self.Parent[self.Index+Board.Bounds[1]]
    end
end

State = {}
State.__index = State
function State.new(ancestor)
    local state = {}
    setmetatable(state, State)
    --state.Ancestor = ancestor
    -- Minimax values here?
    state.a = 1
    state.b = 2
    state.c = 3
    state.d = 4
    --
    state.Branch = {}
    state.Tiles = {}
    return state
end
function State:Init()
    time.reset()
    for i=1, Board.Size do
        table.insert(self.Tiles, Tile.new(i, self.Tiles, nil, nil, nil, nil))
    end
    time_for_snippet = time_for_snippet+time.getElapsed()
    for i=1, Board.Size do
        --left top corner
        if (i==1) then
            self.Tiles[i]:SetDirection("Right")
            self.Tiles[i]:SetDirection("Down")
        --right top corner
        elseif (i==Board.Bounds[1]) then
            self.Tiles[i]:SetDirection("Left")
            self.Tiles[i]:SetDirection("Down")
        --top row
        elseif (i>1) and (i<Board.Bounds[1]) then
            self.Tiles[i]:SetDirection("Left")
            self.Tiles[i]:SetDirection("Right")
            self.Tiles[i]:SetDirection("Down")
        --left bottom corner
        elseif (i==(Board.Size-Board.Bounds[1]+1)) then
            self.Tiles[i]:SetDirection("Up")
            self.Tiles[i]:SetDirection("Right")
        --right bottom corner
        elseif (i==Board.Size) then
            self.Tiles[i]:SetDirection("Left")
            self.Tiles[i]:SetDirection("Up")
        --bottom row
        elseif (i>(Board.Size-Board.Bounds[1]+1)) and (i<Board.Size) then
            self.Tiles[i]:SetDirection("Left")
            self.Tiles[i]:SetDirection("Up")
            self.Tiles[i]:SetDirection("Right")
        --left column
        elseif (i%Board.Bounds[1]==1) then
            self.Tiles[i]:SetDirection("Up")
            self.Tiles[i]:SetDirection("Right")
            self.Tiles[i]:SetDirection("Down")
        --right column
        elseif (i%Board.Bounds[1]==0) then
            self.Tiles[i]:SetDirection("Left")
            self.Tiles[i]:SetDirection("Up")
            self.Tiles[i]:SetDirection("Down")
        --center
        else
            self.Tiles[i]:SetDirection("Left")
            self.Tiles[i]:SetDirection("Up")
            self.Tiles[i]:SetDirection("Right")
            self.Tiles[i]:SetDirection("Down")
        end
    end
    return self
end

time_for_snippet = 0
function State:Generate(method)
    local cursor, merge_value, shift
    if (method=="Move") then
        local rightMove = State.new(self)
        local rightChanged = false
        rightMove:Init()
        for i=1, #self.Tiles do
            rightMove.Tiles[i]:SetValue(self.Tiles[i]:GetValue())
        end
        for i=Board.Bounds[1], Board.Size, Board.Bounds[1] do
            cursor = rightMove.Tiles[i]
            merge_value = cursor:GetValue()
            shift = cursor:GetDirection("Left")
            while (shift~=nil) do
                if (shift:GetValue()~=0) then
                    if (shift:GetValue()==merge_value) then
                        rightChanged=true
                        shift:SetValue(0)
                        cursor:SetValue(merge_value*2)
                        cursor = shift:GetDirection("Left")
                        if cursor~=nil then
                            merge_value = cursor:GetValue()
                            shift = cursor:GetDirection("Left")
                        else
                            break
                        end
                    else
                        cursor = shift
                        merge_value = cursor:GetValue()
                        shift = cursor:GetDirection("Left")
                    end
                elseif (merge_value == 0) then
                    cursor = shift
                    if cursor~=nil then
                        merge_value = cursor:GetValue()
                        shift = cursor:GetDirection("Left")
                    else
                        break
                    end
                else
                    break
                end
            end
        end
        for i=Board.Bounds[1], Board.Size, Board.Bounds[1] do
            cursor = rightMove.Tiles[i]
            merge_value = cursor:GetValue()
            shift = cursor:GetDirection("Left")
            while (shift~=nil) do
                if (shift:GetValue()~=0) then
                    if (merge_value==0) then
                        rightChanged=true
                        cursor:SetValue(shift:GetValue())
                        shift:SetValue(0)
                        cursor = cursor:GetDirection("Left")
                        if cursor~=nil then
                            merge_value = cursor:GetValue()
                            shift = cursor:GetDirection("Left")
                        else
                            break
                        end
                    else
                        cursor = cursor:GetDirection("Left")
                        if cursor~=nil then
                            merge_value = cursor:GetValue()
                            shift = cursor:GetDirection("Left")
                        else
                            break
                        end
                    end
                else
                    shift = shift:GetDirection("Left")
                end
            end
        end
        local leftMove = State.new(self)
        local leftChanged = false
        leftMove:Init()
        for i=1, #self.Tiles do
            leftMove.Tiles[i]:SetValue(self.Tiles[i]:GetValue())
        end
        for i=1, Board.Size, Board.Bounds[1] do
            cursor = leftMove.Tiles[i]
            merge_value = cursor:GetValue()
            shift = cursor:GetDirection("Right")
            while (shift~=nil) do
                if (shift:GetValue()~=0) then
                    if (shift:GetValue()==merge_value) then
                        leftChanged=true
                        shift:SetValue(0)
                        cursor:SetValue(merge_value*2)
                        cursor = shift:GetDirection("Right")
                        if cursor~=nil then
                            merge_value = cursor:GetValue()
                            shift = cursor:GetDirection("Right")
                        else
                            break
                        end
                    else
                        cursor = shift
                        merge_value = cursor:GetValue()
                        shift = cursor:GetDirection("Right")
                    end
                elseif (merge_value == 0) then
                    cursor = shift
                    if cursor~=nil then
                        merge_value = cursor:GetValue()
                        shift = cursor:GetDirection("Right")
                    else
                        break
                    end
                else
                    break
                end
            end
        end
        for i=1, Board.Size, Board.Bounds[1] do
            cursor = leftMove.Tiles[i]
            merge_value = cursor:GetValue()
            shift = cursor:GetDirection("Right")
            while (shift~=nil) do
                if (shift:GetValue()~=0) then
                    if (merge_value==0) then
                        leftChanged=true
                        cursor:SetValue(shift:GetValue())
                        shift:SetValue(0)
                        cursor = cursor:GetDirection("Right")
                        if cursor~=nil then
                            merge_value = cursor:GetValue()
                            shift = cursor:GetDirection("Right")
                        else
                            break
                        end
                    else
                        cursor = cursor:GetDirection("Right")
                        if cursor~=nil then
                            merge_value = cursor:GetValue()
                            shift = cursor:GetDirection("Right")
                        else
                            break
                        end
                    end
                else
                    shift = shift:GetDirection("Right")
                end
            end
        end
        local upMove = State.new(self)
        local upChanged = false
        upMove:Init()
        for i=1, #self.Tiles do
            upMove.Tiles[i]:SetValue(self.Tiles[i]:GetValue())
        end
        for i=1, Board.Bounds[1], 1 do
            cursor = upMove.Tiles[i]
            merge_value = cursor:GetValue()
            shift = cursor:GetDirection("Down")
            while (shift~=nil) do
                if (shift:GetValue()~=0) then
                    if (shift:GetValue()==merge_value) then
                        upChanged = true
                        shift:SetValue(0)
                        cursor:SetValue(merge_value*2)
                        cursor = shift:GetDirection("Down")
                        if cursor~=nil then
                            merge_value = cursor:GetValue()
                            shift = cursor:GetDirection("Down")
                        else
                            break
                        end
                    else
                        cursor = shift
                        merge_value = cursor:GetValue()
                        shift = cursor:GetDirection("Down")
                    end
                elseif (merge_value == 0) then
                    cursor = shift
                    if cursor~=nil then
                        merge_value = cursor:GetValue()
                        shift = cursor:GetDirection("Down")
                    else
                        break
                    end
                else
                    break
                end
            end
        end
        for i=1, Board.Bounds[1], 1 do
            cursor = upMove.Tiles[i]
            merge_value = cursor:GetValue()
            shift = cursor:GetDirection("Down")
            while (shift~=nil) do
                if (shift:GetValue()~=0) then
                    if (merge_value==0) then
                        upChanged=true
                        cursor:SetValue(shift:GetValue())
                        shift:SetValue(0)
                        cursor = cursor:GetDirection("Down")
                        if cursor~=nil then
                            merge_value = cursor:GetValue()
                            shift = cursor:GetDirection("Down")
                        else
                            break
                        end
                    else
                        cursor = cursor:GetDirection("Down")
                        if cursor~=nil then
                            merge_value = cursor:GetValue()
                            shift = cursor:GetDirection("Down")
                        else
                            break
                        end
                    end
                else
                    shift = shift:GetDirection("Down")
                end
            end
        end
        local downMove = State.new(self)
        local downChanged = false
        downMove:Init()
        for i=1, #self.Tiles do
            downMove.Tiles[i]:SetValue(self.Tiles[i]:GetValue())
        end
        for i=Board.Size-Board.Bounds[1]+1, Board.Size, 1 do
            cursor = downMove.Tiles[i]
            merge_value = cursor:GetValue()
            shift = cursor:GetDirection("Up")
            while (shift~=nil) do
                if (shift:GetValue()~=0) then
                    if (shift:GetValue()==merge_value) then
                        downChanged = true
                        shift:SetValue(0)
                        cursor:SetValue(merge_value*2)
                        cursor = shift:GetDirection("Up")
                        if cursor~=nil then
                            merge_value = cursor:GetValue()
                            shift = cursor:GetDirection("Up")
                        else
                            break
                        end
                    else
                        cursor = shift
                        merge_value = cursor:GetValue()
                        shift = cursor:GetDirection("Up")
                    end
                elseif (merge_value == 0) then
                    cursor = shift
                    if cursor~=nil then
                        merge_value = cursor:GetValue()
                        shift = cursor:GetDirection("Up")
                    else
                        break
                    end
                else
                    break
                end
            end
        end
        for i=Board.Size-Board.Bounds[1]+1, Board.Size, 1 do
            cursor = downMove.Tiles[i]
            merge_value = cursor:GetValue()
            shift = cursor:GetDirection("Up")
            while (shift~=nil) do
                if (shift:GetValue()~=0) then
                    if (merge_value==0) then
                        downChanged=true
                        cursor:SetValue(shift:GetValue())
                        shift:SetValue(0)
                        cursor = cursor:GetDirection("Up")
                        if cursor~=nil then
                            merge_value = cursor:GetValue()
                            shift = cursor:GetDirection("Up")
                        else
                            break
                        end
                    else
                        cursor = cursor:GetDirection("Up")
                        if cursor~=nil then
                            merge_value = cursor:GetValue()
                            shift = cursor:GetDirection("Up")
                        else
                            break
                        end
                    end
                else
                    shift = shift:GetDirection("Up")
                end
            end
        end
        if leftChanged then table.insert(self.Branch, leftMove) end
        if upChanged then table.insert(self.Branch, upMove) end
        if rightChanged then table.insert(self.Branch, rightMove) end
        if downChanged then table.insert(self.Branch, downMove) end
    else -- Spawn

    end
end

function State:Print()
    print(".-=-=-=-"..string.rep("=-=-=-=-", Board.Bounds[1])..".")
    print("|       "..string.rep("        ", Board.Bounds[1]).."|")
    io.write("|\t")
    for i=1, #self.Tiles do
        io.write(self.Tiles[i].Value.."\t")
        if (i-1)%Board.Bounds[1]==Board.Bounds[1]-1 and i~=1 and i~=Board.Size then
            io.write("|\n|\t")
        elseif i==Board.Size then
            print("|")
        end
    end
    print("|       "..string.rep("        ", Board.Bounds[1]).."|")
    print("`-=-=-=-"..string.rep("=-=-=-=-", Board.Bounds[1]).."'")
end

function Board:Init(x, y)
    self.Bounds = {x,y}
    Board.Size = Board.Bounds[1]*Board.Bounds[2]
    table.insert(self.History, State.new(nil):Init())
end






