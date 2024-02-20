local OnyxUI = script.Parent.Parent

local ReconcileValues = require(script.Parent.Parent.Utils.ReconcileValues)
local Fusion = require(OnyxUI.Parent.Fusion)
local OnyxNightTheme = require(script.OnyxNightTheme)

local Value = Fusion.Value

local THEME_TEMPLATE = {
	BackgroundColor = Value(Color3.fromRGB(255, 255, 255)),
}

local Themer = {
	Theme = THEME_TEMPLATE,
	Themes = {
		OnyxNight = OnyxNightTheme,
	},
}

function Themer:Add(ThemeName: string, Theme: table)
	self.Themes[ThemeName] = Theme
end

function Themer:Set(Theme: table)
	ReconcileValues(self.Theme, THEME_TEMPLATE)
	ReconcileValues(self.Theme, Theme)
end

Themer:Set(OnyxNightTheme)

return Themer
