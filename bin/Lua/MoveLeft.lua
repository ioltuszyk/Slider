Board:GetCurrentState():Generate("Move")
local newMove = Board:GetCurrentState().Branch[1]
Board.History[1] = newMove
Board:GetCurrentState():Print()