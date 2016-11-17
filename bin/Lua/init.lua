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
    time.start = osSt.clock()
end
time.getelapsed = function ()
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
    tile.Value = 0
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
    state.Ancestor = ancestor
    state.Branch = {}
    state.Tiles = {}
    state.Print = function ()
        for i=1, #state.Tiles do
            print(state.Tiles[i].Value)
        end
    end
    return state
end
function State:Init()
    for i=1, Board.Size do
        table.insert(self.Tiles, Tile.new(i, self.Tiles, nil, nil, nil, nil))
    end
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
        elseif (i>=1) and (i<=Board.Bounds[1]) then
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
        elseif (i>=(Board.Size-Board.Bounds[1]+1)) and (i<=Board.Size) then
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
function State:Generate(method = "Move")
    if (method=="Move") then
        --shift right
        change = false
        cursor = Board.Bounds[1]

        --incrementing by the size to get the last value in each row.
        for i=Board.Bounds[1], Board.Size, Board.Bounds[1] do
            match = Board:GetCurrentState().Tiles[i]:GetValue()
            --to match and merge
            -- -1 to not compare to starting value
            --value adjacent to the rightmost column
            for n=i - 1, i - Board.Bounds[1], -1 do
                

            end
            --to remove zeros
            for n=i, i - Board.Bounds[1], -1 do

            end
        end 



    else -- Spawn

    end
end

function Board:Init(x, y)
    self.Bounds = {x,y}
    Board.Size = Board.Bounds[1]*Board.Bounds[2]
    table.insert(self.History, State.new(nil):Init())
end

Board:Init(4, 4)





