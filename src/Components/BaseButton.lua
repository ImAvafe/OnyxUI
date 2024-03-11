local SoundService = game:GetService("SoundService")

local OnyxUI = script.Parent.Parent

local Fusion = require(OnyxUI.Parent.Fusion)
local Finalize = require(OnyxUI.Utils.Finalize)
local EnsureValue = require(OnyxUI.Utils.EnsureValue)
local Themer = require(OnyxUI.Utils.Themer)

local New = Fusion.New
local OnEvent = Fusion.OnEvent
local Children = Fusion.Children
local Computed = Fusion.Computed

local function Button(Props: table)
	Props.Name = EnsureValue(Props.Name, "string", "BaseButton")
	Props.BackgroundTransparency = EnsureValue(Props.BackgroundTransparency, "number", 1)
	Props.AutomaticSize = EnsureValue(Props.AutomaticSize, "EnumItem", Enum.AutomaticSize.XY)

	Props.Disabled = EnsureValue(Props.Disabled, "boolean", false)

	Props.IsHovering = EnsureValue(Props.IsHovering, "boolean", false)
	Props.IsHolding = EnsureValue(Props.IsHolding, "boolean", false)

	Props.OnActivated = EnsureValue(Props.OnActivated, "function", function() end)
	Props.OnMouseEnter = EnsureValue(Props.OnMouseEnter, "function", function() end)
	Props.OnMouseLeave = EnsureValue(Props.OnMouseLeave, "function", function() end)
	Props.OnMouseButton1Down = EnsureValue(Props.OnMouseButton1Down, "function", function() end)
	Props.OnMouseButton1Up = EnsureValue(Props.OnMouseButton1Up, "function", function() end)

	Props.HoverSound = EnsureValue(Props.HoverSound, "Sound", Themer.Theme.Sound.Hover)
	Props.ClickSound = EnsureValue(Props.ClickSound, "Sound", Themer.Theme.Sound.Click)

	Props.Active = EnsureValue(
		Props.Active,
		"boolean",
		Computed(function()
			return not Props.Disabled:get()
		end)
	)

	return Finalize(New "TextButton" {
		Name = Props.Name,
		Parent = Props.Parent,
		Position = Props.Position,
		Rotation = Props.Rotation,
		AnchorPoint = Props.AnchorPoint,
		Size = Props.Size,
		AutomaticSize = Props.AutomaticSize,
		Visible = Props.Visible,
		ZIndex = Props.ZIndex,
		LayoutOrder = Props.LayoutOrder,
		ClipsDescendants = Props.ClipsDescendants,
		Active = Props.Active,
		Selectable = Props.Selectable,
		Interactable = Props.Interactable,
		BackgroundColor3 = Props.BackgroundColor3,
		BackgroundTransparency = Props.BackgroundTransparency,

		Text = "",
		AutoLocalize = false,

		[OnEvent "Activated"] = function()
			if not Props.Disabled:get() then
				SoundService:PlayLocalSound(Props.ClickSound:get())
				Props.OnActivated:get()()
			end
		end,
		[OnEvent "MouseEnter"] = function()
			if Props.Active:get() then
				SoundService:PlayLocalSound(Props.HoverSound:get())
			end
			Props.IsHovering:set(true)
			Props.OnMouseEnter:get()()
		end,
		[OnEvent "MouseLeave"] = function()
			Props.IsHovering:set(false)
			Props.IsHolding:set(false)
			Props.OnMouseLeave:get()()
		end,
		[OnEvent "MouseButton1Down"] = function()
			if not Props.Disabled:get() then
				Props.IsHolding:set(true)
				Props.OnMouseButton1Down:get()()
			end
		end,
		[OnEvent "MouseButton1Up"] = function()
			Props.IsHolding:set(false)
			Props.OnMouseButton1Up:get()()
		end,

		[Children] = Props[Children],
	})
end

return Button
