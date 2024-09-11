local OnyxUI = script.Parent.Parent
local Fusion = require(OnyxUI.Packages.Fusion)

local Scoped = Fusion.scoped

local Icon = require(script.Parent.Icon)
local Components = {
	Icon = Icon,
}

return {
	story = function(Parent: GuiObject)
		local Scope = Scoped(Fusion, Components)

		Scope:Icon {
			Parent = Parent,
			Image = "rbxassetid://11560341132",
		}

		return function()
			Scope:doCleanup()
		end
	end,
}
