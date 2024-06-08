local OnyxUI = script.Parent.Parent
local Fusion = require(OnyxUI.Parent.Fusion)
local Themer = require(OnyxUI.Utils.Themer)

local New = Fusion.New
local Children = Fusion.Children
local Computed = Fusion.Computed

local Button = require(script.Parent.Button)
local Frame = require(script.Parent.Frame)

return {
	clipsDescendants = false,
	story = function(Parent: GuiObject, _Props: { [any]: any })
		local PreviewPadding = Computed(function()
			return UDim.new(0, Themer.Theme.StrokeThickness["1"]:get())
		end)

		local Instance = Frame {
			Parent = Parent,

			[Children] = {
				New "UIPadding" {
					PaddingBottom = PreviewPadding,
					PaddingLeft = PreviewPadding,
					PaddingRight = PreviewPadding,
					PaddingTop = PreviewPadding,
				},
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
					Contents = { "Ghost" },
					Style = "Ghost",
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
	end,
}
