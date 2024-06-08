local OnyxUI = script.Parent.Parent
local Fusion = require(OnyxUI.Parent.Fusion)
local Themer = require(OnyxUI.Utils.Themer)
local Colors = require(OnyxUI.Utils.Colors)

local Children = Fusion.Children
local Value = Fusion.Value
local Computed = Fusion.Computed

local Frame = require(script.Parent.Frame)
local Avatar = require(script.Parent.Avatar)

local INDICATOR_COLORS = { Colors.Red["500"], Colors.Green["400"], Colors.Orange["500"], Colors.Stone["600"] }

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
			ListFillDirection = Enum.FillDirection.Horizontal,
			ListPadding = Computed(function()
				return UDim.new(0, Themer.Theme.Spacing["1"]:get())
			end),

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
					RingColor = Colors.Green["400"],
					RingThickness = RingThickness,
				},
				Avatar {
					Image = "rbxthumb://type=AvatarHeadShot&id=144146784&w=150&h=150",
					CornerRadius = Computed(function()
						return UDim.new(0, Themer.Theme.CornerRadius.Full:get())
					end),
					IndicatorEnabled = true,
					IndicatorColor = Colors.Sky["500"],
					IndicatorIcon = "rbxassetid://13805569043",
				},
				Avatar {
					Image = "rbxthumb://type=AvatarHeadShot&id=144146784&w=150&h=150",
					CornerRadius = Computed(function()
						return UDim.new(0, Themer.Theme.CornerRadius.Full:get())
					end),
					IndicatorEnabled = true,
					Size = UDim2.fromOffset(150, 150),
				},
			},
		}

		return function()
			Instance:Destroy()
			task.cancel(RandomizerThread)
		end
	end,
}
