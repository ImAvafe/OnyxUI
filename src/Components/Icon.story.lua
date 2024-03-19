local Icon = require(script.Parent.Icon)

return {
	story = function(Parent: GuiObject, _Props: table)
		local Instance = Icon {
			Parent = Parent,
			Image = "rbxassetid://11560341132",
		}

		return function()
			Instance:Destroy()
		end
	end,
}
