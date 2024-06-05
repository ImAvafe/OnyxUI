local OnyxUI = require(script.Parent.Parent)
local Fusion = require(OnyxUI.Packages.Fusion)
local PubTypes = require(script.Parent.Parent.PubTypes)
local EnsureValue = require(script.Parent.Parent.Utils.EnsureValue)
local Themer = require(script.Parent.Parent.Utils.Themer)
local GetValue = require(OnyxUI.Utils.GetValue)

local New = Fusion.New
local Computed = Fusion.Computed
local Children = Fusion.Children

export type BaseProps = {
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

return function(Props: BaseProps)
	local Name = EnsureValue(Props.Name, "string", "Base")
	local CornerRadius = EnsureValue(
		Props.CornerRadius,
		"UDim",
		Computed(function()
			return UDim.new(0, Themer.Theme.CornerRadius["1"]:get())
		end)
	)
	local StrokeThickness = EnsureValue(Props.StrokeThickness, "number", Themer.Theme.StrokeThickness["1"])
	local StrokeColor = EnsureValue(Props.StrokeColor, "Color3", Themer.Theme.Colors.Neutral.Main)
	local StrokeApplyStrokeMode = EnsureValue(Props.StrokeApplyStrokeMode, "EnumItem", Enum.ApplyStrokeMode.Border)
	local Padding = EnsureValue(
		Props.Padding,
		"UDim",
		Computed(function()
			return UDim.new(0, Themer.Theme.Spacing["1"]:get())
		end)
	)
	local PaddingBottom = EnsureValue(Props.PaddingBottom, "UDim", Props.Padding)
	local PaddingLeft = EnsureValue(Props.PaddingLeft, "UDim", Props.Padding)
	local PaddingRight = EnsureValue(Props.PaddingRight, "UDim", Props.Padding)
	local PaddingTop = EnsureValue(Props.PaddingTop, "UDim", Props.Padding)
	local ListPadding = EnsureValue(
		Props.ListPadding,
		"UDim",
		Computed(function()
			return Themer.Theme.Spacing["0.5"]:get()
		end)
	)
	local ListSortOrder = EnsureValue(Props.ListSortOrder, "EnumItem", Enum.SortOrder.LayoutOrder)
	local GridCellPadding = EnsureValue(
		Props.GridCellPadding,
		"UDim2",
		Computed(function()
			return UDim2.fromOffset(Themer.Theme.Spacing["0.5"]:get(), Themer.Theme.Spacing["0.5"]:get())
		end)
	)
	local GridSortOrder = EnsureValue(Props.GridSortOrder, "EnumItem", Enum.SortOrder.LayoutOrder)
	local PagePadding = EnsureValue(
		Props.PagePadding,
		"UDim",
		Computed(function()
			return UDim.new(0, Themer.Theme.Spacing["0.5"]:get())
		end)
	)
	local PageSortOrder = EnsureValue(Props.PageSortOrder, "EnumItem", Enum.SortOrder.LayoutOrder)
	local TablePadding = EnsureValue(
		Props.TablePadding,
		"UDim",
		Computed(function()
			return UDim.new(0, Themer.Theme.Spacing["0.5"]:get())
		end)
	)
	local TableSortOrder = EnsureValue(Props.TableSortOrder, "EnumItem", Enum.SortOrder.LayoutOrder)

	local PaddingInEffect = Computed(function()
		local Paddings = { Props.Padding, Props.PaddingTop, Props.PaddingLeft, Props.PaddingRight, Props.PaddingBottom }

		for _, PaddingProp in pairs(Paddings) do
			local PaddingValue = GetValue(PaddingProp)
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
								return GetValue(PaddingValue)
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
								return GetValue(PaddingValue)
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
								return GetValue(PaddingValue)
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
				local ScaleValue = GetValue(Props.Scale)
				if (typeof(ScaleValue) == "number") and (ScaleValue ~= 1) then
					return New "UIScale" {
						Scale = Props.Scale,
					}
				else
					return
				end
			end, Fusion.cleanup),
			Computed(function()
				if GetValue(Props.StrokeEnabled) == true then
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
				if GetValue(Props.GradientEnabled) == true then
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
				local AspectRatioValue = GetValue(Props.AspectRatio)
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
					(typeof(GetValue(Props.MaxTextSize)) == "number")
					or (typeof(GetValue(Props.MinTextSize)) == "number")
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
				if GetValue(Props.ListEnabled) == true then
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
				if GetValue(Props.GridEnabled) then
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
				if GetValue(Props.TableEnabled) then
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
				if GetValue(Props.PageEnabled) then
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
				local FlexMode = GetValue(Props.FlexMode)
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
