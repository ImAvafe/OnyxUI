local OnyxUI = script.Parent.Parent

local Fusion = require(OnyxUI.Parent.Fusion)

local EnsureValue = require(OnyxUI.Utils.EnsureValue)

local New = Fusion.New
local Children = Fusion.Children

local function Frame(Props: { [any]: any })
	Props.Name = EnsureValue(Props.Name, "string", "Frame")
	Props.BackgroundTransparency = EnsureValue(Props.BackgroundTransparency, "number", 1)
	Props.AutomaticSize = EnsureValue(Props.AutomaticSize, "EnumItem", Enum.AutomaticSize.XY)

	return New "Frame" {
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

		[Children] = Props[Children],
	}
end

return Frame
