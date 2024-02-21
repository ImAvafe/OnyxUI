local OnyxUI = script.Parent.Parent

local Fusion = require(OnyxUI.Parent.Fusion)
local Finalize = require(OnyxUI.Utils.Finalize)
local ColourUtils = require(OnyxUI.Parent.ColourUtils)
local EnsureValue = require(OnyxUI.Utils.EnsureValue)

local New = Fusion.New
local Children = Fusion.Children
local Computed = Fusion.Computed
local Value = Fusion.Value
local OnEvent = Fusion.OnEvent
local Out = Fusion.Out
local Observer = Fusion.Observer
local Spring = Fusion.Spring

local Text = require(OnyxUI.Components.Text)

local function TextInput(Props)
	Props.Disabled = EnsureValue(Props.Disabled, "boolean", false)
	Props.Text = EnsureValue(Props.Text, "string", "")
	Props.CharacterLimit = EnsureValue(Props.CharacterLimit, "number", -1)

	Props.OnFocused = EnsureValue(Props.OnFocused, "function", function() end)
	Props.OnFocusLost = EnsureValue(Props.OnFocusLost, "function", function() end)

	local IsFocused = Value(false)
	local RemainingCharaters = Computed(function()
		return Props.CharacterLimit:get() - (utf8.len(Props.Text:get() or "") or Props.CharacterLimit:get())
	end)

	local TextInputInstance = New "TextBox" {
		Name = Props.Name or "Text",
		Parent = Props.Parent,
		LayoutOrder = Props.LayoutOrder,
		Position = Props.Position,
		AnchorPoint = Props.AnchorPoint,
		Size = Props.Size,
		AutomaticSize = Props.AutomaticSize or Enum.AutomaticSize.XY,
		ZIndex = Props.ZIndex,

		PlaceholderColor3 = Computed(function()
			if Props.Disabled:get() then
				return Color3.fromRGB(65, 65, 65)
			else
				return Color3.fromRGB(100, 100, 100)
			end
		end),
		TextSize = Props.TextSize or 18,
		TextColor3 = Props.TextColor3 or Color3.fromRGB(255, 255, 255),
		FontFace = Props.FontFace or Font.fromName("GothamSsm", Enum.FontWeight.Medium),
		TextEditable = Computed(function()
			return not Props.Disabled:get()
		end),
		Text = Props.Text,
		RichText = Props.RichText,
		PlaceholderText = Props.PlaceholderText,
		TextWrapped = Props.TextWrapped,
		TextXAlignment = Props.TextXAlignment or Enum.TextXAlignment.Left,
		TextYAlignment = Props.TextYAlignment or Enum.TextYAlignment.Top,
		MultiLine = Props.MultiLine,
		ClearTextOnFocus = Props.ClearTextOnFocus,

		AutoLocalize = false,
		ClipsDescendants = true,
		BackgroundColor3 = Color3.fromRGB(34, 34, 34),

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
				CornerRadius = UDim.new(0, 5),
			},
			New "UIPadding" {
				PaddingBottom = UDim.new(0, 8),
				PaddingLeft = UDim.new(0, 12),
				PaddingRight = UDim.new(0, 12),
				PaddingTop = UDim.new(0, 8),
			},
			New "UIStroke" {
				ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
				Color = Spring(
					Computed(function()
						local BaseColor = Color3.fromRGB(50, 50, 50)
						if Props.Disabled:get() then
							return BaseColor
						end
						if IsFocused:get() then
							return ColourUtils.Lighten(BaseColor, 0.09)
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
								return Color3.fromRGB(190, 90, 90)
							else
								return Color3.fromRGB(119, 119, 119)
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
