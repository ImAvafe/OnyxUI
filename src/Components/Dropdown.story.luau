local OnyxUI = script.Parent.Parent
local Fusion = require(OnyxUI.Parent.Fusion)
local Util = require(OnyxUI.Util)
local Themer = require(OnyxUI.Themer)

local Children = Fusion.Children

local Components = {
	Dropdown = require(script.Parent.Dropdown),
	Frame = require(script.Parent.Frame),
}

return {
	story = function(Target: GuiObject)
		local Scope = Fusion.scoped(Fusion, Util, Components)
		local Theme = Themer.Theme:now()

		Scope:Frame {
			Parent = Target,
			Padding = Scope:Computed(function(Use)
				return UDim.new(0, Use(Theme.StrokeThickness["1"]))
			end),

			[Children] = {
				Scope:Dropdown {},
			},
		}

		return function()
			Scope:doCleanup()
		end
	end,
}
