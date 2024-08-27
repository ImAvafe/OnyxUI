local IconText = require(script.Parent.IconText)

return {
	story = function(Parent: GuiObject, _Props: { [any]: any })
		local Instance = IconText {
			Parent = Parent,
			Content = {
				"Here's a shop icon: ",
				"rbxassetid://75029721407761",
				".",
				" And also the Loneka logo: ",
				"rbxassetid://16735398592",
				". Now you can easily have both text and icons!",
			},
		}

		return function()
			Instance:Destroy()
		end
	end,
}
