local OnyxUI = script.Parent.Parent

local Fusion = require(OnyxUI.Parent.Fusion)

local New = Fusion.New
local Children = Fusion.Children

local Frame = require(OnyxUI.Components.Frame)
local Divider = require(OnyxUI.Components.Divider)
local Text = require(OnyxUI.Components.Text)

return function(Target: Instance)
	local Instance = Frame {
		Parent = Target,
		AnchorPoint = Vector2.new(0.5, 0.5),
		Position = UDim2.fromScale(0.5, 0.5),
		Size = UDim2.fromOffset(300, 0),
		AutomaticSize = Enum.AutomaticSize.Y,

		[Children] = {
			New "UIListLayout" {
				SortOrder = Enum.SortOrder.LayoutOrder,
				FillDirection = Enum.FillDirection.Vertical,
			},
			Text {
				Text = "Top text up here",
			},
			Divider {
				FillDirection = Enum.FillDirection.Horizontal,
				-- Length = UDim.new(0, 100),
			},
			Text {
				Text = "Top text up here",
			},
		},
	}

	return function()
		Instance:Destroy()
	end
end
