local NekaUI = script.Parent.Parent

local Fusion = require(NekaUI.Packages.Fusion)
local Finalize = require(NekaUI.Utils.Finalize)
local EnsureProp = require(NekaUI.Utils.EnsureProp)

local New = Fusion.New
local OnEvent = Fusion.OnEvent
local Children = Fusion.Children

local function Button(Props)
	Props.Disabled = EnsureProp(Props.Disabled, "boolean", false)

	Props.IsHovering = EnsureProp(Props.IsHovering, "boolean", false)
	Props.IsHolding = EnsureProp(Props.IsHolding, "boolean", false)
	Props.OnActivated = EnsureProp(Props.OnActivated, "function", function() end)
	Props.OnMouseEnter = EnsureProp(Props.OnMouseEnter, "function", function() end)
	Props.OnMouseLeave = EnsureProp(Props.OnMouseLeave, "function", function() end)
	Props.OnMouseButton1Down = EnsureProp(Props.OnMouseButton1Down, "function", function() end)
	Props.OnMouseButton1Up = EnsureProp(Props.OnMouseButton1Up, "function", function() end)

	return Finalize(New "TextButton" {
		Name = Props.Name or "BaseButton",
		Parent = Props.Parent,
		LayoutOrder = Props.LayoutOrder,
		Position = Props.Position,
		AnchorPoint = Props.AnchorPoint,
		Size = Props.Size,
		AutomaticSize = Props.AutomaticSize or Enum.AutomaticSize.XY,
		ZIndex = Props.ZIndex,
		Visible = Props.Visible,
		Selectable = Props.Selectable,

		Text = "",
		BackgroundTransparency = Props.BackgroundTransparency or 1,
		BackgroundColor3 = Props.BackgroundColor3,
		ClipsDescendants = Props.ClipsDescendants,

		[OnEvent "Activated"] = function()
			if not Props.Disabled:get(false) then
				Props.OnActivated:get()()
			end
		end,
		[OnEvent "MouseEnter"] = function()
			Props.IsHovering:set(true)
			Props.OnMouseEnter:get()()
		end,
		[OnEvent "MouseLeave"] = function()
			Props.IsHovering:set(false)
			Props.IsHolding:set(false)
			Props.OnMouseLeave:get()()
		end,
		[OnEvent "MouseButton1Down"] = function()
			Props.IsHolding:set(true)
			Props.OnMouseButton1Down:get()()
		end,
		[OnEvent "MouseButton1Up"] = function()
			Props.IsHolding:set(false)
			Props.OnMouseButton1Up:get()()
		end,

		[Children] = Props[Children],
	})
end

return Button
