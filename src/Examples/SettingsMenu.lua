local OnyxUI = script.Parent.Parent

local Fusion = require(OnyxUI.Parent.Fusion)
local Themer = require(OnyxUI.Utils.Themer)

local Children = Fusion.Children
local New = Fusion.New

local MenuFrame = require(OnyxUI.Components.MenuFrame)
local Button = require(OnyxUI.Components.Button)
local AutoScaleFrame = require(OnyxUI.Components.AutoScaleFrame)
local TitleBar = require(OnyxUI.Components.TitleBar)
local ScrollingFrame = require(OnyxUI.Components.ScrollingFrame)
local SettingToggle = require(OnyxUI.Components.SettingToggle)

local function SettingsMenu(Props: table)
	return MenuFrame {
		Parent = Props.Parent,
		AnchorPoint = Vector2.new(0.5, 0.5),
		Position = UDim2.fromScale(0.5, 0.5),
		Size = UDim2.fromOffset(330, 0),

		[Children] = {
			New "UIListLayout" {
				SortOrder = Enum.SortOrder.LayoutOrder,
				Padding = UDim.new(0, Themer.Theme.Space:get() * 3),
			},
			TitleBar {
				Title = "Settings",
			},
			ScrollingFrame {
				Size = UDim2.new(UDim.new(1, 0), UDim.new(0, 175)),
				AutomaticSize = Enum.AutomaticSize.None,

				[Children] = {
					New "UIListLayout" {
						SortOrder = Enum.SortOrder.LayoutOrder,
						Padding = UDim.new(0, 6),
					},
					New "UIPadding" {
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
				},
			},
			Button {
				Contents = { "Apply" },
				Style = "Filled",
				Size = UDim2.fromScale(1, 0),
				AutomaticSize = Enum.AutomaticSize.Y,
			},
		},
	}
end

return SettingsMenu
