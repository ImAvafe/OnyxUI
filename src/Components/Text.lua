--[=[
		@class Text
		
		For displaying text. *Lorem ipsum dolo..*
]=]

local OnyxUI = script.Parent.Parent
local Fusion = require(OnyxUI.Parent.Fusion)
local Util = require(OnyxUI.Util)
local Themer = require(OnyxUI.Themer)
local PubTypes = require(OnyxUI.Util.PubTypes)

local Computed = Fusion.Computed
local Hydrate = Fusion.Hydrate

local Base = require(script.Parent.Base)

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

--[=[
		@within Text
		@interface TextProps

		@field ... BaseProps
		@field ... TextProps
]=]
return function(Props: Props)
	local TextColor3 = Util.EnsureValue(Props.TextColor3, "Color3", Themer.Theme.Colors.BaseContent.Main)
	local TextSize = Util.EnsureValue(Props.TextSize, "number", Themer.Theme.TextSize["1"])
	local RichText = Util.EnsureValue(Props.RichText, "boolean", true)
	local FontFace = Util.EnsureValue(
		Props.FontFace,
		"Font",
		Computed(function()
			return Font.new(Themer.Theme.Font.Body:get(), Themer.Theme.FontWeight.Body:get())
		end)
	)
	local TextWrapped = Util.EnsureValue(Props.TextWrapped, "boolean", true)
	local TextXAlignment = Util.EnsureValue(Props.TextXAlignment, "EnumItem", Enum.TextXAlignment.Left)
	local TextYAlignment = Util.EnsureValue(Props.TextYAlignment, "EnumItem", Enum.TextYAlignment.Top)

	return Hydrate(Base(Util.CombineProps(Props, {
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
