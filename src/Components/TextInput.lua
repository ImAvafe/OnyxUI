--[=[
		@class TextInput
		
		For letting the user input text.
]=]

local SoundService = game:GetService("SoundService")

local OnyxUI = script.Parent.Parent
local Fusion = require(OnyxUI.Parent.Fusion)
local Util = require(OnyxUI.Util)
local Themer = require(OnyxUI.Themer)
local PubTypes = require(OnyxUI.Util.PubTypes)

local Hydrate = Fusion.Hydrate
local Computed = Fusion.Computed
local OnEvent = Fusion.OnEvent
local Out = Fusion.Out
local Observer = Fusion.Observer
local Spring = Fusion.Spring
local Cleanup = Fusion.Cleanup
local Value = Fusion.Value

local Base = require(script.Parent.Base)

--[=[
		@within TextInput
		@interface TextInputProps

		@field ... BaseProps
		@field Disabled CanBeState<boolean>?
		@field CharacterLimit CanBeState<number>?
		@field Color CanBeState<Color3>?
		@field PlaceholderText CanBeState<string>?
		@field Text CanBeState<string>?
		@field ClearTextOnFocus CanBeState<boolean>?
		@field TextWrapped CanBeState<boolean>?
		@field MultiLine CanBeState<boolean>?
		@field TextSize CanBeState<number>?
		@field TextColor3 CanBeState<Color3>?
		@field FontFace CanBeState<Font>?
		@field PlaceholderColor3 CanBeState<Color3>?
		@field TextXAlignment CanBeState<Enum.TextXAlignment>?
		@field TextYAlignment CanBeState<Enum.TextYAlignment>?
		@field TextTransparency CanBeState<number>?
		@field IsFocused CanBeState<boolean>?
		@field OnFocused CanBeState<() -> ()>?
		@field OnFocusLost CanBeState<() -> ()>?
]=]
export type Props = Base.Props & {
	Disabled: PubTypes.CanBeState<boolean>?,
	CharacterLimit: PubTypes.CanBeState<number>?,
	Color: PubTypes.CanBeState<Color3>?,
	PlaceholderText: PubTypes.CanBeState<string>?,
	Text: PubTypes.CanBeState<string>?,
	ClearTextOnFocus: PubTypes.CanBeState<boolean>?,
	TextWrapped: PubTypes.CanBeState<boolean>?,
	MultiLine: PubTypes.CanBeState<boolean>?,
	TextSize: PubTypes.CanBeState<number>?,
	TextColor3: PubTypes.CanBeState<Color3>?,
	FontFace: PubTypes.CanBeState<Font>?,
	PlaceholderColor3: PubTypes.CanBeState<Color3>?,
	TextXAlignment: PubTypes.CanBeState<Enum.TextXAlignment>?,
	TextYAlignment: PubTypes.CanBeState<Enum.TextYAlignment>?,
	TextTransparency: PubTypes.CanBeState<number>?,

	IsFocused: PubTypes.CanBeState<boolean>?,
	OnFocused: PubTypes.CanBeState<() -> ()>?,
	OnFocusLost: PubTypes.CanBeState<() -> ()>?,
}

return function(Props: Props)
	local Disabled = Util.EnsureValue(Props.Disabled, "boolean", false)
	local RemainingCharaters = Value(-1)
	local IsFocused = Util.EnsureValue(Props.IsFocused, "boolean", false)
	local OnFocused = Util.EnsureValue(Props.OnFocused, "function", function() end)
	local OnFocusLost = Util.EnsureValue(Props.OnFocusLost, "function", function() end)
	local Text = Util.EnsureValue(Props.Text, "string", "")
	local Color = Util.EnsureValue(Props.Color, "Color3", Themer.Theme.Colors.Primary.Main)
	local CharacterLimit = Util.EnsureValue(Props.CharacterLimit, "number", -1)
	local ClearTextOnFocus = Util.EnsureValue(Props.ClearTextOnFocus, "boolean", false)
	local PlaceholderText = Util.EnsureValue(Props.PlaceholderText, "string", "")
	local TextSize = Util.EnsureValue(Props.TextSize, "number", Themer.Theme.TextSize["1"])
	local PlaceholderColor3 =
		Util.EnsureValue(Props.PlaceholderColor3, "Color3", Themer.Theme.Colors.NeutralContent.Dark)
	local TextColor3 = Util.EnsureValue(
		Props.TextColor3,
		"Color3",
		Computed(function()
			return Themer.Theme.Colors.BaseContent.Main:get()
		end)
	)
	local FontFace = Util.EnsureValue(
		Props.FontFace,
		"Font",
		Computed(function()
			return Font.new(Themer.Theme.Font.Body:get(), Themer.Theme.FontWeight.Body:get())
		end)
	)
	local TextXAlignment = Util.EnsureValue(Props.TextXAlignment, "EnumItem", Enum.TextXAlignment.Left)
	local TextYAlignment = Util.EnsureValue(Props.TextYAlignment, "EnumItem", Enum.TextYAlignment.Top)
	local TextTransparency = Util.EnsureValue(
		Props.TextTransparency,
		"number",
		Computed(function()
			if Disabled:get() then
				return 0.75
			elseif IsFocused:get() then
				return 0
			else
				return 0.5
			end
		end)
	)

	local Observers = {
		Observer(Text):onChange(function()
			local TextValue = Text:get() or ""
			Text:set(TextValue:sub(1, utf8.offset(TextValue, CharacterLimit:get())))
			RemainingCharaters:set(CharacterLimit:get() - (utf8.len(TextValue or "") or CharacterLimit:get()))
		end),
	}

	return Hydrate(Base(Util.CombineProps(Props, {
		ClassName = "TextBox",
		Name = "TextInput",
		CornerRadius = Computed(function()
			return UDim.new(0, Themer.Theme.CornerRadius["1"]:get())
		end),
		Padding = Computed(function()
			return UDim.new(0, Themer.Theme.Spacing["0.5"]:get())
		end),
		StrokeEnabled = true,
		StrokeColor = Spring(
			Computed(function()
				if IsFocused:get() then
					return Color:get()
				else
					return Themer.Theme.Colors.NeutralContent.Dark:get()
				end
			end),
			Themer.Theme.SpringSpeed["1"],
			Themer.Theme.SpringDampening["1"]
		),
		StrokeTransparency = Spring(
			Computed(function()
				if Disabled:get() then
					return 0.9
				end
				if IsFocused:get() then
					return 0
				else
					return 0.8
				end
			end),
			Themer.Theme.SpringSpeed["1"],
			Themer.Theme.SpringDampening["1"]
		),
		AutomaticSize = Enum.AutomaticSize.XY,
		AutoLocalize = false,
		Active = Computed(function()
			return not Disabled:get()
		end),
		BackgroundTransparency = 1,
		ClipsDescendants = true,

		[Cleanup] = Observers,
	}))) {
		Text = Text,
		TextColor3 = Spring(TextColor3, Themer.Theme.SpringSpeed["1"], Themer.Theme.SpringDampening["1"]),
		TextSize = TextSize,
		FontFace = FontFace,
		PlaceholderColor3 = PlaceholderColor3,
		PlaceholderText = PlaceholderText,
		TextXAlignment = TextXAlignment,
		TextYAlignment = TextYAlignment,
		ClearTextOnFocus = ClearTextOnFocus,
		TextTransparency = Spring(TextTransparency, Themer.Theme.SpringSpeed["1"], Themer.Theme.SpringDampening["1"]),
		MultiLine = Props.MultiLine,
		TextWrapped = Props.TextWrapped,

		TextEditable = Computed(function()
			return not Disabled:get()
		end),

		[OnEvent "Focused"] = function()
			if not Disabled:get() then
				IsFocused:set(true)
				SoundService:PlayLocalSound(Themer.Theme.Sound.Focus:get())
				OnFocused:get()()
			end
		end,
		[OnEvent "FocusLost"] = function()
			IsFocused:set(false)
			OnFocusLost:get()()
		end,
		[OnEvent "MouseEnter"] = function()
			SoundService:PlayLocalSound(Themer.Theme.Sound.Hover:get())
		end,
		[OnEvent "SelectionGained"] = function()
			if not Disabled:get() then
				SoundService:PlayLocalSound(Themer.Theme.Sound.Hover:get())
			end
		end,

		[Out "Text"] = Text,
	}
end
