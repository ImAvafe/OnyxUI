--[=[
		@class TextInput
		
		For letting the user input text.
]=]

local SoundService = game:GetService("SoundService")

local OnyxUI = script.Parent.Parent
local Fusion = require(OnyxUI.TypedPackages.Fusion)
local Util = require(OnyxUI.Util)
local Themer = require(OnyxUI.Themer)

local Peek = Fusion.peek
local OnEvent = Fusion.OnEvent
local Out = Fusion.Out
local InnerScope = Fusion.innerScope

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
		@field TextEditable Fusion.UsedAs<boolean>?
		@field MultiLine Fusion.UsedAs<boolean>?
		@field TextSize Fusion.UsedAs<number>?
		@field TextColor3 Fusion.UsedAs<Color3>?
		@field FontFace Fusion.UsedAs<Font>?
		@field PlaceholderColor3 Fusion.UsedAs<Color3>?
		@field TextXAlignment Fusion.UsedAs<Enum.TextXAlignment>?
		@field TextYAlignment Fusion.UsedAs<Enum.TextYAlignment>?
		@field TextTransparency Fusion.UsedAs<number>?
		@field TextProcessor Fusion.UsedAs<(string) -> string>?
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
	TextEditable: Fusion.UsedAs<boolean>?,
	MultiLine: Fusion.UsedAs<boolean>?,
	TextSize: Fusion.UsedAs<number>?,
	TextColor3: Fusion.UsedAs<Color3>?,
	FontFace: Fusion.UsedAs<Font>?,
	PlaceholderColor3: Fusion.UsedAs<Color3>?,
	TextXAlignment: Fusion.UsedAs<Enum.TextXAlignment>?,
	TextYAlignment: Fusion.UsedAs<Enum.TextYAlignment>?,
	TextTransparency: Fusion.UsedAs<number>?,
	TextProcessor: Fusion.UsedAs<(string) -> string>?,

	IsFocused: Fusion.UsedAs<boolean>?,
	OnFocused: Fusion.UsedAs<() -> ()>?,
	OnFocusLost: Fusion.UsedAs<() -> ()>?,
}

return function(Scope: Fusion.Scope<any>, Props: Props)
	local Scope = InnerScope(Scope, Fusion, Util, Components)
	local Theme = Themer.Theme:now()

	local Text = Scope:EnsureValue(Util.Fallback(Props.Text, ""))
	local Disabled = Util.Fallback(Props.Disabled, false)
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
		Scope:Computed(function(Use)
			return Use(Theme.Colors.BaseContent.Main)
		end)
	)
	local FontFace = Util.Fallback(
		Props.FontFace,

		Scope:Computed(function(Use)
			return Font.new(Use(Theme.Font.Body), Use(Theme.FontWeight.Body))
		end)
	)
	local TextXAlignment = Util.Fallback(Props.TextXAlignment, Enum.TextXAlignment.Left)
	local TextYAlignment = Util.Fallback(Props.TextYAlignment, Enum.TextYAlignment.Top)
	local TextTransparency = Util.Fallback(
		Props.TextTransparency,

		Scope:Computed(function(Use)
			if Use(Disabled) then
				return 0.75
			elseif Use(IsFocused) then
				return 0
			else
				return 0.5
			end
		end)
	)
	local TextProcessor = Util.Fallback(Props.TextProcessor, function(NewText)
		return NewText
	end)
	local TextEditable = Util.Fallback(
		Props.TextEditable,
		Scope:Computed(function(Use)
			return not Use(Disabled)
		end)
	)

	local OutText = Scope:Value("")
	local ProcessedText = Scope:Computed(function(Use)
		local OutTextValue = Use(OutText) or ""
		local CharacterLimitValue = Use(CharacterLimit)
		local LimitedText = OutTextValue:sub(1, utf8.offset(OutTextValue, CharacterLimitValue))
		local FullyProcessedText = Use(TextProcessor)(LimitedText)

		return FullyProcessedText
	end)
	local InvalidInputActive = Scope:Value(false)

	local Object = Scope:Hydrate(Scope:Base(Util.CombineProps(Props, {
		ClassName = "TextBox",
		Name = "TextInput",
		CornerRadius = Scope:Computed(function(Use)
			return UDim.new(0, Use(Theme.CornerRadius["1"]))
		end),
		Padding = Scope:Computed(function(Use)
			return UDim.new(0, Use(Theme.Spacing["0.5"]))
		end),
		PaddingLeft = Scope:Spring(
			Scope:Computed(function(Use)
				if Use(InvalidInputActive) then
					return UDim.new(0, Use(Theme.Spacing["0.75"]))
				else
					return UDim.new(0, Use(Theme.Spacing["0.5"]))
				end
			end),
			Theme.SpringSpeed["1"],
			Theme.SpringDampening["1"]
		),
		PaddingRight = Scope:Spring(
			Scope:Computed(function(Use)
				if Use(InvalidInputActive) then
					return UDim.new(0, Use(Theme.Spacing["0.75"]))
				else
					return UDim.new(0, Use(Theme.Spacing["0.5"]))
				end
			end),
			Theme.SpringSpeed["1"],
			Theme.SpringDampening["1"]
		),
		StrokeEnabled = true,
		StrokeColor = Scope:Spring(
			Scope:Computed(function(Use)
				if Use(IsFocused) then
					return Use(Color)
				else
					return Use(Theme.Colors.NeutralContent.Dark)
				end
			end),
			Theme.SpringSpeed["1"],
			Theme.SpringDampening["1"]
		),
		StrokeTransparency = Scope:Spring(
			Scope:Computed(function(Use)
				if Use(Disabled) then
					return 0.9
				end
				if Use(IsFocused) then
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
		Active = Scope:Computed(function(Use)
			return not Use(Disabled)
		end),
		BackgroundTransparency = 1,
		ClipsDescendants = true,
	}))) {
		Text = Text,
		TextColor3 = Scope:Spring(
			Scope:Computed(function(Use)
				if Use(InvalidInputActive) then
					return Use(Theme.Colors.Error.Main)
				else
					return Use(TextColor3)
				end
			end),
			Theme.SpringSpeed["1"],
			Theme.SpringDampening["1"]
		),
		TextSize = TextSize,
		FontFace = FontFace,
		PlaceholderColor3 = PlaceholderColor3,
		PlaceholderText = PlaceholderText,
		TextXAlignment = TextXAlignment,
		TextYAlignment = TextYAlignment,
		ClearTextOnFocus = ClearTextOnFocus,
		TextTransparency = Scope:Spring(TextTransparency, Theme.SpringSpeed["1"], Theme.SpringDampening["1"]),
		TextEditable = TextEditable,

		MultiLine = Props.MultiLine,
		TextWrapped = Props.TextWrapped,

		[OnEvent "Focused"] = function()
			if (not Peek(Disabled)) and Peek(TextEditable) then
				IsFocused:set(true)
				SoundService:PlayLocalSound(Peek(Theme.Sound.Focus))
				Peek(OnFocused)()
			end
		end,
		[OnEvent "FocusLost"] = function()
			IsFocused:set(false)
			Peek(OnFocusLost)()
		end,
		[OnEvent "MouseEnter"] = function()
			if not Peek(Disabled) then
				SoundService:PlayLocalSound(Peek(Theme.Sound.Hover))
			end
		end,
		[OnEvent "SelectionGained"] = function()
			if (not Peek(Disabled)) and Peek(TextEditable) then
				SoundService:PlayLocalSound(Peek(Theme.Sound.Hover))
			end
		end,
		[Out "Text"] = OutText,
	}

	Scope:Observer(OutText):onChange(function()
		local ProcessedTextValue = Peek(ProcessedText)
		local OutTextValue = Peek(OutText)

		Text:set(ProcessedTextValue)
		Object.Text = ProcessedTextValue

		if utf8.len(OutTextValue) ~= utf8.len(ProcessedTextValue) then
			InvalidInputActive:set(true)
			task.wait(0.075)
			InvalidInputActive:set(false)
		end
	end)

	return Object
end
