local OnyxUI = script.Parent.Parent

local Fusion = require(OnyxUI.Parent.Fusion)
local Finalize = require(OnyxUI.Utils.Finalize)
local EnsureValue = require(OnyxUI.Utils.EnsureValue)
local Themer = require(OnyxUI.Utils.Themer)

local New = Fusion.New
local Children = Fusion.Children
local Computed = Fusion.Computed
local OnEvent = Fusion.OnEvent
local Out = Fusion.Out
local Observer = Fusion.Observer
local Spring = Fusion.Spring

local function TextInput(Props: table)
	Props.Name = EnsureValue(Props.Name, "string", "TextInput")
	Props.Disabled = EnsureValue(Props.Disabled, "boolean", false)
	Props.Text = EnsureValue(Props.Text, "string", "")
	Props.PlaceholderText = EnsureValue(Props.PlaceholderText, "string", "")
	Props.TextSize = EnsureValue(Props.TextSize, "string", Themer.Theme.TextSize["1"])
	Props.FontFace = EnsureValue(
		Props.FontFace,
		"Font",
		Computed(function()
			return Font.new(Themer.Theme.Font.Body:get(), Themer.Theme.FontWeight.Body:get())
		end)
	)
	Props.AutomaticSize = EnsureValue(Props.AutomaticSize, "EnumItem", Enum.AutomaticSize.XY)
	Props.FocusColor = EnsureValue(Props.FocusColor, "Color3", Themer.Theme.Colors.Primary.Main)
	Props.TextColor3 = EnsureValue(Props.TextColor3, "Color3", Themer.Theme.Colors.BaseContent.Main)
	Props.PlaceholderColor3 = EnsureValue(Props.PlaceholderColor3, "Color3", Themer.Theme.Colors.NeutralContent.Dark)
	Props.BackgroundColor3 = EnsureValue(Props.BackgroundColor3, "Color3", Themer.Theme.Colors.Base.Light)
	Props.ClipsDescendants = EnsureValue(Props.ClipsDescendants, "boolean", true)

	Props.CharacterLimit = EnsureValue(Props.CharacterLimit, "number", -1)
	Props.RemainingCharaters = EnsureValue(Props.RemainingCharaters, "number", -1)

	Props.IsFocused = EnsureValue(Props.IsFocused, "boolean", false)
	Props.OnFocused = EnsureValue(Props.OnFocused, "function", function() end)
	Props.OnFocusLost = EnsureValue(Props.OnFocusLost, "function", function() end)

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
				return Themer.Theme.Colors.Neutral.Light:get()
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
			Props.IsFocused:set(true)
			Props.OnFocused:get()()
		end,
		[OnEvent "FocusLost"] = function()
			Props.IsFocused:set(false)
			Props.OnFocusLost:get()()
		end,

		[Out "Text"] = Props.Text,

		[Children] = {
			New "UICorner" {
				CornerRadius = Computed(function()
					return UDim.new(0, Themer.Theme.CornerRadius["0.5"]:get())
				end),
			},
			New "UIPadding" {
				PaddingBottom = Computed(function()
					return UDim.new(0, Themer.Theme.Spacing["0.5"]:get())
				end),
				PaddingLeft = Computed(function()
					return UDim.new(0, Themer.Theme.Spacing["0.75"]:get())
				end),
				PaddingRight = Computed(function()
					return UDim.new(0, Themer.Theme.Spacing["0.75"]:get())
				end),
				PaddingTop = Computed(function()
					return UDim.new(0, Themer.Theme.Spacing["0.5"]:get())
				end),
			},
			New "UIStroke" {
				ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
				Color = Spring(
					Computed(function()
						if Props.Disabled:get() then
							return Themer.Theme.Colors.Neutral.Dark:get()
						end
						if Props.IsFocused:get() then
							return Props.FocusColor:get()
						else
							return Themer.Theme.Colors.Neutral.Light:get()
						end
					end),
					Themer.Theme.SpringSpeed["1"],
					Themer.Theme.SpringDampening
				),
				Thickness = 2,
			},

			Props[Children],
		},
	}

	local DisconnectTextObs = Observer(Props.Text):onChange(function()
		local Text = Props.Text:get() or ""
		Props.Text:set(Text:sub(1, utf8.offset(Text, Props.CharacterLimit:get())))
		Props.RemainingCharaters:set(
			Props.CharacterLimit:get() - (utf8.len(Props.Text:get() or "") or Props.CharacterLimit:get())
		)
	end)

	TextInputInstance:GetPropertyChangedSignal("Parent"):Connect(function()
		if TextInputInstance.Parent == nil then
			DisconnectTextObs()
		end
	end)

	return Finalize(TextInputInstance)
end

return TextInput
