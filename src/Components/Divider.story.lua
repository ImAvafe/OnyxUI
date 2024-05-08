local OnyxUI = require(script.Parent.Parent)
local Fusion = require(OnyxUI.Packages.Fusion)

local New = Fusion.New
local Children = Fusion.Children

local Frame = require(OnyxUI.Components.Frame)
local Divider = require(OnyxUI.Components.Divider)
local Text = require(OnyxUI.Components.Text)

return {
	story = function(Parent: GuiObject, _Props: { [any]: any })
		local Instance = Frame {
			Parent = Parent,
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
	end,
}
