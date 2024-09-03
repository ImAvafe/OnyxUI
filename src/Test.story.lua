local OnyxUI = script.Parent
local Fusion = require(OnyxUI.Packages.Fusion)
local Themer = require(OnyxUI.Themer)

local Base = require(OnyxUI.Components.Base)

return function(Parent: GuiObject)
	local Scope = Fusion.scoped(Fusion)

	local Object
	Themer.Theme
		:is(Themer.NewTheme(Scope, { Colors = { Base = { Main = Color3.fromRGB(255, 0, 0) } } }))
		:during(function()
			Object = Base(Scope, {
				Parent = Parent,
				Size = UDim2.fromOffset(100, 100),
			})
		end)

	return function()
		Object:Destroy()
		Scope:doCleanup()
	end
end
