local OnyxUI = require(script.Parent.Parent)
local Fusion = require(OnyxUI.Packages.Fusion)
local Themer = require(OnyxUI.Utils.Themer)

local New = Fusion.New
local Children = Fusion.Children
local Computed = Fusion.Computed

local MenuFrame = require(OnyxUI.Components.MenuFrame)
local Frame = require(OnyxUI.Components.Frame)

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
				MenuFrame {
					Parent = Parent,
					Size = UDim2.fromOffset(300, 400),
					AutomaticSize = Enum.AutomaticSize.None,
				},
			},
		}

		return function()
			Instance:Destroy()
		end
	end,
}
