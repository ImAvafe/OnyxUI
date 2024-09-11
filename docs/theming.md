---
sidebar_position: 3
---

# Theming

OnyxUI handles theming through a module called [`Themer`](/api/Themer). Themer allows you to customize components throughout OnyxUI, with support for things like colors, corner radiuses, paddings, etc. You'll also probably want to reference it within your own UI for a more consistent design.

## Sample themes

- [OnyxNight](https://github.com/ImAvafe/OnyxUI/blob/main/src/Themer/OnyxNight.luau) - *The default theme*
- [BitCave](https://github.com/ImAvafe/OnyxUI/blob/main/samples/Themes/BitCave.luau)

## Making your own theme

:::tip
Check out [ThemeSpec.luau](https://github.com/ImAvafe/OnyxUI/blob/main/src/Themer/ThemeSpec.luau) for a full reference of available theme properties.
:::

1. Copy the following code into a new "`MyTheme`" module
  ```lua
  local Themer = OnyxUI.Themer
  local Scoped = Fusion.scoped

  local Scope = Scoped()

  local MyTheme = Themer.NewTheme(Scope, {
    -- Specify theme properties here
  })

  return MyTheme
  ```
2. Specify the properties you want
3. Use it when constructing your UI
  ```lua
  local MyTheme = require(path.to.MyTheme)

  local Themer = OnyxUI.Themer

  Themer.Theme:is(MyTheme):during(function()
    local Theme = Themer.Theme:now() -- This now returns MyTheme!
    -- Any UI constructed from this callback will also use MyTheme.
  end)
  ```