local Text = require(script.Parent.Text)

return function(Target: Instance)
  local Instance = Text {
    Parent = Target,
    AnchorPoint = Vector2.new(0.5, 0.5),
    Position = UDim2.fromScale(0.5, 0.5),
    Text = "Hi this is some text uwu"
  }

  return function()
    Instance:Destroy()
  end
end