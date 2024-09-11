--[=[
		@class NumberSpinner
		
		Useful for number counters.
		
		:::info
		This currently only supports the legacy [`Font`](https://create.roblox.com/docs/reference/engine/classes/TextLabel#Font) property. Passing in a [`FontFace`](https://create.roblox.com/docs/reference/engine/classes/TextLabel#FontFace) will not do anything.
		:::
]=]

local OnyxUI = script.Parent.Parent

local Fusion = require(OnyxUI.TypedPackages.Fusion)
local NumberSpinner = require(script.NumberSpinner)
local Util = require(OnyxUI.Util)
local Themer = require(OnyxUI.Themer)

local Peek = Fusion.peek
local InnerScope = Fusion.innerScope

local Text = require(script.Parent.Text)
local Components = {
	Text = Text,
}

export type Props = Text.Props & {
	Value: Fusion.UsedAs<number>?,
	Prefix: Fusion.UsedAs<string>?,
	Suffix: Fusion.UsedAs<string>?,
	Decimals: Fusion.UsedAs<boolean>?,
	Duration: Fusion.UsedAs<number>?,
	Commas: Fusion.UsedAs<boolean>?,
}

--[=[
		@within NumberSpinner
		@interface NumberSpinnerProps

		@field ... TextProps
		@field Value Fusion.UsedAs<number>?
		@field Prefix Fusion.UsedAs<string>?
		@field Suffix Fusion.UsedAs<string>?
		@field Decimals Fusion.UsedAs<boolean>?
		@field Duration Fusion.UsedAs<number>?
		@field Commas Fusion.UsedAs<boolean>?
]=]
return function(Scope: Fusion.Scope<any>, Props: Props)
	local Scope = InnerScope(Scope, Fusion, Util, Components)
	local Theme = Themer.Theme:now()

	local TextSize = Util.Fallback(Props.TextSize, Theme.TextSize["1"])

	local Value = Util.Fallback(Props.Value, 0)
	local Prefix = Util.Fallback(Props.Prefix, "")
	local Suffix = Util.Fallback(Props.Suffix, "")
	local Decimals = Util.Fallback(Props.Decimals, 0)
	local Duration = Util.Fallback(Props.Duration, 0.3)
	local Commas = Util.Fallback(Props.Commas, false)

	local Spinner = NumberSpinner.fromGuiObject(Scope:Text(Util.CombineProps(Props, {
		Name = "NumberSpinner",
		AutomaticSize = Enum.AutomaticSize.None,
		TextSize = TextSize,
		Font = Enum.Font.GothamBold,
		Size = Scope:Computed(function(Use)
			return UDim2.new(UDim.new(1, 0), UDim.new(0, Use(TextSize)))
		end),
	})))

	local SpinnerProps =
		{ Value = Value, Prefix = Prefix, Suffix = Suffix, Decimals = Decimals, Duration = Duration, Comas = Commas }
	for PropName, Prop in pairs(SpinnerProps) do
		Spinner[PropName] = Peek(Prop)

		Scope:Observer(Prop):onChange(function()
			Spinner[PropName] = Peek(Prop)
		end)
	end

	return Spinner.GuiObject
end
