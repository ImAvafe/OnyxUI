local Icon = require(script.Parent.Icon)

return {
	story = function(Parent: GuiObject, _Props: table)
		local Instance = Icon {
			Parent = Parent,
			AnchorPoint = Vector2.new(0.5, 0.5),
			Position = UDim2.fromScale(0.5, 0.5),
			Image = "rbxassetid://11560341132",
		}

		return function()
			Instance:Destroy()
		end
	end,
}
