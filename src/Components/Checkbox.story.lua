local OnyxUI = require(script.Parent.Parent)
local Fusion = require(OnyxUI.Packages.Fusion)
local Themer = require(OnyxUI.Utils.Themer)
local Colors = require(OnyxUI.Utils.Colors)

local New = Fusion.New
local Children = Fusion.Children
local Computed = Fusion.Computed

local Frame = require(OnyxUI.Components.Frame)
local Checkbox = require(OnyxUI.Components.Checkbox)

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
					SortOrder = Enum.SortOrder.LayoutOrder,
					FillDirection = Enum.FillDirection.Horizontal,
					Padding = Computed(function()
						return UDim.new(0, Themer.Theme.Spacing["0.5"]:get())
					end),
				},
				Checkbox {},
				Checkbox {
					Checked = true,
				},
				Checkbox {
					Disabled = true,
				},
				Checkbox {
					Disabled = true,
					Checked = true,
				},
				Checkbox {
					Icon = "rbxassetid://16743550373",
					Color = Colors.Red["500"],
					Checked = true,
				},
			},
		}

		return function()
			Instance:Destroy()
		end
	end,
}
