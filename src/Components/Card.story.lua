local OnyxUI = script.Parent.Parent
local Packages = require(OnyxUI.Packages)
local Fusion = require(Packages.Fusion)
local Themer = require(OnyxUI.Themer)

local Children = Fusion.Children
local Computed = Fusion.Computed

local Frame = require(OnyxUI.Components.Frame)
local Card = require(OnyxUI.Components.Card)
local Text = require(OnyxUI.Components.Text)
local Divider = require(OnyxUI.Components.Divider)

return {
	story = function(Parent: GuiObject, _Props: { [any]: any })
		local Instance = Frame {
			Parent = Parent,
			Size = UDim2.fromOffset(300, 0),
			AutomaticSize = Enum.AutomaticSize.Y,
			ListEnabled = true,
			ListFillDirection = Enum.FillDirection.Vertical,
			ListPadding = Computed(function()
				return UDim.new(0, Themer.Theme.Spacing["0.75"]:get())
			end),

			[Children] = {
				Card {
					Size = UDim2.new(UDim.new(1, 0), UDim.new(0, 75)),
					AutomaticSize = Enum.AutomaticSize.None,
				},
				Card {
					Size = UDim2.fromScale(1, 0),
					AutomaticSize = Enum.AutomaticSize.Y,
					ListEnabled = true,
					ListPadding = Computed(function()
						return UDim.new(0, Themer.Theme.Spacing["0.25"]:get())
					end),

					[Children] = {
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
	end,
}
