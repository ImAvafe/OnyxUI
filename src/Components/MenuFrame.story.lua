local MenuFrame = require(script.Parent.MenuFrame)

return {
	story = function(Parent: GuiObject, _Props: table)
		local Instance = MenuFrame {
			Parent = Parent,
			AnchorPoint = Vector2.new(0.5, 0.5),
			Position = UDim2.fromScale(0.5, 0.5),
			Size = UDim2.fromOffset(300, 400),
			AutomaticSize = Enum.AutomaticSize.None,
		}

		return function()
			Instance:Destroy()
		end
	end,
}
