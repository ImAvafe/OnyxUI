local Icon = require(script.Parent.Icon)

return function(Target: Instance)
  local Instance = Icon {
    Parent = Target,
    AnchorPoint = Vector2.new(0.5, 0.5),
    Position = UDim2.fromScale(0.5, 0.5),
    Image = "rbxassetid://11560341132"
  }

  return function()
    Instance:Destroy()
  end
end