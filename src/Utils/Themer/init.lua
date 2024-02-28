local OnyxUI = script.Parent.Parent

local ReconcileValues = require(script.Parent.Parent.Utils.ReconcileValues)
local Fusion = require(OnyxUI.Parent.Fusion)
local OnyxNightTheme = require(script.OnyxNight)
local ThemeTemplate = require(script.ThemeTemplate)
local Loader = require(OnyxUI.Parent.Loader)
local ColourUtils = require(OnyxUI.Parent.ColourUtils)

local Value = Fusion.Value

local SPACING_MULTIPLIERS = {
	0.25,
	0.5,
	0.75,
	1,
	1.5,
	2,
	3,
	4,
	6,
	8,
	12,
	16,
	24,
	32,
	40,
	48,
}
local TEXT_SIZE_MULTIPLIERS = {
	0.75,
	0.875,
	1,
	1.125,
	1.25,
	1.5,
	1.875,
	2.25,
	3,
	3.75,
	4.5,
}

local Themer = {
	Theme = table.clone(ThemeTemplate),
	Themes = Loader.LoadChildren(script),
}

function Themer:_ProcessColors(Theme: table)
	if Theme.Colors then
		for _, Color in pairs(Theme.Colors) do
			if typeof(Color.Main) == "table" and Color.Main.get then
				local ColorVariations = { "Contrast", "Dark", "Light" }
				for _, Variation in ipairs(ColorVariations) do
					if Color[Variation] == nil then
						Color[Variation] = Value()
					end
				end
				if Color.Contrast:get() == nil then
					Color.Contrast:set(ColourUtils.Emphasise(Color.Main:get(), 1))
				end
				if Color.Dark:get() == nil then
					Color.Dark:set(ColourUtils.Darken(Color.Main:get(), 0.05))
				end
				if Color.Light:get() == nil then
					Color.Light:set(ColourUtils.Lighten(Color.Main:get(), 0.05))
				end
			end
		end
	end
end

function Themer:_ProcessSpacings(Theme: table)
	if Theme.Spacings then
		for _, Multiplier in ipairs(SPACING_MULTIPLIERS) do
			if Theme.Spacings[tostring(Multiplier)]:get() == nil then
				Theme.Spacings[tostring(Multiplier)]:set(Theme.Spacings.Base:get() * Multiplier)
			end
		end
	end
end

function Themer:_ProcessTextSizes(Theme: table)
	if Theme.TextSizes then
		for _, Multiplier in ipairs(TEXT_SIZE_MULTIPLIERS) do
			if Theme.TextSizes[tostring(Multiplier)]:get() == nil then
				Theme.TextSizes[tostring(Multiplier)]:set(Theme.TextSizes.Base:get() * Multiplier)
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
	self:_ProcessColors(self.Theme)
	self:_ProcessSpacings(self.Theme)
	self:_ProcessTextSizes(self.Theme)
end

Themer:Set(OnyxNightTheme)
-- Themer:Set(Themer.Themes.BitCave)

return Themer
