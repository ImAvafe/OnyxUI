local OnyxUI = script.Parent.Parent

local Fusion = require(OnyxUI.Parent.Fusion)
local Themer = require(OnyxUI.Themer)

local Scoped = Fusion.scoped
local Children = Fusion.Children

local Frame = require(OnyxUI.Components.Frame)
local Divider = require(OnyxUI.Components.Divider)
local Text = require(OnyxUI.Components.Text)
local Components = {
	Frame = Frame,
	Text = Text,
	Divider = Divider,
}

return {
	story = function(Props)
		local Scope = Fusion.innerScope(Props.scope, Fusion, Components)
		local Theme = Themer.Theme:now()

		Scope:Frame {
			Parent = Props.target,
			Size = UDim2.fromOffset(300, 0),
			AutomaticSize = Enum.AutomaticSize.Y,
			ListEnabled = true,
			ListFillDirection = Enum.FillDirection.Vertical,
			ListPadding = Scope:Computed(function(Use)
				return UDim.new(0, Use(Theme.Spacing["0.5"]))
			end),

			[Children] = {
				Scope:Text {
					Text = "Some top content..",
				},
				Scope:Divider {
					FillDirection = Enum.FillDirection.Horizontal,
				},
				Scope:Text {
					Text = "And some bottom content too.",
				},
			},
		}
	end,
	fusion = Fusion,
}
