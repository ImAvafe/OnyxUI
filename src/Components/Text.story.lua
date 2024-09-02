local Text = require(script.Parent.Text)

return {
	story = function(Parent: GuiObject, _Props: { [any]: any })
		local Instance = Text {
			Parent = Parent,
			Text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.",
		}

		return function()
			Instance:Destroy()
		end
	end,
}
