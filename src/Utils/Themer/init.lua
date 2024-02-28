local OnyxUI = script.Parent.Parent

local ReconcileValues = require(script.Parent.Parent.Utils.ReconcileValues)
local Fusion = require(OnyxUI.Parent.Fusion)
local OnyxNightTheme = require(script.OnyxNight)
local ThemeTemplate = require(script.ThemeTemplate)
local Loader = require(OnyxUI.Parent.Loader)
local ColourUtils = require(OnyxUI.Parent.ColourUtils)

local Value = Fusion.Value

local Themer = {
	Theme = table.clone(ThemeTemplate),
	Themes = Loader.LoadChildren(script),
}

function Themer:ProcessColors(Theme: table)
	if Theme.Colors then
		for _, Color in pairs(Theme.Colors) do
			if typeof(Color.Main) == "table" and Color.Main.get then
				if Color.Contrast == nil then
					Color.Contrast = Value(ColourUtils.Emphasise(Color.Main:get(), 1))
				end
				if Color.Dark == nil then
					Color.Dark = Value(ColourUtils.Darken(Color.Main:get(), 0.05))
				end
				if Color.Light == nil then
					Color.Light = Value(ColourUtils.Lighten(Color.Main:get(), 0.05))
				end
			end
		end
	end
end

function Themer:Add(ThemeName: string, Theme: table)
	self.Themes[ThemeName] = {}
	ReconcileValues(self.Themes[ThemeName], ThemeTemplate)
	ReconcileValues(self.Themes[ThemeName], Theme)
end

function Themer:Set(Theme: table)
	ReconcileValues(self.Theme, ThemeTemplate)
	ReconcileValues(self.Theme, Theme)
	self:ProcessColors(self.Theme)
end

Themer:Set(OnyxNightTheme)
-- Themer:Set(Themer.Themes.BitCave)

return Themer
