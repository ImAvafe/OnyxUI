local OnyxUI = script.Parent.Parent.Parent

local Fusion = require(OnyxUI.Parent.Fusion)

local Value = Fusion.Value

return {
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
