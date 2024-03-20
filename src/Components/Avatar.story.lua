local OnyxUI = script.Parent.Parent

local Fusion = require(OnyxUI.Parent.Fusion)
local Modifier = require(OnyxUI.Utils.Modifier)
local Themer = require(OnyxUI.Utils.Themer)
local Colors = require(OnyxUI.Utils.Colors)

local Children = Fusion.Children

local Frame = require(OnyxUI.Components.Frame)
local Avatar = require(OnyxUI.Components.Avatar)

return {
	story = function(Parent: GuiObject, _Props: table)
		local Instance = Frame {
			Parent = Parent,

			[Children] = {
				Modifier.ListLayout {},
				Modifier.Padding {
					Padding = UDim.new(0, Themer.Theme.StrokeThickness["2"]:get()),
				},
				Avatar {
					Image = "rbxthumb://type=AvatarHeadShot&id=144146784&w=150&h=150",
				},
				Avatar {
					Image = "rbxthumb://type=AvatarHeadShot&id=144146784&w=150&h=150",
					CornerRadius = Themer.Theme.CornerRadius.Full,
				},
				Avatar {
					Image = "rbxthumb://type=AvatarHeadShot&id=144146784&w=150&h=150",
					CornerRadius = Themer.Theme.CornerRadius.Full,
					RingEnabled = true,
				},
				Avatar {
					Image = "rbxthumb://type=AvatarHeadShot&id=144146784&w=150&h=150",
					CornerRadius = Themer.Theme.CornerRadius.Full,
					IndicatorEnabled = true,
				},
				Avatar {
					Image = "rbxthumb://type=AvatarHeadShot&id=144146784&w=150&h=150",
					CornerRadius = Themer.Theme.CornerRadius.Full,
					IndicatorEnabled = true,
					IndicatorColor = Colors.Sky["500"],
					IndicatorImage = "rbxassetid://13805569043",
				},
				Avatar {
					Image = "rbxthumb://type=AvatarHeadShot&id=144146784&w=150&h=150",
					CornerRadius = Themer.Theme.CornerRadius.Full,
					IndicatorEnabled = true,
					Size = UDim2.fromOffset(150, 150),
				},
			},
		}

		return function()
			Instance:Destroy()
		end
	end,
}
