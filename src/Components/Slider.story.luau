local OnyxUI = script.Parent.Parent
local Fusion = require(OnyxUI.Parent.Fusion)
local Util = require(OnyxUI.Util)
local Themer = require(OnyxUI.Themer)

local Scoped = Fusion.scoped
local Children = Fusion.Children

local Components = {
	Slider = require(OnyxUI.Components.Slider),
	Frame = require(OnyxUI.Components.Frame),
}

return {
	story = function(Props)
		local Scope = Scoped(Fusion, Util, Components)
		local Theme = Themer.Theme:now()

		Scope:Frame {
			Parent = Props.target,
			Size = Scope:Computed(function(Use)
				return UDim2.fromOffset(Use(Theme.Spacing["16"]), 0)
			end),
			AutomaticSize = Enum.AutomaticSize.Y,
			Padding = Scope:Computed(function(Use)
				return UDim.new(0, Use(Theme.StrokeThickness["1"]))
			end),
			ListEnabled = true,
			ListPadding = Scope:Computed(function(Use)
				return UDim.new(0, Use(Theme.Spacing["0.5"]))
			end),
			ListHorizontalFlex = Enum.UIFlexAlignment.Fill,

			[Children] = {
				Scope:Slider {},
			},
		}
	end,
	fusion = Fusion,
}
