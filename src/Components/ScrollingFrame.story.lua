local Component = require(script.Parent.IconButton)

return function(Target: Instance)
	local Instance = Component {
		Parent = Target,
		Size = UDim2.fromOffset(200, 200),
		CanvasSize = UDim2.new(UDim.new(1, 0), UDim.new(0, 1000)),
		AutomaticCanvasSize = Enum.AutomaticSize.None,
	}

	return function()
		Instance:Destroy()
	end
end
