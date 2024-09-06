local OnyxUI = script.Parent.Parent.OnyxUI.Packages.OnyxUI
local Fusion = require(OnyxUI.Packages.Fusion)
local Themer = require(OnyxUI.Themer)
local Util = require(OnyxUI.Util)

local Children = Fusion.Children

local MenuFrame = require(OnyxUI.Components.MenuFrame)
local Button = require(OnyxUI.Components.Button)
local TitleBar = require(OnyxUI.Components.TitleBar)
local Scroller = require(OnyxUI.Components.Scroller)
local SettingToggle = require(script.SettingToggle)
local TextInput = require(OnyxUI.Components.TextInput)
local Components = {
	MenuFrame = MenuFrame,
	Button = Button,
	TitleBar = TitleBar,
	Scroller = Scroller,
	SettingToggle = SettingToggle,
	TextInput = TextInput,
}

export type Props = {
	Parent: Fusion.UsedAs<Instance>?,
}

return function(Scope: Fusion.Scope<any>, Props: Props)
	local Scope: Fusion.Scope<typeof(Fusion) & typeof(Util) & typeof(Components)> =
		Fusion.innerScope(Scope, Fusion, Util, Components)
	local Theme = Themer.Theme:now()

	return Scope:MenuFrame(Util.CombineProps(Props, {
		Parent = Props.Parent,
		Size = UDim2.fromOffset(330, 0),
		AutomaticSize = Enum.AutomaticSize.Y,
		ListEnabled = true,
		ListPadding = Scope:Computed(function(Use)
			return UDim.new(0, Use(Theme.Spacing["0.75"]))
		end),

		[Children] = {
			Scope:TitleBar {
				Content = { "Settings" },
			},
			Scope:Scroller {
				Size = UDim2.new(UDim.new(1, 0), UDim.new(0, 175)),
				AutomaticSize = Enum.AutomaticSize.None,
				ListEnabled = true,
				ListHorizontalFlex = Enum.UIFlexAlignment.Fill,
				Padding = Scope:Computed(function(Use)
					return UDim.new(0, Use(Theme.StrokeThickness["1"]))
				end),
				PaddingRight = Scope:Computed(function(Use)
					return UDim.new(0, Use(Theme.StrokeThickness["1"]) + Use(Theme.Spacing["1"]))
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
