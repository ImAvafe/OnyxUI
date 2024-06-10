local OnyxUI = script.Parent.Parent
local Fusion = require(OnyxUI.Parent.Fusion)
local Themer = require(OnyxUI.Utils.Themer)

local Children = Fusion.Children
local Computed = Fusion.Computed

local TextArea = require(script.Parent.TextArea)
local Frame = require(script.Parent.Frame)

return {
	story = function(Parent: GuiObject, _Props: { [any]: any })
		local Instance = Frame {
			Parent = Parent,
			Size = UDim2.fromOffset(300, 0),
			AutomaticSize = Enum.AutomaticSize.Y,
			ListEnabled = true,
			Padding = Computed(function()
				return UDim.new(0, Themer.Theme.StrokeThickness["1"]:get())
			end),

			[Children] = {
				TextArea {
					Size = UDim2.fromOffset(200, 50),
				},
				TextArea {
					Size = UDim2.fromOffset(200, 100),
					CharacterLimit = 20,
				},
			},
		}

		return function()
			Instance:Destroy()
		end
	end,
}
