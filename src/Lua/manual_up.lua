print("Manual Input Enabled")

math.randomseed(os.time())
currentState:Branch()
if (currentState.Tree.Up~=nil) then
    currentState.Tree.Up:Spawn()
    currentState = currentState.Tree.Up.Tree[math.random(#currentState.Tree.Up.Tree)]
end
currentState:Print()