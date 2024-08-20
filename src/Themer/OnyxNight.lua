local OnyxUI = require(script.Parent.Parent)
local Util = require(OnyxUI.Util)
local ThemeTemplate = require(OnyxUI.Themer.ThemeTemplate)

local OnyxNight: ThemeTemplate.Theme = {
	Colors = {
		Primary = {
			Main = Util.Colors.Violet["500"],
		},
		Secondary = {
			Main = Util.Colors.White,
		},
		Accent = {
			Main = Util.Colors.White,
		},

		Neutral = {
			Main = Util.Colors.Stone["800"],
		},
		NeutralContent = {
			Main = Util.Colors.Stone["300"],
		},

		Base = {
			Main = Util.Colors.Stone["900"],
		},
		BaseContent = {
			Main = Util.Colors.White,
		},

		Success = {
			Main = Util.Colors.Green["500"],
		},
		Error = {
			Main = Util.Colors.Red["500"],
		},
		Warning = {
			Main = Util.Colors.Amber["500"],
		},
		Info = {
			Main = Util.Colors.Cyan["400"],
		},
	},
	Font = {
		Body = "rbxasset://fonts/families/Montserrat.json",
		Heading = "rbxasset://fonts/families/Montserrat.json",
		Monospace = "rbxasset://fonts/families/Montserrat.json",
	},
	FontWeight = {
		Body = Enum.FontWeight.SemiBold,
		Bold = Enum.FontWeight.Bold,
		Heading = Enum.FontWeight.Bold,
	},
	TextSize = {
		Base = 19,
	},
	CornerRadius = {
		Base = 6,
	},
	StrokeThickness = {
		Base = 2,
	},
	Spacing = {
		Base = 16,
	},
	SpringSpeed = {
		Base = 50,
	},
	SpringDampening = 1,
	Sound = {},
	Emphasis = {},
}

return OnyxNight
