local OnyxUI = script.Parent.Parent

local Fusion = require(OnyxUI.Packages.Fusion)
local Themer = require(OnyxUI.Themer)
local Util = require(OnyxUI.Util)

local Scoped = Fusion.scoped
local Children = Fusion.Children
local peek = Fusion.peek

local Frame = require(script.Parent.Frame)
local Avatar = require(script.Parent.Avatar)
local Components = {
	Frame = Frame,
	Avatar = Avatar,
}

local INDICATOR_COLORS =
	{ Util.Colors.Red["500"], Util.Colors.Green["400"], Util.Colors.Orange["500"], Util.Colors.Stone["600"] }

return {
	story = function(Parent: GuiObject)
		local Scope: Fusion.Scope<typeof(Fusion) & typeof(Components)> = Scoped(Fusion, Components)
		local Theme: Themer.ThemeObject = Themer.Theme:now()

		local IndicatorColor = Scope:Value(INDICATOR_COLORS[2])
		local RingThickness = Scope:Value(peek(Theme.StrokeThickness["2"]))

		local RandomizerThread = task.spawn(function()
			while task.wait(1) do
				IndicatorColor:set(INDICATOR_COLORS[math.random(1, #INDICATOR_COLORS)])

				if peek(RingThickness) == peek(Theme.StrokeThickness["2"]) then
					RingThickness:set(peek(Theme.StrokeThickness["3"]))
				else
					RingThickness:set(peek(Theme.StrokeThickness["2"]))
				end
			end
		end)

		local Instance = Scope:Frame {
			Parent = Parent,
			Padding = Scope:Computed(function(use)
				return UDim.new(0, use(Theme.StrokeThickness["4"]))
			end),
			ListEnabled = true,
			ListPadding = Scope:Computed(function(use)
				return UDim.new(0, use(Theme.Spacing["1"]))
			end),
			ListFillDirection = Enum.FillDirection.Horizontal,

			[Children] = {
				Scope:Avatar {
					Image = "rbxthumb://type=AvatarHeadShot&id=144146784&w=150&h=150",
				},
				Scope:Avatar {
					Image = "rbxthumb://type=AvatarHeadShot&id=144146784&w=150&h=150",
					CornerRadius = Scope:Computed(function(use)
						return UDim.new(0, use(Theme.CornerRadius.Full))
					end),
				},
				Scope:Avatar {
					Image = "rbxthumb://type=AvatarHeadShot&id=144146784&w=150&h=150",
					CornerRadius = Scope:Computed(function(use)
						return UDim.new(0, use(Theme.CornerRadius.Full))
					end),
					RingEnabled = true,
					RingColor = IndicatorColor,
				},
				Scope:Avatar {
					Image = "rbxthumb://type=AvatarHeadShot&id=144146784&w=150&h=150",
					CornerRadius = Scope:Computed(function(use)
						return UDim.new(0, use(Theme.CornerRadius.Full))
					end),
					IndicatorEnabled = true,
					IndicatorColor = IndicatorColor,
				},
				Scope:Avatar {
					Image = "rbxthumb://type=AvatarHeadShot&id=144146784&w=150&h=150",
					CornerRadius = Scope:Computed(function(use)
						return UDim.new(0, use(Theme.CornerRadius.Full))
					end),
					RingEnabled = true,
					RingColor = Util.Colors.Green["400"],
					RingThickness = RingThickness,
				},
				Scope:Avatar {
					Image = "rbxthumb://type=AvatarHeadShot&id=144146784&w=150&h=150",
					CornerRadius = Scope:Computed(function(use)
						return UDim.new(0, use(Theme.CornerRadius.Full))
					end),
					IndicatorEnabled = true,
					IndicatorColor = Util.Colors.Sky["500"],
					IndicatorIcon = "rbxassetid://13805569043",
				},
			},
		}

		return function()
			Instance:Destroy()
			task.cancel(RandomizerThread)
		end
	end,
}
