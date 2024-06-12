local Text = require(script.Parent.Text)

return {
	story = function(Parent: GuiObject, _Props: { [any]: any })
		local Instance = Text {
			Parent = Parent,
			Text = "This is some sample text\n\navafe.me!",
		}

		return function()
			Instance:Destroy()
		end
	end,
}
