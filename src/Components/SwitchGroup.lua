--[=[
		@class SwitchGroup
		
		Useful for pairing [`SwitchInput`](/api/SwitchInput)s with other components, like [`Text`](/api/Text).
]=]

local OnyxUI = script.Parent.Parent
local Util = require(OnyxUI.Util)
local Themer = require(OnyxUI.Themer)

local BaseButton = require(script.Parent.BaseButton)
local SwitchInput = require(script.Parent.SwitchInput)

export type Props = SwitchInput.Props & {}

--[=[
		@within SwitchGroup
		@interface SwitchGroupProps

		@field ... SwitchInputProps
		@field ... SwitchGroupProps
]=]
return function(Props: Props)
	local Switched = Util.EnsureValue(Props.Switched, "boolean", false)

	Props.Switched = Switched

	return BaseButton(Util.CombineProps(Props, {
		Name = "SwitchGroup",
		ClickSound = Themer.Theme.Sound.Switch,
		Disabled = Props.Disabled,

		OnActivated = function()
			Switched:set(not Switched:get())
		end,
	}))
end
