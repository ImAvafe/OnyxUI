local SoundService = game:GetService("SoundService")

local OnyxUI = script.Parent.Parent
local Fusion = require(OnyxUI.Parent.Fusion)
local EnsureValue = require(OnyxUI.Utils.EnsureValue)
local Themer = require(OnyxUI.Themer)
local PubTypes = require(OnyxUI.Utils.PubTypes)
local CombineProps = require(OnyxUI.Utils.CombineProps)

local Hydrate = Fusion.Hydrate
local Computed = Fusion.Computed
local OnEvent = Fusion.OnEvent
local Out = Fusion.Out
local Observer = Fusion.Observer
local Spring = Fusion.Spring
local Cleanup = Fusion.Cleanup
local Value = Fusion.Value

local Base = require(script.Parent.Base)

export type Props = Base.Props & {
	Disabled: PubTypes.CanBeState<boolean>?,
	Text: PubTypes.CanBeState<string>?,
	PlaceholderText: PubTypes.CanBeState<string>?,
	Color: PubTypes.CanBeState<Color3>?,
	CharacterLimit: PubTypes.CanBeState<number>?,
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
	local Disabled = EnsureValue(Props.Disabled, "boolean", false)
	local RemainingCharaters = Value(-1)
	local IsFocused = EnsureValue(Props.IsFocused, "boolean", false)
	local OnFocused = EnsureValue(Props.OnFocused, "function", function() end)
	local OnFocusLost = EnsureValue(Props.OnFocusLost, "function", function() end)
	local Text = EnsureValue(Props.Text, "string", "")
	local Color = EnsureValue(Props.Color, "Color3", Themer.Theme.Colors.Primary.Main)
	local CharacterLimit = EnsureValue(Props.CharacterLimit, "number", -1)
	local ClearTextOnFocus = EnsureValue(Props.ClearTextOnFocus, "boolean", false)
	local PlaceholderText = EnsureValue(Props.PlaceholderText, "string", "")
	local TextSize = EnsureValue(Props.TextSize, "number", Themer.Theme.TextSize["1"])
	local PlaceholderColor3 = EnsureValue(Props.PlaceholderColor3, "Color3", Themer.Theme.Colors.NeutralContent.Dark)
	local TextColor3 = EnsureValue(
		Props.TextColor3,
		"Color3",
		Computed(function()
			return Themer.Theme.Colors.BaseContent.Main:get()
		end)
	)
	local FontFace = EnsureValue(
		Props.FontFace,
		"Font",
		Computed(function()
			return Font.new(Themer.Theme.Font.Body:get(), Themer.Theme.FontWeight.Body:get())
		end)
	)
	local TextXAlignment = EnsureValue(Props.TextXAlignment, "EnumItem", Enum.TextXAlignment.Left)
	local TextYAlignment = EnsureValue(Props.TextYAlignment, "EnumItem", Enum.TextYAlignment.Top)
	local TextTransparency = EnsureValue(
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

	return Hydrate(Base(CombineProps(Props, {
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
			Themer.Theme.SpringDampening
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
			Themer.Theme.SpringDampening
		),
		AutomaticSize = Enum.AutomaticSize.XY,
		AutoLocalize = false,
		Active = Computed(function()
			return not Disabled:get()
		end),
		BackgroundTransparency = 1,

		[Cleanup] = Observers,
	}))) {
		Text = Text,
		TextColor3 = Spring(TextColor3, Themer.Theme.SpringSpeed["1"], Themer.Theme.SpringDampening),
		TextSize = TextSize,
		FontFace = FontFace,
		PlaceholderColor3 = PlaceholderColor3,
		PlaceholderText = PlaceholderText,
		TextXAlignment = TextXAlignment,
		TextYAlignment = TextYAlignment,
		ClearTextOnFocus = ClearTextOnFocus,
		TextTransparency = Spring(TextTransparency, Themer.Theme.SpringSpeed["1"], Themer.Theme.SpringDampening),
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
