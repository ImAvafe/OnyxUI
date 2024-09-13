--[=[
		@class MenuFrame
		
		For displaying top-level menus to the user.
]=]

local OnyxUI = script.Parent.Parent

local Fusion = require(OnyxUI.Parent.Fusion)
local Themer = require(OnyxUI.Themer)
local Util = require(OnyxUI.Util)

local Out = Fusion.Out
local InnerScope = Fusion.innerScope

local Group = require(script.Parent.Group)
local Components = {
	Group = Group,
}

export type Props = Group.Props & {}

--[=[
		@within MenuFrame
		@interface MenuFrameProps

		@field ... GroupProps
]=]
return function(Scope: Fusion.Scope<any>, Props: Props)
	local Scope = InnerScope(Scope, Fusion, Util, Components)
	local Theme = Themer.Theme:now()

	local AutomaticSize = Scope:Value(Enum.AutomaticSize.None)

	return Scope:Group(Util.CombineProps(Props, {
		Name = "MenuFrame",
		GroupTransparency = Props.GroupTransparency,
		BackgroundColor3 = Theme.Colors.Base.Main,
		BackgroundTransparency = 0,
		Padding = Scope:Computed(function(Use)
			return UDim.new(0, Use(Theme.Spacing["1"]))
		end),
		CornerRadius = Scope:Computed(function(Use)
			return UDim.new(0, Use(Theme.CornerRadius["3"]))
		end),
		StrokeEnabled = true,
		StrokeColor = Theme.Colors.Neutral.Main,

		[Out "AutomaticSize"] = AutomaticSize,
	}))
end
