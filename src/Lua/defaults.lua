print("Manual Input Enabled")

currentState = State.new(nil)
currentState.Tiles = {
    2, 2, 2, 2,
    2, 2, 2, 2,
    2, 0, 0, 2,
    2, 2, 2, 2
}
currentState:Print()

time.reset()

for i=1, 50000 do
    currentState:Branch()
    --print(currentState.Tree.Left.AdjacencyBonus)
end
--currentState.Tree[144322]:Print()

print(time.getElapsed())


-- Uncomment for stress testing; manual keys enabled in slider.cpp