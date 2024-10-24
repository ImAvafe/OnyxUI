local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local CoreGui = game:GetService("CoreGui")

local OnyxUI = script.Parent.Parent.Parent
local Fusion = require(OnyxUI.Parent.Fusion)
local Util = require(OnyxUI.Util)
local Themer = require(OnyxUI.Themer)
local Signal = require(OnyxUI.Parent.Signal)

local Children = Fusion.Children

local Components = {
	TextInput = require(OnyxUI.Components.TextInput),
	Scroller = require(OnyxUI.Components.Scroller),
	Button = require(OnyxUI.Components.Button),
	Group = require(OnyxUI.Components.Group),
}

local Scope = Fusion.scoped(Fusion, Components, Util)

local States = {
	Object = Scope:Value(nil),
	Items = Scope:Value(Scope:Value({})),
	Selection = Scope:Value(Scope:Value(nil)),
	Theme = Scope:Value(Themer.Theme:now()),
	OnSelected = Scope:Value(Scope:Value(function() end)),
	FocusLost = Signal.new(),
}

local Open = Scope:Computed(function(Use)
	return Use(States.Object) ~= nil
end)
local CanvasPosition = Scope:Value(Vector2.new())
local OnFocusLost = function(SelectedItem)
	if SelectedItem then
		Fusion.peek(States.Selection):set(SelectedItem)
	end

	States.Items:set({})
	States.Object:set(nil)

	Fusion.peek(Fusion.peek(States.OnSelected))()
	States.OnSelected:set(function() end)

	CanvasPosition:set(Vector2.new(), true)
end

States.FocusLost:Connect(function()
	OnFocusLost()
end)

local function WatchPositionAndSize(GuiObject: Fusion.UsedAs<GuiObject>)
	local AbsolutePosition = Scope:Value(Vector2.new())
	local AbsoluteSize = Scope:Value(Vector2.new())

	local PositionConnection: RBXScriptConnection?
	local SizeConnection: RBXScriptConnection?

	Scope:Observer(GuiObject):onChange(function()
		local ObjectValue = Fusion.peek(GuiObject)

		if PositionConnection then
			PositionConnection:Disconnect()
		end
		if SizeConnection then
			SizeConnection:Disconnect()
		end

		if ObjectValue ~= nil then
			AbsolutePosition:set(ObjectValue.AbsolutePosition)
			AbsoluteSize:set(ObjectValue.AbsoluteSize)

			SizeConnection = ObjectValue:GetPropertyChangedSignal("AbsoluteSize"):Connect(function()
				AbsoluteSize:set(ObjectValue.AbsoluteSize)
			end)

			task.delay(1, function()
				PositionConnection = ObjectValue:GetPropertyChangedSignal("AbsolutePosition"):Connect(function()
					States.Object:set(nil)
				end)
			end)
		end
	end)

	return AbsolutePosition, AbsoluteSize
end

local AbsolutePosition, AbsoluteSize = WatchPositionAndSize(States.Object)

Scope:New "ScreenGui" {
	Name = "DropdownHandler",
	DisplayOrder = 1000,
	Parent = Scope:Computed(function(Use)
		if RunService:IsRunning() and (Players.LocalPlayer ~= nil) then
			return Players.LocalPlayer:FindFirstChild("PlayerGui")
		else
			return CoreGui
		end
	end),
	Enabled = Open,

	[Children] = {
		Scope:Group {
			Name = "List",
			AnchorPoint = Vector2.new(0, -1),
			Position = Scope:Computed(function(Use)
				local Theme = Use(States.Theme)
				local AbsolutePositionValue = Use(AbsolutePosition)
				local AbsoluteSizeValue = Use(AbsoluteSize)
				return UDim2.fromOffset(
					AbsolutePositionValue.X,
					(AbsolutePositionValue.Y + AbsoluteSizeValue.Y) + (Use(Theme.StrokeThickness["1"]) * 2)
				)
			end),
			Size = Scope:Computed(function(Use)
				local AbsoluteSizeValue = Use(AbsoluteSize)
				return UDim2.new(UDim.new(0, AbsoluteSizeValue.X), UDim.new(0, 0))
			end),
			AutomaticSize = Enum.AutomaticSize.Y,
			CornerRadius = Scope:Computed(function(Use)
				local Theme = Use(States.Theme)
				return Use(UDim.new(0, Use(Theme.CornerRadius["1"])))
			end),

			[Children] = {
				Scope:Scroller {
					Size = Scope:Computed(function(Use)
						local Theme = Use(States.Theme)
						return UDim2.new(UDim.new(1, 0), UDim.new(0, Use(Theme.Spacing["16"])))
					end),
					AutomaticSize = Enum.AutomaticSize.None,
					StrokeEnabled = true,
					StrokeColor = Scope:Computed(function(Use)
						local Theme = Use(States.Theme)
						return Use(Theme.Colors.Neutral.Main)
					end),
					ListEnabled = true,
					ListPadding = Scope:Computed(function(Use)
						local Theme = Use(States.Theme)
						return Use(UDim.new(0, Use(Theme.Spacing["0"])))
					end),
					ListHorizontalFlex = Enum.UIFlexAlignment.Fill,
					BackgroundTransparency = 0,
					BackgroundColor3 = Scope:Computed(function(Use)
						local Theme = Use(States.Theme)
						return Use(Theme.Colors.Neutral.Main)
					end),
					Active = true,
					CanvasPosition = CanvasPosition,

					[Children] = {
						Scope:Computed(function(Use)
							return Scope:ForValues(Use(States.Items), function(Use, Scope, Item)
								local IsHovering = Scope:Value(false)

								return Themer.Theme:is(Use(States.Theme)):during(function()
									return Scope:Button {
										Name = "ItemButton",
										Content = { Item },
										Style = "Ghost",
										Color = Scope:Computed(function(Use)
											local Theme = Use(States.Theme)
											return Use(Theme.Colors.BaseContent.Main)
										end),
										BackgroundTransparency = Scope:Computed(function(Use)
											local Theme = Use(States.Theme)
											if Use(IsHovering) then
												return 1 - Use(Theme.Emphasis.Light)
											else
												return 1
											end
										end),
										IsHovering = IsHovering,
										CornerRadius = Scope:Computed(function(Use)
											local Theme = Use(States.Theme)
											return UDim.new(0, Use(Theme.CornerRadius["0"]))
										end),

										OnActivated = function()
											OnFocusLost(Item)
										end,
									}
								end)
							end)
						end),
					},
				},
			},
		},
	},
}

return States
