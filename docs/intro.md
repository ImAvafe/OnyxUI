---
sidebar_position: 1
---

# Getting Started

## Installation

### Wally package

1. Copy the [Wally details](https://wally.run/package/imavafe/onyx-ui)
2. Paste it into your `wally.toml` dependencies
3. Run `wally install`

### Roblox model

1. Download the `OnyxUI.rbxm` file [listed here](https://github.com/ImAvafe/OnyxUI/releases/latest)
2. Insert `OnyxUI.rbxm` into Roblox Studio

## Project structure

OnyxUI is structured as a collection of modules, separated by folders. This is unconventional, but necessary for exposing types so you can properly build off of OnyxUI. Here's a basic usage sample below:

```lua
local OnyxUI = require(path.to.OnyxUI)

-- Util
local Themer = require(OnyxUI.Themer)
local Util = require(OnyxUI.Util)

-- Components
local Card = require(OnyxUI.Components.Card)

-- Component construction
return function()
  return Card {
    BackgroundColor3 = Util.Colors.Gray["200"],
    Padding = Computed(function()
      return UDim.new(0, Themer.Theme.Spacing["2"]:get())
    end),
  }
end
```