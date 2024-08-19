---
sidebar_position: 4
---

# Util

Important utilities for UI development.

## [EnsureValue](/api/Util#EnsureValue)

Want to ensure your component props are Fusion `Value`s? This makes it a one-line operation.

```lua
local Util = require(OnyxUI.Util)

return function(Props)
  local MyProp = Util.EnsureValue(Props.MyProp, "string", "Default")
end
```

## [CombineProps](/api/Util#CombineProps)

Let's say you have a "CustomButton" component, and you want it to support `Size`, `Position`, and other arbitrary properties. Manually implementing all that boilerplate in the component itself is tedious. So let's have `CombineProps` do the passthrough for us:

```lua
local Util = require(OnyxUI.Util)

return function(Props)
  return BaseButton(Util.CombineProps(Props, {
    BackgroundTransparency = 0,
    CornerRadius = Computed(function()
      return UDim.new(0, Themer.Theme.CornerRadius["1"]:get())
    end),

    -- All properties from OnyxUI's `BaseButton` component will now work.
  }))
end
```

## [Colors](/api/Util#Colors)

Color shorthands imported from [TailwindCSS's color palette](https://tailwindcss.com/docs/customizing-colors#default-color-palette). So you don't have to worry about color picking anymore.

```lua
local Util = require(OnyxUI.Util)

return function(Props)
  return Button {
    Color = Util.Colors.Red["500"], -- Shade "500" of Colors.Red
  }
end
```