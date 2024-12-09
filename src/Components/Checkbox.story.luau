local OnyxUI = script.Parent.Parent

local Fusion = require(OnyxUI.Parent.Fusion)
local Themer = require(OnyxUI.Themer)
local Util = require(OnyxUI.Util)

local Scoped = Fusion.scoped
local Children = Fusion.Children

local Frame = require(OnyxUI.Components.Frame)
local Checkbox = require(OnyxUI.Components.Checkbox)
local Components = {
	Frame = Frame,
	Checkbox = Checkbox,
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
			ListEnabled = true,
			ListFillDirection = Enum.FillDirection.Horizontal,
			ListPadding = Scope:Computed(function(Use)
				return UDim.new(0, Use(Theme.Spacing["0.5"]))
			end),

			[Children] = {
				Scope:Checkbox {},
				Scope:Checkbox {
					Checked = true,
				},
				Scope:Checkbox {
					Disabled = true,
				},
				Scope:Checkbox {
					Disabled = true,
					Checked = true,
				},
				Scope:Checkbox {
					Icon = "rbxassetid://16743550373",
					Color = Util.Colors.Red["500"],
					Checked = true,
				},
			},
		}
	end,
	fusion = Fusion,
}
