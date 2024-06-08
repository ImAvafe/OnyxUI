local OnyxUI = script.Parent.Parent
local Themer = require(script.Parent.Parent.Utils.Themer)
local Fusion = require(OnyxUI.Parent.Fusion)
local EnsureValue = require(OnyxUI.Utils.EnsureValue)

local Children = Fusion.Children
local Computed = Fusion.Computed

local SwitchGroup = require(OnyxUI.Components.SwitchGroup)
local SwitchInput = require(OnyxUI.Components.SwitchInput)
local Text = require(OnyxUI.Components.Text)

local DISABLED_TRANSPARENCY = 0.5

local function SettingToggle(Props: { [any]: any })
	Props.SwitchedOn = EnsureValue(Props.SwitchedOn, "boolean", false)
	Props.Disabled = EnsureValue(Props.Disabled, "boolean", false)

	return SwitchGroup {
		Size = UDim2.fromScale(1, 0),
		AutomaticSize = Enum.AutomaticSize.Y,
		SwitchedOn = Props.SwitchedOn,
		Disabled = Props.Disabled,

		[Children] = {
			Text {
				AnchorPoint = Vector2.new(0, 0.5),
				Position = UDim2.fromScale(0, 0.5),
				Text = Props.Label,
				TextColor3 = Themer.Theme.Colors.BaseContent.Main,
				TextTransparency = Computed(function()
					if Props.Disabled:get() then
						return DISABLED_TRANSPARENCY
					else
						return 0
					end
				end),
				TextWrapped = false,
			},
			SwitchInput {
				AnchorPoint = Vector2.new(1, 0),
				Position = UDim2.fromScale(1, 0),
				SwitchedOn = Props.SwitchedOn,
				Disabled = Props.Disabled,
				Selectable = false,
			},
		},
	}
end

return SettingToggle
