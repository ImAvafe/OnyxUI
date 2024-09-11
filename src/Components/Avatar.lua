--[=[
		@class Avatar
		
		Useful for displaying player headshots and profile pictures. And optionally, user status.
]=]

local OnyxUI = script.Parent.Parent

local Fusion = require(OnyxUI.Packages.Fusion)
local Util = require(OnyxUI.Util)
local Themer = require(OnyxUI.Themer)

local Children = Fusion.Children

local Image = require(script.Parent.Image)
local Group = require(script.Parent.Group)
local Icon = require(script.Parent.Icon)
local Components = {
	Image = Image,
	Group = Group,
	Icon = Icon,
}

export type Props = Image.Props & {
	Image: Fusion.UsedAs<string>?,
	RingEnabled: Fusion.UsedAs<boolean>?,
	RingColor: Fusion.UsedAs<Color3>?,
	RingThickness: Fusion.UsedAs<number>?,
	IndicatorEnabled: Fusion.UsedAs<boolean>?,
	IndicatorColor: Fusion.UsedAs<Color3>?,
	IndicatorIcon: Fusion.UsedAs<string>?,
	IndicatorIconColor: Fusion.UsedAs<Color3>?,
	IndicatorCornerRadius: Fusion.UsedAs<UDim>?,
}

--[=[
		@within Avatar
		@interface AvatarProps

		@field ... ImageProps
		@field Image Fusion.UsedAs<string>?
		@field RingEnabled Fusion.UsedAs<boolean>?
		@field RingColor Fusion.UsedAs<Color3>?
		@field RingThickness Fusion.UsedAs<number>?
		@field IndicatorEnabled Fusion.UsedAs<boolean>?
		@field IndicatorColor Fusion.UsedAs<Color3>?
		@field IndicatorIcon Fusion.UsedAs<string>?
		@field IndicatorIconColor Fusion.UsedAs<Color3>?
		@field IndicatorCornerRadius Fusion.UsedAs<UDim>?
]=]
return function(Scope: Fusion.Scope<any>, Props: Props)
	local Scope = Fusion.innerScope(Scope, Fusion, Util, Components)
	local Theme = Themer.Theme:now()

	local EnsuredProps = {
		Image = Util.Fallback(Props.Image, nil),
		RingEnabled = Util.Fallback(Props.RingEnabled, false),
		RingColor = Util.Fallback(Props.RingColor, Theme.Colors.Primary.Main),
		RingThickness = Util.Fallback(Props.RingThickness, Theme.StrokeThickness["2"]),
		IndicatorEnabled = Util.Fallback(Props.IndicatorEnabled, false),
		IndicatorColor = Util.Fallback(Props.IndicatorColor, Theme.Colors.Primary.Main),
		IndicatorCornerRadius = Util.Fallback(
			Props.IndicatorCornerRadius,
			Scope:Computed(function(Use)
				return UDim.new(0, Use(Theme.CornerRadius.Full))
			end)
		),
		IndicatorIcon = Util.Fallback(Props.IndicatorIcon, nil),
		IndicatorIconColor = Util.Fallback(Props.IndicatorIconColor, Util.Colors.White),
	}

	return Scope:Image(Util.CombineProps(Props, {
		Name = "Avatar",
		Image = EnsuredProps.Image,
		Size = Scope:Computed(function(Use)
			return UDim2.fromOffset(Use(Theme.TextSize["4.5"]), Use(Theme.TextSize["4.5"]))
		end),
		BackgroundColor3 = Theme.Colors.Neutral.Dark,
		StrokeEnabled = EnsuredProps.RingEnabled,
		StrokeColor = Scope:Spring(EnsuredProps.RingColor, Theme.SpringSpeed["0.5"], Theme.SpringDampening["1"]),
		StrokeThickness = Scope:Spring(
			EnsuredProps.RingThickness,
			Theme.SpringSpeed["0.5"],
			Theme.SpringDampening["1"]
		),
		CornerRadius = Scope:Computed(function(Use)
			return UDim.new(0, Use(Theme.CornerRadius["1"]))
		end),

		[Children] = {
			Scope:Computed(function(Use)
				if Use(EnsuredProps.IndicatorEnabled) then
					return Scope:Group {
						Name = "Indicator",
						BackgroundColor3 = Scope:Spring(
							EnsuredProps.IndicatorColor,
							Theme.SpringSpeed["0.5"],
							Theme.SpringDampening["1"]
						),
						BackgroundTransparency = 0,
						Size = UDim2.fromScale(0.25, 0.25),
						AutomaticSize = Enum.AutomaticSize.None,
						AnchorPoint = Vector2.new(1, 1),
						Position = UDim2.fromScale(1, 1),
						AspectRatio = 1,
						CornerRadius = EnsuredProps.IndicatorCornerRadius,

						[Children] = {
							Scope:Icon {
								Image = EnsuredProps.IndicatorIcon,
								ImageColor3 = EnsuredProps.IndicatorIconColor,
								ImageTransparency = Scope:Computed(function(Use)
									if Use(EnsuredProps.IndicatorIcon) then
										return 0
									else
										return 1
									end
								end),
								Size = UDim2.fromScale(1, 1),
								AnchorPoint = Vector2.new(0.5, 0.5),
								Position = UDim2.fromScale(0.5, 0.5),
							},
						},
					}
				else
					return
				end
			end),
		},
	}))
end
