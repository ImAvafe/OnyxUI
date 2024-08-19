---
sidebar_position: 3
---

# Themer

Themer allows you to customize components throughout OnyxUI, with support for things like colors, corner radiuses, paddings, etc. You'll also probably want to incorporate it within your own UI for a more consistent design.

## Sample themes

- [OnyxNight](https://github.com/ImAvafe/OnyxUI/blob/main/src/Utils/Themer/OnyxNight.lua)
- [BitCave](https://github.com/ImAvafe/OnyxUI/blob/main/src/Utils/Themer/BitCave.lua)

## Making your own theme

:::tip
Check out the [`ThemeTemplate`](https://github.com/ImAvafe/OnyxUI/blob/main/src/Utils/Themer/ThemeTemplate.lua) file for a reference of properties you can specify in your theme. Make sure to not include Fusion `Value`s in yours.
:::

Once you've created your own theme, you can load it into OnyxUI with `Themer:Set()`.