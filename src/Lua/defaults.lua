print("Manual Input Enabled")

currentState = State.new(nil)
currentState.Tiles = {
    0, 0, 0, 0,
    0, 0, 0, 0,
    0, 0, 0, 0,
    0, 0, 0, 0
}
currentState.Tiles[math.random(#currentState.Tiles)] = math.random(2)*2
currentState:Print()


-- Uncomment for stress testing; manual keys enabled in slider.cpp