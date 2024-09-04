local OnyxUI = script.Parent.Parent
local Fusion = require(OnyxUI.Packages.Fusion)

local Scoped = Fusion.scoped

local ScrollingFrame = require(script.Parent.ScrollingFrame)
local Components = {
	ScrollingFrame = ScrollingFrame,
}

return {
	story = function(Parent: GuiObject)
		local Scope: Fusion.Scope<typeof(Fusion) & typeof(Components)> = Scoped(Fusion, Components)

		local Instance = Scope:ScrollingFrame {
			Parent = Parent,
			Size = UDim2.fromOffset(200, 200),
			CanvasSize = UDim2.new(UDim.new(1, 0), UDim.new(0, 1000)),
			AutomaticCanvasSize = Enum.AutomaticSize.None,
		}

		return function()
			Instance:Destroy()
		end
	end,
}
