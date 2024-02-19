local NekaUI = script.Parent.Parent

local Fusion = require(NekaUI.Parent.Fusion)
local ColourUtils = require(NekaUI.Parent.ColourUtils)
local Finalize = require(NekaUI.Utils.Finalize)
local EnsureProp = require(NekaUI.Utils.EnsureProp)

local New = Fusion.New
local Children = Fusion.Children
local Computed = Fusion.Computed

local BaseButton = require(NekaUI.Components.BaseButton)
local Icon = require(NekaUI.Components.Icon)

local function IconButton(Props)
	local IsHovering = EnsureProp(Props.IsHovering, "boolean", false)

	return Finalize(BaseButton {
		Name = Props.Name or "IconButton",
		Parent = Props.Parent,
		LayoutOrder = Props.LayoutOrder,
		Position = Props.Position,
		AnchorPoint = Props.AnchorPoint,
		Size = Props.Size,
		AutomaticSize = Props.AutomaticSize,
		ZIndex = Props.ZIndex,

		BackgroundTransparency = 1,
		ImageColor3 = Props.ImageColor3,
		IsHovering = IsHovering,

		OnActivated = Props.OnActivated,

		[Children] = {
			New "UIListLayout" {},
			New "UICorner" {
				CornerRadius = UDim.new(0, 8),
			},
			Icon {
				Image = Props.Image,
				Size = Props.Size,
				ImageColor3 = Computed(function()
					local ImageColor3 = Props.ImageColor3 or Color3.fromRGB(255, 255, 255)
					if IsHovering:get() then
						return ColourUtils.Darken(ImageColor3, 0.1)
					else
						return ImageColor3
					end
				end),
			},
		},
	})
end

return IconButton
