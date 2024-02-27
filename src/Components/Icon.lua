local OnyxUI = script.Parent.Parent

local Fusion = require(OnyxUI.Parent.Fusion)
local EnsureValue = require(OnyxUI.Utils.EnsureValue)

local New = Fusion.New
local Children = Fusion.Children

local function Text(Props: table)
	Props.Name = EnsureValue(Props.Name, "string", "Icon")
	Props.Size = EnsureValue(Props.Size, "number", UDim2.fromOffset(20, 20))
	Props.ImageColor3 = EnsureValue(Props.ImageColor3, "Color3", Color3.fromRGB(255, 255, 255))
	Props.BackgroundTransparency = EnsureValue(Props.BackgroundTransparency, "number", 1)

	return New "ImageLabel" {
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

		Image = Props.Image,
		ImageColor3 = Props.ImageColor3,

		[Children] = Props[Children],
	}
end

return Text
