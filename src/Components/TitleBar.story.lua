local OnyxUI = script.Parent.Parent
local Fusion = require(OnyxUI.Parent.Fusion)
local Themer = require(OnyxUI.Themer)

local Children = Fusion.Children
local Computed = Fusion.Computed

local MenuFrame = require(OnyxUI.Components.MenuFrame)
local TitleBar = require(OnyxUI.Components.TitleBar)
local Frame = require(OnyxUI.Components.Frame)

return {
	story = function(Parent: GuiObject, _Props)
		local Instance = Frame {
			Parent = Parent,
			Padding = Computed(function()
				return UDim.new(0, Themer.Theme.StrokeThickness["1"]:get())
			end),
			ListEnabled = true,

			[Children] = {
				TitleBar {
					Content = { "Title" },
				},
				MenuFrame {
					Size = UDim2.fromOffset(300, 0),
					AutomaticSize = Enum.AutomaticSize.Y,

					[Children] = {
						TitleBar {
							Content = { "Title" },
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
