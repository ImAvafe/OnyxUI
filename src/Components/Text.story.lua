local OnyxUI = script.Parent.Parent
local Fusion = require(OnyxUI.TypedPackages.Fusion)
local Util = require(OnyxUI.Util)

local Scoped = Fusion.scoped

local Components = {
	Text = require(OnyxUI.Components.Text),
}

return {
	story = function(Parent: GuiObject)
		local Scope = Scoped(Fusion, Util, Components)

		Scope:Text {
			Parent = Parent,
			Text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.",
		}

		return function()
			Scope:doCleanup()
		end
	end,
}
