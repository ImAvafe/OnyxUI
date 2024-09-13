local OnyxUI = script.Parent.Parent

local Fusion = require(OnyxUI.Parent.Fusion)
local Themer = require(OnyxUI.Themer)
local Util = require(OnyxUI.Util)

local Scoped = Fusion.scoped
local Children = Fusion.Children
local Peek = Fusion.peek

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
		local Scope = Scoped(Fusion, Components)
		local Theme = Themer.Theme:now()

		local IndicatorColor = Scope:Value(INDICATOR_COLORS[2])
		local RingThickness = Scope:Value(Peek(Theme.StrokeThickness["2"]))

		local RandomizerThread = task.spawn(function()
			while task.wait(1) do
				IndicatorColor:set(INDICATOR_COLORS[math.random(1, #INDICATOR_COLORS)])

				if Peek(RingThickness) == Peek(Theme.StrokeThickness["2"]) then
					RingThickness:set(Peek(Theme.StrokeThickness["3"]))
				else
					RingThickness:set(Peek(Theme.StrokeThickness["2"]))
				end
			end
		end)

		Scope:innerScope({
			function()
				task.cancel(RandomizerThread)
			end,
		})

		Scope:Frame {
			Parent = Parent,
			Padding = Scope:Computed(function(Use)
				return UDim.new(0, Use(Theme.StrokeThickness["4"]))
			end),
			ListEnabled = true,
			ListPadding = Scope:Computed(function(Use)
				return UDim.new(0, Use(Theme.Spacing["1"]))
			end),
			ListFillDirection = Enum.FillDirection.Horizontal,

			[Children] = {
				Scope:Avatar {
					Image = "rbxthumb://type=AvatarHeadShot&id=144146784&w=150&h=150",
				},
				Scope:Avatar {
					Image = "rbxthumb://type=AvatarHeadShot&id=144146784&w=150&h=150",
					CornerRadius = Scope:Computed(function(Use)
						return UDim.new(0, Use(Theme.CornerRadius.Full))
					end),
				},
				Scope:Avatar {
					Image = "rbxthumb://type=AvatarHeadShot&id=144146784&w=150&h=150",
					CornerRadius = Scope:Computed(function(Use)
						return UDim.new(0, Use(Theme.CornerRadius.Full))
					end),
					RingEnabled = true,
					RingColor = IndicatorColor,
				},
				Scope:Avatar {
					Image = "rbxthumb://type=AvatarHeadShot&id=144146784&w=150&h=150",
					CornerRadius = Scope:Computed(function(Use)
						return UDim.new(0, Use(Theme.CornerRadius.Full))
					end),
					IndicatorEnabled = true,
					IndicatorColor = IndicatorColor,
				},
				Scope:Avatar {
					Image = "rbxthumb://type=AvatarHeadShot&id=144146784&w=150&h=150",
					CornerRadius = Scope:Computed(function(Use)
						return UDim.new(0, Use(Theme.CornerRadius.Full))
					end),
					RingEnabled = true,
					RingColor = Util.Colors.Green["400"],
					RingThickness = RingThickness,
				},
				Scope:Avatar {
					Image = "rbxthumb://type=AvatarHeadShot&id=144146784&w=150&h=150",
					CornerRadius = Scope:Computed(function(Use)
						return UDim.new(0, Use(Theme.CornerRadius.Full))
					end),
					IndicatorEnabled = true,
					IndicatorColor = Util.Colors.Sky["500"],
					IndicatorIcon = "rbxassetid://13805569043",
				},
			},
		}

		return function()
			Scope:doCleanup()
		end
	end,
}
