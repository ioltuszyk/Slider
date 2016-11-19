print("Manual Input Enabled")

currentState:Branch()
currentState = currentState.Tree[1] -- Left
currentState.Parent = nil
currentState:Print()
