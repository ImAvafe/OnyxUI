local OnyxUI = script.Parent.Parent

local Fusion = require(OnyxUI.Packages.Fusion)
local Themer = require(OnyxUI.Themer)

local Children = Fusion.Children
local Scoped = Fusion.scoped

local TitleBar = require(OnyxUI.Components.TitleBar)
local Frame = require(OnyxUI.Components.Frame)
local Components = {
	Frame = Frame,
	TitleBar = TitleBar,
}

return {
	story = function(Parent: GuiObject, _Props)
		local Scope: Fusion.Scope<typeof(Fusion) & typeof(Components)> = Scoped(Fusion, Components)
		local Theme: Themer.ThemeObject = Themer.Theme:now()

		local Instance = Scope:Frame {
			Parent = Parent,
			Padding = Scope:Computed(function(use)
				return UDim.new(0, use(Theme.StrokeThickness["1"]))
			end),
			Size = Scope:Computed(function(use)
				return UDim2.fromOffset(use(Theme.Spacing["16"]), 0)
			end),
			AutomaticSize = Enum.AutomaticSize.Y,
			ListEnabled = true,
			ListHorizontalFlex = Enum.UIFlexAlignment.Fill,

			[Children] = {
				Scope:TitleBar {
					Content = { "Title" },
				},
				Scope:TitleBar {
					Content = { "rbxassetid://75029721407761", "Shop" },
				},
			},
		}

		return function()
			Instance:Destroy()
		end
	end,
}
