local OnyxUI = script.Parent
local OnyxNightTheme = require(script.OnyxNight)
local NewTheme = require(script.NewTheme)
local ThemeType = require(script.Theme)
local Fusion = require(OnyxUI.Parent.Fusion)

local Contextual = Fusion.Contextual

export type Theme = ThemeType.Theme

--[=[
	@class Themer
	
	Themer allows you to customize components throughout OnyxUI, with support for things like colors, corner radiuses, paddings, etc. You'll also probably want to incorporate it within your own UI for a more consistent design.
]=]
local Themer = {}

--[=[
	@function NewTheme
	@within Themer

	@param Scope Fusion.Scope
	@param Theme Theme

	Creates the specified theme.
]=]
function Themer.NewTheme(Scope: Fusion.Scope, Theme: Theme)
	return NewTheme(Scope, Theme)
end

--[=[
	@prop Theme table
	@within Themer

	The currently active theme. Use this to reference theme properties.
]=]
Themer.Theme = Contextual(OnyxNightTheme)

export type ThemeObject = typeof(Themer.NewTheme(Fusion.scoped(), {}))

return Themer
