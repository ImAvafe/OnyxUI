local OnyxUI = script.Parent.Parent
local Fusion = require(OnyxUI.Parent.Fusion)

local Scoped = Fusion.scoped

local IconText = require(script.Parent.IconText)
local Components = {
	IconText = IconText,
}

return {
	story = function(Parent: GuiObject)
		local Scope = Scoped(Fusion, Components)

		Scope:IconText {
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
			Scope:doCleanup()
		end
	end,
}
