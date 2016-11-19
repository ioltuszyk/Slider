print("Manual Input Enabled")

currentState:Branch()
currentState = currentState.Tree[2] -- Right
currentState.Parent = nil
currentState:Print()
