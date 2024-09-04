local OnyxUI = script.Parent.Parent

local Fusion = require(OnyxUI.Packages.Fusion)
local Themer = require(OnyxUI.Themer)

local Scoped = Fusion.scoped
local Children = Fusion.Children

local Frame = require(OnyxUI.Components.Frame)
local Image = require(OnyxUI.Components.Image)
local Components = {
	Frame = Frame,
	Image = Image,
}

return {
	story = function(Parent: GuiObject)
		local Scope: Fusion.Scope<typeof(Fusion) & typeof(Components)> = Scoped(Fusion, Components)
		local Theme: Themer.ThemeObject = Themer.Theme:now()

		local Instance = Scope:Frame {
			Parent = Parent,
			AutomaticSize = Enum.AutomaticSize.XY,
			ListEnabled = true,
			ListFillDirection = Enum.FillDirection.Horizontal,
			ListPadding = Scope:Computed(function(use)
				return UDim.new(0, use(Theme.Spacing["0.75"]))
			end),

			[Children] = {
				Scope:Image {
					Image = "rbxassetid://15307540148",
				},
				Scope:Image {},
				Scope:Image {
					FallbackImage = "rbxassetid://13193902400",
				},
			},
		}

		return function()
			Instance:Destroy()
		end
	end,
}
