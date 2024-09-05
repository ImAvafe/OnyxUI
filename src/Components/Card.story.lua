local OnyxUI = script.Parent.Parent

local Fusion = require(OnyxUI.Packages.Fusion)
local Themer = require(OnyxUI.Themer)

local Scoped = Fusion.scoped
local Children = Fusion.Children

local Frame = require(OnyxUI.Components.Frame)
local Card = require(OnyxUI.Components.Card)
local Text = require(OnyxUI.Components.Text)
local Divider = require(OnyxUI.Components.Divider)
local Components = {
	Frame = Frame,
	Divider = Divider,
	Text = Text,
	Card = Card,
}

return {
	story = function(Parent: GuiObject)
		local Scope: Fusion.Scope<typeof(Fusion) & typeof(Components)> = Scoped(Fusion, Components)
		local Theme: Themer.ThemeObject = Themer.Theme:now()

		Scope:Frame {
			Parent = Parent,
			Size = UDim2.fromOffset(300, 0),
			AutomaticSize = Enum.AutomaticSize.Y,
			ListEnabled = true,
			ListFillDirection = Enum.FillDirection.Vertical,
			ListPadding = Scope:Computed(function(Use)
				return UDim.new(0, Use(Theme.Spacing["0.75"]))
			end),

			[Children] = {
				Scope:Card {
					Size = UDim2.new(UDim.new(1, 0), UDim.new(0, 75)),
					AutomaticSize = Enum.AutomaticSize.None,
				},
				Scope:Card {
					Size = UDim2.fromScale(1, 0),
					AutomaticSize = Enum.AutomaticSize.Y,
					ListEnabled = true,
					ListPadding = Scope:Computed(function(Use)
						return UDim.new(0, Use(Theme.Spacing["0.25"]))
					end),

					[Children] = {
						Scope:Text {
							Text = "Title",
							TextSize = Theme.TextSize["1.25"],
							FontFace = Scope:Computed(function(Use)
								return Font.new(Use(Theme.Font.Heading), Use(Theme.FontWeight.Heading))
							end),
						},
						Scope:Divider {},
						Scope:Text {
							Text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
						},
					},
				},
			},
		}

		return function()
			Scope:doCleanup()
		end
	end,
}
