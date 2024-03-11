local OnyxUI = script.Parent.Parent

local Fusion = require(OnyxUI.Parent.Fusion)
local Themer = require(OnyxUI.Utils.Themer)

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
				Padding = UDim.new(0, Themer.Theme.Spacing["0.75"]:get()),
				FillDirection = Enum.FillDirection.Vertical,
			},
			Button {
				Contents = { "Button" },
			},
			Button {
				Contents = { "Button" },
				Style = "Outlined",
			},
			Button {
				Contents = { "rbxassetid://11560341132", "Purchase" },
				Color = Color3.fromRGB(86, 255, 70),
			},
			Button {
				Contents = { "rbxassetid://13405228418", "Delete" },
				Style = "Outlined",
				Color = Themer.Theme.Colors.Error.Main,
			},
			Button {
				Contents = { "rbxassetid://11560341132", "Bobux" },
				Color = Color3.fromRGB(86, 255, 70),
				Disabled = true,
			},
			Button {
				Contents = { "Testing" },
				Color = Color3.fromRGB(86, 255, 70),
				Disabled = true,
				Style = "Outlined",
			},
		},
	}

	return function()
		Instance:Destroy()
	end
end
