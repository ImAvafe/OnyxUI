local OnyxUI = script.Parent.Parent

local ReconcileValues = require(script.Parent.Parent.Utils.ReconcileValues)
local Fusion = require(OnyxUI.Parent.Fusion)
local OnyxNightTheme = require(script.OnyxNight)
local Loader = require(OnyxUI.Parent.Loader)
local ColourUtils = require(OnyxUI.Parent.ColourUtils)

local Value = Fusion.Value

local THEME_TEMPLATE = {
	Colors = {
		Primary = {
			Main = Value(nil),
		},
		Secondary = {
			Main = Value(nil),
		},
		Accent = {
			Main = Value(nil),
		},

		Neutral = {
			Main = Value(nil),
		},
		NeutralContent = {
			Main = Value(nil),
		},

		Base = {
			Main = Value(nil),
		},
		BaseContent = {
			Main = Value(nil),
		},

		Success = {
			Main = Value(nil),
		},
		Error = {
			Main = Value(nil),
		},
		Warning = {
			Main = Value(nil),
		},
		Info = {
			Main = Value(nil),
		},
	},
	Fonts = {
		Body = Value("GothamSsm"),
		Heading = Value("GothamSsm"),
		Monospace = Value("GothamSsm"),
	},
	FontWeights = {
		Body = Value(Enum.FontWeight.Regular),
		Bold = Value(Enum.FontWeight.Bold),
		Heading = Value(Enum.FontWeight.Bold),
	},
	TextSizes = {
		["1"] = Value(12),
		["2"] = Value(14),
		["3"] = Value(16),
		["4"] = Value(18),
		["5"] = Value(20),
		["6"] = Value(24),
		["7"] = Value(30),
		["8"] = Value(36),
		["9"] = Value(48),
		["10"] = Value(60),
		["11"] = Value(72),
	},
	CornerRadius = Value(8),
	StrokeThickness = Value(2),
	Space = Value(4),
	SpringSpeed = Value(0.1),
}

local Themer = {
	Theme = THEME_TEMPLATE,
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
	ReconcileValues(self.Themes[ThemeName], THEME_TEMPLATE)
	ReconcileValues(self.Themes[ThemeName], Theme)
end

function Themer:Set(Theme: table)
	ReconcileValues(self.Theme, THEME_TEMPLATE)
	ReconcileValues(self.Theme, Theme)
	self:ProcessColors(self.Theme)
end

Themer:Set(OnyxNightTheme)
-- Themer:Set(Themer.Themes.BitCave)

return Themer
