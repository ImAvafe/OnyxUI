local OnyxUI = require(script.Parent.Parent.Parent.OnyxUI)
local Fusion = require(script.Parent.Parent.Parent.OnyxUI.Packages.OnyxUI.Parent.Fusion)

local Util = OnyxUI.Util
local Themer = OnyxUI.Themer
local Components = OnyxUI.Components
local Children = Fusion.Children
local InnerScope = Fusion.innerScope

local function Palette(Scope: Fusion.Scope<any>, _: any)
	local Scope = InnerScope(Scope, Fusion, Util, Components)
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
