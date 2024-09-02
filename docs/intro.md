---
sidebar_position: 1
---

# Getting Started

:::info Premature
  OnyxUI is premature software, relying on the premature software Fusion. It will, at times, *move fast and break things™️*. If that doesn't deter you, get ready to enjoy how easy UI can be. ✨
:::

:::info Fusion 0.2.0
OnyxUI currently only supports Fusion 0.2. 0.3 support is still in the works.
:::

## Installation

### Wally package

1. Copy the [Wally details](https://wally.run/package/imavafe/onyx-ui)
2. Paste it into your `wally.toml` dependencies
3. Run `wally install`

### Roblox model

1. Download the `OnyxUI.rbxm` file [listed here](https://github.com/ImAvafe/OnyxUI/releases/latest)
2. Insert `OnyxUI.rbxm` into Roblox Studio

## Project structure

OnyxUI is structured as a collection of modules. This is unconventional, but necessary for exposing types so you can properly build off of OnyxUI. Here's a basic usage sample below:

```lua
local OnyxUI = require(path.to.OnyxUI)
local Themer = require(OnyxUI.Themer)
local Util = require(OnyxUI.Util)

-- Components
local Card = require(OnyxUI.Components.Card)

-- Types
export type Props = Card.Props & {} -- This wouldn't work if Card wasn't required directly.

-- Component construction
return function(Props: Props)
  return Card {
    BackgroundColor3 = Util.Colors.Gray["200"],
    Padding = Computed(function()
      return UDim.new(0, Themer.Theme.Spacing["2"]:get())
    end),
  }
end
```

## [See it in action ✨](in-production.md)