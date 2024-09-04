local OnyxUI = script.Parent
local Util = require(script.Parent.Util)
local Fusion = require(OnyxUI.Packages.Fusion)
local Themer = require(OnyxUI.Themer)
local Components = require(OnyxUI.Components)

local Children = Fusion.Children

local function Palette(Scope: Fusion.Scope<any>, _: any)
	local Theme = Themer.Theme:now()

	return Scope:Base {
		Name = "Palette",
		ListEnabled = true,
		ListPadding = Scope:Computed(function(use)
			return UDim.new(0, use(Theme.Spacing["0.75"]))
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
	local Scope: Fusion.Scope<typeof(Fusion) & typeof(Components) & { ["Palette"]: typeof(Palette) }> =
		Fusion.scoped(Fusion, Components, {
			Palette = Palette,
		})

	local AnotherTheme = Themer.NewTheme(Scope, {
		Colors = {
			Info = { Main = Util.Colors.Blue["600"] },
		},
	})

	local Object = Scope:Base {
		Parent = Parent,
		ListEnabled = true,
		ListFillDirection = Enum.FillDirection.Horizontal,

		[Children] = {
			Scope:Palette {},
			Themer.Theme:is(AnotherTheme):during(function()
				return Scope:Palette {}
			end),
		},
	}

	return function()
		Object:Destroy()
		Scope:doCleanup()
	end
end
