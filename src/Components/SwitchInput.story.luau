local OnyxUI = script.Parent.Parent

local Fusion = require(OnyxUI.Parent.Fusion)
local Themer = require(OnyxUI.Themer)

local Scoped = Fusion.scoped
local Children = Fusion.Children

local SwitchInput = require(script.Parent.SwitchInput)
local Frame = require(script.Parent.Frame)
local Components = {
	SwitchInput = SwitchInput,
	Frame = Frame,
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
			ListPadding = Scope:Computed(function(Use)
				return UDim.new(0, Use(Theme.Spacing["0.5"]))
			end),

			[Children] = {
				Scope:SwitchInput {},
				Scope:SwitchInput {
					Disabled = true,
				},
			},
		}
	end,
	fusion = Fusion,
}
