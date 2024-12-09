local OnyxUI = script.Parent.Parent

local Fusion = require(OnyxUI.Parent.Fusion)
local Themer = require(OnyxUI.Themer)

local Children = Fusion.Children
local Scoped = Fusion.scoped

local MenuFrame = require(script.Parent.MenuFrame)
local Frame = require(script.Parent.Frame)
local Text = require(script.Parent.Text)
local Components = {
	MenuFrame = MenuFrame,
	Text = Text,
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
			ListFillDirection = Enum.FillDirection.Horizontal,

			[Children] = {
				Scope:MenuFrame {
					Parent = Props.target,
					Size = UDim2.fromOffset(300, 200),
					AutomaticSize = Enum.AutomaticSize.None,

					[Children] = {
						Scope:Text {
							Text = "Here's a MenuFrame with some text in it.",
						},
					},
				},
			},
		}
	end,
	fusion = Fusion,
}
