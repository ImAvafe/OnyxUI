local OnyxUI = script.Parent.Parent

local Fusion = require(OnyxUI.Parent.Fusion)
local Themer = require(OnyxUI.Utils.Themer)

local New = Fusion.New
local Children = Fusion.Children
local Computed = Fusion.Computed

local TextInput = require(script.Parent.TextInput)
local Frame = require(script.Parent.Frame)

return {
	story = function(Parent: GuiObject, _Props: table)
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
					Padding = UDim.new(0, 8),
					FillDirection = Enum.FillDirection.Vertical,
				},
				TextInput {
					PlaceholderText = "You can type here!",
				},
				TextInput {
					PlaceholderText = "You can't type here!",
					Disabled = true,
				},
				TextInput {
					PlaceholderText = "Twenty characters only!",
					CharacterLimit = 20,
				},
				TextInput {
					PlaceholderText = "This one wrap-expands!",
				},
			},
		}

		return function()
			Instance:Destroy()
		end
	end,
}
