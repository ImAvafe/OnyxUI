local OnyxUI = script.Parent.Parent
local Fusion = require(OnyxUI.Parent.Fusion)
local Themer = require(OnyxUI.Utils.Themer)

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
					Size = UDim2.fromOffset(300, 400),
					AutomaticSize = Enum.AutomaticSize.None,
				},
				MenuFrame {
					Parent = Parent,

					[Children] = { Text { Text = "Hiiii" } },
				},
			},
		}

		return function()
			Instance:Destroy()
		end
	end,
}
