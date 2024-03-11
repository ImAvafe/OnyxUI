local OnyxUI = script.Parent.Parent

local Fusion = require(OnyxUI.Parent.Fusion)
local EnsureValue = require(OnyxUI.Utils.EnsureValue)
local Themer = require(OnyxUI.Utils.Themer)

local New = Fusion.New
local Children = Fusion.Children
local Computed = Fusion.Computed
local Spring = Fusion.Spring

local Frame = require(OnyxUI.Components.Frame)
local CanvasGroup = require(OnyxUI.Components.CanvasGroup)

return function(Props: table)
	Props.Name = EnsureValue(Props.Name, "string", "ProgressBar")
	Props.Size = EnsureValue(
		Props.Size,
		"UDim2",
		Computed(function()
			return UDim2.fromOffset(250, Themer.Theme.TextSize["1"]:get())
		end)
	)
	Props.AutomaticSize = EnsureValue(Props.AutomaticSize, "EnumItem", Enum.AutomaticSize.None)
	Props.BackgroundTransparency = EnsureValue(Props.BackgroundTransparency, "number", 0)
	Props.BackgroundColor3 = EnsureValue(Props.BackgroundColor3, "Color3", Themer.Theme.Colors.Neutral.Dark)

	Props.Progress = EnsureValue(Props.Progress, "number", 0)
	Props.Color = EnsureValue(Props.Color, "Color3", Themer.Theme.Colors.Primary.Main)
	Props.SpringSpeed = EnsureValue(Props.SpringSpeed, "number", Themer.Theme.SpringSpeed["0.5"])
	Props.SpringDampening = EnsureValue(Props.SpringDampening, "number", Themer.Theme.SpringDampening)

	return CanvasGroup {
		Name = Props.Name,
		Parent = Props.Parent,
		Position = Props.Position,
		Rotation = Props.Rotation,
		AnchorPoint = Props.AnchorPoint,
		Size = Props.Size,
		AutomaticSize = Props.AutomaticSize,
		Visible = Props.Visible,
		ZIndex = Props.ZIndex,
		LayoutOrder = Props.LayoutOrder,
		ClipsDescendants = Props.ClipsDescendants,
		Active = Props.Active,
		Selectable = Props.Selectable,
		Interactable = Props.Interactable,
		BackgroundColor3 = Props.BackgroundColor3,
		BackgroundTransparency = Props.BackgroundTransparency,

		[Children] = {
			New "UICorner" {
				CornerRadius = Computed(function()
					return UDim.new(0, Themer.Theme.CornerRadius["2"]:get())
				end),
			},
			Frame {
				Name = "ProgressFill",
				Size = Spring(
					Computed(function()
						return UDim2.fromScale(Props.Progress:get(), 1)
					end),
					Props.SpringSpeed,
					Props.SpringDampening
				),
				AutomaticSize = Enum.AutomaticSize.None,
				BackgroundTransparency = 0,
				BackgroundColor3 = Props.Color,
			},
		},
	}
end
