print("Manual Input Enabled")

if (currentState.Parent~=nil) then
    currentState = currentState.Parent.Parent
end
currentState:Print()
