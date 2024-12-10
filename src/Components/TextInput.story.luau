local OnyxUI = script.Parent.Parent

local Fusion = require(OnyxUI.Parent.Fusion)
local Themer = require(OnyxUI.Themer)

local Children = Fusion.Children
local Scoped = Fusion.scoped

local TextInput = require(script.Parent.TextInput)
local Frame = require(script.Parent.Frame)
local Components = {
	Frame = Frame,
	TextInput = TextInput,
}

return {
	story = function(Props)
		local Scope = Fusion.innerScope(Props.scope, Fusion, Components)
		local Theme = Themer.Theme:now()

		Scope:Frame {
			Parent = Props.target,
			Size = UDim2.fromOffset(250, 0),
			AutomaticSize = Enum.AutomaticSize.Y,
			ListEnabled = true,
			ListPadding = Scope:Computed(function(Use)
				return UDim.new(0, Use(Theme.Spacing["0.5"]))
			end),
			ListHorizontalFlex = Enum.UIFlexAlignment.Fill,
			Padding = Scope:Computed(function(Use)
				return UDim.new(0, Use(Theme.StrokeThickness["1"]))
			end),

			[Children] = {
				Scope:TextInput {},
				Scope:TextInput {
					PlaceholderText = "Disabled TextInput.",
					Disabled = true,
				},
				Scope:TextInput {
					PlaceholderText = "Twenty characters only!",
					CharacterLimit = 20,
				},
				Scope:TextInput {
					PlaceholderText = "Something dangerous!",
					Color = Theme.Colors.Error.Main,
				},
			},
		}
	end,
	fusion = Fusion,
}
