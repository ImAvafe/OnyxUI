local OnyxUI = script.Parent.Parent

local Fusion = require(OnyxUI.Parent.Fusion)
local Finalize = require(OnyxUI.Utils.Finalize)
local EnsureValue = require(OnyxUI.Utils.EnsureValue)

local Children = Fusion.Children
local Computed = Fusion.Computed

local Frame = require(OnyxUI.Components.Frame)
local Text = require(OnyxUI.Components.Text)
local IconButton = require(OnyxUI.Components.IconButton)

local function TitleBar(Props)
	Props.CloseButtonDisabled = EnsureValue(Props.CloseButtonDisabled, "boolean", false)
	Props.TextSize = EnsureValue(Props.TextSize, "number", 26)

	return Finalize(Frame {
		Name = "TitleBar",
		Size = UDim2.fromScale(1, 0),
		AutomaticSize = Enum.AutomaticSize.Y,

		[Children] = {
			Text {
				Name = "Title",
				AnchorPoint = Vector2.new(0.5, 0.5),
				Position = UDim2.fromScale(0.5, 0.5),
				Text = Props.Title,
				TextSize = Props.TextSize,
				AutoLocalize = Props.AutoLocalize,
			},
			Computed(function()
				if not Props.CloseButtonDisabled:get() then
					return IconButton {
						Name = "CloseButton",
						Image = "rbxassetid://13405228418",
						AnchorPoint = Vector2.new(1, 0.5),
						Position = UDim2.fromScale(1, 0.5),
						Size = UDim2.fromOffset(23, 23),
						OnActivated = function()
							if Props.OnClose then
								Props.OnClose()
							end
						end,
					}
				end
			end, Fusion.cleanup),
		},
	})
end

return TitleBar
