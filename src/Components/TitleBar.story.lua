local OnyxUI = script.Parent.Parent

local Fusion = require(OnyxUI.Parent.Fusion)

local Children = Fusion.Children

local TitleBar = require(script.Parent.TitleBar)
local MenuFrame = require(script.Parent.MenuFrame)

return {
	story = function(Parent: GuiObject, _Props: table)
		local Instance = MenuFrame {
			Parent = Parent,
			AnchorPoint = Vector2.new(0.5, 0.5),
			Position = UDim2.fromScale(0.5, 0.5),
			Size = UDim2.fromOffset(300, 0),
			AutomaticSize = Enum.AutomaticSize.Y,

			[Children] = {
				TitleBar {
					Title = "Shopping",
				},
			},
		}

		return function()
			Instance:Destroy()
		end
	end,
}
