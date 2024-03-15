local OnyxUI = script.Parent.Parent

local Fusion = require(OnyxUI.Parent.Fusion)
local Themer = require(OnyxUI.Utils.Themer)

local New = Fusion.New
local Children = Fusion.Children
local Computed = Fusion.Computed

local Frame = require(OnyxUI.Components.Frame)
local Card = require(OnyxUI.Components.Card)
local Text = require(OnyxUI.Components.Text)
local Divider = require(OnyxUI.Components.Divider)

return function(Target: Instance)
	local Instance = Frame {
		Parent = Target,
		AnchorPoint = Vector2.new(0.5, 0.5),
		Position = UDim2.fromScale(0.5, 0.5),
		Size = UDim2.fromOffset(300, 0),
		AutomaticSize = Enum.AutomaticSize.Y,

		[Children] = {
			New "UIListLayout" {
				SortOrder = Enum.SortOrder.LayoutOrder,
				FillDirection = Enum.FillDirection.Vertical,
				Padding = Computed(function()
					return UDim.new(0, Themer.Theme.Spacing["0.75"]:get())
				end),
			},
			Card {
				Size = UDim2.new(UDim.new(1, 0), UDim.new(0, 150)),
				AutomaticSize = Enum.AutomaticSize.None,
			},
			Card {
				Size = UDim2.fromScale(1, 0),
				AutomaticSize = Enum.AutomaticSize.Y,

				[Children] = {
					New "UIListLayout" {
						Padding = Computed(function()
							return UDim.new(0, Themer.Theme.Spacing["0.25"]:get())
						end),
						SortOrder = Enum.SortOrder.LayoutOrder,
					},
					Text {
						Text = "Title",
						TextSize = Themer.Theme.TextSize["1.25"],
						FontFace = Computed(function()
							return Font.new(Themer.Theme.Font.Heading:get(), Themer.Theme.FontWeight.Heading:get())
						end),
					},
					Divider {},
					Text {
						Text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
					},
				},
			},
		},
	}

	return function()
		Instance:Destroy()
	end
end