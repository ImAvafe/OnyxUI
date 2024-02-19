local NekaUI = script.Parent.Parent

local Fusion = require(NekaUI.Parent.Fusion)
local EnsureProp = require(NekaUI.Utils.EnsureProp)

local New = Fusion.New
local Children = Fusion.Children

local function Text(Props)
	Props.ImageColor3 = EnsureProp(Props.ImageColor3, "Color3", Color3.fromRGB(255, 255, 255))

	return New "ImageLabel" {
		Name = Props.Name or "Icon",
		Parent = Props.Parent,
		LayoutOrder = Props.LayoutOrder,
		Position = Props.Position,
		AnchorPoint = Props.AnchorPoint,
		Size = Props.Size or UDim2.fromOffset(20, 20),
		AutomaticSize = Props.AutomaticSize,
		ZIndex = Props.ZIndex,
		Rotation = Props.Rotation,

		Image = Props.Image,
		ImageColor3 = Props.ImageColor3,
		BackgroundTransparency = 1,

		[Children] = {
			-- New "UIAspectRatioConstraint" {
			--   AspectRatio = 1,
			-- },

			Props[Children],
		},
	}
end

return Text
