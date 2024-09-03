local OnyxUI = script.Parent.Parent
local Packages = require(OnyxUI.Packages)
local Fusion = require(Packages.Fusion)
local Themer = require(OnyxUI.Themer)

local Children = Fusion.Children
local Computed = Fusion.Computed

local TitleBar = require(OnyxUI.Components.TitleBar)
local Frame = require(OnyxUI.Components.Frame)

return {
	story = function(Parent: GuiObject, _Props)
		local Instance = Frame {
			Parent = Parent,
			Padding = Computed(function()
				return UDim.new(0, Themer.Theme.StrokeThickness["1"]:get())
			end),
			Size = Computed(function()
				return UDim2.fromOffset(Themer.Theme.Spacing["16"]:get(), 0)
			end),
			AutomaticSize = Enum.AutomaticSize.Y,
			ListEnabled = true,
			ListHorizontalFlex = Enum.UIFlexAlignment.Fill,

			[Children] = {
				TitleBar {
					Content = { "Title" },
				},
				TitleBar {
					Content = { "rbxassetid://75029721407761", "Shop" },
				},
			},
		}

		return function()
			Instance:Destroy()
		end
	end,
}
