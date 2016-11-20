print("Manual Input Enabled")

math.randomseed(os.time())
currentState:Branch()
if (currentState.Tree.Down~=nil) then
    currentState.Tree.Down:Spawn()
    currentState = currentState.Tree.Down.Tree[math.random(#currentState.Tree.Down.Tree)]
end
currentState:Print()
