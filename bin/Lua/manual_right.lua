print("Manual Input Enabled")

math.randomseed(os.time())
currentState:Branch()
if (currentState.Tree.Right~=nil) then
    currentState.Tree.Right:Spawn()
    currentState = currentState.Tree.Right.Tree[math.random(#currentState.Tree.Right.Tree)]
    currentState.Parent = nil
end
currentState:Print()
