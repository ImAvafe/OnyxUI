local NekaUI = script.Parent.Parent

local Fusion = require(NekaUI.Parent.Fusion)
local Finalize = require(NekaUI.Utils.Finalize)
local EnsureProp = require(NekaUI.Utils.EnsureProp)

local New = Fusion.New
local Children = Fusion.Children

local Frame = require(NekaUI.Components.Frame)

local function ScrollingFrame(Props)
	Props.AutomaticSize = EnsureProp(Props.AutomaticSize, "Enum", Enum.AutomaticSize.None)
	Props.ScrollingDirection = EnsureProp(Props.ScrollingDirection, "Enum", Enum.ScrollingDirection.Y)
	Props.AutomaticCanvasSize = EnsureProp(Props.AutomaticCanvasSize, "Enum", Enum.AutomaticSize.Y)

	return Finalize(New "ScrollingFrame" {
		Name = Props.Name,
		Parent = Props.Parent,
		LayoutOrder = Props.LayoutOrder,
		Position = Props.Position,
		AnchorPoint = Props.AnchorPoint,
		Size = Props.Size,
		AutomaticSize = Props.AutomaticSize,
		ZIndex = Props.ZIndex,
		Selectable = false,

		BackgroundTransparency = 1,
		ScrollBarThickness = 0,
		ScrollBarImageTransparency = 1,
		ScrollingDirection = Props.ScrollingDirection,
		ScrollBarImageColor3 = Color3.fromRGB(255, 255, 255),
		AutomaticCanvasSize = Props.AutomaticCanvasSize,

		[Children] = {
			Frame {
				Name = "Contents",
				Size = UDim2.fromScale(1, 1),
				AutomaticSize = Enum.AutomaticSize.None,

				[Children] = Props[Children],
			},
		},
	})
end

return ScrollingFrame
