--[=[
		@class TextInput
		
		For letting the user input text.
]=]

local SoundService = game:GetService("SoundService")

local OnyxUI = script.Parent.Parent
local Fusion = require(OnyxUI.Packages.Fusion)
local Util = require(OnyxUI.Util)
local Themer = require(OnyxUI.Themer)

local peek = Fusion.peek

local OnEvent = Fusion.OnEvent
local Out = Fusion.Out

local Base = require(script.Parent.Base)
local Components = {
	Base = Base,
}

--[=[
		@within TextInput
		@interface TextInputProps

		@field ... BaseProps
		@field Disabled Fusion.UsedAs<boolean>?
		@field CharacterLimit Fusion.UsedAs<number>?
		@field Color Fusion.UsedAs<Color3>?
		@field PlaceholderText Fusion.UsedAs<string>?
		@field Text Fusion.UsedAs<string>?
		@field ClearTextOnFocus Fusion.UsedAs<boolean>?
		@field TextWrapped Fusion.UsedAs<boolean>?
		@field MultiLine Fusion.UsedAs<boolean>?
		@field TextSize Fusion.UsedAs<number>?
		@field TextColor3 Fusion.UsedAs<Color3>?
		@field FontFace Fusion.UsedAs<Font>?
		@field PlaceholderColor3 Fusion.UsedAs<Color3>?
		@field TextXAlignment Fusion.UsedAs<Enum.TextXAlignment>?
		@field TextYAlignment Fusion.UsedAs<Enum.TextYAlignment>?
		@field TextTransparency Fusion.UsedAs<number>?
		@field IsFocused Fusion.UsedAs<boolean>?
		@field OnFocused Fusion.UsedAs<() -> ()>?
		@field OnFocusLost Fusion.UsedAs<() -> ()>?
]=]
export type Props = Base.Props & {
	Disabled: Fusion.UsedAs<boolean>?,
	CharacterLimit: Fusion.UsedAs<number>?,
	Color: Fusion.UsedAs<Color3>?,
	PlaceholderText: Fusion.UsedAs<string>?,
	Text: Fusion.UsedAs<string>?,
	ClearTextOnFocus: Fusion.UsedAs<boolean>?,
	TextWrapped: Fusion.UsedAs<boolean>?,
	MultiLine: Fusion.UsedAs<boolean>?,
	TextSize: Fusion.UsedAs<number>?,
	TextColor3: Fusion.UsedAs<Color3>?,
	FontFace: Fusion.UsedAs<Font>?,
	PlaceholderColor3: Fusion.UsedAs<Color3>?,
	TextXAlignment: Fusion.UsedAs<Enum.TextXAlignment>?,
	TextYAlignment: Fusion.UsedAs<Enum.TextYAlignment>?,
	TextTransparency: Fusion.UsedAs<number>?,

	IsFocused: Fusion.UsedAs<boolean>?,
	OnFocused: Fusion.UsedAs<() -> ()>?,
	OnFocusLost: Fusion.UsedAs<() -> ()>?,
}

return function(Scope: Fusion.Scope<any>, Props: Props)
	local Scope: Fusion.Scope<typeof(Fusion) & typeof(Util) & typeof(Components)> =
		Fusion.innerScope(Scope, Fusion, Util, Components)
	local Theme = Themer.Theme:now()

	local Text = Scope:EnsureValue(Util.Fallback(Props.Text, ""))
	local Disabled = Util.Fallback(Props.Disabled, false)
	local RemainingCharaters = Scope:Value(-1)
	local IsFocused = Scope:EnsureValue(Util.Fallback(Props.IsFocused, false))
	local OnFocused = Util.Fallback(Props.OnFocused, function() end)
	local OnFocusLost = Util.Fallback(Props.OnFocusLost, function() end)
	local Color = Util.Fallback(Props.Color, Theme.Colors.Primary.Main)
	local CharacterLimit = Util.Fallback(Props.CharacterLimit, -1)
	local ClearTextOnFocus = Util.Fallback(Props.ClearTextOnFocus, false)
	local PlaceholderText = Util.Fallback(Props.PlaceholderText, "")
	local TextSize = Util.Fallback(Props.TextSize, Theme.TextSize["1"])
	local PlaceholderColor3 = Util.Fallback(Props.PlaceholderColor3, Theme.Colors.NeutralContent.Dark)
	local TextColor3 = Util.Fallback(
		Props.TextColor3,
		Scope:Computed(function(use)
			return use(Theme.Colors.BaseContent.Main)
		end)
	)
	local FontFace = Util.Fallback(
		Props.FontFace,

		Scope:Computed(function(use)
			return Font.new(use(Theme.Font.Body), use(Theme.FontWeight.Body))
		end)
	)
	local TextXAlignment = Util.Fallback(Props.TextXAlignment, Enum.TextXAlignment.Left)
	local TextYAlignment = Util.Fallback(Props.TextYAlignment, Enum.TextYAlignment.Top)
	local TextTransparency = Util.Fallback(
		Props.TextTransparency,

		Scope:Computed(function(use)
			if use(Disabled) then
				return 0.75
			elseif use(IsFocused) then
				return 0
			else
				return 0.5
			end
		end)
	)

	Scope:Observer(Text):onChange(function()
		local TextValue = peek(Text) or ""
		Text:set(TextValue:sub(1, utf8.offset(TextValue, peek(CharacterLimit))))
		RemainingCharaters:set(CharacterLimit - (utf8.len(TextValue or "") or peek(CharacterLimit)))
	end)

	return Scope:Hydrate(Scope:Base(Util.CombineProps(Props, {
		ClassName = "TextBox",
		Name = "TextInput",
		CornerRadius = Scope:Computed(function(use)
			return UDim.new(0, use(Theme.CornerRadius["1"]))
		end),
		Padding = Scope:Computed(function(use)
			return UDim.new(0, use(Theme.Spacing["0.5"]))
		end),
		StrokeEnabled = true,
		StrokeColor = Scope:Spring(
			Scope:Computed(function(use)
				if use(IsFocused) then
					return use(Color)
				else
					return use(Theme.Colors.NeutralContent.Dark)
				end
			end),
			Theme.SpringSpeed["1"],
			Theme.SpringDampening["1"]
		),
		StrokeTransparency = Scope:Spring(
			Scope:Computed(function(use)
				if use(Disabled) then
					return 0.9
				end
				if use(IsFocused) then
					return 0
				else
					return 0.8
				end
			end),
			Theme.SpringSpeed["1"],
			Theme.SpringDampening["1"]
		),
		AutomaticSize = Enum.AutomaticSize.XY,
		AutoLocalize = false,
		Active = Scope:Computed(function(use)
			return not use(Disabled)
		end),
		BackgroundTransparency = 1,
		ClipsDescendants = true,
	}))) {
		Text = Text,
		TextColor3 = Scope:Spring(TextColor3, Theme.SpringSpeed["1"], Theme.SpringDampening["1"]),
		TextSize = TextSize,
		FontFace = FontFace,
		PlaceholderColor3 = PlaceholderColor3,
		PlaceholderText = PlaceholderText,
		TextXAlignment = TextXAlignment,
		TextYAlignment = TextYAlignment,
		ClearTextOnFocus = ClearTextOnFocus,
		TextTransparency = Scope:Spring(TextTransparency, Theme.SpringSpeed["1"], Theme.SpringDampening["1"]),
		MultiLine = Props.MultiLine,
		TextWrapped = Props.TextWrapped,

		TextEditable = Scope:Computed(function(use)
			return not use(Disabled)
		end),

		[OnEvent "Focused"] = function()
			if not peek(Disabled) then
				IsFocused:set(true)
				SoundService:PlayLocalSound(peek(Theme.Sound.Focus))
				peek(OnFocused)()
			end
		end,
		[OnEvent "FocusLost"] = function()
			IsFocused:set(false)
			peek(OnFocusLost)()
		end,
		[OnEvent "MouseEnter"] = function()
			SoundService:PlayLocalSound(peek(Theme.Sound.Hover))
		end,
		[OnEvent "SelectionGained"] = function()
			if not peek(Disabled) then
				SoundService:PlayLocalSound(peek(Theme.Sound.Hover))
			end
		end,

		[Out "Text"] = Text,
	}
end
