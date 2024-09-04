local OnyxUI = script.Parent.Parent

local Fusion = require(OnyxUI.Packages.Fusion)
local Themer = require(OnyxUI.Themer)
local Util = require(OnyxUI.Util)

local Children = Fusion.Children

local MenuFrame = require(OnyxUI.Components.MenuFrame)
local Button = require(OnyxUI.Components.Button)
local TitleBar = require(OnyxUI.Components.TitleBar)
local ScrollingFrame = require(OnyxUI.Components.ScrollingFrame)
local SettingToggle = require(OnyxUI.Examples.SettingToggle)
local TextInput = require(OnyxUI.Components.TextInput)

return function(Props)
	return Scope:MenuFrame(Util.CombineProps(Props, {
		Parent = Props.Parent,
		Size = UDim2.fromOffset(330, 0),
		AutomaticSize = Enum.AutomaticSize.Y,
		ListEnabled = true,
		ListPadding = Scope:Computed(function(use)
			return UDim.new(0, use(Theme.Spacing["0.75"]))
		end),

		[Children] = {
			Scope:TitleBar {
				Content = { "Settings" },
			},
			Scope:ScrollingFrame {
				Size = UDim2.new(UDim.new(1, 0), UDim.new(0, use(175)),
				AutomaticSize = Enum.AutomaticSize.None,
				ListEnabled = true,
				Padding = Scope:Computed(function(use)
					return UDim.new(0, use(Theme.StrokeThickness["1"]))
				end),
				PaddingRight = Scope:Computed(function(use)
					return UDim.new(0, use(Theme.StrokeThickness["1"]) + Theme.Spacing["1"]))
				end),

				[Children] = {
					Scope:SettingToggle {
						Label = "Music",
						Switched = true,
					},
					Scope:SettingToggle {
						Label = "Low quality",
					},
					Scope:SettingToggle {
						Label = "Copyrighted audio",
						Switched = true,
					},
					Scope:SettingToggle {
						Label = "Infinite Bobux",
						Disabled = true,
					},
					Scope:SettingToggle {
						Label = "Something else",
					},
					Scope:SettingToggle {
						Label = "Nothing same",
					},
					Scope:TextInput {
						Size = UDim2.fromScale(1, 0),
						AutomaticSize = Enum.AutomaticSize.Y,
						PlaceholderText = "Nickname",
					},
				},
			},
			Scope:Button {
				Content = { "Close" },
				Color = Theme.Colors.Primary.Main,
				Size = UDim2.fromScale(1, 0),
				AutomaticSize = Enum.AutomaticSize.Y,
			},
		},
	}))
end
