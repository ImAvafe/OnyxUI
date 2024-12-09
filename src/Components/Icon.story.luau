local OnyxUI = script.Parent.Parent
local Fusion = require(OnyxUI.Parent.Fusion)

local Scoped = Fusion.scoped

local Icon = require(script.Parent.Icon)
local Components = {
	Icon = Icon,
}

return {
	story = function(Props)
		local Scope = Fusion.innerScope(Props.scope, Fusion, Components)

		Scope:Icon {
			Parent = Props.target,
			Image = "rbxassetid://11560341132",
		}
	end,
	fusion = Fusion,
}
