local OnyxUI = script.Parent.Parent

local Fusion = require(OnyxUI.Parent.Fusion)
local Finalize = require(OnyxUI.Utils.Finalize)
local ColourUtils = require(OnyxUI.Parent.ColourUtils)
local EnsureValue = require(OnyxUI.Utils.EnsureValue)
local Themer = require(OnyxUI.Utils.Themer)

local New = Fusion.New
local Children = Fusion.Children
local Computed = Fusion.Computed
local Value = Fusion.Value
local OnEvent = Fusion.OnEvent
local Out = Fusion.Out
local Observer = Fusion.Observer
local Spring = Fusion.Spring

local Text = require(OnyxUI.Components.Text)

local function TextInput(Props: table)
	Props.Name = EnsureValue(Props.Name, "string", "TextInput")
	Props.Disabled = EnsureValue(Props.Disabled, "boolean", false)
	Props.Text = EnsureValue(Props.Text, "string", "")
	Props.BackgroundColor3 = EnsureValue(Props.BackgroundColor3, "Color3", Themer.Theme.Colors.Neutral.Dark:get())
	Props.TextSize = EnsureValue(Props.TextSize, "string", Themer.Theme.TextSize:get())
	Props.TextColor3 = EnsureValue(Props.TextColor3, "Color3", Themer.Theme.Colors.BaseContent.Main:get())
	Props.PlaceholderColor3 =
		EnsureValue(Props.PlaceholderColor3, "Color3", Themer.Theme.Colors.NeutralContent.Dark:get())
	Props.FontFace = EnsureValue(
		Props.FontFace,
		"Font",
		Font.fromName(Themer.Theme.Fonts.Body:get(), Themer.Theme.FontWeights.Body:get())
	)

	Props.AutomaticSize = EnsureValue(Props.AutomaticSize, "EnumItem", Enum.AutomaticSize.XY)
	Props.CharacterLimit = EnsureValue(Props.CharacterLimit, "number", -1)
	Props.OnFocused = EnsureValue(Props.OnFocused, "function", function() end)
	Props.OnFocusLost = EnsureValue(Props.OnFocusLost, "function", function() end)

	local IsFocused = Value(false)
	local RemainingCharaters = Computed(function()
		return Props.CharacterLimit:get() - (utf8.len(Props.Text:get() or "") or Props.CharacterLimit:get())
	end)

	local TextInputInstance = New "TextBox" {
		Name = Props.Name,
		Parent = Props.Parent,
		Position = Props.Position,
		Rotation = Props.Rotation,
		AnchorPoint = Props.AnchorPoint,
		Size = Props.Size,
		AutomaticSize = Props.AutomaticSize,
		Visible = Props.Visible,
		ZIndex = Props.ZIndex,
		LayoutOrder = Props.LayoutOrder,
		ClipsDescendants = Props.ClipsDescendants,
		Active = Props.Active,
		Selectable = Props.Selectable,
		BackgroundColor3 = Props.BackgroundColor3,
		BackgroundTransparency = Props.BackgroundTransparency,

		PlaceholderColor3 = Computed(function()
			if Props.Disabled:get() then
				return Color3.fromRGB(65, 65, 65)
			else
				return Props.PlaceholderColor3:get()
			end
		end),
		TextSize = Props.TextSize,
		TextColor3 = Props.TextColor3,
		FontFace = Props.FontFace,
		Text = Props.Text,
		RichText = Props.RichText,
		PlaceholderText = Props.PlaceholderText,
		TextWrapped = Props.TextWrapped,
		TextXAlignment = Props.TextXAlignment or Enum.TextXAlignment.Left,
		TextYAlignment = Props.TextYAlignment or Enum.TextYAlignment.Top,
		MultiLine = Props.MultiLine,
		ClearTextOnFocus = Props.ClearTextOnFocus,
		AutoLocalize = false,
		TextEditable = Computed(function()
			return not Props.Disabled:get()
		end),

		[OnEvent "Focused"] = function()
			IsFocused:set(true)
			Props.OnFocused:get()()
		end,
		[OnEvent "FocusLost"] = function()
			IsFocused:set(false)
			Props.OnFocusLost:get()()
		end,

		[Out "Text"] = Props.Text,

		[Children] = {
			New "UICorner" {
				CornerRadius = Computed(function()
					return UDim.new(0, Themer.Theme.CornerRadius:get() / 1.5)
				end),
			},
			New "UIPadding" {
				PaddingBottom = UDim.new(0, Themer.Theme.Space:get() * 2),
				PaddingLeft = UDim.new(0, Themer.Theme.Space:get() * 3),
				PaddingRight = UDim.new(0, Themer.Theme.Space:get() * 3),
				PaddingTop = UDim.new(0, Themer.Theme.Space:get() * 2),
			},
			New "UIStroke" {
				ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
				Color = Spring(
					Computed(function()
						local BaseColor = Themer.Theme.Colors.Neutral.Light:get()
						if Props.Disabled:get() then
							return BaseColor
						end
						if IsFocused:get() then
							return ColourUtils.Lighten(BaseColor, 0.08)
						else
							return BaseColor
						end
					end),
					60,
					1
				),
				Thickness = 2,
			},
			Computed(function()
				if (Props.CharacterLimit:get() ~= -1) and (RemainingCharaters:get() < Props.CharacterLimit:get()) then
					return Text {
						Name = "RemainingCharCount",
						AnchorPoint = Vector2.new(1, 1),
						Position = UDim2.fromScale(1, 1),
						Text = RemainingCharaters,
						TextSize = 15,
						TextColor3 = Computed(function()
							if RemainingCharaters:get() == 0 then
								return Themer.Theme.Colors.Error.Main:get()
							else
								return Themer.Theme.Colors.Neutral.Light:get()
							end
						end),
					}
				end
			end, Fusion.cleanup),

			Props[Children],
		},
	}

	local DisconnectTextObs = Observer(Props.Text):onChange(function()
		local NewText = Props.Text:get() or ""
		Props.Text:set(NewText:sub(1, utf8.offset(NewText, Props.CharacterLimit:get())))
	end)

	TextInputInstance:GetPropertyChangedSignal("Parent"):Connect(function()
		if TextInputInstance.Parent == nil then
			DisconnectTextObs()
		end
	end)

	return Finalize(TextInputInstance)
end

return TextInput
