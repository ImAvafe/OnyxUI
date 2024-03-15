local OnyxUI = script.Parent.Parent

local Fusion = require(OnyxUI.Parent.Fusion)

local EnsureValue = require(OnyxUI.Utils.EnsureValue)
local Themer = require(OnyxUI.Utils.Themer)

local New = Fusion.New
local Children = Fusion.Children
local Out = Fusion.Out
local Computed = Fusion.Computed

local function Text(Props: table)
	Props.Name = EnsureValue(Props.Name, "string", "Text")
	Props.AutomaticSize = EnsureValue(Props.AutomaticSize, "EnumItem", Enum.AutomaticSize.XY)
	Props.TextColor3 = EnsureValue(Props.TextColor3, "Color3", Themer.Theme.Colors.BaseContent.Main)
	Props.TextSize = EnsureValue(Props.TextSize, "number", Themer.Theme.TextSize["1"])
	Props.RichText = EnsureValue(Props.RichText, "boolean", true)
	Props.FontFace = EnsureValue(
		Props.FontFace,
		"Font",
		Computed(function()
			return Font.new(Themer.Theme.Font.Body:get(), Themer.Theme.FontWeight.Body:get())
		end)
	)
	Props.TextWrapped = EnsureValue(Props.TextWrapped, "boolean", true)
	Props.ClipsDescendants = EnsureValue(Props.ClipsDescendants, "boolean", true)
	Props.TextXAlignment = EnsureValue(Props.TextXAlignment, "EnumItem", Enum.TextXAlignment.Left)
	Props.TextYAlignment = EnsureValue(Props.TextYAlignment, "EnumItem", Enum.TextYAlignment.Top)
	Props.BackgroundTransparency = EnsureValue(Props.BackgroundTransparency, "number", 1)

	return New "TextLabel" {
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
		Interactable = Props.Interactable,
		BackgroundColor3 = Props.BackgroundColor3,
		BackgroundTransparency = Props.BackgroundTransparency,

		RichText = Props.RichText,
		TextSize = Props.TextSize,
		TextColor3 = Props.TextColor3,
		FontFace = Props.FontFace,
		Font = Props.Font,
		TextScaled = Props.TextScaled,
		Text = Props.Text,
		TextWrapped = Props.TextWrapped,
		TextXAlignment = Props.TextXAlignment,
		TextYAlignment = Props.TextYAlignment,
		TextTruncate = Props.TextTruncate,
		AutoLocalize = Props.AutoLocalize,
		LineHeight = Props.LineHeight,
		LocalizedText = Props.LocalizedText,
		MaxVisibleGraphemes = Props.MaxVisibleGraphemes,
		TextTransparency = Props.TextTransparency,

		[Out "ContentText"] = Props.ContentText,
		[Out "TextBounds"] = Props.TextBounds,
		[Out "TextFits"] = Props.TextFits,

		[Children] = Props[Children],
	}
end

return Text
