local OnyxUI = script.Parent.Parent

local Fusion = require(OnyxUI.Parent.Fusion)
local Themer = require(OnyxUI.Utils.Themer)
local Colors = require(OnyxUI.Utils.Colors)

local New = Fusion.New
local Children = Fusion.Children

local IconButton = require(script.Parent.IconButton)
local Frame = require(script.Parent.Frame)

return function(Target: Instance)
	local Instance = Frame {
		Parent = Target,
		AnchorPoint = Vector2.new(0.5, 0.5),
		Position = UDim2.fromScale(0.5, 0.5),

		[Children] = {
			New "UIListLayout" {
				Padding = UDim.new(0, Themer.Theme.Spacing["0.5"]:get()),
				FillDirection = Enum.FillDirection.Horizontal,
				SortOrder = Enum.SortOrder.LayoutOrder,
			},
			IconButton {
				Image = "rbxassetid://16735398592",
			},
			IconButton {
				Image = "rbxassetid://11560341132",
				Color = Colors.Amber["500"],
			},
			IconButton {
				Image = "rbxassetid://13405228418",
				Color = Colors.Red["500"],
				Style = "Outlined",
			},
			IconButton {
				Image = "rbxassetid://13405228418",
				Color = Colors.Red["500"],
				Style = "Ghost",
			},
		},
	}

	return function()
		Instance:Destroy()
	end
end
