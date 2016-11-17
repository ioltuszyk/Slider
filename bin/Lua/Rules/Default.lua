Tile = {}
Tile.__index = Tile
function Tile.new(left, up, right, down)
    local tile = {}
    setmetatable(tile, Tile)
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
function Tile:SetDirection(direction, tile)
    self[direction] = tile
end

Rules = {
    Spawning = function (State)
    end
}

Board = {
    Bounds = {15000,15000},
    History = {},
    Previous = function () end,
    Forward = function () end,
    State = {}
}
Board.Size = Board.Bounds[1]*Board.Bounds[2]

time.reset() -- testing

for i=1, Board.Size do
    local newTile = Tile.new(nil, nil, nil, nil)
    newTile:SetValue(i)
    table.insert(Board.State, newTile)
end

for i=1, Board.Size do
    --print("Populating Tile #"..i)
    --left top corner
    if (i==1) then
        Board.State[i]:SetDirection("Right", Board.State[i+1])
        Board.State[i]:SetDirection("Down", Board.State[i+Board.Bounds[1]])
     --right top corner
    elseif (i==Board.Bounds[1]) then
        Board.State[i]:SetDirection("Left", Board.State[i-1])
        Board.State[i]:SetDirection("Down", Board.State[i+Board.Bounds[1]])
    --top row
    elseif (i>=1) and (i<=Board.Bounds[1]) then
        Board.State[i]:SetDirection("Left", Board.State[i-1])
        Board.State[i]:SetDirection("Right", Board.State[i+1])
        Board.State[i]:SetDirection("Down", Board.State[i+Board.Bounds[1]])
    --left bottom corner
    elseif (i==(Board.Size-Board.Bounds[1]+1)) then
        Board.State[i]:SetDirection("Up", Board.State[i-Board.Bounds[1]])
        Board.State[i]:SetDirection("Right", Board.State[i+1])
    --right bottom corner
    elseif (i==Board.Size) then
        Board.State[i]:SetDirection("Left", Board.State[i-1])
        Board.State[i]:SetDirection("Up", Board.State[i-Board.Bounds[1]])
    --bottom row
    elseif (i>=(Board.Size-Board.Bounds[1]+1)) and (i<=Board.Size) then
        Board.State[i]:SetDirection("Left", Board.State[i-1])
        Board.State[i]:SetDirection("Up", Board.State[i-Board.Bounds[1]])
        Board.State[i]:SetDirection("Right", Board.State[i+1])
    --left row
    elseif (i%Board.Bounds[1]==1) then
        Board.State[i]:SetDirection("Up", Board.State[i-Board.Bounds[1]])
        Board.State[i]:SetDirection("Right", Board.State[i+1])
        Board.State[i]:SetDirection("Down", Board.State[i+Board.Bounds[1]])
    --right row
    elseif (i%Board.Bounds[1]==0) then
        Board.State[i]:SetDirection("Left", Board.State[i-1])
        Board.State[i]:SetDirection("Up", Board.State[i-Board.Bounds[1]])
        Board.State[i]:SetDirection("Down", Board.State[i+Board.Bounds[1]])
    --center
    else
        Board.State[i]:SetDirection("Left", Board.State[i-1])
        Board.State[i]:SetDirection("Up", Board.State[i-Board.Bounds[1]])
        Board.State[i]:SetDirection("Right", Board.State[i+1])
        Board.State[i]:SetDirection("Down", Board.State[i+Board.Bounds[1]])
    end
end

--[[
TODO:   New .lua, draw Board.State every ___ seconds -> the magic of async
]]

print("Made "..Board.Size.." tiles in ~"..time.getelapsed().." seconds")
wait(10)