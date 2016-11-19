print("Manual Input Enabled")

currentState:Branch()
currentState = currentState.Tree[4] -- Down
currentState.Parent = nil
currentState:Print()
