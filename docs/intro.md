---
sidebar_position: 1
---

# Getting Started

:::info Premature
  OnyxUI is premature software, relying on the premature software Fusion. It will, at times, *move fast and break things™️*. If that doesn't deter you, get ready to enjoy how easy UI can be. ✨
:::

:::info Fusion 0.2 users:
While it's recommended to use Fusion 0.3, OnyxUI offers [an old version](https://github.com/ImAvafe/OnyxUI/releases/tag/0.3.0) for Fusion 0.2. It will not receive any updates, and lacks the major improvements of newer OnyxUI versions.
:::

## Installation

### Wally package

1. Copy the [Wally details](https://wally.run/package/imavafe/onyx-ui)
2. Paste it into your `wally.toml` dependencies
3. Run `wally install`

### Roblox model

1. Download the `OnyxUI.rbxm` file [listed here](https://github.com/ImAvafe/OnyxUI/releases/latest)
2. Insert `OnyxUI.rbxm` into Roblox Studio

## Usage Example

Here's a basic component example, making use of some of OnyxUI's features.

```lua
local OnyxUI = require(path.to.OnyxUI)
local Fusion = require(path.to.Fusion)

local Themer = OnyxUI.Themer
local Util = OnyxUI.Util
local Components = OnyxUI.Components
local InnerScope = Fusion.innerScope

-- Components
local Card = require(OnyxUI.Components.Card)

-- Types
export type Props = Card.Props & {}

-- Component construction
return function(Scope: Fusion.Scope<any>, Props: Props)
	local Scope = InnerScope(Scope, Fusion, Util, Components)
	local Theme = Themer.Theme:now()

	return Scope:Card {
		BackgroundColor3 = Util.Colors.Gray["200"],
		Padding = Scope:Computed(function(Use)
			return UDim.new(0, Use(Theme.Spacing["2"]))
		end),
	}
end
```

## [See it in action ✨](in-production.md)