local NekaUI = script.Parent.Parent

local Fusion = require(NekaUI.Parent.Fusion)
local Finalize = require(NekaUI.Utils.Finalize)
local EnsureProp = require(NekaUI.Utils.EnsureProp)

local Children = Fusion.Children

local BaseButton = require(NekaUI.Components.BaseButton)

local function SwitchGroup(Props)
	Props.SwitchedOn = EnsureProp(Props.SwitchedOn, "boolean", false)
	Props.Disabled = EnsureProp(Props.Disabled, "boolean", false)

	return Finalize(BaseButton {
		Name = Props.Name or "SwitchGroup",
		Parent = Props.Parent,
		LayoutOrder = Props.LayoutOrder,
		Position = Props.Position,
		AnchorPoint = Props.AnchorPoint,
		Size = Props.Size,
		AutomaticSize = Props.AutomaticSize,
		ZIndex = Props.ZIndex,

		OnActivated = function()
			if not Props.Disabled:get() then
				Props.SwitchedOn:set(not Props.SwitchedOn:get())
			end
		end,

		[Children] = Props[Children],
	})
end

return SwitchGroup
