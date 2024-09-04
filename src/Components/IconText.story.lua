local OnyxUI = script.Parent.Parent
local Fusion = require(OnyxUI.Packages.Fusion)

local Scoped = Fusion.scoped

local IconText = require(script.Parent.IconText)
local Components = {
	IconText = IconText,
}

return {
	story = function(Parent: GuiObject)
		local Scope: Fusion.Scope<typeof(Fusion) & typeof(Components)> = Scoped(Fusion, Components)

		local Instance = Scope:IconText {
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
