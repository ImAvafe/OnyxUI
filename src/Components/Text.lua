local OnyxUI = script.Parent.Parent
local Fusion = require(OnyxUI.Parent.Fusion)
local EnsureValue = require(OnyxUI.Utils.EnsureValue)
local Themer = require(OnyxUI.Utils.Themer)

local Computed = Fusion.Computed
local Hydrate = Fusion.Hydrate

local Base = require(script.Parent.Base)
local PubTypes = require(OnyxUI.Utils.PubTypes)
local CombineProps = require(script.Parent.Parent.Utils.CombineProps)

export type Props = Base.Props & {
	Text: PubTypes.CanBeState<string>?,
	TextColor3: PubTypes.CanBeState<Color3>?,
	TextSize: PubTypes.CanBeState<number>?,
	RichText: PubTypes.CanBeState<boolean>?,
	FontFace: PubTypes.CanBeState<Font>?,
	TextWrapped: PubTypes.CanBeState<boolean>?,
	TextXAlignment: PubTypes.CanBeState<Enum.TextXAlignment>?,
	TextYAlignment: PubTypes.CanBeState<Enum.TextYAlignment>?,
	Font: PubTypes.CanBeState<Enum.Font>?,
	TextScaled: PubTypes.CanBeState<boolean>?,
	TextTruncate: PubTypes.CanBeState<boolean>?,
	LineHeight: PubTypes.CanBeState<number>?,
	LocalizedText: PubTypes.CanBeState<string>?,
	MaxVisibleGraphemes: PubTypes.CanBeState<number>?,
	TextTransparency: PubTypes.CanBeState<number>?,
}

return function(Props: Props)
	local TextColor3 = EnsureValue(Props.TextColor3, "Color3", Themer.Theme.Colors.BaseContent.Main)
	local TextSize = EnsureValue(Props.TextSize, "number", Themer.Theme.TextSize["1"])
	local RichText = EnsureValue(Props.RichText, "boolean", true)
	local FontFace = EnsureValue(
		Props.FontFace,
		"Font",
		Computed(function()
			return Font.new(Themer.Theme.Font.Body:get(), Themer.Theme.FontWeight.Body:get())
		end)
	)
	local TextWrapped = EnsureValue(Props.TextWrapped, "boolean", true)
	local TextXAlignment = EnsureValue(Props.TextXAlignment, "EnumItem", Enum.TextXAlignment.Left)
	local TextYAlignment = EnsureValue(Props.TextYAlignment, "EnumItem", Enum.TextYAlignment.Top)

	return Hydrate(Base(CombineProps(Props, {
		ClassName = "TextLabel",
		Name = "Text",
		AutomaticSize = Enum.AutomaticSize.XY,
		ClipsDescendants = false,
		BackgroundTransparency = 1,
	}))) {
		TextColor3 = TextColor3,
		TextSize = TextSize,
		RichText = RichText,
		FontFace = FontFace,
		TextWrapped = TextWrapped,
		TextXAlignment = TextXAlignment,
		TextYAlignment = TextYAlignment,

		Text = Props.Text,
		TextTransparency = Props.TextTransparency,
		MaxVisibleGraphemes = Props.MaxVisibleGraphemes,
		LocalizedText = Props.LocalizedText,
		LineHeight = Props.LineHeight,
		TextTruncate = Props.TextTruncate,
		TextScaled = Props.TextScaled,
		Font = Props.Font,
	}
end
