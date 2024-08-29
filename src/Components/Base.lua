--[=[
		@class Base

		The foundational component of OnyxUI, from which all other components are built off of. Props supported here typically work in all other components.

		:::info Where are the props?
		View the [source code](https://github.com/ImAvafe/OnyxUI/blob/main/src/Components/Base.lua) to see all supported props.
		:::
		:::info Styling props
		A reference of common styling props can be found in [this docs page](/docs/styling-props).
		:::
]=]

local OnyxUI = script.Parent.Parent
local Fusion = require(OnyxUI.Parent.Fusion)
local PubTypes = require(OnyxUI.Util.PubTypes)
local Util = require(OnyxUI.Util)
local Themer = require(OnyxUI.Themer)

local New = Fusion.New
local Computed = Fusion.Computed
local Children = Fusion.Children

export type Props = {
	ClassName: string?,

	Name: PubTypes.CanBeState<string>?,
	Parent: PubTypes.CanBeState<Instance>?,
	Position: PubTypes.CanBeState<UDim2>?,
	Rotation: PubTypes.CanBeState<number>?,
	AnchorPoint: PubTypes.CanBeState<Vector2>?,
	Size: PubTypes.CanBeState<UDim2>?,
	AutomaticSize: PubTypes.CanBeState<Enum.AutomaticSize>?,
	Visible: PubTypes.CanBeState<boolean>?,
	ZIndex: PubTypes.CanBeState<number>?,
	LayoutOrder: PubTypes.CanBeState<number>?,
	ClipsDescendants: PubTypes.CanBeState<boolean>?,
	Active: PubTypes.CanBeState<boolean>?,
	Selectable: PubTypes.CanBeState<boolean>?,
	Interactable: PubTypes.CanBeState<boolean>?,
	BackgroundColor3: PubTypes.CanBeState<Color3>?,
	BackgroundTransparency: PubTypes.CanBeState<number>?,
	NextSelectionDown: PubTypes.CanBeState<GuiObject>?,
	NextSelectionUp: PubTypes.CanBeState<GuiObject>?,
	NextSelectionRight: PubTypes.CanBeState<GuiObject>?,
	NextSelectionLeft: PubTypes.CanBeState<GuiObject>?,
	SelectionImageObject: PubTypes.CanBeState<GuiObject>?,
	SelectionOrder: PubTypes.CanBeState<number>?,
	SizeConstraint: PubTypes.CanBeState<Enum.SizeConstraint>?,
	AutoLocalize: PubTypes.CanBeState<boolean>?,
	RootLocalizationTable: PubTypes.CanBeState<LocalizationTable>?,
	SelectionBehaviorDown: PubTypes.CanBeState<Enum.SelectionBehavior>?,
	SelectionBehaviorUp: PubTypes.CanBeState<Enum.SelectionBehavior>?,
	SelectionBehaviorRight: PubTypes.CanBeState<Enum.SelectionBehavior>?,
	SelectionBehaviorLeft: PubTypes.CanBeState<Enum.SelectionBehavior>?,
	SelectionGroup: PubTypes.CanBeState<boolean>?,

	CornerRadius: PubTypes.CanBeState<UDim>?,

	Padding: PubTypes.CanBeState<UDim>?,
	PaddingTop: PubTypes.CanBeState<UDim>?,
	PaddingLeft: PubTypes.CanBeState<UDim>?,
	PaddingRight: PubTypes.CanBeState<UDim>?,
	PaddingBottom: PubTypes.CanBeState<UDim>?,

	Scale: PubTypes.CanBeState<number>?,

	StrokeEnabled: PubTypes.CanBeState<boolean>?,
	StrokeThickness: PubTypes.CanBeState<number>?,
	StrokeColor: PubTypes.CanBeState<Color3>?,
	StrokeTransparency: PubTypes.CanBeState<number>?,
	StrokeLineJoinMode: PubTypes.CanBeState<Enum.LineJoinMode>?,
	StrokeApplyStrokeMode: PubTypes.CanBeState<Enum.ApplyStrokeMode>?,

	GradientEnabled: PubTypes.CanBeState<boolean>?,
	GradientColor: PubTypes.CanBeState<ColorSequence>?,
	GradientOffset: PubTypes.CanBeState<UDim>?,
	GradientRotation: PubTypes.CanBeState<number>?,
	GradientTransparency: PubTypes.CanBeState<number>?,

	AspectRatio: PubTypes.CanBeState<number>?,
	AspectType: PubTypes.CanBeState<Enum.AspectType>?,
	DominantAxis: PubTypes.CanBeState<Enum.DominantAxis>?,

	ListEnabled: PubTypes.CanBeState<boolean>?,
	ListPadding: PubTypes.CanBeState<UDim>?,
	ListFillDirection: PubTypes.CanBeState<Enum.FillDirection>?,
	ListSortOrder: PubTypes.CanBeState<Enum.SortOrder>?,
	ListWraps: PubTypes.CanBeState<boolean>?,
	ListHorizontalAlignment: PubTypes.CanBeState<Enum.HorizontalAlignment>?,
	ListHorizontalFlex: PubTypes.CanBeState<boolean>?,
	ListVerticalAlignment: PubTypes.CanBeState<Enum.VerticalAlignment>?,
	ListVerticalFlex: PubTypes.CanBeState<boolean>?,
	ListItemLineAlignment: PubTypes.CanBeState<Enum.ItemLineAlignment>?,

	GridEnabled: PubTypes.CanBeState<boolean>?,
	GridCellPadding: PubTypes.CanBeState<UDim>?,
	GridCellSize: PubTypes.CanBeState<UDim2>?,
	GridFillDirection: PubTypes.CanBeState<Enum.FillDirection>?,
	GridFillDirectionMaxCells: PubTypes.CanBeState<number>?,
	GridSortOrder: PubTypes.CanBeState<Enum.SortOrder>?,
	GridStartCorner: PubTypes.CanBeState<Enum.StartCorner>?,
	GridHorizontalAlignment: PubTypes.CanBeState<Enum.HorizontalAlignment>?,
	GridVerticalAlignment: PubTypes.CanBeState<Enum.VerticalAlignment>?,

	TableEnabled: PubTypes.CanBeState<boolean>?,
	TablePadding: PubTypes.CanBeState<UDim>?,
	TableFillEmptySpaceColumns: PubTypes.CanBeState<boolean>?,
	TableFillEmptySpaceRows: PubTypes.CanBeState<boolean>?,
	TableFillDirection: PubTypes.CanBeState<Enum.FillDirection>?,
	TableSortOrder: PubTypes.CanBeState<Enum.SortOrder>?,
	TableMajorAxis: PubTypes.CanBeState<Enum.TableMajorAxis>?,
	TableHorizontalAlignment: PubTypes.CanBeState<Enum.HorizontalAlignment>?,
	TableVerticalAlignment: PubTypes.CanBeState<Enum.VerticalAlignment>?,

	PageEnabled: PubTypes.CanBeState<boolean>?,
	PageAnimated: PubTypes.CanBeState<boolean>?,
	PageCircular: PubTypes.CanBeState<boolean>?,
	PageEasingDirection: PubTypes.CanBeState<Enum.EasingDirection>?,
	PageEasingStyle: PubTypes.CanBeState<Enum.EasingStyle>?,
	PagePadding: PubTypes.CanBeState<UDim>?,
	PageTweenTime: PubTypes.CanBeState<number>?,
	PageFillDirection: PubTypes.CanBeState<Enum.FillDirection>?,
	PageSortOrder: PubTypes.CanBeState<Enum.SortOrder>?,
	PageHorizontalAlignment: PubTypes.CanBeState<Enum.HorizontalAlignment>?,
	PageVerticalAlignment: PubTypes.CanBeState<Enum.VerticalAlignment>?,
	PageGamepadInputEnabled: PubTypes.CanBeState<boolean>?,
	PageScrollWheelInputEnabled: PubTypes.CanBeState<boolean>?,
	PageTouchInputEnabled: PubTypes.CanBeState<boolean>?,

	FlexMode: PubTypes.CanBeState<Enum.UIFlexMode>?,
	FlexItemLineAlignment: PubTypes.CanBeState<Enum.ItemLineAlignment>?,
	FlexGrowRatio: PubTypes.CanBeState<number>?,
	FlexShrinkRatio: PubTypes.CanBeState<number>?,

	MaxSize: PubTypes.CanBeState<Vector2>?,
	MinSize: PubTypes.CanBeState<Vector2>?,

	MaxTextSize: PubTypes.CanBeState<number>?,
	MinTextSize: PubTypes.CanBeState<number>?,
}

--[=[
	@within Base
	@interface BaseProps

	@field ... BaseProps
	
	@field ClassName string?
	@field Name CanBeState<string>?
	@field Parent CanBeState<Instance>?
	@field Position CanBeState<UDim2>?
	@field Rotation CanBeState<number>?
	@field AnchorPoint CanBeState<Vector2>?
	@field Size CanBeState<UDim2>?
	@field AutomaticSize CanBeState<Enum.AutomaticSize>?
	@field Visible CanBeState<boolean>?
	@field ZIndex CanBeState<number>?
	@field LayoutOrder CanBeState<number>?
	@field ClipsDescendants CanBeState<boolean>?
	@field Active CanBeState<boolean>?
	@field Selectable CanBeState<boolean>?
	@field Interactable CanBeState<boolean>?
	@field BackgroundColor3 CanBeState<Color3>?
	@field BackgroundTransparency CanBeState<number>?
	@field NextSelectionDown CanBeState<GuiObject>?
	@field NextSelectionUp CanBeState<GuiObject>?
	@field NextSelectionRight CanBeState<GuiObject>?
	@field NextSelectionLeft CanBeState<GuiObject>?
	@field SelectionImageObject CanBeState<GuiObject>?
	@field SelectionOrder CanBeState<number>?
	@field SizeConstraint CanBeState<Enum.SizeConstraint>?
	@field AutoLocalize CanBeState<boolean>?
	@field RootLocalizationTable CanBeState<LocalizationTable>?
	@field SelectionBehaviorDown CanBeState<Enum.SelectionBehavior>?
	@field SelectionBehaviorUp CanBeState<Enum.SelectionBehavior>?
	@field SelectionBehaviorRight CanBeState<Enum.SelectionBehavior>?
	@field SelectionBehaviorLeft CanBeState<Enum.SelectionBehavior>?
	@field SelectionGroup CanBeState<boolean>?
	@field CornerRadius CanBeState<UDim>?
	@field Padding CanBeState<UDim>?
	@field PaddingTop CanBeState<UDim>?
	@field PaddingLeft CanBeState<UDim>?
	@field PaddingRight CanBeState<UDim>?
	@field PaddingBottom CanBeState<UDim>?
	@field Scale CanBeState<number>?
	@field StrokeEnabled CanBeState<boolean>?
	@field StrokeThickness CanBeState<number>?
	@field StrokeColor CanBeState<Color3>?
	@field StrokeTransparency CanBeState<number>?
	@field StrokeLineJoinMode CanBeState<Enum.LineJoinMode>?
	@field StrokeApplyStrokeMode CanBeState<Enum.ApplyStrokeMode>?
	@field GradientEnabled CanBeState<boolean>?
	@field GradientColor CanBeState<ColorSequence>?
	@field GradientOffset CanBeState<UDim>?
	@field GradientRotation CanBeState<number>?
	@field GradientTransparency CanBeState<number>?
	@field AspectRatio CanBeState<number>?
	@field AspectType CanBeState<Enum.AspectType>?
	@field DominantAxis CanBeState<Enum.DominantAxis>?
	@field ListEnabled CanBeState<boolean>?
	@field ListPadding CanBeState<UDim>?
	@field ListFillDirection CanBeState<Enum.FillDirection>?
	@field ListSortOrder CanBeState<Enum.SortOrder>?
	@field ListWraps CanBeState<boolean>?
	@field ListHorizontalAlignment CanBeState<Enum.HorizontalAlignment>?
	@field ListHorizontalFlex CanBeState<boolean>?
	@field ListVerticalAlignment CanBeState<Enum.VerticalAlignment>?
	@field ListVerticalFlex CanBeState<boolean>?
	@field ListItemLineAlignment CanBeState<Enum.ItemLineAlignment>?
	@field GridEnabled CanBeState<boolean>?
	@field GridCellPadding CanBeState<UDim>?
	@field GridCellSize CanBeState<UDim2>?
	@field GridFillDirection CanBeState<Enum.FillDirection>?
	@field GridFillDirectionMaxCells CanBeState<number>?
	@field GridSortOrder CanBeState<Enum.SortOrder>?
	@field GridStartCorner CanBeState<Enum.StartCorner>?
	@field GridHorizontalAlignment CanBeState<Enum.HorizontalAlignment>?
	@field GridVerticalAlignment CanBeState<Enum.VerticalAlignment>?
	@field TableEnabled CanBeState<boolean>?
	@field TablePadding CanBeState<UDim>?
	@field TableFillEmptySpaceColumns CanBeState<boolean>?
	@field TableFillEmptySpaceRows CanBeState<boolean>?
	@field TableFillDirection CanBeState<Enum.FillDirection>?
	@field TableSortOrder CanBeState<Enum.SortOrder>?
	@field TableMajorAxis CanBeState<Enum.TableMajorAxis>?
	@field TableHorizontalAlignment CanBeState<Enum.HorizontalAlignment>?
	@field TableVerticalAlignment CanBeState<Enum.VerticalAlignment>?
	@field PageEnabled CanBeState<boolean>?
	@field PageAnimated CanBeState<boolean>?
	@field PageCircular CanBeState<boolean>?
	@field PageEasingDirection CanBeState<Enum.EasingDirection>?
	@field PageEasingStyle CanBeState<Enum.EasingStyle>?
	@field PagePadding CanBeState<UDim>?
	@field PageTweenTime CanBeState<number>?
	@field PageFillDirection CanBeState<Enum.FillDirection>?
	@field PageSortOrder CanBeState<Enum.SortOrder>?
	@field PageHorizontalAlignment CanBeState<Enum.HorizontalAlignment>?
	@field PageVerticalAlignment CanBeState<Enum.VerticalAlignment>?
	@field PageGamepadInputEnabled CanBeState<boolean>?
	@field PageScrollWheelInputEnabled CanBeState<boolean>?
	@field PageTouchInputEnabled CanBeState<boolean>?
	@field FlexMode CanBeState<Enum.UIFlexMode>?
	@field FlexItemLineAlignment CanBeState<Enum.ItemLineAlignment>?
	@field FlexGrowRatio CanBeState<number>?
	@field FlexShrinkRatio CanBeState<number>?
	@field MaxSize CanBeState<Vector2>?
	@field MinSize CanBeState<Vector2>?
	@field MaxTextSize CanBeState<number>?
	@field MinTextSize CanBeState<number>?
]=]
return function(Props: Props): GuiObject
	local Name = Util.EnsureValue(Props.Name, "string", "Base")
	local CornerRadius = Util.EnsureValue(
		Props.CornerRadius,
		"UDim",
		Computed(function()
			return UDim.new(0, 0)
		end)
	)
	local StrokeThickness = Util.EnsureValue(Props.StrokeThickness, "number", Themer.Theme.StrokeThickness["1"])
	local StrokeColor = Util.EnsureValue(Props.StrokeColor, "Color3", Themer.Theme.Colors.Neutral.Main)
	local StrokeApplyStrokeMode = Util.EnsureValue(Props.StrokeApplyStrokeMode, "EnumItem", Enum.ApplyStrokeMode.Border)
	local Padding = Util.EnsureValue(
		Props.Padding,
		"UDim",
		Computed(function()
			return UDim.new(0, Themer.Theme.Spacing["1"]:get())
		end)
	)
	local PaddingBottom = Util.EnsureValue(Props.PaddingBottom, "UDim", Props.Padding)
	local PaddingLeft = Util.EnsureValue(Props.PaddingLeft, "UDim", Props.Padding)
	local PaddingRight = Util.EnsureValue(Props.PaddingRight, "UDim", Props.Padding)
	local PaddingTop = Util.EnsureValue(Props.PaddingTop, "UDim", Props.Padding)
	local ListPadding = Util.EnsureValue(
		Props.ListPadding,
		"UDim",
		Computed(function()
			return UDim.new(0, Themer.Theme.Spacing["1"]:get())
		end)
	)
	local ListSortOrder = Util.EnsureValue(Props.ListSortOrder, "EnumItem", Enum.SortOrder.LayoutOrder)
	local GridCellPadding = Util.EnsureValue(
		Props.GridCellPadding,
		"UDim2",
		Computed(function()
			return UDim2.fromOffset(Themer.Theme.Spacing["0.5"]:get(), Themer.Theme.Spacing["0.5"]:get())
		end)
	)
	local GridSortOrder = Util.EnsureValue(Props.GridSortOrder, "EnumItem", Enum.SortOrder.LayoutOrder)
	local PagePadding = Util.EnsureValue(
		Props.PagePadding,
		"UDim",
		Computed(function()
			return UDim.new(0, Themer.Theme.Spacing["0.5"]:get())
		end)
	)
	local PageSortOrder = Util.EnsureValue(Props.PageSortOrder, "EnumItem", Enum.SortOrder.LayoutOrder)
	local TablePadding = Util.EnsureValue(
		Props.TablePadding,
		"UDim",
		Computed(function()
			return UDim.new(0, Themer.Theme.Spacing["0.5"]:get())
		end)
	)
	local TableSortOrder = Util.EnsureValue(Props.TableSortOrder, "EnumItem", Enum.SortOrder.LayoutOrder)

	local PaddingInEffect = Computed(function()
		local Paddings = { Props.Padding, Props.PaddingTop, Props.PaddingLeft, Props.PaddingRight, Props.PaddingBottom }

		for _, PaddingProp in pairs(Paddings) do
			local PaddingValue = Util.GetValue(PaddingProp)
			if typeof(PaddingValue) == "UDim" then
				return true
			end
		end

		return false
	end)

	return New(Props.ClassName or "Frame") {
		Name = Name,

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

		[Children] = {
			Props[Children],

			Computed(function()
				local CornerRadiusValue = CornerRadius:get()
				if
					(typeof(CornerRadiusValue) == "UDim")
					and ((CornerRadiusValue.Offset ~= 0) or (CornerRadiusValue.Scale ~= 0))
				then
					return New "UICorner" {
						CornerRadius = CornerRadius,
					}
				else
					return
				end
			end, Fusion.cleanup),
			Computed(function()
				if PaddingInEffect:get() == true then
					return New "UIPadding" {
						PaddingTop = Computed(function()
							local PaddingTopValue = PaddingTop:get()
							local PaddingValue = Padding:get()
							if typeof(PaddingTopValue) == "UDim" then
								return PaddingTopValue
							elseif typeof(PaddingValue) == "UDim" then
								return PaddingValue
							else
								return UDim.new()
							end
						end),
						PaddingLeft = Computed(function()
							local PaddingLeftValue = PaddingLeft:get()
							local PaddingValue = Padding:get()
							if typeof(PaddingLeftValue) == "UDim" then
								return PaddingLeftValue
							elseif typeof(PaddingValue) == "UDim" then
								return Util.GetValue(PaddingValue)
							else
								return UDim.new()
							end
						end),
						PaddingRight = Computed(function()
							local PaddingRightValue = PaddingRight:get()
							local PaddingValue = Padding:get()
							if typeof(PaddingRightValue) == "UDim" then
								return PaddingRightValue
							elseif typeof(PaddingValue) == "UDim" then
								return Util.GetValue(PaddingValue)
							else
								return UDim.new()
							end
						end),
						PaddingBottom = Computed(function()
							local PaddingBottomValue = PaddingBottom:get()
							local PaddingValue = Padding:get()
							if typeof(PaddingBottomValue) == "UDim" then
								return PaddingBottomValue
							elseif typeof(PaddingValue) == "UDim" then
								return Util.GetValue(PaddingValue)
							else
								return UDim.new()
							end
						end),
					}
				else
					return
				end
			end, Fusion.cleanup),
			Computed(function()
				local ScaleValue = Util.GetValue(Props.Scale)
				if (typeof(ScaleValue) == "number") and (ScaleValue ~= 1) then
					return New "UIScale" {
						Scale = Props.Scale,
					}
				else
					return
				end
			end, Fusion.cleanup),
			Computed(function()
				if Util.GetValue(Props.StrokeEnabled) == true then
					return New "UIStroke" {
						Enabled = Props.StrokeEnabled,
						Thickness = StrokeThickness,
						Color = StrokeColor,
						Transparency = Props.StrokeTransparency,
						ApplyStrokeMode = StrokeApplyStrokeMode,
						LineJoinMode = Props.StrokeLineJoinMode,
					}
				else
					return
				end
			end, Fusion.cleanup),
			Computed(function()
				if Util.GetValue(Props.GradientEnabled) == true then
					return New "UIGradient" {
						Enabled = Props.GradientEnabled,
						Color = Props.GradientColor,
						Offset = Props.GradientOffset,
						Rotation = Props.GradientRotation,
						Transparency = Props.GradientTransparency,
					}
				else
					return
				end
			end, Fusion.cleanup),
			Computed(function()
				local AspectRatioValue = Util.GetValue(Props.AspectRatio)
				if typeof(AspectRatioValue) == "number" then
					return New "UIAspectRatioConstraint" {
						AspectRatio = Props.AspectRatio,
						DominantAxis = Props.DominantAxis,
						AspectType = Props.AspectType,
					}
				else
					return
				end
			end, Fusion.cleanup),
			Computed(function()
				if (Props.MaxSize ~= nil) or (Props.MinSize ~= nil) then
					return New "UISizeConstraint" {
						MaxSize = Props.MaxSize,
						MinSize = Props.MinSize,
					}
				else
					return
				end
			end, Fusion.cleanup),
			Computed(function()
				if
					(typeof(Util.GetValue(Props.MaxTextSize)) == "number")
					or (typeof(Util.GetValue(Props.MinTextSize)) == "number")
				then
					return New "UITextSizeConstraint" {
						MaxTextSize = Props.MaxTextSize,
						MinTextSize = Props.MinTextSize,
					}
				else
					return
				end
			end, Fusion.cleanup),
			Computed(function()
				if Util.GetValue(Props.ListEnabled) == true then
					return New "UIListLayout" {
						Padding = ListPadding,
						FillDirection = Props.ListFillDirection,
						SortOrder = ListSortOrder,
						Wraps = Props.ListWraps,
						HorizontalAlignment = Props.ListHorizontalAlignment,
						HorizontalFlex = Props.ListHorizontalFlex,
						ItemLineAlignment = Props.ListItemLineAlignment,
						VerticalAlignment = Props.ListVerticalAlignment,
						VerticalFlex = Props.ListVerticalFlex,
					}
				else
					return
				end
			end, Fusion.cleanup),
			Computed(function()
				if Util.GetValue(Props.GridEnabled) then
					return New "UIGridLayout" {
						CellPadding = GridCellPadding,
						CellSize = Props.GridCellSize,
						FillDirection = Props.GridFillDirection,
						FillDirectionMaxCells = Props.GridFillDirectionMaxCells,
						SortOrder = GridSortOrder,
						StartCorner = Props.GridStartCorner,
						HorizontalAlignment = Props.GridHorizontalAlignment,
						VerticalAlignment = Props.GridVerticalAlignment,
					}
				else
					return
				end
			end, Fusion.cleanup),
			Computed(function()
				if Util.GetValue(Props.TableEnabled) then
					return New "UITableLayout" {
						Padding = TablePadding,
						FillEmptySpaceColumns = Props.TableFillEmptySpaceColumns,
						FillEmptySpaceRows = Props.TableFillEmptySpaceRows,
						FillDirection = Props.TableFillDirection,
						SortOrder = TableSortOrder,
						MajorAxis = Props.TableMajorAxis,
						HorizontalAlignment = Props.TableHorizontalAlignment,
						VerticalAlignment = Props.TableVerticalAlignment,
					}
				else
					return
				end
			end, Fusion.cleanup),
			Computed(function()
				if Util.GetValue(Props.PageEnabled) then
					return New "UIPageLayout" {
						Animated = Props.PageAnimated,
						Circular = Props.PageCircular,
						EasingDirection = Props.PageEasingDirection,
						EasingStyle = Props.PageEasingStyle,
						Padding = PagePadding,
						TweenTime = Props.PageTweenTime,
						FillDirection = Props.PageFillDirection,
						SortOrder = PageSortOrder,
						HorizontalAlignment = Props.PageHorizontalAlignment,
						VerticalAlignment = Props.PageVerticalAlignment,
						GamepadInputEnabled = Props.PageGamepadInputEnabled,
						ScrollWheelInputEnabled = Props.PageScrollWheelInputEnabled,
						TouchInputEnabled = Props.PageTouchInputEnabled,
					}
				else
					return
				end
			end, Fusion.cleanup),
			Computed(function()
				local FlexMode = Util.GetValue(Props.FlexMode)
				if (FlexMode ~= nil) and (FlexMode ~= Enum.UIFlexMode.None) then
					return New "UIFlexItem" {
						FlexMode = Props.FlexMode,
						FlexItemLineAlignment = Props.FlexItemLineAlignment,
						FlexGrowRatio = Props.FlexGrowRatio,
						FlexShrinkRatio = Props.FlexShrinkRatio,
					}
				else
					return
				end
			end, Fusion.cleanup),
		},
	}
end
