print("Manual Input Enabled")

math.randomseed(os.time())
currentState:Branch()
if (currentState.Tree.Left~=nil) then
    currentState.Tree.Left:Spawn()
    currentState = currentState.Tree.Left.Tree[math.random(#currentState.Tree.Left.Tree)]
end
currentState:Print()

