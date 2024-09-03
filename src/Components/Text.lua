--[=[
		@class Text
		
		For displaying text. *Lorem ipsum dolo..*
]=]

local OnyxUI = script.Parent.Parent
local Packages = require(OnyxUI.Packages)
local Fusion = require(Packages.Fusion)
local Util = require(OnyxUI.Util)
local Themer = require(OnyxUI.Themer)

local Computed = Fusion.Computed
local Hydrate = Fusion.Hydrate

local Base = require(script.Parent.Base)

export type Props = Base.Props & {
	Text: Fusion.UsedAs<string>?,
	TextColor3: Fusion.UsedAs<Color3>?,
	TextSize: Fusion.UsedAs<number>?,
	RichText: Fusion.UsedAs<boolean>?,
	FontFace: Fusion.UsedAs<Font>?,
	TextWrapped: Fusion.UsedAs<boolean>?,
	TextXAlignment: Fusion.UsedAs<Enum.TextXAlignment>?,
	TextYAlignment: Fusion.UsedAs<Enum.TextYAlignment>?,
	Font: Fusion.UsedAs<Enum.Font>?,
	TextScaled: Fusion.UsedAs<boolean>?,
	TextTruncate: Fusion.UsedAs<boolean>?,
	LineHeight: Fusion.UsedAs<number>?,
	LocalizedText: Fusion.UsedAs<string>?,
	MaxVisibleGraphemes: Fusion.UsedAs<number>?,
	TextTransparency: Fusion.UsedAs<number>?,
}

--[=[
		@within Text
		@interface TextProps

		@field ... BaseProps
		@field Text Fusion.UsedAs<string>?
		@field TextColor3 Fusion.UsedAs<Color3>?
		@field TextSize Fusion.UsedAs<number>?
		@field RichText Fusion.UsedAs<boolean>?
		@field FontFace Fusion.UsedAs<Font>?
		@field TextWrapped Fusion.UsedAs<boolean>?
		@field TextXAlignment Fusion.UsedAs<Enum.TextXAlignment>?
		@field TextYAlignment Fusion.UsedAs<Enum.TextYAlignment>?
		@field Font Fusion.UsedAs<Enum.Font>?
		@field TextScaled Fusion.UsedAs<boolean>?
		@field TextTruncate Fusion.UsedAs<boolean>?
		@field LineHeight Fusion.UsedAs<number>?
		@field LocalizedText Fusion.UsedAs<string>?
		@field MaxVisibleGraphemes Fusion.UsedAs<number>?
		@field TextTransparency Fusion.UsedAs<number>?
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
