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
    Bounds = {3,3},
    History = {},
    Previous = function () end,
    Forward = function () end,
    State = {}
}
Board.Size = Board.Bounds[1]*Board.Bounds[2]

for i=1, Board.Size do
    local newTile = Tile.new(nil, nil, nil, nil)
    newTile:SetValue(i)
    table.insert(Board.State, newTile)
end

for i=1, Board.Size do
    --left top corner
    if (i==1) then
        Board.State[1]:SetDirection("Right", Board.State[2])
        Board.State[1]:SetDirection("Down", Board.State[1+Board.Bounds[1]])
    end
end

print(Board.State[1]:GetDirection("Down"):GetValue())

print("Made all the tiles")
wait(10)