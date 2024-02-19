local OnyxUI = script.Parent.Parent

local Fusion = require(OnyxUI.Parent.Fusion)

local Children = Fusion.Children
local New = Fusion.New

local MenuFrame = require(OnyxUI.Components.MenuFrame)
local Button = require(OnyxUI.Components.Button)
local AutoScaleFrame = require(OnyxUI.Components.AutoScaleFrame)
local TitleBar = require(OnyxUI.Components.TitleBar)
local ScrollingFrame = require(OnyxUI.Components.ScrollingFrame)
local SettingToggle = require(OnyxUI.Components.SettingToggle)

local function SettingsMenu(Props)
	return AutoScaleFrame {
		Parent = Props.Parent,
		AnchorPoint = Vector2.new(0.5, 0.5),
		Position = UDim2.fromScale(0.5, 0.5),
		BaseResolution = Vector2.new(883, 893),

		[Children] = {
			New "UIListLayout" {},
			MenuFrame {
				Size = UDim2.fromOffset(330, 0),

				[Children] = {
					TitleBar {
						Title = "Settings",
					},
					ScrollingFrame {
						Size = UDim2.new(UDim.new(1, 0), UDim.new(0, 135)),
						AutomaticSize = Enum.AutomaticSize.None,

						[Children] = {
							New "UIListLayout" {
								SortOrder = Enum.SortOrder.LayoutOrder,
								Padding = UDim.new(0, 10),
							},
							New "UIPadding" {
								PaddingTop = UDim.new(0, 2),
								PaddingBottom = UDim.new(0, 3),
								PaddingRight = UDim.new(0, 2),
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
						Size = UDim2.fromScale(1, 0),
						Style = "Filled",
						AutomaticSize = Enum.AutomaticSize.Y,
					},
				},
			},
		},
	}
end

return SettingsMenu
