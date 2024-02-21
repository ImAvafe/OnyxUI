local OnyxUI = script.Parent.Parent

local ReconcileValues = require(script.Parent.Parent.Utils.ReconcileValues)
local Fusion = require(OnyxUI.Parent.Fusion)
local OnyxNightTheme = require(script.OnyxNight)
local Loader = require(OnyxUI.Parent.Loader)

local Value = Fusion.Value

local THEME_TEMPLATE = {
	BackgroundColor = Value(Color3.fromRGB(255, 255, 255)),
}

local Themer = {
	Theme = THEME_TEMPLATE,
	Themes = Loader.LoadChildren(script),
}

print(Themer.Themes)

function Themer:Add(ThemeName: string, Theme: table)
	self.Themes[ThemeName] = {}
	ReconcileValues(self.Themes[ThemeName], THEME_TEMPLATE)
	ReconcileValues(self.Themes[ThemeName], Theme)
end

function Themer:Set(Theme: table)
	ReconcileValues(self.Theme, THEME_TEMPLATE)
	ReconcileValues(self.Theme, Theme)
end

Themer:Set(OnyxNightTheme)

return Themer
