local NekaUI = script.Parent.Parent

local Fusion = require(NekaUI.Parent.Fusion)
local Finalize = require(NekaUI.Utils.Finalize)

local New = Fusion.New
local Children = Fusion.Children

local function Frame(Props)
	return Finalize(New "Frame" {
		Name = Props.Name,
		Parent = Props.Parent,
		LayoutOrder = Props.LayoutOrder,
		Position = Props.Position,
		AnchorPoint = Props.AnchorPoint,
		Size = Props.Size,
		AutomaticSize = Props.AutomaticSize or Enum.AutomaticSize.XY,
		ZIndex = Props.ZIndex,
		Visible = Props.Visible,

		BackgroundTransparency = 1,

		[Children] = Props[Children],
	})
end

return Frame
