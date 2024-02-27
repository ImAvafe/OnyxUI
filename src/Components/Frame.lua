local OnyxUI = script.Parent.Parent

local Fusion = require(OnyxUI.Parent.Fusion)
local Finalize = require(OnyxUI.Utils.Finalize)
local EnsureValue = require(OnyxUI.Utils.EnsureValue)

local New = Fusion.New
local Children = Fusion.Children

local function Frame(Props: table)
	Props.Name = EnsureValue(Props.Name, "string", "Frame")
	Props.BackgroundTransparency = EnsureValue(Props.BackgroundTransparency, "number", 1)
	Props.AutomaticSize = EnsureValue(Props.AutomaticSize, "EnumItem", Enum.AutomaticSize.XY)

	return Finalize(New "Frame" {
		Name = Props.Name,
		Parent = Props.Parent,
		LayoutOrder = Props.LayoutOrder,
		Position = Props.Position,
		AnchorPoint = Props.AnchorPoint,
		Size = Props.Size,
		AutomaticSize = Props.AutomaticSize,
		ZIndex = Props.ZIndex,
		Visible = Props.Visible,

		BackgroundTransparency = Props.BackgroundTransparency,

		[Children] = Props[Children],
	})
end

return Frame
