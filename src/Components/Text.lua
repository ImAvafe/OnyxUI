local OnyxUI = require(script.Parent.Parent)
local Fusion = require(OnyxUI.Packages.Fusion)
local EnsureValue = require(OnyxUI.Utils.EnsureValue)
local Themer = require(OnyxUI.Utils.Themer)

local Computed = Fusion.Computed
local Hydrate = Fusion.Hydrate

local Base = require(script.Parent.Base)
local PubTypes = require(script.Parent.Parent.PubTypes)
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

local function Text(Props: Props)
	local Name = EnsureValue(Props.Name, "string", "Text")
	local AutomaticSize = EnsureValue(Props.AutomaticSize, "EnumItem", Enum.AutomaticSize.XY)
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
	local ClipsDescendants = EnsureValue(Props.ClipsDescendants, "boolean", false)
	local TextXAlignment = EnsureValue(Props.TextXAlignment, "EnumItem", Enum.TextXAlignment.Left)
	local TextYAlignment = EnsureValue(Props.TextYAlignment, "EnumItem", Enum.TextYAlignment.Top)
	local BackgroundTransparency = EnsureValue(Props.BackgroundTransparency, "number", 1)

	return Hydrate(Base(CombineProps(Props, {
		ClassName = "TextLabel",
		Name = Name,
		AutomaticSize = AutomaticSize,
	}))) {
		Text = Props.Text,
		TextColor3 = TextColor3,
		TextSize = TextSize,
		RichText = RichText,
		FontFace = FontFace,
		TextWrapped = TextWrapped,
		ClipsDescendants = ClipsDescendants,
		TextXAlignment = TextXAlignment,
		TextYAlignment = TextYAlignment,
		BackgroundTransparency = BackgroundTransparency,
	}
end

return Text
