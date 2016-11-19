print("Manual Input Enabled")

currentState:Branch()
currentState = currentState.Tree[3] -- Up
currentState.Parent = nil
currentState:Print()
