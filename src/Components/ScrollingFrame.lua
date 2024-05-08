local OnyxUI = require(script.Parent.Parent)
local Fusion = require(OnyxUI.Packages.Fusion)

local EnsureValue = require(OnyxUI.Utils.EnsureValue)
local Themer = require(OnyxUI.Utils.Themer)

local New = Fusion.New
local Children = Fusion.Children
local Computed = Fusion.Computed

local function ScrollingFrame(Props: { [any]: any })
	Props.Name = EnsureValue(Props.Name, "string", "ScrollingFrame")
	Props.AutomaticSize = EnsureValue(Props.AutomaticSize, "Enum", Enum.AutomaticSize.None)
	Props.ScrollingDirection = EnsureValue(Props.ScrollingDirection, "Enum", Enum.ScrollingDirection.Y)
	Props.AutomaticCanvasSize = EnsureValue(Props.AutomaticCanvasSize, "Enum", Enum.AutomaticSize.Y)
	Props.BackgroundTransparency = EnsureValue(Props.BackgroundTransparency, "number", 1)
	Props.ScrollBarThickness = EnsureValue(Props.ScrollBarThickness, "number", 8)
	Props.ScrollBarImageTransparency = EnsureValue(Props.ScrollBarImageTransparency, "number", 0)
	Props.ScrollBarImageColor3 =
		EnsureValue(Props.ScrollBarImageColor3, "Color3", Themer.Theme.Colors.NeutralContent.Dark)
	Props.Selectable = EnsureValue(Props.Selectable, "boolean", false)
	Props.MidImage = EnsureValue(Props.MidImage, "string", "rbxassetid://16547330984")

	return New "ScrollingFrame" {
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

		ScrollingDirection = Props.ScrollingDirection,
		AutomaticCanvasSize = Props.AutomaticCanvasSize,
		CanvasSize = Props.CanvasSize,
		ScrollBarThickness = Props.ScrollBarThickness,
		ScrollBarImageTransparency = Props.ScrollBarImageTransparency,
		ScrollBarImageColor3 = Props.ScrollBarImageColor3,
		MidImage = Props.MidImage,
		BottomImage = Computed(function()
			if Themer.Theme.CornerRadius["1"]:get() >= 3 then
				return "rbxassetid://16547643439"
			else
				return "rbxassetid://16547330984"
			end
		end),
		TopImage = Computed(function()
			if Themer.Theme.CornerRadius["1"]:get() >= 3 then
				return "rbxassetid://16547667444"
			else
				return "rbxassetid://16547330984"
			end
		end),

		[Children] = Props[Children],
	}
end

return ScrollingFrame
