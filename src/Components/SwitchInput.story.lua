local OnyxUI = require(script.Parent.Parent)
local Fusion = require(OnyxUI.Packages.Fusion)
local Themer = require(OnyxUI.Utils.Themer)

local New = Fusion.New
local Children = Fusion.Children
local Computed = Fusion.Computed

local SwitchInput = require(script.Parent.SwitchInput)
local Text = require(script.Parent.Text)
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
				SwitchInput {
					[Children] = {
						Text {
							AnchorPoint = Vector2.new(0, 0.5),
							Position = UDim2.fromScale(0, 0.5),
							Text = "uwu",
							TextSize = 19,
						},
					},
				},
			},
		}

		return function()
			Instance:Destroy()
		end
	end,
}
