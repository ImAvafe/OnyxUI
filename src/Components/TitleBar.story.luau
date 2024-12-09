local OnyxUI = script.Parent.Parent

local Fusion = require(OnyxUI.Parent.Fusion)
local Themer = require(OnyxUI.Themer)

local Children = Fusion.Children
local Scoped = Fusion.scoped

local TitleBar = require(OnyxUI.Components.TitleBar)
local Frame = require(OnyxUI.Components.Frame)
local Components = {
	Frame = Frame,
	TitleBar = TitleBar,
}

return {
	story = function(Props)
		local Scope = Fusion.innerScope(Props.scope, Fusion, Components)
		local Theme = Themer.Theme:now()

		Scope:Frame {
			Parent = Props.target,
			Padding = Scope:Computed(function(Use)
				return UDim.new(0, Use(Theme.StrokeThickness["1"]))
			end),
			Size = Scope:Computed(function(Use)
				return UDim2.fromOffset(Use(Theme.Spacing["16"]), 0)
			end),
			AutomaticSize = Enum.AutomaticSize.Y,
			ListEnabled = true,
			ListHorizontalFlex = Enum.UIFlexAlignment.Fill,

			[Children] = {
				Scope:TitleBar {
					Content = { "Title" },
				},
				Scope:TitleBar {
					Content = { "rbxassetid://75029721407761", "Shop" },
				},
			},
		}
	end,
	fusion = Fusion,
}
