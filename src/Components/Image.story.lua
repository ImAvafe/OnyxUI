local OnyxUI = script.Parent.Parent
local Packages = require(OnyxUI.Packages)
local Fusion = require(Packages.Fusion)
local Themer = require(OnyxUI.Themer)

local Children = Fusion.Children
local Computed = Fusion.Computed

local Frame = require(OnyxUI.Components.Frame)
local Image = require(OnyxUI.Components.Image)

return {
	story = function(Parent: GuiObject, _Props: { [any]: any })
		local Instance = Frame {
			Parent = Parent,
			AutomaticSize = Enum.AutomaticSize.XY,
			ListEnabled = true,
			ListFillDirection = Enum.FillDirection.Horizontal,
			ListPadding = Computed(function()
				return UDim.new(0, Themer.Theme.Spacing["0.75"]:get())
			end),

			[Children] = {
				Image {
					Image = "rbxassetid://15307540148",
				},
				Image {},
				Image {
					FallbackImage = "rbxassetid://13193902400",
				},
			},
		}

		return function()
			Instance:Destroy()
		end
	end,
}
