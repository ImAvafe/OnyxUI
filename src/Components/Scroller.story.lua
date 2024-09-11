local OnyxUI = script.Parent.Parent
local Fusion = require(OnyxUI.Packages.Fusion)

local Scoped = Fusion.scoped

local Scroller = require(script.Parent.Scroller)
local Components = {
	Scroller = Scroller,
}

return {
	story = function(Parent: GuiObject)
		local Scope = Scoped(Fusion, Components)

		Scope:Scroller {
			Parent = Parent,
			Size = UDim2.fromOffset(200, 200),
			CanvasSize = UDim2.new(UDim.new(1, 0), UDim.new(0, 1000)),
			AutomaticCanvasSize = Enum.AutomaticSize.None,
		}

		return function()
			Scope:doCleanup()
		end
	end,
}
