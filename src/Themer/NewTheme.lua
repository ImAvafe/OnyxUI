local OnyxUI = script.Parent.Parent
local Fusion = require(OnyxUI.Packages.Fusion)
local ThemeType = require(script.Parent.Theme)
local ColorUtils = require(OnyxUI.Packages.ColorUtils)

local peek = Fusion.peek

export type Theme = ThemeType.Theme

local function ReconcileTheme(Target, Source)
	for Key, Value in pairs(Target) do
		if (typeof(Value) == "table") and (Value.kind == "Value") then
			Value:set(peek(Source[Key]))
		elseif typeof(Value) == "table" then
			if typeof(Source[Key]) == "table" then
				ReconcileTheme(Value, Source[Key])
			end
		end
	end
end

local function ProcessColors(Theme: Theme)
	if Theme.Colors then
		for ColorName, _ in pairs(Theme.Colors) do
			local Color = Theme.Colors[ColorName]
			if Color then
				if Color.Main then
					if Color.Contrast == nil then
						Color.Contrast = ColorUtils.Emphasize(Color.Main, 1)
					end
					if Color.Dark == nil then
						Color.Dark = ColorUtils.Darken(Color.Main, 0.05)
					end
					if Color.Light == nil then
						Color.Light = ColorUtils.Lighten(Color.Main, 0.05)
					end
				end
			end
		end
	end
end

local function ProcessMultipliers(Theme: Theme, Template, Key: string)
	local Unit = Theme[Key]
	if Unit ~= nil then
		local Base = Unit.Base
		if Base ~= nil then
			for MultiplierKey, _ in pairs(Template[Key]) do
				local Multiplier = tonumber(MultiplierKey)
				if Multiplier ~= nil then
					if Unit[MultiplierKey] == nil then
						Unit[MultiplierKey] = Base * Multiplier
					end
				end
			end
		end
	end
end

local function NewTheme(Scope: Fusion.Scope, Theme: Theme)
	Scope = Fusion.innerScope(Scope, Fusion)

	local ThemeObject = {
		Colors = {
			Primary = {
				Main = Scope:Value(nil),
				Dark = Scope:Value(nil),
				Light = Scope:Value(nil),
				Contrast = Scope:Value(nil),
			},
			Secondary = {
				Main = Scope:Value(nil),
				Dark = Scope:Value(nil),
				Light = Scope:Value(nil),
				Contrast = Scope:Value(nil),
			},
			Accent = {
				Main = Scope:Value(nil),
				Dark = Scope:Value(nil),
				Light = Scope:Value(nil),
				Contrast = Scope:Value(nil),
			},

			Neutral = {
				Main = Scope:Value(nil),
				Dark = Scope:Value(nil),
				Light = Scope:Value(nil),
				Contrast = Scope:Value(nil),
			},
			NeutralContent = {
				Main = Scope:Value(nil),
				Dark = Scope:Value(nil),
				Light = Scope:Value(nil),
				Contrast = Scope:Value(nil),
			},

			Base = {
				Main = Scope:Value(nil),
				Dark = Scope:Value(nil),
				Light = Scope:Value(nil),
				Contrast = Scope:Value(nil),
			},
			BaseContent = {
				Main = Scope:Value(nil),
				Dark = Scope:Value(nil),
				Light = Scope:Value(nil),
				Contrast = Scope:Value(nil),
			},

			Success = {
				Main = Scope:Value(nil),
				Dark = Scope:Value(nil),
				Light = Scope:Value(nil),
				Contrast = Scope:Value(nil),
			},
			Error = {
				Main = Scope:Value(nil),
				Dark = Scope:Value(nil),
				Light = Scope:Value(nil),
				Contrast = Scope:Value(nil),
			},
			Warning = {
				Main = Scope:Value(nil),
				Dark = Scope:Value(nil),
				Light = Scope:Value(nil),
				Contrast = Scope:Value(nil),
			},
			Info = {
				Main = Scope:Value(nil),
				Dark = Scope:Value(nil),
				Light = Scope:Value(nil),
				Contrast = Scope:Value(nil),
			},
		},
		Font = {
			Body = Scope:Value("GothamSsm"),
			Heading = Scope:Value("GothamSsm"),
			Monospace = Scope:Value("GothamSsm"),
		},
		FontWeight = {
			Body = Scope:Value(Enum.FontWeight.Regular),
			Bold = Scope:Value(Enum.FontWeight.Bold),
			Heading = Scope:Value(Enum.FontWeight.Bold),
		},
		TextSize = {
			Base = Scope:Value(16),
			["0.75"] = Scope:Value(nil),
			["0.875"] = Scope:Value(nil),
			["1"] = Scope:Value(nil),
			["1.125"] = Scope:Value(nil),
			["1.25"] = Scope:Value(nil),
			["1.5"] = Scope:Value(nil),
			["1.875"] = Scope:Value(nil),
			["2.25"] = Scope:Value(nil),
			["3"] = Scope:Value(nil),
			["3.75"] = Scope:Value(nil),
			["4.5"] = Scope:Value(nil),
		},
		Spacing = {
			Base = Scope:Value(16),
			["0"] = Scope:Value(0),
			["0.25"] = Scope:Value(nil),
			["0.5"] = Scope:Value(nil),
			["0.75"] = Scope:Value(nil),
			["1"] = Scope:Value(nil),
			["1.5"] = Scope:Value(nil),
			["2"] = Scope:Value(nil),
			["3"] = Scope:Value(nil),
			["4"] = Scope:Value(nil),
			["6"] = Scope:Value(nil),
			["8"] = Scope:Value(nil),
			["12"] = Scope:Value(nil),
			["16"] = Scope:Value(nil),
			["24"] = Scope:Value(nil),
			["32"] = Scope:Value(nil),
			["40"] = Scope:Value(nil),
			["48"] = Scope:Value(nil),
		},
		CornerRadius = {
			Base = Scope:Value(4),
			["0"] = Scope:Value(0),
			["0.5"] = Scope:Value(nil),
			["1"] = Scope:Value(nil),
			["1.5"] = Scope:Value(nil),
			["2"] = Scope:Value(nil),
			["3"] = Scope:Value(nil),
			["4"] = Scope:Value(nil),
			["6"] = Scope:Value(nil),
			Full = Scope:Value(nil),
		},
		StrokeThickness = {
			Base = Scope:Value(2),
			["0"] = Scope:Value(0),
			["1"] = Scope:Value(nil),
			["2"] = Scope:Value(nil),
			["3"] = Scope:Value(nil),
			["4"] = Scope:Value(nil),
			["8"] = Scope:Value(nil),
		},
		SpringSpeed = {
			Base = Scope:Value(40),
			["0.1"] = Scope:Value(nil),
			["0.175"] = Scope:Value(nil),
			["0.25"] = Scope:Value(nil),
			["0.375"] = Scope:Value(nil),
			["0.5"] = Scope:Value(nil),
			["0.75"] = Scope:Value(nil),
			["1"] = Scope:Value(nil),
			["1.5"] = Scope:Value(nil),
			["2"] = Scope:Value(nil),
			Immediate = Scope:Value(1000),
		},
		SpringDampening = {
			Base = Scope:Value(40),
			["0.1"] = Scope:Value(nil),
			["0.175"] = Scope:Value(nil),
			["0.25"] = Scope:Value(nil),
			["0.375"] = Scope:Value(nil),
			["0.5"] = Scope:Value(nil),
			["0.75"] = Scope:Value(nil),
			["1"] = Scope:Value(nil),
			["1.5"] = Scope:Value(nil),
			["2"] = Scope:Value(nil),
			["5"] = Scope:Value(nil),
			["10"] = Scope:Value(nil),
			Full = Scope:Value(1000),
		},
		Sound = {
			Hover = Scope:Value(Scope:New "Sound" {
				SoundId = "rbxassetid://10066936758",
				Volume = 0.05,
			}),
			Click = Scope:Value(Scope:New "Sound" {
				SoundId = "rbxassetid://16480549841",
				Volume = 0.5,
			}),
			Focus = Scope:Value(Scope:New "Sound" {
				SoundId = "rbxassetid://16480549841",
				Volume = 0.5,
			}),
			Switch = Scope:Value(Scope:New "Sound" {
				SoundId = "rbxassetid://9119713951",
				Volume = 0.5,
			}),
		},
		Emphasis = {
			Light = Scope:Value(0.15),
			Regular = Scope:Value(0.3),
			Strong = Scope:Value(0.5),
			Contrast = Scope:Value(1),
		},
	}

	ReconcileTheme(ThemeObject, Theme)

	ProcessColors(Theme)
	ProcessMultipliers(Theme, ThemeObject, "Spacing")
	ProcessMultipliers(Theme, ThemeObject, "TextSize")
	ProcessMultipliers(Theme, ThemeObject, "CornerRadius")
	ProcessMultipliers(Theme, ThemeObject, "StrokeThickness")
	ProcessMultipliers(Theme, ThemeObject, "SpringSpeed")
	ProcessMultipliers(Theme, ThemeObject, "SpringDampening")

	return ThemeObject
end

return NewTheme
