local OnyxUI = script.Parent.Parent
local Fusion = require(OnyxUI.Packages.Fusion)
local Util = require(OnyxUI.Util)

local Scoped = Fusion.scoped

local Components = {
	Text = require(OnyxUI.Components.Text),
}

return {
	story = function(Parent: GuiObject)
		local Scope: Fusion.Scope<typeof(Fusion) & typeof(Util) & typeof(Components)> = Scoped(Fusion, Util, Components)

		local Instance = Scope:Text {
			Parent = Parent,
			Text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.",
		}

		return function()
			Instance:Destroy()
			Scope:doCleanup()
		end
	end,
}
