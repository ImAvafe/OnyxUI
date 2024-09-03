--[=[
		@class Base

		The foundational component of OnyxUI, from which all other components are built off of. Props supported here typically work in all other components.

		:::info Styling props
		A reference of common styling props can be found in [this docs page](/docs/styling-props).
		:::
]=]

local OnyxUI = script.Parent.Parent
local Fusion = require(OnyxUI.Packages.Fusion)
local Util = require(OnyxUI.Util)
local Themer = require(OnyxUI.Themer)

export type Props = {
	ClassName: string?,

	Name: Fusion.UsedAs<string>?,
	Parent: Fusion.UsedAs<Instance>?,
	Position: Fusion.UsedAs<UDim2>?,
	Rotation: Fusion.UsedAs<number>?,
	AnchorPoint: Fusion.UsedAs<Vector2>?,
	Size: Fusion.UsedAs<UDim2>?,
	AutomaticSize: Fusion.UsedAs<Enum.AutomaticSize>?,
	Visible: Fusion.UsedAs<boolean>?,
	ZIndex: Fusion.UsedAs<number>?,
	LayoutOrder: Fusion.UsedAs<number>?,
	ClipsDescendants: Fusion.UsedAs<boolean>?,
	Active: Fusion.UsedAs<boolean>?,
	Selectable: Fusion.UsedAs<boolean>?,
	Interactable: Fusion.UsedAs<boolean>?,
	BackgroundColor3: Fusion.UsedAs<Color3>?,
	BackgroundTransparency: Fusion.UsedAs<number>?,
	NextSelectionDown: Fusion.UsedAs<GuiObject>?,
	NextSelectionUp: Fusion.UsedAs<GuiObject>?,
	NextSelectionRight: Fusion.UsedAs<GuiObject>?,
	NextSelectionLeft: Fusion.UsedAs<GuiObject>?,
	SelectionImageObject: Fusion.UsedAs<GuiObject>?,
	SelectionOrder: Fusion.UsedAs<number>?,
	SizeConstraint: Fusion.UsedAs<Enum.SizeConstraint>?,
	AutoLocalize: Fusion.UsedAs<boolean>?,
	RootLocalizationTable: Fusion.UsedAs<LocalizationTable>?,
	SelectionBehaviorDown: Fusion.UsedAs<Enum.SelectionBehavior>?,
	SelectionBehaviorUp: Fusion.UsedAs<Enum.SelectionBehavior>?,
	SelectionBehaviorRight: Fusion.UsedAs<Enum.SelectionBehavior>?,
	SelectionBehaviorLeft: Fusion.UsedAs<Enum.SelectionBehavior>?,
	SelectionGroup: Fusion.UsedAs<boolean>?,

	CornerRadius: Fusion.UsedAs<UDim>?,

	Padding: Fusion.UsedAs<UDim>?,
	PaddingTop: Fusion.UsedAs<UDim>?,
	PaddingLeft: Fusion.UsedAs<UDim>?,
	PaddingRight: Fusion.UsedAs<UDim>?,
	PaddingBottom: Fusion.UsedAs<UDim>?,

	Scale: Fusion.UsedAs<number>?,

	StrokeEnabled: Fusion.UsedAs<boolean>?,
	StrokeThickness: Fusion.UsedAs<number>?,
	StrokeColor: Fusion.UsedAs<Color3>?,
	StrokeTransparency: Fusion.UsedAs<number>?,
	StrokeLineJoinMode: Fusion.UsedAs<Enum.LineJoinMode>?,
	StrokeApplyStrokeMode: Fusion.UsedAs<Enum.ApplyStrokeMode>?,

	GradientEnabled: Fusion.UsedAs<boolean>?,
	GradientColor: Fusion.UsedAs<ColorSequence>?,
	GradientOffset: Fusion.UsedAs<UDim>?,
	GradientRotation: Fusion.UsedAs<number>?,
	GradientTransparency: Fusion.UsedAs<number>?,

	AspectRatio: Fusion.UsedAs<number>?,
	AspectType: Fusion.UsedAs<Enum.AspectType>?,
	DominantAxis: Fusion.UsedAs<Enum.DominantAxis>?,

	ListEnabled: Fusion.UsedAs<boolean>?,
	ListPadding: Fusion.UsedAs<UDim>?,
	ListFillDirection: Fusion.UsedAs<Enum.FillDirection>?,
	ListSortOrder: Fusion.UsedAs<Enum.SortOrder>?,
	ListWraps: Fusion.UsedAs<boolean>?,
	ListHorizontalAlignment: Fusion.UsedAs<Enum.HorizontalAlignment>?,
	ListHorizontalFlex: Fusion.UsedAs<boolean>?,
	ListVerticalAlignment: Fusion.UsedAs<Enum.VerticalAlignment>?,
	ListVerticalFlex: Fusion.UsedAs<boolean>?,
	ListItemLineAlignment: Fusion.UsedAs<Enum.ItemLineAlignment>?,

	GridEnabled: Fusion.UsedAs<boolean>?,
	GridCellPadding: Fusion.UsedAs<UDim>?,
	GridCellSize: Fusion.UsedAs<UDim2>?,
	GridFillDirection: Fusion.UsedAs<Enum.FillDirection>?,
	GridFillDirectionMaxCells: Fusion.UsedAs<number>?,
	GridSortOrder: Fusion.UsedAs<Enum.SortOrder>?,
	GridStartCorner: Fusion.UsedAs<Enum.StartCorner>?,
	GridHorizontalAlignment: Fusion.UsedAs<Enum.HorizontalAlignment>?,
	GridVerticalAlignment: Fusion.UsedAs<Enum.VerticalAlignment>?,

	TableEnabled: Fusion.UsedAs<boolean>?,
	TablePadding: Fusion.UsedAs<UDim>?,
	TableFillEmptySpaceColumns: Fusion.UsedAs<boolean>?,
	TableFillEmptySpaceRows: Fusion.UsedAs<boolean>?,
	TableFillDirection: Fusion.UsedAs<Enum.FillDirection>?,
	TableSortOrder: Fusion.UsedAs<Enum.SortOrder>?,
	TableMajorAxis: Fusion.UsedAs<Enum.TableMajorAxis>?,
	TableHorizontalAlignment: Fusion.UsedAs<Enum.HorizontalAlignment>?,
	TableVerticalAlignment: Fusion.UsedAs<Enum.VerticalAlignment>?,

	PageEnabled: Fusion.UsedAs<boolean>?,
	PageAnimated: Fusion.UsedAs<boolean>?,
	PageCircular: Fusion.UsedAs<boolean>?,
	PageEasingDirection: Fusion.UsedAs<Enum.EasingDirection>?,
	PageEasingStyle: Fusion.UsedAs<Enum.EasingStyle>?,
	PagePadding: Fusion.UsedAs<UDim>?,
	PageTweenTime: Fusion.UsedAs<number>?,
	PageFillDirection: Fusion.UsedAs<Enum.FillDirection>?,
	PageSortOrder: Fusion.UsedAs<Enum.SortOrder>?,
	PageHorizontalAlignment: Fusion.UsedAs<Enum.HorizontalAlignment>?,
	PageVerticalAlignment: Fusion.UsedAs<Enum.VerticalAlignment>?,
	PageGamepadInputEnabled: Fusion.UsedAs<boolean>?,
	PageScrollWheelInputEnabled: Fusion.UsedAs<boolean>?,
	PageTouchInputEnabled: Fusion.UsedAs<boolean>?,

	FlexMode: Fusion.UsedAs<Enum.UIFlexMode>?,
	FlexItemLineAlignment: Fusion.UsedAs<Enum.ItemLineAlignment>?,
	FlexGrowRatio: Fusion.UsedAs<number>?,
	FlexShrinkRatio: Fusion.UsedAs<number>?,

	MaxSize: Fusion.UsedAs<Vector2>?,
	MinSize: Fusion.UsedAs<Vector2>?,

	MaxTextSize: Fusion.UsedAs<number>?,
	MinTextSize: Fusion.UsedAs<number>?,
}

--[=[
	@within Base
	@interface BaseProps

	@field ... BaseProps
	
	@field ClassName string?
	@field Name Fusion.UsedAs<string>?
	@field Parent Fusion.UsedAs<Instance>?
	@field Position Fusion.UsedAs<UDim2>?
	@field Rotation Fusion.UsedAs<number>?
	@field AnchorPoint Fusion.UsedAs<Vector2>?
	@field Size Fusion.UsedAs<UDim2>?
	@field AutomaticSize Fusion.UsedAs<Enum.AutomaticSize>?
	@field Visible Fusion.UsedAs<boolean>?
	@field ZIndex Fusion.UsedAs<number>?
	@field LayoutOrder Fusion.UsedAs<number>?
	@field ClipsDescendants Fusion.UsedAs<boolean>?
	@field Active Fusion.UsedAs<boolean>?
	@field Selectable Fusion.UsedAs<boolean>?
	@field Interactable Fusion.UsedAs<boolean>?
	@field BackgroundColor3 Fusion.UsedAs<Color3>?
	@field BackgroundTransparency Fusion.UsedAs<number>?
	@field NextSelectionDown Fusion.UsedAs<GuiObject>?
	@field NextSelectionUp Fusion.UsedAs<GuiObject>?
	@field NextSelectionRight Fusion.UsedAs<GuiObject>?
	@field NextSelectionLeft Fusion.UsedAs<GuiObject>?
	@field SelectionImageObject Fusion.UsedAs<GuiObject>?
	@field SelectionOrder Fusion.UsedAs<number>?
	@field SizeConstraint Fusion.UsedAs<Enum.SizeConstraint>?
	@field AutoLocalize Fusion.UsedAs<boolean>?
	@field RootLocalizationTable Fusion.UsedAs<LocalizationTable>?
	@field SelectionBehaviorDown Fusion.UsedAs<Enum.SelectionBehavior>?
	@field SelectionBehaviorUp Fusion.UsedAs<Enum.SelectionBehavior>?
	@field SelectionBehaviorRight Fusion.UsedAs<Enum.SelectionBehavior>?
	@field SelectionBehaviorLeft Fusion.UsedAs<Enum.SelectionBehavior>?
	@field SelectionGroup Fusion.UsedAs<boolean>?
	@field CornerRadius Fusion.UsedAs<UDim>?
	@field Padding Fusion.UsedAs<UDim>?
	@field PaddingTop Fusion.UsedAs<UDim>?
	@field PaddingLeft Fusion.UsedAs<UDim>?
	@field PaddingRight Fusion.UsedAs<UDim>?
	@field PaddingBottom Fusion.UsedAs<UDim>?
	@field Scale Fusion.UsedAs<number>?
	@field StrokeEnabled Fusion.UsedAs<boolean>?
	@field StrokeThickness Fusion.UsedAs<number>?
	@field StrokeColor Fusion.UsedAs<Color3>?
	@field StrokeTransparency Fusion.UsedAs<number>?
	@field StrokeLineJoinMode Fusion.UsedAs<Enum.LineJoinMode>?
	@field StrokeApplyStrokeMode Fusion.UsedAs<Enum.ApplyStrokeMode>?
	@field GradientEnabled Fusion.UsedAs<boolean>?
	@field GradientColor Fusion.UsedAs<ColorSequence>?
	@field GradientOffset Fusion.UsedAs<UDim>?
	@field GradientRotation Fusion.UsedAs<number>?
	@field GradientTransparency Fusion.UsedAs<number>?
	@field AspectRatio Fusion.UsedAs<number>?
	@field AspectType Fusion.UsedAs<Enum.AspectType>?
	@field DominantAxis Fusion.UsedAs<Enum.DominantAxis>?
	@field ListEnabled Fusion.UsedAs<boolean>?
	@field ListPadding Fusion.UsedAs<UDim>?
	@field ListFillDirection Fusion.UsedAs<Enum.FillDirection>?
	@field ListSortOrder Fusion.UsedAs<Enum.SortOrder>?
	@field ListWraps Fusion.UsedAs<boolean>?
	@field ListHorizontalAlignment Fusion.UsedAs<Enum.HorizontalAlignment>?
	@field ListHorizontalFlex Fusion.UsedAs<boolean>?
	@field ListVerticalAlignment Fusion.UsedAs<Enum.VerticalAlignment>?
	@field ListVerticalFlex Fusion.UsedAs<boolean>?
	@field ListItemLineAlignment Fusion.UsedAs<Enum.ItemLineAlignment>?
	@field GridEnabled Fusion.UsedAs<boolean>?
	@field GridCellPadding Fusion.UsedAs<UDim>?
	@field GridCellSize Fusion.UsedAs<UDim2>?
	@field GridFillDirection Fusion.UsedAs<Enum.FillDirection>?
	@field GridFillDirectionMaxCells Fusion.UsedAs<number>?
	@field GridSortOrder Fusion.UsedAs<Enum.SortOrder>?
	@field GridStartCorner Fusion.UsedAs<Enum.StartCorner>?
	@field GridHorizontalAlignment Fusion.UsedAs<Enum.HorizontalAlignment>?
	@field GridVerticalAlignment Fusion.UsedAs<Enum.VerticalAlignment>?
	@field TableEnabled Fusion.UsedAs<boolean>?
	@field TablePadding Fusion.UsedAs<UDim>?
	@field TableFillEmptySpaceColumns Fusion.UsedAs<boolean>?
	@field TableFillEmptySpaceRows Fusion.UsedAs<boolean>?
	@field TableFillDirection Fusion.UsedAs<Enum.FillDirection>?
	@field TableSortOrder Fusion.UsedAs<Enum.SortOrder>?
	@field TableMajorAxis Fusion.UsedAs<Enum.TableMajorAxis>?
	@field TableHorizontalAlignment Fusion.UsedAs<Enum.HorizontalAlignment>?
	@field TableVerticalAlignment Fusion.UsedAs<Enum.VerticalAlignment>?
	@field PageEnabled Fusion.UsedAs<boolean>?
	@field PageAnimated Fusion.UsedAs<boolean>?
	@field PageCircular Fusion.UsedAs<boolean>?
	@field PageEasingDirection Fusion.UsedAs<Enum.EasingDirection>?
	@field PageEasingStyle Fusion.UsedAs<Enum.EasingStyle>?
	@field PagePadding Fusion.UsedAs<UDim>?
	@field PageTweenTime Fusion.UsedAs<number>?
	@field PageFillDirection Fusion.UsedAs<Enum.FillDirection>?
	@field PageSortOrder Fusion.UsedAs<Enum.SortOrder>?
	@field PageHorizontalAlignment Fusion.UsedAs<Enum.HorizontalAlignment>?
	@field PageVerticalAlignment Fusion.UsedAs<Enum.VerticalAlignment>?
	@field PageGamepadInputEnabled Fusion.UsedAs<boolean>?
	@field PageScrollWheelInputEnabled Fusion.UsedAs<boolean>?
	@field PageTouchInputEnabled Fusion.UsedAs<boolean>?
	@field FlexMode Fusion.UsedAs<Enum.UIFlexMode>?
	@field FlexItemLineAlignment Fusion.UsedAs<Enum.ItemLineAlignment>?
	@field FlexGrowRatio Fusion.UsedAs<number>?
	@field FlexShrinkRatio Fusion.UsedAs<number>?
	@field MaxSize Fusion.UsedAs<Vector2>?
	@field MinSize Fusion.UsedAs<Vector2>?
	@field MaxTextSize Fusion.UsedAs<number>?
	@field MinTextSize Fusion.UsedAs<number>?
]=]
return function(Scope: Fusion.Scope, Props: Props): Fusion.Child
	local Theme: Themer.ThemeObject = Themer.Theme:now()

	Props.BackgroundColor3 = Theme.Colors.Base.Main
	Props.ClassName = Util.Fallback(Props.ClassName, "Frame")
	Props.Name = Util.Fallback(Props.Name, "Base")
	Props.CornerRadius = Util.Fallback(Props.CornerRadius, UDim.new(0, 0))
	Props.StrokeThickness = Util.Fallback(Props.StrokeThickness, Theme.StrokeThickness["1"])
	-- Props.StrokeColor = Util.Fallback(Props.StrokeColor, Themer.Theme.Colors.Neutral.Main)
	-- Props.StrokeApplyStrokeMode = Util.Fallback(Props.StrokeApplyStrokeMode, Enum.ApplyStrokeMode.Border)
	-- Props.Padding = Util.Fallback(
	-- 	Props.Padding,
	-- 	Scope:Computed(function(use)
	-- 		return UDim.new(0, use(Themer.Theme.Spacing["1"]))
	-- 	end)
	-- )
	-- Props.PaddingBottom = Util.Fallback(Props.PaddingBottom, Props.Padding)
	-- Props.PaddingLeft = Util.Fallback(Props.PaddingLeft, Props.Padding)
	-- Props.PaddingRight = Util.Fallback(Props.PaddingRight, Props.Padding)
	-- Props.PaddingTop = Util.Fallback(Props.PaddingTop, Props.Padding)
	-- Props.ListPadding = Util.Fallback(
	-- 	Props.ListPadding,
	-- 	Scope:Computed(function()
	-- 		return UDim.new(0, Themer.Theme.Spacing["1"]:get())
	-- 	end)
	-- )
	-- Props.ListSortOrder = Util.Fallback(Props.ListSortOrder, Enum.SortOrder.LayoutOrder)
	-- Props.GridCellPadding = Util.Fallback(
	-- 	Props.GridCellPadding,
	-- 	Scope:Computed(function()
	-- 		return UDim2.fromOffset(Themer.Theme.Spacing["0.5"]:get(), Themer.Theme.Spacing["0.5"]:get())
	-- 	end)
	-- )
	-- Props.GridSortOrder = Util.Fallback(Props.GridSortOrder, Enum.SortOrder.LayoutOrder)
	-- Props.PagePadding = Util.Fallback(
	-- 	Props.PagePadding,
	-- 	Scope:Computed(function()
	-- 		return UDim.new(0, Themer.Theme.Spacing["0.5"]:get())
	-- 	end)
	-- )
	-- Props.PageSortOrder = Util.Fallback(Props.PageSortOrder, Enum.SortOrder.LayoutOrder)
	-- Props.TablePadding = Util.Fallback(
	-- 	Props.TablePadding,
	-- 	Scope:Computed(function()
	-- 		return UDim.new(0, Themer.Theme.Spacing["0.5"]:get())
	-- 	end)
	-- )
	-- Props.TableSortOrder = Util.Fallback(Props.TableSortOrder, Enum.SortOrder.LayoutOrder)

	-- local PaddingInEffect = Scope:Computed(function()
	-- 	local Paddings = { Props.Padding, Props.PaddingTop, Props.PaddingLeft, Props.PaddingRight, Props.PaddingBottom }

	-- 	for _, PaddingProp in pairs(Paddings) do
	-- 		local PaddingValue = Util.GetValue(PaddingProp)
	-- 		if typeof(PaddingValue) == "UDim" then
	-- 			return true
	-- 		end
	-- 	end

	-- 	return false
	-- end)

	return Scope:New(Props.ClassName) {
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
		NextSelectionDown = Props.NextSelectionDown,
		NextSelectionUp = Props.NextSelectionUp,
		NextSelectionRight = Props.NextSelectionRight,
		NextSelectionLeft = Props.NextSelectionLeft,
		SelectionImageObject = Props.SelectionImageObject,
		SelectionOrder = Props.SelectionOrder,
		SizeConstraint = Props.SizeConstraint,
		AutoLocalize = Props.AutoLocalize,
		RootLocalizationTable = Props.RootLocalizationTable,
		SelectionBehaviorDown = Props.SelectionBehaviorDown,
		SelectionBehaviorUp = Props.SelectionBehaviorUp,
		SelectionBehaviorRight = Props.SelectionBehaviorRight,
		SelectionBehaviorLeft = Props.SelectionBehaviorLeft,
		SelectionGroup = Props.SelectionGroup,

		-- [Children] = {
		-- 	Props[Children],

		-- 	Scope:Computed(function()
		-- 		local CornerRadiusValue = CornerRadius:get()
		-- 		if
		-- 			(typeof(CornerRadiusValue) == "UDim")
		-- 			and ((CornerRadiusValue.Offset ~= 0) or (CornerRadiusValue.Scale ~= 0))
		-- 		then
		-- 			return New "UICorner" {
		-- 				CornerRadius = CornerRadius,
		-- 			}
		-- 		else
		-- 			return
		-- 		end
		-- 	end, Fusion.cleanup),
		-- 	Scope:Computed(function()
		-- 		if PaddingInEffect:get() == true then
		-- 			return Scope:New "UIPadding" {
		-- 				PaddingTop = Scope:Computed(function()
		-- 					local PaddingTopValue = PaddingTop:get()
		-- 					local PaddingValue = Padding:get()
		-- 					if typeof(PaddingTopValue) == "UDim" then
		-- 						return PaddingTopValue
		-- 					elseif typeof(PaddingValue) == "UDim" then
		-- 						return PaddingValue
		-- 					else
		-- 						return UDim.new()
		-- 					end
		-- 				end),
		-- 				PaddingLeft = Computed(function()
		-- 					local PaddingLeftValue = PaddingLeft:get()
		-- 					local PaddingValue = Padding:get()
		-- 					if typeof(PaddingLeftValue) == "UDim" then
		-- 						return PaddingLeftValue
		-- 					elseif typeof(PaddingValue) == "UDim" then
		-- 						return Util.GetValue(PaddingValue)
		-- 					else
		-- 						return UDim.new()
		-- 					end
		-- 				end),
		-- 				PaddingRight = Computed(function()
		-- 					local PaddingRightValue = PaddingRight:get()
		-- 					local PaddingValue = Padding:get()
		-- 					if typeof(PaddingRightValue) == "UDim" then
		-- 						return PaddingRightValue
		-- 					elseif typeof(PaddingValue) == "UDim" then
		-- 						return Util.GetValue(PaddingValue)
		-- 					else
		-- 						return UDim.new()
		-- 					end
		-- 				end),
		-- 				PaddingBottom = Computed(function()
		-- 					local PaddingBottomValue = PaddingBottom:get()
		-- 					local PaddingValue = Padding:get()
		-- 					if typeof(PaddingBottomValue) == "UDim" then
		-- 						return PaddingBottomValue
		-- 					elseif typeof(PaddingValue) == "UDim" then
		-- 						return Util.GetValue(PaddingValue)
		-- 					else
		-- 						return UDim.new()
		-- 					end
		-- 				end),
		-- 			}
		-- 		else
		-- 			return
		-- 		end
		-- 	end, Fusion.cleanup),
		-- 	Computed(function()
		-- 		local ScaleValue = Util.GetValue(Props.Scale)
		-- 		if (typeof(ScaleValue) == "number") and (ScaleValue ~= 1) then
		-- 			return New "UIScale" {
		-- 				Scale = Props.Scale,
		-- 			}
		-- 		else
		-- 			return
		-- 		end
		-- 	end, Fusion.cleanup),
		-- 	Computed(function()
		-- 		if Util.GetValue(Props.StrokeEnabled) == true then
		-- 			return New "UIStroke" {
		-- 				Enabled = Props.StrokeEnabled,
		-- 				Thickness = StrokeThickness,
		-- 				Color = StrokeColor,
		-- 				Transparency = Props.StrokeTransparency,
		-- 				ApplyStrokeMode = StrokeApplyStrokeMode,
		-- 				LineJoinMode = Props.StrokeLineJoinMode,
		-- 			}
		-- 		else
		-- 			return
		-- 		end
		-- 	end, Fusion.cleanup),
		-- 	Computed(function()
		-- 		if Util.GetValue(Props.GradientEnabled) == true then
		-- 			return New "UIGradient" {
		-- 				Enabled = Props.GradientEnabled,
		-- 				Color = Props.GradientColor,
		-- 				Offset = Props.GradientOffset,
		-- 				Rotation = Props.GradientRotation,
		-- 				Transparency = Props.GradientTransparency,
		-- 			}
		-- 		else
		-- 			return
		-- 		end
		-- 	end, Fusion.cleanup),
		-- 	Computed(function()
		-- 		local AspectRatioValue = Util.GetValue(Props.AspectRatio)
		-- 		if typeof(AspectRatioValue) == "number" then
		-- 			return New "UIAspectRatioConstraint" {
		-- 				AspectRatio = Props.AspectRatio,
		-- 				DominantAxis = Props.DominantAxis,
		-- 				AspectType = Props.AspectType,
		-- 			}
		-- 		else
		-- 			return
		-- 		end
		-- 	end, Fusion.cleanup),
		-- 	Computed(function()
		-- 		if (Props.MaxSize ~= nil) or (Props.MinSize ~= nil) then
		-- 			return New "UISizeConstraint" {
		-- 				MaxSize = Props.MaxSize,
		-- 				MinSize = Props.MinSize,
		-- 			}
		-- 		else
		-- 			return
		-- 		end
		-- 	end, Fusion.cleanup),
		-- 	Computed(function()
		-- 		if
		-- 			(typeof(Util.GetValue(Props.MaxTextSize)) == "number")
		-- 			or (typeof(Util.GetValue(Props.MinTextSize)) == "number")
		-- 		then
		-- 			return New "UITextSizeConstraint" {
		-- 				MaxTextSize = Props.MaxTextSize,
		-- 				MinTextSize = Props.MinTextSize,
		-- 			}
		-- 		else
		-- 			return
		-- 		end
		-- 	end, Fusion.cleanup),
		-- 	Computed(function()
		-- 		if Util.GetValue(Props.ListEnabled) == true then
		-- 			return New "UIListLayout" {
		-- 				Padding = ListPadding,
		-- 				FillDirection = Props.ListFillDirection,
		-- 				SortOrder = ListSortOrder,
		-- 				Wraps = Props.ListWraps,
		-- 				HorizontalAlignment = Props.ListHorizontalAlignment,
		-- 				HorizontalFlex = Props.ListHorizontalFlex,
		-- 				ItemLineAlignment = Props.ListItemLineAlignment,
		-- 				VerticalAlignment = Props.ListVerticalAlignment,
		-- 				VerticalFlex = Props.ListVerticalFlex,
		-- 			}
		-- 		else
		-- 			return
		-- 		end
		-- 	end, Fusion.cleanup),
		-- 	Computed(function()
		-- 		if Util.GetValue(Props.GridEnabled) then
		-- 			return New "UIGridLayout" {
		-- 				CellPadding = GridCellPadding,
		-- 				CellSize = Props.GridCellSize,
		-- 				FillDirection = Props.GridFillDirection,
		-- 				FillDirectionMaxCells = Props.GridFillDirectionMaxCells,
		-- 				SortOrder = GridSortOrder,
		-- 				StartCorner = Props.GridStartCorner,
		-- 				HorizontalAlignment = Props.GridHorizontalAlignment,
		-- 				VerticalAlignment = Props.GridVerticalAlignment,
		-- 			}
		-- 		else
		-- 			return
		-- 		end
		-- 	end, Fusion.cleanup),
		-- 	Computed(function()
		-- 		if Util.GetValue(Props.TableEnabled) then
		-- 			return New "UITableLayout" {
		-- 				Padding = TablePadding,
		-- 				FillEmptySpaceColumns = Props.TableFillEmptySpaceColumns,
		-- 				FillEmptySpaceRows = Props.TableFillEmptySpaceRows,
		-- 				FillDirection = Props.TableFillDirection,
		-- 				SortOrder = TableSortOrder,
		-- 				MajorAxis = Props.TableMajorAxis,
		-- 				HorizontalAlignment = Props.TableHorizontalAlignment,
		-- 				VerticalAlignment = Props.TableVerticalAlignment,
		-- 			}
		-- 		else
		-- 			return
		-- 		end
		-- 	end, Fusion.cleanup),
		-- 	Computed(function()
		-- 		if Util.GetValue(Props.PageEnabled) then
		-- 			return New "UIPageLayout" {
		-- 				Animated = Props.PageAnimated,
		-- 				Circular = Props.PageCircular,
		-- 				EasingDirection = Props.PageEasingDirection,
		-- 				EasingStyle = Props.PageEasingStyle,
		-- 				Padding = PagePadding,
		-- 				TweenTime = Props.PageTweenTime,
		-- 				FillDirection = Props.PageFillDirection,
		-- 				SortOrder = PageSortOrder,
		-- 				HorizontalAlignment = Props.PageHorizontalAlignment,
		-- 				VerticalAlignment = Props.PageVerticalAlignment,
		-- 				GamepadInputEnabled = Props.PageGamepadInputEnabled,
		-- 				ScrollWheelInputEnabled = Props.PageScrollWheelInputEnabled,
		-- 				TouchInputEnabled = Props.PageTouchInputEnabled,
		-- 			}
		-- 		else
		-- 			return
		-- 		end
		-- 	end, Fusion.cleanup),
		-- 	Computed(function()
		-- 		local FlexMode = Util.GetValue(Props.FlexMode)
		-- 		if (FlexMode ~= nil) and (FlexMode ~= Enum.UIFlexMode.None) then
		-- 			return New "UIFlexItem" {
		-- 				FlexMode = Props.FlexMode,
		-- 				FlexItemLineAlignment = Props.FlexItemLineAlignment,
		-- 				FlexGrowRatio = Props.FlexGrowRatio,
		-- 				FlexShrinkRatio = Props.FlexShrinkRatio,
		-- 			}
		-- 		else
		-- 			return
		-- 		end
		-- 	end, Fusion.cleanup),
		-- },
	}
end
