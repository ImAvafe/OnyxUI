local OnyxUI = script.Parent.Parent
local Fusion = require(OnyxUI.Parent.Fusion)
local Themer = require(OnyxUI.Themer)

local Children = Fusion.Children
local Computed = Fusion.Computed

local TextArea = require(script.Parent.TextArea)
local Frame = require(script.Parent.Frame)

return {
	story = function(Parent: GuiObject, _Props: { [any]: any })
		local Instance = Frame {
			Parent = Parent,
			Size = UDim2.fromOffset(250, 0),
			AutomaticSize = Enum.AutomaticSize.Y,
			ListEnabled = true,
			ListPadding = Computed(function()
				return UDim.new(0, Themer.Theme.Spacing["0.5"]:get())
			end),
			Padding = Computed(function()
				return UDim.new(0, Themer.Theme.StrokeThickness["1"]:get())
			end),

			[Children] = {
				TextArea {
					Size = UDim2.new(
						UDim.new(1, 0),
						UDim.new(0, (Themer.Theme.TextSize["1"]:get() * 2) + Themer.Theme.Spacing["0.5"]:get() * 2)
					),
				},
				TextArea {
					Size = UDim2.new(UDim.new(1, 0), UDim.new(0, 100)),
					CharacterLimit = 60,
					PlaceholderText = "This TextArea has a character limit.",
				},
				TextArea {
					Size = UDim2.new(UDim.new(1, 0), UDim.new(0, 0)),
					AutomaticSize = Enum.AutomaticSize.Y,
					PlaceholderText = "This one will expand as you type.",
				},
			},
		}

		return function()
			Instance:Destroy()
		end
	end,
}
