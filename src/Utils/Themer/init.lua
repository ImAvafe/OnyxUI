local OnyxUI = script.Parent.Parent

local ReconcileValues = require(script.Parent.Parent.Utils.ReconcileValues)
local Fusion = require(OnyxUI.Parent.Fusion)
local OnyxNightTheme = require(script.OnyxNight)
local Loader = require(OnyxUI.Parent.Loader)

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
	TextSize = Value(14),
	CornerRadius = Value(8),
	StrokeWidth = Value(2),
	Space = Value(4),
	Transitions = {},
}

local Themer = {
	Theme = THEME_TEMPLATE,
	Themes = Loader.LoadChildren(script),
}

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
