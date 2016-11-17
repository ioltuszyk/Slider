time.reset() -- testing

Board:Init(4, 4)

print("Made "..Board.Size.." tiles in ~"..time.getelapsed().." seconds")
wait(10)
