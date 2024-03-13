local OnyxUI = script.Parent.Parent

local Fusion = require(OnyxUI.Parent.Fusion)

local EnsureValue = require(OnyxUI.Utils.EnsureValue)
local Themer = require(OnyxUI.Utils.Themer)

local Children = Fusion.Children
local Computed = Fusion.Computed

local Frame = require(OnyxUI.Components.Frame)
local Text = require(OnyxUI.Components.Text)
local IconButton = require(OnyxUI.Components.IconButton)

local function TitleBar(Props: table)
	Props.Name = EnsureValue(Props.Name, "string", "TitleBar")
	Props.TextSize = EnsureValue(Props.TextSize, "number", Themer.Theme.TextSize["1.5"])
	Props.FontFace = EnsureValue(
		Props.FontFace,
		"Font",
		Computed(function()
			return Font.new(Themer.Theme.Font.Heading:get(), Themer.Theme.FontWeight.Heading:get())
		end)
	)
	Props.Size = EnsureValue(Props.Size, "Udim2", UDim2.fromScale(1, 0))
	Props.AutomaticSize = EnsureValue(Props.AutomaticSize, "EnumItem", Enum.AutomaticSize.Y)
	Props.CloseButtonDisabled = EnsureValue(Props.CloseButtonDisabled, "boolean", false)
	Props.CloseButtonImage = EnsureValue(Props.CloseButtonImage, "string", "rbxassetid://13405228418")
	Props.OnClose = EnsureValue(Props.OnClose, "function", function() end)

	return Frame {
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
		BackgroundColor3 = Props.BackgroundColor3,
		BackgroundTransparency = Props.BackgroundTransparency,

		[Children] = {
			Text {
				Name = "Title",
				AnchorPoint = Vector2.new(0.5, 0),
				Position = UDim2.fromScale(0.5, 0),
				Text = Props.Title,
				TextSize = Props.TextSize,
				FontFace = Props.FontFace,
				AutoLocalize = Props.AutoLocalize,
			},
			Computed(function()
				if not Props.CloseButtonDisabled:get() then
					return IconButton {
						Name = "CloseButton",
						Image = Props.CloseButtonImage,
						Style = "Ghost",
						Color = Themer.Theme.Colors.BaseContent.Main,
						ContentSize = Computed(function()
							return Props.TextSize:get() * 0.9
						end),
						AnchorPoint = Vector2.new(1, 0),
						Position = UDim2.fromScale(1, 0),
						OnActivated = function()
							if Props.OnClose:get() then
								Props.OnClose:get()()
							end
						end,
					}
				end
			end, Fusion.cleanup),
		},
	}
end

return TitleBar
