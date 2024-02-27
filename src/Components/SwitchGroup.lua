local OnyxUI = script.Parent.Parent

local Fusion = require(OnyxUI.Parent.Fusion)
local Finalize = require(OnyxUI.Utils.Finalize)
local EnsureValue = require(OnyxUI.Utils.EnsureValue)

local Children = Fusion.Children

local BaseButton = require(OnyxUI.Components.BaseButton)

local function SwitchGroup(Props: table)
	Props.SwitchedOn = EnsureValue(Props.SwitchedOn, "boolean", false)
	Props.Disabled = EnsureValue(Props.Disabled, "boolean", false)

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
