local Component = require(script.Parent.ScrollingFrame)

return {
	story = function(Parent: GuiObject, _Props: table)
		local Instance = Component {
			Parent = Parent,
			Size = UDim2.fromOffset(200, 200),
			CanvasSize = UDim2.new(UDim.new(1, 0), UDim.new(0, 1000)),
			AutomaticCanvasSize = Enum.AutomaticSize.None,
		}

		return function()
			Instance:Destroy()
		end
	end,
}
