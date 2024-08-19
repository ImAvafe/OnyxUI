---
sidebar_position: 3
---

# Utils

Important utilities for UI development. These are also used by OnyxUI itself!

## Themer

Themer allows you to customize components throughout OnyxUI, with support for things like colors, corner radiuses, paddings, etc. You'll also probably want to incorporate it within your own UI for a more consistent design.

### Default themes

Some themes are included by default, which can be seen here:

- [OnyxNight](https://github.com/ImAvafe/OnyxUI/blob/main/src/Utils/Themer/OnyxNight.lua)
- [BitCave](https://github.com/ImAvafe/OnyxUI/blob/main/src/Utils/Themer/BitCave.lua)

### Making your own theme

:::tip
Check out the [`ThemeTemplate`](https://github.com/ImAvafe/OnyxUI/blob/main/src/Utils/Themer/ThemeTemplate.lua) file for a reference of properties you can specify in your theme.
:::

Once you've created your own theme, you can load it into OnyxUI with `Themer:Set()`.

## EnsureValue

Want to ensure your component props are Fusion `Value`s? This makes it a one-line operation.

```lua
return function(Props)
  local MyProp = EnsureValue(Props.MyProp, "string", "Default")
```

## CombineProps

Let's say you have a "CustomButton" component, and you want it to support `Size`, `Position`, and other arbitrary properties. Manually implementing all that boilerplate in the component itself is tedious. So let's take advantage of `CombineProps` to do the passthrough for us:

```lua
return function(Props)
  return BaseButton(CombineProps(Props, {
    BackgroundTransparency = 0,
    CornerRadius = Computed(function()
      return UDim.new(0, Themer.Theme.CornerRadius["1"]:get())
    end),

    -- All properties from OnyxUI's `Base` component will now work.
  }))
```

## Colors

Color shorthands imported from [TailwindCSS's color palette](https://tailwindcss.com/docs/customizing-colors#default-color-palette). So you don't have to worry about color picking anymore.