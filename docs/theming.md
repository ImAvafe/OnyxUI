---
sidebar_position: 3
---

# Theming

OnyxUI handles theming through a module called [`Themer`](/api/Themer). Themer allows you to customize components throughout OnyxUI, with support for things like colors, corner radiuses, paddings, etc. You'll also probably want to incorporate it within your own UI for a more consistent design.

:::info Contextual theming
Themer cannot currently handle having two separate themes active at once. This is due to Fusion's lack of a contexts feature. If you need this functionality, you'll need to have separate installs of OnyxUI.
:::

## Sample themes

- [OnyxNight](https://github.com/ImAvafe/OnyxUI/blob/main/src/Themer/OnyxNight.lua) - *The default theme*
- [BitCave](https://github.com/ImAvafe/OnyxUI/blob/main/src/Themer/BitCave.lua)

## Making your own theme

:::tip
Check out the [`ThemeTemplate`](https://github.com/ImAvafe/OnyxUI/blob/main/src/Themer/ThemeTemplate.lua) file for a reference of properties you can specify in your theme. Make sure to not include any Fusion `Value`s in yours.
:::

1. Copy the following code into a new "`MyTheme`" module
  ```lua
  local Themer = require(OnyxUI.Themer)

  local Theme: Themer.Theme = {

  }

  return Theme
  ```
1. Specify properties you want within your `Theme` table
2. Load it into OnyxUI with [`Themer:Set(Theme)`](/api/Themer#Set)