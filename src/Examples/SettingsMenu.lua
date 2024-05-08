local OnyxUI = require(script.Parent.Parent)
local Fusion = require(OnyxUI.Packages.Fusion)
local Themer = require(OnyxUI.Utils.Themer)
local Modifier = require(OnyxUI.Utils.Modifier)

local Children = Fusion.Children
local Computed = Fusion.Computed

local MenuFrame = require(OnyxUI.Components.MenuFrame)
local Button = require(OnyxUI.Components.Button)
local TitleBar = require(OnyxUI.Components.TitleBar)
local ScrollingFrame = require(OnyxUI.Components.ScrollingFrame)
local SettingToggle = require(OnyxUI.Components.SettingToggle)
local TextInput = require(OnyxUI.Components.TextInput)

local function SettingsMenu(Props: { [any]: any })
	return MenuFrame {
		Parent = Props.Parent,
		Size = UDim2.fromOffset(330, 0),

		[Children] = {
			Modifier.ListLayout {
				SortOrder = Enum.SortOrder.LayoutOrder,
				Padding = UDim.new(0, Themer.Theme.Spacing["0.75"]:get()),
			},

			TitleBar {
				Title = "Settings",
			},
			ScrollingFrame {
				Size = UDim2.new(UDim.new(1, 0), UDim.new(0, 175)),
				AutomaticSize = Enum.AutomaticSize.None,

				[Children] = {
					Modifier.ListLayout {
						SortOrder = Enum.SortOrder.LayoutOrder,
						Padding = Computed(function()
							return UDim.new(0, Themer.Theme.Spacing["0.5"]:get())
						end),
					},
					Modifier.Padding {
						Padding = Computed(function()
							return UDim.new(0, Themer.Theme.StrokeThickness["1"]:get())
						end),
						PaddingRight = UDim.new(0, 16),
					},

					SettingToggle {
						Label = "Music",
						SwitchedOn = true,
					},
					SettingToggle {
						Label = "Low quality",
					},
					SettingToggle {
						Label = "Copyrighted audio",
						SwitchedOn = true,
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
				Size = UDim2.fromScale(1, 0),
				AutomaticSize = Enum.AutomaticSize.Y,
				-- Style = "Outlined",
				-- Disabled = true,
			},
		},
	}
end

return SettingsMenu
