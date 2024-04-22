local Text = require(script.Parent.Text)

return {
	story = function(Parent: GuiObject, _Props: { [any]: any })
		local Instance = Text {
			Parent = Parent,
			Text = "Hi this is some text uwu",
		}

		return function()
			Instance:Destroy()
		end
	end,
}
