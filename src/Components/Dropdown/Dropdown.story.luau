local OnyxUI = script.Parent.Parent.Parent
local Fusion = require(OnyxUI.Parent.Fusion)
local Util = require(OnyxUI.Util)
local Themer = require(OnyxUI.Themer)

local Children = Fusion.Children

local Components = {
	Dropdown = require(script.Parent),
	Frame = require(script.Parent.Parent.Frame),
	Text = require(script.Parent.Parent.Text),
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
			ListEnabled = true,

			[Children] = {
				Scope:Dropdown {
					Items = { "R$1,000,000", "End world hunger", "Infinite Skibidi Toilet" },
				},
				Scope:Text {
					Text = "This text should not move.",
				},
			},
		}

		return function()
			Scope:doCleanup()
		end
	end,
}
