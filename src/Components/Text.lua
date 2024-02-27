local OnyxUI = script.Parent.Parent

local Fusion = require(OnyxUI.Parent.Fusion)
local Finalize = require(OnyxUI.Utils.Finalize)
local EnsureValue = require(OnyxUI.Utils.EnsureValue)

local New = Fusion.New
local Children = Fusion.Children

local function Text(Props: table)
	Props.Name = EnsureValue(Props.Name, "string", "Text")
	Props.AutomaticSize = EnsureValue(Props.AutomaticSize, "EnumItem", Enum.AutomaticSize.XY)
	Props.TextColor3 = EnsureValue(Props.TextColor3, "Color3", Color3.fromRGB(255, 255, 255))
	Props.TextSize = EnsureValue(Props.TextSize, "number", 18)
	Props.RichText = EnsureValue(Props.RichText, "boolean", false)
	Props.FontFace = EnsureValue(Props.FontFace, "Font", Font.fromEnum(Enum.Font.GothamMedium))
	Props.ClipsDescendants = EnsureValue(Props.ClipsDescendants, "boolean", true)
	Props.TextXAlignment = EnsureValue(Props.TextXAlignment, "EnumItem", Enum.TextXAlignment.Left)
	Props.TextYAlignment = EnsureValue(Props.TextYAlignment, "EnumItem", Enum.TextYAlignment.Top)
	Props.BackgroundTransparency = EnsureValue(Props.BackgroundTransparency, "number", 1)

	return Finalize(New "TextLabel" {
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

		RichText = Props.RichText,
		TextSize = Props.TextSize,
		TextColor3 = Props.TextColor3,
		FontFace = Props.FontFace,
		TextScaled = Props.TextScaled,
		Text = Props.Text,
		TextWrapped = Props.TextWrapped,
		TextXAlignment = Props.TextXAlignment,
		TextYAlignment = Props.TextYAlignment,
		TextTruncate = Props.TextTruncate,
		AutoLocalize = Props.AutoLocalize,

		[Children] = Props[Children],
	})
end

return Text
