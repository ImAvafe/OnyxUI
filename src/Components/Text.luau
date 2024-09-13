--[=[
		@class Text
		
		For displaying text. *Lorem ipsum dolo..*
]=]

local OnyxUI = script.Parent.Parent
local Fusion = require(OnyxUI.Parent.Fusion)
local Util = require(OnyxUI.Util)
local Themer = require(OnyxUI.Themer)

local InnerScope = Fusion.innerScope

local Base = require(script.Parent.Base)
local Components = {
	Base = Base,
}

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
return function(Scope: Fusion.Scope<any>, Props: Props): Instance
	local Scope = InnerScope(Scope, Fusion, Util, Components)
	local Theme = Themer.Theme:now()

	local TextColor3 = Util.Fallback(Props.TextColor3, Theme.Colors.BaseContent.Main)
	local TextSize = Util.Fallback(Props.TextSize, Theme.TextSize["1"])
	local RichText = Util.Fallback(Props.RichText, true)
	local FontFace = Util.Fallback(
		Props.FontFace,
		Scope:Computed(function(Use)
			return Font.new(Use(Theme.Font.Body), Use(Theme.FontWeight.Body))
		end)
	)
	local TextWrapped = Util.Fallback(Props.TextWrapped, true)
	local TextXAlignment = Util.Fallback(Props.TextXAlignment, Enum.TextXAlignment.Left)
	local TextYAlignment = Util.Fallback(Props.TextYAlignment, Enum.TextYAlignment.Top)

	return Scope:Hydrate(Scope:Base(Util.CombineProps(Props, {
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
