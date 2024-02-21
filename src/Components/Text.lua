local OnyxUI = script.Parent.Parent

local Fusion = require(OnyxUI.Parent.Fusion)
local Finalize = require(OnyxUI.Utils.Finalize)
local EnsureValue = require(OnyxUI.Utils.EnsureValue)

local New = Fusion.New
local Children = Fusion.Children

local function Text(Props)
	Props.TextColor3 = EnsureValue(Props.TextColor3, "Color3", Color3.fromRGB(255, 255, 255))
	Props.TextSize = EnsureValue(Props.TextSize, "number", 18)
	Props.RichText = EnsureValue(Props.RichText, "boolean", false)
	Props.FontFace = EnsureValue(Props.FontFace, "Font", Font.fromEnum(Enum.Font.GothamMedium))
	Props.ClipsDescendants = EnsureValue(Props.ClipsDescendants, "boolean", true)

	return Finalize(New "TextLabel" {
		Name = Props.Name or "Text",
		Parent = Props.Parent,
		LayoutOrder = Props.LayoutOrder,
		Position = Props.Position,
		AnchorPoint = Props.AnchorPoint,
		Size = Props.Size,
		AutomaticSize = Props.AutomaticSize or Enum.AutomaticSize.XY,
		ZIndex = Props.ZIndex,
		Visible = Props.Visible,

		BackgroundTransparency = 1,
		ClipsDescendants = Props.ClipsDescendants,

		RichText = Props.RichText,
		TextSize = Props.TextSize,
		TextColor3 = Props.TextColor3,
		FontFace = Props.FontFace,
		TextScaled = Props.TextScaled,
		Text = Props.Text,
		TextWrapped = Props.TextWrapped,
		TextXAlignment = Props.TextXAlignment or Enum.TextXAlignment.Left,
		TextYAlignment = Props.TextYAlignment or Enum.TextYAlignment.Top,
		TextTruncate = Props.TextTruncate,
		AutoLocalize = Props.AutoLocalize,

		[Children] = Props[Children],
	})
end

return Text
