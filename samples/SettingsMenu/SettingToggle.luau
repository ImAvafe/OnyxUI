local OnyxUI = script.Parent.Parent.Parent.OnyxUI.Packages.OnyxUI
local Themer = require(OnyxUI.Themer)
local Fusion = require(OnyxUI.Parent.Fusion)
local Util = require(OnyxUI.Util)

local Children = Fusion.Children
local InnerScope = Fusion.innerScope

local SwitchGroup = require(OnyxUI.Components.SwitchGroup)
local SwitchInput = require(OnyxUI.Components.SwitchInput)
local Text = require(OnyxUI.Components.Text)
local Components = {
	Text = Text,
	SwitchInput = SwitchInput,
	SwitchGroup = SwitchGroup,
}

local DISABLED_TRANSPARENCY = 0.5

export type Props = SwitchGroup.Props & {
	Label: Fusion.UsedAs<string>,
}

local function SettingToggle(Scope: Fusion.Scope<any>, Props: Props)
	local Scope = InnerScope(Scope, Fusion, Util, Components)
	local Theme = Themer.Theme:now()

	local Switched = Scope:EnsureValue(Util.Fallback(Props.Switched, false))
	local Disabled = Util.Fallback(Props.Disabled, false)

	Props.Switched = Switched

	return Scope:SwitchGroup(Util.CombineProps(Props, {
		Size = UDim2.fromScale(1, 0),
		AutomaticSize = Enum.AutomaticSize.Y,
		Switched = Switched,
		Disabled = Disabled,

		[Children] = {
			Scope:Text {
				AnchorPoint = Vector2.new(0, 0.5),
				Position = UDim2.fromScale(0, 0.5),
				Text = Props.Label,
				TextColor3 = Theme.Colors.BaseContent.Main,
				TextTransparency = Scope:Computed(function(Use)
					if Use(Disabled) then
						return DISABLED_TRANSPARENCY
					else
						return 0
					end
				end),
				TextWrapped = false,
			},
			Scope:SwitchInput {
				AnchorPoint = Vector2.new(1, 0),
				Position = UDim2.fromScale(1, 0),
				Switched = Switched,
				Disabled = Props.Disabled,
				Selectable = false,
			},
		},
	}))
end

return SettingToggle
