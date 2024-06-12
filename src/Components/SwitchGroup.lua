local OnyxUI = script.Parent.Parent
local EnsureValue = require(OnyxUI.Utils.EnsureValue)
local Themer = require(OnyxUI.Utils.Themer)
local CombineProps = require(OnyxUI.Utils.CombineProps)

local BaseButton = require(script.Parent.BaseButton)
local SwitchInput = require(script.Parent.SwitchInput)

export type Props = SwitchInput.Props & {}

return function(Props: Props)
	local Switched = EnsureValue(Props.Switched, "boolean", false)

	return BaseButton(CombineProps(Props, {
		Name = "SwitchGroup",
		ClickSound = Themer.Theme.Sound.Switch,
		Disabled = Props.Disabled,

		OnActivated = function()
			Switched:set(not Switched:get())
		end,
	}))
end
