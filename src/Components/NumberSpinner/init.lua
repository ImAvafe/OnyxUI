local OnyxUI = script.Parent.Parent
local Fusion = require(OnyxUI.Parent.Fusion)
local NumberSpinner = require(script.NumberSpinner)
local Util = require(OnyxUI.Util)
local Themer = require(OnyxUI.Themer)
local PubTypes = require(OnyxUI.Util.PubTypes)

local Cleanup = Fusion.Cleanup
local Observer = Fusion.Observer
local Computed = Fusion.Computed

local Text = require(script.Parent.Text)

export type Props = Text.Props & {
	Value: PubTypes.CanBeState<number>?,
	Prefix: PubTypes.CanBeState<string>?,
	Suffix: PubTypes.CanBeState<string>?,
	Decimals: PubTypes.CanBeState<boolean>?,
	Duration: PubTypes.CanBeState<number>?,
	Commas: PubTypes.CanBeState<boolean>?,
}

return function(Props: Props)
	local TextSize = Util.EnsureValue(Props.TextSize, "number", Themer.Theme.TextSize["1"])

	local Value = Util.EnsureValue(Props.Value, "number", 0)
	local Prefix = Util.EnsureValue(Props.Prefix, "string", "")
	local Suffix = Util.EnsureValue(Props.Suffix, "string", "")
	local Decimals = Util.EnsureValue(Props.Decimals, "number", 0)
	local Duration = Util.EnsureValue(Props.Duration, "number", 0.3)
	local Commas = Util.EnsureValue(Props.Commas, "boolean", false)

	local Observers = {}

	local Spinner = NumberSpinner.fromGuiObject(Text(Util.CombineProps(Props, {
		Name = "NumberSpinner",
		AutomaticSize = Enum.AutomaticSize.None,
		TextSize = TextSize,
		Font = Enum.Font.GothamBold,
		Size = Computed(function()
			return UDim2.new(UDim.new(1, 0), UDim.new(0, TextSize:get()))
		end),

		[Cleanup] = Observers,
	})))

	local SpinnerProps =
		{ Value = Value, Prefix = Prefix, Suffix = Suffix, Decimals = Decimals, Duration = Duration, Comas = Commas }
	for PropName, Prop in pairs(SpinnerProps) do
		Spinner[PropName] = Prop:get()

		table.insert(
			Observers,
			Observer(Prop):onChange(function()
				Spinner[PropName] = Prop:get()
			end)
		)
	end

	return Spinner.GuiObject
end
