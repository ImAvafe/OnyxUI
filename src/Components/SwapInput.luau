--[=[
		@class SwapInput
		
		Swap between an array values.
]=]

local OnyxUI = script.Parent.Parent
local Fusion = require(OnyxUI.Parent.Fusion)
local Util = require(OnyxUI.Util)
local Themer = require(OnyxUI.Themer)
local ColorUtils = require(OnyxUI.Parent.ColorUtils)

local InnerScope = Fusion.innerScope
local Children = Fusion.Children
local Peek = Fusion.peek

local BaseButton = require(script.Parent.BaseButton)
local Components = {
	BaseButton = BaseButton,
	Text = require(script.Parent.Text),
	IconButton = require(script.Parent.IconButton),
}

export type Props = BaseButton.Props & {
	Options: Fusion.UsedAs<{ string }>?,
	Selection: Fusion.UsedAs<number>?,
	Disabled: Fusion.UsedAs<boolean>?,
	Color: Fusion.UsedAs<Color3>?,
	ContentSize: Fusion.UsedAs<number>?,
}

--[=[
		@within SwapInput
		@interface SwapInputProps

		@field ... BaseButtonProps
		@field Options Fusion.UsedAs<{ string }>?
		@field Selection Fusion.UsedAs<number>?
		@field Disabled Fusion.UsedAs<boolean>?
		@field Color Fusion.UsedAs<Color3>?
		@field ContentSize Fusion.UsedAs<number>?
]=]
return function(Scope: Fusion.Scope<any>, Props: Props)
	local Scope = InnerScope(Scope, Fusion, Util, Components)
	local Theme = Themer.Theme:now()

	local Options = Util.Fallback(Props.Options, {})
	local Selection = Scope:EnsureValue(Util.Fallback(Props.Selection, 1))
	local Color = Util.Fallback(Props.Color, Theme.Colors.BaseContent.Main)
	local Disabled = Util.Fallback(Props.Disabled, false)
	local ContentSize = Util.Fallback(Props.ContentSize, Theme.TextSize["1"])

	local IsHolding = Scope:Value(false)
	local IsHovering = Scope:Value(false)
	local ShownIncrement = Scope:Value(0)

	local SelectionContent = Scope:Computed(function(Use)
		local OptionsValue = Use(Options)
		local SelectionValue = Use(Selection)

		return OptionsValue[SelectionValue]
	end)
	local EffectiveContentColor = Scope:Computed(function(Use)
		if Use(Disabled) then
			return Use(Theme.Colors.BaseContent.Main)
		else
			if Use(IsHolding) then
				return ColorUtils.Emphasize(Use(Color), Use(Theme.Emphasis.Regular))
			elseif Use(IsHovering) then
				return ColorUtils.Emphasize(Use(Color), Use(Theme.Emphasis.Light))
			else
				return Use(Color)
			end
		end
	end)
	local ArrowSize = Scope:Computed(function(Use)
		local ContentSizeValue = Use(ContentSize)

		return ContentSizeValue * 1.25
	end)

	Scope:Observer(Options):onChange(function()
		Selection:set(1)
	end)

	local function RotateSelection(Increment: number)
		local OptionsValue = Peek(Options)
		local SelectionValue = Peek(Selection)
		local NewSelection = SelectionValue + Increment

		if NewSelection > #OptionsValue then
			NewSelection = 1
		elseif NewSelection < 1 then
			NewSelection = #OptionsValue
		end

		Selection:set(NewSelection)
	end

	local OldSelectionValue = Peek(Props.Selection) or 1
	Scope:Observer(Selection):onChange(function()
		local SelectionValue = Peek(Selection)

		local SelectionIncreased = SelectionValue > OldSelectionValue
		ShownIncrement:set((SelectionIncreased and 1) or -1)
		task.wait(0.1)
		ShownIncrement:set(0)
	end)

	return Scope:BaseButton(Util.CombineProps(Props, {
		Name = "SwapInput",
		ListEnabled = true,
		ListHorizontalFlex = Enum.UIFlexAlignment.SpaceBetween,
		ListFillDirection = Enum.FillDirection.Horizontal,
		ListVerticalAlignment = Enum.VerticalAlignment.Center,
		Padding = Scope:Computed(function(Use)
			local Offset = Use(Theme.Spacing["0.25"])
			return UDim.new(0, Offset)
		end),
		StrokeEnabled = true,
		StrokeColor = Color,
		StrokeTransparency = Scope:Spring(
			Scope:Computed(function(Use)
				if Use(Disabled) then
					return 0.9
				else
					return 0.8
				end
			end),
			Theme.SpringSpeed["1"],
			Theme.SpringDampening["1"]
		),
		CornerRadius = Scope:Computed(function(Use)
			return UDim.new(0, Use(Theme.CornerRadius["1"]))
		end),
		Disabled = Disabled,

		IsHolding = IsHolding,
		IsHovering = IsHovering,

		OnActivated = function()
			RotateSelection(1)
		end,

		[Children] = {
			Scope:IconButton {
				Image = "rbxassetid://136326079088976",
				Style = "Ghost",
				Color = Color,
				Disabled = Disabled,
				ContentSize = Scope:Spring(
					Scope:Computed(function(Use)
						local ShownIncrementValue = Use(ShownIncrement)
						local ContentSizeValue = Use(ArrowSize)

						if ShownIncrementValue < 0 then
							return Use(ContentSizeValue * (1 - Use(Theme.Emphasis.Regular)))
						else
							return Use(ContentSizeValue)
						end
					end),
					Theme.SpringSpeed["1"],
					Theme.SpringDampening["1"]
				),

				OnActivated = function()
					RotateSelection(-1)
				end,
			},
			Scope:Text {
				Text = Scope:Computed(function(Use)
					local SelectionContentValue = Use(SelectionContent)
					if SelectionContentValue ~= nil then
						return SelectionContentValue
					else
						return ""
					end
				end),
				TextColor3 = EffectiveContentColor,
				TextTransparency = Scope:Computed(function(Use)
					if Use(Disabled) then
						return 0.75
					else
						return 0
					end
				end),
			},
			Scope:IconButton {
				Image = "rbxassetid://85293585205481",
				Style = "Ghost",
				Color = Color,
				Disabled = Disabled,
				ContentSize = Scope:Spring(
					Scope:Computed(function(Use)
						local ShownIncrementValue = Use(ShownIncrement)
						local ContentSizeValue = Use(ArrowSize)

						if ShownIncrementValue > 0 then
							return Use(ContentSizeValue * (1 - Use(Theme.Emphasis.Regular)))
						else
							return Use(ContentSizeValue)
						end
					end),
					Theme.SpringSpeed["1"],
					Theme.SpringDampening["1"]
				),

				OnActivated = function()
					RotateSelection(1)
				end,
			},
		},
	}))
end
