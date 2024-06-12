local OnyxUI = script.Parent.Parent
local ReconcileValues = require(script.Parent.Parent.Utils.ReconcileValues)
local OnyxNightTheme = require(script.OnyxNight)
local ThemeTemplate = require(script.ThemeTemplate)
local ColorUtils = require(OnyxUI.Parent.ColorUtils)

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
local CORNER_RADIUS_MULTIPLIERS = {
	0.5,
	1,
	1.5,
	2,
	3,
	4,
	6,
}
local STROKE_THICKNESS_MULTIPLIERS = {
	1,
	2,
	3,
	4,
	8,
}
local SPRING_SPEED_MULTIPLIERS = {
	0.1,
	0.175,
	0.25,
	0.375,
	0.5,
	0.75,
	1,
	1.5,
	2,
}

local Themer = {
	Theme = table.clone(ThemeTemplate),
	Themes = {},
}

function Themer:_LoadDefaultThemes()
	for _, ThemeModule in ipairs(script:GetChildren()) do
		self.Themes[ThemeModule.Name] = require(ThemeModule)
	end
end

function Themer:_ProcessColors(Theme: { [any]: any })
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

function Themer:_ProcessSpacings(Theme: { [any]: any })
	if Theme.Spacing then
		for _, Multiplier in ipairs(SPACING_MULTIPLIERS) do
			if Theme.Spacing[tostring(Multiplier)] == nil then
				Theme.Spacing[tostring(Multiplier)] = Theme.Spacing.Base * Multiplier
			end
		end
	end
end

function Themer:_ProcessTextSizes(Theme: { [any]: any })
	if Theme.TextSize then
		for _, Multiplier in ipairs(TEXT_SIZE_MULTIPLIERS) do
			if Theme.TextSize[tostring(Multiplier)] == nil then
				Theme.TextSize[tostring(Multiplier)] = Theme.TextSize.Base * Multiplier
			end
		end
	end
end

function Themer:_ProcessCornerRadii(Theme: { [any]: any })
	if Theme.CornerRadius then
		for _, Multiplier in ipairs(CORNER_RADIUS_MULTIPLIERS) do
			if Theme.CornerRadius[tostring(Multiplier)] == nil then
				Theme.CornerRadius[tostring(Multiplier)] = Theme.CornerRadius.Base * Multiplier
			end
		end

		if Theme.CornerRadius.Full == nil then
			Theme.CornerRadius.Full = Theme.CornerRadius["1"] * 9999
		end
	end
end

function Themer:_ProcessStrokeThickness(Theme: { [any]: any })
	if Theme.StrokeThickness then
		for _, Multiplier in ipairs(STROKE_THICKNESS_MULTIPLIERS) do
			if Theme.StrokeThickness[tostring(Multiplier)] == nil then
				Theme.StrokeThickness[tostring(Multiplier)] = Theme.StrokeThickness.Base * Multiplier
			end
		end
	end
end

function Themer:_ProcessSpringSpeed(Theme: { [any]: any })
	if Theme.SpringSpeed then
		for _, Multiplier in ipairs(SPRING_SPEED_MULTIPLIERS) do
			if Theme.SpringSpeed[tostring(Multiplier)] == nil then
				Theme.SpringSpeed[tostring(Multiplier)] = Theme.SpringSpeed.Base * Multiplier
			end
		end
	end
end

function Themer:Add(ThemeName: string, Theme: { [any]: any })
	self.Themes[ThemeName] = {}
	ReconcileValues(self.Themes[ThemeName], ThemeTemplate)
	ReconcileValues(self.Themes[ThemeName], Theme)
end

function Themer:Set(Theme: { [any]: any })
	ReconcileValues(self.Theme, ThemeTemplate)

	self:_ProcessColors(Theme)
	self:_ProcessSpacings(Theme)
	self:_ProcessTextSizes(Theme)
	self:_ProcessCornerRadii(Theme)
	self:_ProcessStrokeThickness(Theme)
	self:_ProcessSpringSpeed(Theme)
	ReconcileValues(self.Theme, Theme)
end

Themer:_LoadDefaultThemes()
Themer:Set(OnyxNightTheme)

return Themer
