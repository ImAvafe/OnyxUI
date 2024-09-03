local OnyxUI = script.Parent.Parent
local Packages = require(OnyxUI.Packages)
local Fusion = require(Packages.Fusion)
local Themer = require(OnyxUI.Themer)
local Util = require(OnyxUI.Util)

local Children = Fusion.Children
local Value = Fusion.Value
local Computed = Fusion.Computed

local Frame = require(script.Parent.Frame)
local Avatar = require(script.Parent.Avatar)

local INDICATOR_COLORS =
	{ Util.Colors.Red["500"], Util.Colors.Green["400"], Util.Colors.Orange["500"], Util.Colors.Stone["600"] }

return {
	story = function(Parent: GuiObject, _Props: { [any]: any })
		local IndicatorColor = Value(INDICATOR_COLORS[2])
		local RingThickness = Value(Themer.Theme.StrokeThickness["2"]:get())

		local RandomizerThread = task.spawn(function()
			while task.wait(1) do
				IndicatorColor:set(INDICATOR_COLORS[math.random(1, #INDICATOR_COLORS)])

				if RingThickness:get() == Themer.Theme.StrokeThickness["2"]:get() then
					RingThickness:set(Themer.Theme.StrokeThickness["3"]:get())
				else
					RingThickness:set(Themer.Theme.StrokeThickness["2"]:get())
				end
			end
		end)

		local Instance = Frame {
			Parent = Parent,
			Padding = Computed(function()
				return UDim.new(0, Themer.Theme.StrokeThickness["4"]:get())
			end),
			ListEnabled = true,
			ListPadding = Computed(function()
				return UDim.new(0, Themer.Theme.Spacing["1"]:get())
			end),
			ListFillDirection = Enum.FillDirection.Horizontal,

			[Children] = {
				Avatar {
					Image = "rbxthumb://type=AvatarHeadShot&id=144146784&w=150&h=150",
				},
				Avatar {
					Image = "rbxthumb://type=AvatarHeadShot&id=144146784&w=150&h=150",
					CornerRadius = Computed(function()
						return UDim.new(0, Themer.Theme.CornerRadius.Full:get())
					end),
				},
				Avatar {
					Image = "rbxthumb://type=AvatarHeadShot&id=144146784&w=150&h=150",
					CornerRadius = Computed(function()
						return UDim.new(0, Themer.Theme.CornerRadius.Full:get())
					end),
					RingEnabled = true,
					RingColor = IndicatorColor,
				},
				Avatar {
					Image = "rbxthumb://type=AvatarHeadShot&id=144146784&w=150&h=150",
					CornerRadius = Computed(function()
						return UDim.new(0, Themer.Theme.CornerRadius.Full:get())
					end),
					IndicatorEnabled = true,
					IndicatorColor = IndicatorColor,
				},
				Avatar {
					Image = "rbxthumb://type=AvatarHeadShot&id=144146784&w=150&h=150",
					CornerRadius = Computed(function()
						return UDim.new(0, Themer.Theme.CornerRadius.Full:get())
					end),
					RingEnabled = true,
					RingColor = Util.Colors.Green["400"],
					RingThickness = RingThickness,
				},
				Avatar {
					Image = "rbxthumb://type=AvatarHeadShot&id=144146784&w=150&h=150",
					CornerRadius = Computed(function()
						return UDim.new(0, Themer.Theme.CornerRadius.Full:get())
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
