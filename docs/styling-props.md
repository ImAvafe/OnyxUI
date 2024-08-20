---
sidebar_position: 4
---

# Styling Props

Styling props are globally supported props for styling UI. These aim to stay close to Roblox's way of doing things, but differ when necessary, most notably in children-based styling.

:::tip
Styling props are powered by the [`Base`](/api/Base) component. For type references, read its source code.
:::

## Property-based styling

Traditional [`GuiObject`](https://create.roblox.com/docs/reference/engine/classes/GuiObject) properties like [`BackgroundColor3`](https://create.roblox.com/docs/reference/engine/classes/GuiObject#BackgroundColor3) are supported identically to how Roblox does it. Use these as you would normally. There are exceptions however, like how `Color` is preferred over `BackgroundColor3` in [`Button`](/api/Button).

## Children-based styling

`UIPadding`s, `UIStroke`s, `UIListLayout`s... Children-based styling is just too much boilerplate. In OnyxUI, all components support an extensive set of props to *avoid* working with these objects. See references below:

### Basics

| Roblox 🤓 | OnyxUI 😎 |
|-----|-----|
|`UICorner`|`CornerRadius`|
|`UIPadding`|`Padding`, `PaddingTop`, `PaddingLeft`, `PaddingRight`, `PaddingBottom`|
|`UIStroke`|`StrokeEnabled`, `StrokeThickness`, `StrokeColor`, `StrokeTransparency`, `StrokeLineJoinMode`, `StrokeApplyStrokeMode`|
|`UIGradient`|`GradientEnabled`, `GradientColor`, `GradientOffset`, `GradientRotation`, `GradientTransparency`|


### Layouts

| Roblox 🤓 | OnyxUI 😎 |
|-----|-----|
|`UIFlexItem`|`FlexMode`, `FlexItemLineAlignment`, `FlexGrowRatio`, `FlexShrinkRatio`|
|`UIListLayout`|`ListEnabled`, `ListPadding`, `ListFillDirection`, `ListSortOrder`, `ListWraps`, `ListHorizontalAlignment`, `ListHorizontalFlex`, `ListVerticalAlignment`, `ListVerticalFlex`, `ListItemLineAlignment`|
|`UIGridLayout`|`GridEnabled`, `GridFillDirection`, `GridFillDirectionMaxCells`, `GridCellPadding`, `GridCellSize`, `GridSortOrder`, `GridStartCorner`, `GridHorizontalAlignment`, `GridVerticalAlignment`|

*For other layouts like `UITableLayout` and `UIPageLayout`, see the [`Base`](/api/Base) component's source code.*

### Constraints

| Roblox 🤓 | OnyxUI 😎 |
|-----|-----|
|`UIAspectRatioConstraint`|`AspectRatio`, `AspectType`, `DominantAxis`|
|`UISizeConstraint`|`MaxSize`, `MinSize`|
|`UITextSizeConstraint`|`MaxTextSize`, `MinTextSize`|

## Use in custom components

To support styling props in your own components, make use of the [`CombineProps`](/docs/utilities#combineprops) utility to pass props through automatically. Your component must be based upon an OnyxUI component such as [`Base`](/api/Base) for this to work.