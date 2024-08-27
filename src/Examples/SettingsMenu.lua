local OnyxUI = script.Parent.Parent
local Fusion = require(OnyxUI.Parent.Fusion)
local Themer = require(OnyxUI.Themer)
local Util = require(OnyxUI.Util)

local Children = Fusion.Children
local Computed = Fusion.Computed

local MenuFrame = require(OnyxUI.Components.MenuFrame)
local Button = require(OnyxUI.Components.Button)
local TitleBar = require(OnyxUI.Components.TitleBar)
local ScrollingFrame = require(OnyxUI.Components.ScrollingFrame)
local SettingToggle = require(OnyxUI.Examples.SettingToggle)
local TextInput = require(OnyxUI.Components.TextInput)

return function(Props)
	return MenuFrame(Util.CombineProps(Props, {
		Parent = Props.Parent,
		Size = UDim2.fromOffset(330, 0),
		AutomaticSize = Enum.AutomaticSize.Y,
		ListEnabled = true,
		ListPadding = Computed(function()
			return UDim.new(0, Themer.Theme.Spacing["0.75"]:get())
		end),

		[Children] = {
			TitleBar {
				Content = { "Settings" },
			},
			ScrollingFrame {
				Size = UDim2.new(UDim.new(1, 0), UDim.new(0, 175)),
				AutomaticSize = Enum.AutomaticSize.None,
				ListEnabled = true,
				Padding = Computed(function()
					return UDim.new(0, Themer.Theme.StrokeThickness["1"]:get())
				end),
				PaddingRight = Computed(function()
					return UDim.new(0, Themer.Theme.StrokeThickness["1"]:get() + Themer.Theme.Spacing["1"]:get())
				end),

				[Children] = {
					SettingToggle {
						Label = "Music",
						Switched = true,
					},
					SettingToggle {
						Label = "Low quality",
					},
					SettingToggle {
						Label = "Copyrighted audio",
						Switched = true,
					},
					SettingToggle {
						Label = "Infinite Bobux",
						Disabled = true,
					},
					SettingToggle {
						Label = "Something else",
					},
					SettingToggle {
						Label = "Nothing same",
					},
					TextInput {
						Size = UDim2.fromScale(1, 0),
						AutomaticSize = Enum.AutomaticSize.Y,
						PlaceholderText = "Nickname",
					},
				},
			},
			Button {
				Contents = { "Close" },
				Color = Themer.Theme.Colors.Primary.Main,
				Size = UDim2.fromScale(1, 0),
				AutomaticSize = Enum.AutomaticSize.Y,
			},
		},
	}))
end
