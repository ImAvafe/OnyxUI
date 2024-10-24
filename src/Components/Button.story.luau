local OnyxUI = script.Parent.Parent

local Fusion = require(OnyxUI.Parent.Fusion)
local Themer = require(OnyxUI.Themer)

local Scoped = Fusion.scoped
local Children = Fusion.Children

local Button = require(script.Parent.Button)
local Frame = require(script.Parent.Frame)
local Divider = require(script.Parent.Divider)
local Components = {
	Button = Button,
	Frame = Frame,
	Divider = Divider,
}

return {
	clipsDescendants = false,
	story = function(Parent: GuiObject)
		local Scope = Scoped(Fusion, Components)
		local Theme = Themer.Theme:now()

		Scope:Frame {
			Parent = Parent,
			ListEnabled = true,
			ListPadding = Scope:Computed(function(Use)
				return UDim.new(0, Use(Theme.Spacing["0.5"]))
			end),
			Padding = Scope:Computed(function(Use)
				return UDim.new(0, Use(Theme.StrokeThickness["1"]))
			end),

			[Children] = {
				Scope:Button {
					Content = { "Button" },
				},
				Scope:Button {
					Content = { "Button" },
					Color = Theme.Colors.Primary.Main,
				},
				Scope:Button {
					Content = { "Button" },
					Style = "Outlined",
					Color = Theme.Colors.Primary.Main,
				},
				Scope:Button {
					Content = { "rbxassetid://11560341132", "Purchase" },
					Color = Color3.fromRGB(86, 255, 70),
				},
				Scope:Button {
					Content = { "rbxassetid://13405228418", "Delete" },
					Style = "Outlined",
					Color = Theme.Colors.Error.Main,
				},
				Scope:Button {
					Content = { "Ghost" },
					Style = "Ghost",
					Color = Theme.Colors.BaseContent.Main,
				},
				Scope:Button {
					Content = { "rbxassetid://11560341132", "Bobux" },
					Color = Color3.fromRGB(86, 255, 70),
					Disabled = true,
				},
				Scope:Button {
					Content = { "Testing" },
					Color = Color3.fromRGB(86, 255, 70),
					Disabled = true,
					Style = "Outlined",
				},
				Scope:Divider {},
				Scope:Frame {
					ListEnabled = true,
					ListFillDirection = Enum.FillDirection.Horizontal,
					ListVerticalAlignment = Enum.VerticalAlignment.Center,
					Padding = Scope:Computed(function(Use)
						return UDim.new(0, Use(Theme.Spacing["1"]))
					end),

					[Children] = {
						Scope:Button {
							Content = { "Button (xs)" },
							SizeVariant = "ExtraSmall",
							Color = Theme.Colors.Primary.Main,
						},
						Scope:Button {
							Content = { "Button (sm)" },
							SizeVariant = "Small",
							Color = Theme.Colors.Primary.Main,
						},
						Scope:Button {
							Content = { "Button (md)" },
							SizeVariant = "Medium",
							Color = Theme.Colors.Primary.Main,
						},
						Scope:Button {
							Content = { "Button (lg)" },
							SizeVariant = "Large",
							Color = Theme.Colors.Primary.Main,
						},
						Scope:Button {
							Content = { "Button (xl)" },
							SizeVariant = "ExtraLarge",
							Color = Theme.Colors.Primary.Main,
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
