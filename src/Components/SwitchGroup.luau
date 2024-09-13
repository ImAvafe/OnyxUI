--[=[
		@class SwitchGroup
		
		Useful for pairing [`SwitchInput`](/api/SwitchInput)s with other components, like [`Text`](/api/Text).
]=]

local OnyxUI = script.Parent.Parent
local Util = require(OnyxUI.Util)
local Themer = require(OnyxUI.Themer)
local Fusion = require(OnyxUI.Parent.Fusion)

local Peek = Fusion.peek
local InnerScope = Fusion.innerScope

local BaseButton = require(script.Parent.BaseButton)
local SwitchInput = require(script.Parent.SwitchInput)
local Components = {
	BaseButton = BaseButton,
	SwitchInput = SwitchInput,
}

export type Props = SwitchInput.Props & {}

--[=[
		@within SwitchGroup
		@interface SwitchGroupProps

		@field ... SwitchInputProps
]=]
return function(Scope: Fusion.Scope<any>, Props: Props)
	local Scope = InnerScope(Scope, Fusion, Util, Components)
	local Theme = Themer.Theme:now()

	local Switched = Scope:EnsureValue(Util.Fallback(Props.Switched, false))

	Props.Switched = Switched

	return Scope:BaseButton(Util.CombineProps(Props, {
		Name = "SwitchGroup",
		ClickSound = Theme.Sound.Switch,
		Disabled = Props.Disabled,

		OnActivated = function()
			Switched:set(not Peek(Switched))
		end,
	}))
end
