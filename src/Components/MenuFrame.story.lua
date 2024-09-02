local OnyxUI = script.Parent.Parent
local Fusion = require(OnyxUI.Parent.Fusion)
local Themer = require(OnyxUI.Themer)

local Children = Fusion.Children
local Computed = Fusion.Computed

local MenuFrame = require(script.Parent.MenuFrame)
local Frame = require(script.Parent.Frame)
local Text = require(script.Parent.Text)

return {
	story = function(Parent: GuiObject, _Props)
		local Instance = Frame {
			Parent = Parent,
			Padding = Computed(function()
				return UDim.new(0, Themer.Theme.StrokeThickness["1"]:get())
			end),
			ListEnabled = true,
			ListFillDirection = Enum.FillDirection.Horizontal,

			[Children] = {
				MenuFrame {
					Parent = Parent,
					Size = UDim2.fromOffset(300, 200),
					AutomaticSize = Enum.AutomaticSize.None,

					[Children] = {
						Text {
							Text = "Here's a MenuFrame with some text in it.",
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
