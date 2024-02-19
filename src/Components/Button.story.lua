local NekaUI = script.Parent.Parent

local Fusion = require(NekaUI.Parent.Fusion)

local New = Fusion.New
local Children = Fusion.Children

local Button = require(script.Parent.Button)
local Frame = require(script.Parent.Frame)

return function(Target: Instance)
	local Instance = Frame {
		Parent = Target,
		AnchorPoint = Vector2.new(0.5, 0.5),
		Position = UDim2.fromScale(0.5, 0.5),

		[Children] = {
			New "UIListLayout" {
				Padding = UDim.new(0, 8),
				FillDirection = Enum.FillDirection.Horizontal,
			},
			Button {
				Contents = { "Button" },
				Style = "Filled",
			},
			Button {
				Contents = { "Button" },
			},
			Button {
				Contents = { "rbxassetid://11560341132", "Purchase" },
				Style = "Filled",
				BackgroundColor3 = Color3.fromRGB(86, 255, 70),
				ContentColor3 = Color3.fromRGB(0, 0, 0),
			},
			Button {
				Contents = { "rbxassetid://13405228418", "Delete" },
				Style = "Empty",
				BackgroundColor3 = Color3.fromRGB(255, 59, 59),
				ContentColor3 = Color3.fromRGB(255, 59, 59),
			},
		},
	}

	return function()
		Instance:Destroy()
	end
end
