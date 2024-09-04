local OnyxUI = script.Parent.Parent
local Fusion = require(OnyxUI.Packages.Fusion)

local Scoped = Fusion.scoped

local Icon = require(script.Parent.Icon)
local Components = {
	Icon = Icon,
}

return {
	story = function(Parent: GuiObject)
		local Scope: Fusion.Scope<typeof(Fusion) & typeof(Components)> = Scoped(Fusion, Components)

		local Instance = Scope:Icon {
			Parent = Parent,
			Image = "rbxassetid://11560341132",
		}

		return function()
			Instance:Destroy()
		end
	end,
}
