--[[
2 2 3 0
1 1 1 1
1 1 1 1
1 1 1 1
]]

Board:Init(4, 4)
local state = Board:GetCurrentState()
state.Tiles[1]:SetValue(2)
state.Tiles[2]:SetValue(2)
state.Tiles[3]:SetValue(3)
state.Tiles[4]:SetValue(0)
state.Tiles[5]:SetValue(1)
state.Tiles[6]:SetValue(1)
state.Tiles[7]:SetValue(1)
state.Tiles[8]:SetValue(1)
state.Tiles[9]:SetValue(1)
state.Tiles[10]:SetValue(1)
state.Tiles[11]:SetValue(1)
state.Tiles[12]:SetValue(1)
state.Tiles[13]:SetValue(1)
state.Tiles[14]:SetValue(1)
state.Tiles[15]:SetValue(1)
state.Tiles[16]:SetValue(1)

for i=1, 50000 do
    Board:GetCurrentState():Generate("Move")
end
print(time_for_snippet)
Board:GetCurrentState():Print()
--print(time.getElapsed())
--Board:GetCurrentState().Branch[6000].Print()

wait(10)
