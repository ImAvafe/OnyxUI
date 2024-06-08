local OnyxUI = script.Parent.Parent
local Fusion = require(OnyxUI.Parent.Fusion)
local NumberSpinner = require(script.NumberSpinner)
local EnsureValue = require(OnyxUI.Utils.EnsureValue)
local Themer = require(OnyxUI.Utils.Themer)
local PubTypes = require(OnyxUI.Utils.PubTypes)
local CombineProps = require(OnyxUI.Utils.CombineProps)

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
	local TextSize = EnsureValue(Props.TextSize, "number", Themer.Theme.TextSize["1"])

	local Value = EnsureValue(Props.Value, "number", 0)
	local Prefix = EnsureValue(Props.Prefix, "string", "")
	local Suffix = EnsureValue(Props.Suffix, "string", "")
	local Decimals = EnsureValue(Props.Decimals, "number", 0)
	local Duration = EnsureValue(Props.Duration, "number", 0.3)
	local Commas = EnsureValue(Props.Commas, "boolean", false)

	local Observers = {}

	local Spinner = NumberSpinner.fromGuiObject(Text(CombineProps(Props, {
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
