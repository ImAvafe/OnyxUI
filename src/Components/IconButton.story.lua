local OnyxUI = script.Parent.Parent

local Fusion = require(OnyxUI.Parent.Fusion)
local Themer = require(OnyxUI.Utils.Themer)
local Colors = require(OnyxUI.Utils.Colors)

local New = Fusion.New
local Children = Fusion.Children
local Computed = Fusion.Computed

local IconButton = require(script.Parent.IconButton)
local Frame = require(script.Parent.Frame)

return {
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
					Padding = UDim.new(0, Themer.Theme.Spacing["0.5"]:get()),
					FillDirection = Enum.FillDirection.Horizontal,
					SortOrder = Enum.SortOrder.LayoutOrder,
				},
				IconButton {
					Image = "rbxassetid://10814531047",
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
				IconButton {
					Image = "rbxassetid://10814531047",
					Disabled = true,
				},
				IconButton {
					Image = "rbxassetid://10814531047",
					Style = "Ghost",
					Disabled = true,
				},
			},
		}

		return function()
			Instance:Destroy()
		end
	end,
}
