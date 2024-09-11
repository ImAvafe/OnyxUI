local OnyxUI = script.Parent.Parent.Parent.OnyxUI.Packages.OnyxUI
local Util = require(OnyxUI.Util)
local Fusion = require(OnyxUI.Packages.Fusion)
local Themer = require(OnyxUI.Themer)
local Components = require(OnyxUI.Components)

local Children = Fusion.Children

local function Palette(Scope: Fusion.Scope<any>, _: any)
	local Theme = Themer.Theme:now()

	return Scope:Base {
		Name = "Palette",
		BackgroundTransparency = 1,
		ListEnabled = true,
		ListPadding = Scope:Computed(function(Use)
			return UDim.new(0, Use(Theme.Spacing["0.75"]))
		end),

		[Children] = {
			{
				Scope:Base {
					Size = UDim2.fromOffset(100, 100),
					BackgroundColor3 = Theme.Colors.Info.Light,
					BackgroundTransparency = 0,
				},
				Scope:Base {
					Size = UDim2.fromOffset(100, 100),
					BackgroundColor3 = Theme.Colors.Info.Main,
					BackgroundTransparency = 0,
				},
				Scope:Base {
					Size = UDim2.fromOffset(100, 100),
					BackgroundColor3 = Theme.Colors.Info.Dark,
					BackgroundTransparency = 0,
				},
				Scope:Base {
					Size = UDim2.fromOffset(100, 100),
					BackgroundColor3 = Theme.Colors.Info.Contrast,
					BackgroundTransparency = 0,
				},
			},
		},
	}
end

return function(Parent: GuiObject)
	local Scope = Fusion.scoped(Fusion, Components, {
		Palette = Palette,
	})

	local AnotherTheme = Themer.NewTheme(Scope, {
		Colors = {
			Info = { Main = Util.Colors.Blue["600"] },
		},
	})

	Scope:Base {
		Parent = Parent,
		ListEnabled = true,
		ListFillDirection = Enum.FillDirection.Horizontal,
		BackgroundTransparency = 1,

		[Children] = {
			Scope:Palette {},
			Themer.Theme:is(AnotherTheme):during(function()
				return Scope:Palette {}
			end),
		},
	}

	return function()
		Scope:doCleanup()
	end
end
